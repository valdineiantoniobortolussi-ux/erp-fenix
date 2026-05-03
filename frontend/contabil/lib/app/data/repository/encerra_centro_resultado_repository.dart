import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/encerra_centro_resultado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/encerra_centro_resultado_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class EncerraCentroResultadoRepository {
  final EncerraCentroResultadoApiProvider encerraCentroResultadoApiProvider;
  final EncerraCentroResultadoDriftProvider encerraCentroResultadoDriftProvider;

  EncerraCentroResultadoRepository({required this.encerraCentroResultadoApiProvider, required this.encerraCentroResultadoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await encerraCentroResultadoDriftProvider.getList(filter: filter);
    } else {
      return await encerraCentroResultadoApiProvider.getList(filter: filter);
    }
  }

  Future<EncerraCentroResultadoModel?>? save({required EncerraCentroResultadoModel encerraCentroResultadoModel}) async {
    if (encerraCentroResultadoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await encerraCentroResultadoDriftProvider.update(encerraCentroResultadoModel);
      } else {
        return await encerraCentroResultadoApiProvider.update(encerraCentroResultadoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await encerraCentroResultadoDriftProvider.insert(encerraCentroResultadoModel);
      } else {
        return await encerraCentroResultadoApiProvider.insert(encerraCentroResultadoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await encerraCentroResultadoDriftProvider.delete(id) ?? false;
    } else {
      return await encerraCentroResultadoApiProvider.delete(id) ?? false;
    }
  }
}