import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_transporte_volume_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_transporte_volume_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeRepository {
  final NfeTransporteVolumeApiProvider nfeTransporteVolumeApiProvider;
  final NfeTransporteVolumeDriftProvider nfeTransporteVolumeDriftProvider;

  NfeTransporteVolumeRepository({required this.nfeTransporteVolumeApiProvider, required this.nfeTransporteVolumeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeTransporteVolumeDriftProvider.getList(filter: filter);
    } else {
      return await nfeTransporteVolumeApiProvider.getList(filter: filter);
    }
  }

  Future<NfeTransporteVolumeModel?>? save({required NfeTransporteVolumeModel nfeTransporteVolumeModel}) async {
    if (nfeTransporteVolumeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeTransporteVolumeDriftProvider.update(nfeTransporteVolumeModel);
      } else {
        return await nfeTransporteVolumeApiProvider.update(nfeTransporteVolumeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeTransporteVolumeDriftProvider.insert(nfeTransporteVolumeModel);
      } else {
        return await nfeTransporteVolumeApiProvider.insert(nfeTransporteVolumeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeTransporteVolumeDriftProvider.delete(id) ?? false;
    } else {
      return await nfeTransporteVolumeApiProvider.delete(id) ?? false;
    }
  }
}