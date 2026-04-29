import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/feriados_api_provider.dart';
import 'package:folha/app/data/provider/drift/feriados_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FeriadosRepository {
  final FeriadosApiProvider feriadosApiProvider;
  final FeriadosDriftProvider feriadosDriftProvider;

  FeriadosRepository({required this.feriadosApiProvider, required this.feriadosDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await feriadosDriftProvider.getList(filter: filter);
    } else {
      return await feriadosApiProvider.getList(filter: filter);
    }
  }

  Future<FeriadosModel?>? save({required FeriadosModel feriadosModel}) async {
    if (feriadosModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await feriadosDriftProvider.update(feriadosModel);
      } else {
        return await feriadosApiProvider.update(feriadosModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await feriadosDriftProvider.insert(feriadosModel);
      } else {
        return await feriadosApiProvider.insert(feriadosModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await feriadosDriftProvider.delete(id) ?? false;
    } else {
      return await feriadosApiProvider.delete(id) ?? false;
    }
  }
}