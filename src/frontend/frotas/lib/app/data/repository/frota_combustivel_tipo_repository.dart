import 'package:frotas/app/infra/constants.dart';
import 'package:frotas/app/data/provider/api/frota_combustivel_tipo_api_provider.dart';
import 'package:frotas/app/data/provider/drift/frota_combustivel_tipo_drift_provider.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaCombustivelTipoRepository {
  final FrotaCombustivelTipoApiProvider frotaCombustivelTipoApiProvider;
  final FrotaCombustivelTipoDriftProvider frotaCombustivelTipoDriftProvider;

  FrotaCombustivelTipoRepository({required this.frotaCombustivelTipoApiProvider, required this.frotaCombustivelTipoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaCombustivelTipoDriftProvider.getList(filter: filter);
    } else {
      return await frotaCombustivelTipoApiProvider.getList(filter: filter);
    }
  }

  Future<FrotaCombustivelTipoModel?>? save({required FrotaCombustivelTipoModel frotaCombustivelTipoModel}) async {
    if (frotaCombustivelTipoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await frotaCombustivelTipoDriftProvider.update(frotaCombustivelTipoModel);
      } else {
        return await frotaCombustivelTipoApiProvider.update(frotaCombustivelTipoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await frotaCombustivelTipoDriftProvider.insert(frotaCombustivelTipoModel);
      } else {
        return await frotaCombustivelTipoApiProvider.insert(frotaCombustivelTipoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await frotaCombustivelTipoDriftProvider.delete(id) ?? false;
    } else {
      return await frotaCombustivelTipoApiProvider.delete(id) ?? false;
    }
  }
}