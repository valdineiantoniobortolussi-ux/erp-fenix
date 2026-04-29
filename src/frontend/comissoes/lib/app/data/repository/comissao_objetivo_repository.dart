import 'package:comissoes/app/infra/constants.dart';
import 'package:comissoes/app/data/provider/api/comissao_objetivo_api_provider.dart';
import 'package:comissoes/app/data/provider/drift/comissao_objetivo_drift_provider.dart';
import 'package:comissoes/app/data/model/model_imports.dart';

class ComissaoObjetivoRepository {
  final ComissaoObjetivoApiProvider comissaoObjetivoApiProvider;
  final ComissaoObjetivoDriftProvider comissaoObjetivoDriftProvider;

  ComissaoObjetivoRepository({required this.comissaoObjetivoApiProvider, required this.comissaoObjetivoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await comissaoObjetivoDriftProvider.getList(filter: filter);
    } else {
      return await comissaoObjetivoApiProvider.getList(filter: filter);
    }
  }

  Future<ComissaoObjetivoModel?>? save({required ComissaoObjetivoModel comissaoObjetivoModel}) async {
    if (comissaoObjetivoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await comissaoObjetivoDriftProvider.update(comissaoObjetivoModel);
      } else {
        return await comissaoObjetivoApiProvider.update(comissaoObjetivoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await comissaoObjetivoDriftProvider.insert(comissaoObjetivoModel);
      } else {
        return await comissaoObjetivoApiProvider.insert(comissaoObjetivoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await comissaoObjetivoDriftProvider.delete(id) ?? false;
    } else {
      return await comissaoObjetivoApiProvider.delete(id) ?? false;
    }
  }
}