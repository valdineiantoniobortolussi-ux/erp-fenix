import 'package:frotas/app/infra/constants.dart';
import 'package:frotas/app/data/provider/api/frota_veiculo_tipo_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_veiculo_tipo_drift_provider.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaVeiculoTipoRepository {
  final FrotaVeiculoTipoApiProvider frotaVeiculoTipoApiProvider;
  final FrotaVeiculoTipoDriftProvider frotaVeiculoTipoDriftProvider;

  FrotaVeiculoTipoRepository({required this.frotaVeiculoTipoApiProvider, required this.frotaVeiculoTipoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaVeiculoTipoDriftProvider.getList(filter: filter);
    } else {
      return await frotaVeiculoTipoApiProvider.getList(filter: filter);
    }
  }

  Future<FrotaVeiculoTipoModel?>? save({required FrotaVeiculoTipoModel frotaVeiculoTipoModel}) async {
    if (frotaVeiculoTipoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await frotaVeiculoTipoDriftProvider.update(frotaVeiculoTipoModel);
      } else {
        return await frotaVeiculoTipoApiProvider.update(frotaVeiculoTipoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await frotaVeiculoTipoDriftProvider.insert(frotaVeiculoTipoModel);
      } else {
        return await frotaVeiculoTipoApiProvider.insert(frotaVeiculoTipoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaVeiculoTipoDriftProvider.delete(id) ?? false;
    } else {
      return await frotaVeiculoTipoApiProvider.delete(id) ?? false;
    }
  }
}