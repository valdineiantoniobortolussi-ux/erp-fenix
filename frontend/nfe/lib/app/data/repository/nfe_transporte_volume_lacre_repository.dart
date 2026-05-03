import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_transporte_volume_lacre_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_transporte_volume_lacre_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeLacreRepository {
  final NfeTransporteVolumeLacreApiProvider nfeTransporteVolumeLacreApiProvider;
  final NfeTransporteVolumeLacreDriftProvider nfeTransporteVolumeLacreDriftProvider;

  NfeTransporteVolumeLacreRepository({required this.nfeTransporteVolumeLacreApiProvider, required this.nfeTransporteVolumeLacreDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeTransporteVolumeLacreDriftProvider.getList(filter: filter);
    } else {
      return await nfeTransporteVolumeLacreApiProvider.getList(filter: filter);
    }
  }

  Future<NfeTransporteVolumeLacreModel?>? save({required NfeTransporteVolumeLacreModel nfeTransporteVolumeLacreModel}) async {
    if (nfeTransporteVolumeLacreModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeTransporteVolumeLacreDriftProvider.update(nfeTransporteVolumeLacreModel);
      } else {
        return await nfeTransporteVolumeLacreApiProvider.update(nfeTransporteVolumeLacreModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeTransporteVolumeLacreDriftProvider.insert(nfeTransporteVolumeLacreModel);
      } else {
        return await nfeTransporteVolumeLacreApiProvider.insert(nfeTransporteVolumeLacreModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeTransporteVolumeLacreDriftProvider.delete(id) ?? false;
    } else {
      return await nfeTransporteVolumeLacreApiProvider.delete(id) ?? false;
    }
  }
}