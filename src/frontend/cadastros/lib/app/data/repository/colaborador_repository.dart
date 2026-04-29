import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/colaborador_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/colaborador_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ColaboradorRepository {
  final ColaboradorApiProvider colaboradorApiProvider;
  final ColaboradorDriftProvider colaboradorDriftProvider;

  ColaboradorRepository({required this.colaboradorApiProvider, required this.colaboradorDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await colaboradorDriftProvider.getList(filter: filter);
    } else {
      return await colaboradorApiProvider.getList(filter: filter);
    }
  }

  Future<ColaboradorModel?>? save({required ColaboradorModel colaboradorModel}) async {
    if (colaboradorModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await colaboradorDriftProvider.update(colaboradorModel);
      } else {
        return await colaboradorApiProvider.update(colaboradorModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await colaboradorDriftProvider.insert(colaboradorModel);
      } else {
        return await colaboradorApiProvider.insert(colaboradorModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await colaboradorDriftProvider.delete(id) ?? false;
    } else {
      return await colaboradorApiProvider.delete(id) ?? false;
    }
  }
}