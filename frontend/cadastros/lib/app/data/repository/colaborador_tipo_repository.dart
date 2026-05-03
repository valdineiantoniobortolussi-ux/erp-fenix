import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/colaborador_tipo_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/colaborador_tipo_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ColaboradorTipoRepository {
  final ColaboradorTipoApiProvider colaboradorTipoApiProvider;
  final ColaboradorTipoDriftProvider colaboradorTipoDriftProvider;

  ColaboradorTipoRepository({required this.colaboradorTipoApiProvider, required this.colaboradorTipoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await colaboradorTipoDriftProvider.getList(filter: filter);
    } else {
      return await colaboradorTipoApiProvider.getList(filter: filter);
    }
  }

  Future<ColaboradorTipoModel?>? save({required ColaboradorTipoModel colaboradorTipoModel}) async {
    if (colaboradorTipoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await colaboradorTipoDriftProvider.update(colaboradorTipoModel);
      } else {
        return await colaboradorTipoApiProvider.update(colaboradorTipoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await colaboradorTipoDriftProvider.insert(colaboradorTipoModel);
      } else {
        return await colaboradorTipoApiProvider.insert(colaboradorTipoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await colaboradorTipoDriftProvider.delete(id) ?? false;
    } else {
      return await colaboradorTipoApiProvider.delete(id) ?? false;
    }
  }
}