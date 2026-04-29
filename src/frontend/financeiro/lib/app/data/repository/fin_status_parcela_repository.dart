import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_status_parcela_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_status_parcela_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinStatusParcelaRepository {
  final FinStatusParcelaApiProvider finStatusParcelaApiProvider;
  final FinStatusParcelaDriftProvider finStatusParcelaDriftProvider;

  FinStatusParcelaRepository({required this.finStatusParcelaApiProvider, required this.finStatusParcelaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finStatusParcelaDriftProvider.getList(filter: filter);
    } else {
      return await finStatusParcelaApiProvider.getList(filter: filter);
    }
  }

  Future<FinStatusParcelaModel?>? save({required FinStatusParcelaModel finStatusParcelaModel}) async {
    if (finStatusParcelaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finStatusParcelaDriftProvider.update(finStatusParcelaModel);
      } else {
        return await finStatusParcelaApiProvider.update(finStatusParcelaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finStatusParcelaDriftProvider.insert(finStatusParcelaModel);
      } else {
        return await finStatusParcelaApiProvider.insert(finStatusParcelaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finStatusParcelaDriftProvider.delete(id) ?? false;
    } else {
      return await finStatusParcelaApiProvider.delete(id) ?? false;
    }
  }
}