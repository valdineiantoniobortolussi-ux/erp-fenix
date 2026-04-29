import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_municipal_regime_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_municipal_regime_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalMunicipalRegimeRepository {
  final FiscalMunicipalRegimeApiProvider fiscalMunicipalRegimeApiProvider;
  final FiscalMunicipalRegimeDriftProvider fiscalMunicipalRegimeDriftProvider;

  FiscalMunicipalRegimeRepository({required this.fiscalMunicipalRegimeApiProvider, required this.fiscalMunicipalRegimeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalMunicipalRegimeDriftProvider.getList(filter: filter);
    } else {
      return await fiscalMunicipalRegimeApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalMunicipalRegimeModel?>? save({required FiscalMunicipalRegimeModel fiscalMunicipalRegimeModel}) async {
    if (fiscalMunicipalRegimeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalMunicipalRegimeDriftProvider.update(fiscalMunicipalRegimeModel);
      } else {
        return await fiscalMunicipalRegimeApiProvider.update(fiscalMunicipalRegimeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalMunicipalRegimeDriftProvider.insert(fiscalMunicipalRegimeModel);
      } else {
        return await fiscalMunicipalRegimeApiProvider.insert(fiscalMunicipalRegimeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalMunicipalRegimeDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalMunicipalRegimeApiProvider.delete(id) ?? false;
    }
  }
}