import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_lote_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lote_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLoteRepository {
  final ContabilLoteApiProvider contabilLoteApiProvider;
  final ContabilLoteDriftProvider contabilLoteDriftProvider;

  ContabilLoteRepository({required this.contabilLoteApiProvider, required this.contabilLoteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLoteDriftProvider.getList(filter: filter);
    } else {
      return await contabilLoteApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilLoteModel?>? save({required ContabilLoteModel contabilLoteModel}) async {
    if (contabilLoteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilLoteDriftProvider.update(contabilLoteModel);
      } else {
        return await contabilLoteApiProvider.update(contabilLoteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilLoteDriftProvider.insert(contabilLoteModel);
      } else {
        return await contabilLoteApiProvider.insert(contabilLoteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLoteDriftProvider.delete(id) ?? false;
    } else {
      return await contabilLoteApiProvider.delete(id) ?? false;
    }
  }
}