import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_estadual_regime_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_estadual_regime_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalEstadualRegimeRepository {
  final FiscalEstadualRegimeApiProvider fiscalEstadualRegimeApiProvider;
  final FiscalEstadualRegimeDriftProvider fiscalEstadualRegimeDriftProvider;

  FiscalEstadualRegimeRepository({required this.fiscalEstadualRegimeApiProvider, required this.fiscalEstadualRegimeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalEstadualRegimeDriftProvider.getList(filter: filter);
    } else {
      return await fiscalEstadualRegimeApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalEstadualRegimeModel?>? save({required FiscalEstadualRegimeModel fiscalEstadualRegimeModel}) async {
    if (fiscalEstadualRegimeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalEstadualRegimeDriftProvider.update(fiscalEstadualRegimeModel);
      } else {
        return await fiscalEstadualRegimeApiProvider.update(fiscalEstadualRegimeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalEstadualRegimeDriftProvider.insert(fiscalEstadualRegimeModel);
      } else {
        return await fiscalEstadualRegimeApiProvider.insert(fiscalEstadualRegimeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalEstadualRegimeDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalEstadualRegimeApiProvider.delete(id) ?? false;
    }
  }
}