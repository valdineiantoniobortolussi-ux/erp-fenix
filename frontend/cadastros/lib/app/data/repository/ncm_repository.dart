import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/ncm_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/ncm_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class NcmRepository {
  final NcmApiProvider ncmApiProvider;
  final NcmDriftProvider ncmDriftProvider;

  NcmRepository({required this.ncmApiProvider, required this.ncmDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await ncmDriftProvider.getList(filter: filter);
    } else {
      return await ncmApiProvider.getList(filter: filter);
    }
  }

  Future<NcmModel?>? save({required NcmModel ncmModel}) async {
    if (ncmModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await ncmDriftProvider.update(ncmModel);
      } else {
        return await ncmApiProvider.update(ncmModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await ncmDriftProvider.insert(ncmModel);
      } else {
        return await ncmApiProvider.insert(ncmModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await ncmDriftProvider.delete(id) ?? false;
    } else {
      return await ncmApiProvider.delete(id) ?? false;
    }
  }
}