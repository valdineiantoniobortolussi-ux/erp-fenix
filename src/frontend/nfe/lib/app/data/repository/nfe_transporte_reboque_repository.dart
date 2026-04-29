import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_transporte_reboque_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_transporte_reboque_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteReboqueRepository {
  final NfeTransporteReboqueApiProvider nfeTransporteReboqueApiProvider;
  final NfeTransporteReboqueDriftProvider nfeTransporteReboqueDriftProvider;

  NfeTransporteReboqueRepository({required this.nfeTransporteReboqueApiProvider, required this.nfeTransporteReboqueDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeTransporteReboqueDriftProvider.getList(filter: filter);
    } else {
      return await nfeTransporteReboqueApiProvider.getList(filter: filter);
    }
  }

  Future<NfeTransporteReboqueModel?>? save({required NfeTransporteReboqueModel nfeTransporteReboqueModel}) async {
    if (nfeTransporteReboqueModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeTransporteReboqueDriftProvider.update(nfeTransporteReboqueModel);
      } else {
        return await nfeTransporteReboqueApiProvider.update(nfeTransporteReboqueModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeTransporteReboqueDriftProvider.insert(nfeTransporteReboqueModel);
      } else {
        return await nfeTransporteReboqueApiProvider.insert(nfeTransporteReboqueModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeTransporteReboqueDriftProvider.delete(id) ?? false;
    } else {
      return await nfeTransporteReboqueApiProvider.delete(id) ?? false;
    }
  }
}