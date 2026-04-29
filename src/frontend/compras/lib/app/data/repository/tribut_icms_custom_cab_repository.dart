import 'package:compras/app/infra/constants.dart';
import 'package:compras/app/data/provider/api/tribut_icms_custom_cab_api_provider.dart';
import 'package:compras/app/data/provider/drift/tribut_icms_custom_cab_drift_provider.dart';
import 'package:compras/app/data/model/model_imports.dart';

class TributIcmsCustomCabRepository {
  final TributIcmsCustomCabApiProvider tributIcmsCustomCabApiProvider;
  final TributIcmsCustomCabDriftProvider tributIcmsCustomCabDriftProvider;

  TributIcmsCustomCabRepository({required this.tributIcmsCustomCabApiProvider, required this.tributIcmsCustomCabDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tributIcmsCustomCabDriftProvider.getList(filter: filter);
    } else {
      return await tributIcmsCustomCabApiProvider.getList(filter: filter);
    }
  }

  Future<TributIcmsCustomCabModel?>? save({required TributIcmsCustomCabModel tributIcmsCustomCabModel}) async {
    if (tributIcmsCustomCabModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tributIcmsCustomCabDriftProvider.update(tributIcmsCustomCabModel);
      } else {
        return await tributIcmsCustomCabApiProvider.update(tributIcmsCustomCabModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tributIcmsCustomCabDriftProvider.insert(tributIcmsCustomCabModel);
      } else {
        return await tributIcmsCustomCabApiProvider.insert(tributIcmsCustomCabModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tributIcmsCustomCabDriftProvider.delete(id) ?? false;
    } else {
      return await tributIcmsCustomCabApiProvider.delete(id) ?? false;
    }
  }
}