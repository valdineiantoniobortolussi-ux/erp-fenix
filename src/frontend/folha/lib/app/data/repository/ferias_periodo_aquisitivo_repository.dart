import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/ferias_periodo_aquisitivo_api_provider.dart';
import 'package:folha/app/data/provider/drift/ferias_periodo_aquisitivo_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FeriasPeriodoAquisitivoRepository {
  final FeriasPeriodoAquisitivoApiProvider feriasPeriodoAquisitivoApiProvider;
  final FeriasPeriodoAquisitivoDriftProvider feriasPeriodoAquisitivoDriftProvider;

  FeriasPeriodoAquisitivoRepository({required this.feriasPeriodoAquisitivoApiProvider, required this.feriasPeriodoAquisitivoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await feriasPeriodoAquisitivoDriftProvider.getList(filter: filter);
    } else {
      return await feriasPeriodoAquisitivoApiProvider.getList(filter: filter);
    }
  }

  Future<FeriasPeriodoAquisitivoModel?>? save({required FeriasPeriodoAquisitivoModel feriasPeriodoAquisitivoModel}) async {
    if (feriasPeriodoAquisitivoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await feriasPeriodoAquisitivoDriftProvider.update(feriasPeriodoAquisitivoModel);
      } else {
        return await feriasPeriodoAquisitivoApiProvider.update(feriasPeriodoAquisitivoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await feriasPeriodoAquisitivoDriftProvider.insert(feriasPeriodoAquisitivoModel);
      } else {
        return await feriasPeriodoAquisitivoApiProvider.insert(feriasPeriodoAquisitivoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await feriasPeriodoAquisitivoDriftProvider.delete(id) ?? false;
    } else {
      return await feriasPeriodoAquisitivoApiProvider.delete(id) ?? false;
    }
  }
}