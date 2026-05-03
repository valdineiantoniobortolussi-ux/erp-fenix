import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/cst_pis_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_pis_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstPisRepository {
  final CstPisApiProvider cstPisApiProvider;
  final CstPisDriftProvider cstPisDriftProvider;

  CstPisRepository({required this.cstPisApiProvider, required this.cstPisDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cstPisDriftProvider.getList(filter: filter);
    } else {
      return await cstPisApiProvider.getList(filter: filter);
    }
  }

  Future<CstPisModel?>? save({required CstPisModel cstPisModel}) async {
    if (cstPisModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cstPisDriftProvider.update(cstPisModel);
      } else {
        return await cstPisApiProvider.update(cstPisModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cstPisDriftProvider.insert(cstPisModel);
      } else {
        return await cstPisApiProvider.insert(cstPisModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cstPisDriftProvider.delete(id) ?? false;
    } else {
      return await cstPisApiProvider.delete(id) ?? false;
    }
  }
}