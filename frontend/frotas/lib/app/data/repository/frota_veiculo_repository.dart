import 'package:frotas/app/infra/constants.dart';
import 'package:frotas/app/data/provider/api/frota_veiculo_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_veiculo_drift_provider.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaVeiculoRepository {
  final FrotaVeiculoApiProvider frotaVeiculoApiProvider;
  final FrotaVeiculoDriftProvider frotaVeiculoDriftProvider;

  FrotaVeiculoRepository({required this.frotaVeiculoApiProvider, required this.frotaVeiculoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaVeiculoDriftProvider.getList(filter: filter);
    } else {
      return await frotaVeiculoApiProvider.getList(filter: filter);
    }
  }

  Future<FrotaVeiculoModel?>? save({required FrotaVeiculoModel frotaVeiculoModel}) async {
    if (frotaVeiculoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await frotaVeiculoDriftProvider.update(frotaVeiculoModel);
      } else {
        return await frotaVeiculoApiProvider.update(frotaVeiculoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await frotaVeiculoDriftProvider.insert(frotaVeiculoModel);
      } else {
        return await frotaVeiculoApiProvider.insert(frotaVeiculoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaVeiculoDriftProvider.delete(id) ?? false;
    } else {
      return await frotaVeiculoApiProvider.delete(id) ?? false;
    }
  }
}