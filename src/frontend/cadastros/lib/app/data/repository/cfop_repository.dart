import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/cfop_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cfop_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CfopRepository {
  final CfopApiProvider cfopApiProvider;
  final CfopDriftProvider cfopDriftProvider;

  CfopRepository({required this.cfopApiProvider, required this.cfopDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cfopDriftProvider.getList(filter: filter);
    } else {
      return await cfopApiProvider.getList(filter: filter);
    }
  }

  Future<CfopModel?>? save({required CfopModel cfopModel}) async {
    if (cfopModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cfopDriftProvider.update(cfopModel);
      } else {
        return await cfopApiProvider.update(cfopModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cfopDriftProvider.insert(cfopModel);
      } else {
        return await cfopApiProvider.insert(cfopModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cfopDriftProvider.delete(id) ?? false;
    } else {
      return await cfopApiProvider.delete(id) ?? false;
    }
  }
}