import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/estado_civil_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/estado_civil_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class EstadoCivilRepository {
  final EstadoCivilApiProvider estadoCivilApiProvider;
  final EstadoCivilDriftProvider estadoCivilDriftProvider;

  EstadoCivilRepository({required this.estadoCivilApiProvider, required this.estadoCivilDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await estadoCivilDriftProvider.getList(filter: filter);
    } else {
      return await estadoCivilApiProvider.getList(filter: filter);
    }
  }

  Future<EstadoCivilModel?>? save({required EstadoCivilModel estadoCivilModel}) async {
    if (estadoCivilModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await estadoCivilDriftProvider.update(estadoCivilModel);
      } else {
        return await estadoCivilApiProvider.update(estadoCivilModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await estadoCivilDriftProvider.insert(estadoCivilModel);
      } else {
        return await estadoCivilApiProvider.insert(estadoCivilModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await estadoCivilDriftProvider.delete(id) ?? false;
    } else {
      return await estadoCivilApiProvider.delete(id) ?? false;
    }
  }
}