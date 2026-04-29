import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/cargo_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cargo_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CargoRepository {
  final CargoApiProvider cargoApiProvider;
  final CargoDriftProvider cargoDriftProvider;

  CargoRepository({required this.cargoApiProvider, required this.cargoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cargoDriftProvider.getList(filter: filter);
    } else {
      return await cargoApiProvider.getList(filter: filter);
    }
  }

  Future<CargoModel?>? save({required CargoModel cargoModel}) async {
    if (cargoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cargoDriftProvider.update(cargoModel);
      } else {
        return await cargoApiProvider.update(cargoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cargoDriftProvider.insert(cargoModel);
      } else {
        return await cargoApiProvider.insert(cargoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cargoDriftProvider.delete(id) ?? false;
    } else {
      return await cargoApiProvider.delete(id) ?? false;
    }
  }
}