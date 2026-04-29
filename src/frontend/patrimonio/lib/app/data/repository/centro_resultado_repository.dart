import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/centro_resultado_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/centro_resultado_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class CentroResultadoRepository {
  final CentroResultadoApiProvider centroResultadoApiProvider;
  final CentroResultadoDriftProvider centroResultadoDriftProvider;

  CentroResultadoRepository({required this.centroResultadoApiProvider, required this.centroResultadoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await centroResultadoDriftProvider.getList(filter: filter);
    } else {
      return await centroResultadoApiProvider.getList(filter: filter);
    }
  }

  Future<CentroResultadoModel?>? save({required CentroResultadoModel centroResultadoModel}) async {
    if (centroResultadoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await centroResultadoDriftProvider.update(centroResultadoModel);
      } else {
        return await centroResultadoApiProvider.update(centroResultadoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await centroResultadoDriftProvider.insert(centroResultadoModel);
      } else {
        return await centroResultadoApiProvider.insert(centroResultadoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await centroResultadoDriftProvider.delete(id) ?? false;
    } else {
      return await centroResultadoApiProvider.delete(id) ?? false;
    }
  }
}