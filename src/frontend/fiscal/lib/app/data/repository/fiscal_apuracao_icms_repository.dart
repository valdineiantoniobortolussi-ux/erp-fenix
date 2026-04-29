import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_apuracao_icms_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_apuracao_icms_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalApuracaoIcmsRepository {
  final FiscalApuracaoIcmsApiProvider fiscalApuracaoIcmsApiProvider;
  final FiscalApuracaoIcmsDriftProvider fiscalApuracaoIcmsDriftProvider;

  FiscalApuracaoIcmsRepository({required this.fiscalApuracaoIcmsApiProvider, required this.fiscalApuracaoIcmsDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalApuracaoIcmsDriftProvider.getList(filter: filter);
    } else {
      return await fiscalApuracaoIcmsApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalApuracaoIcmsModel?>? save({required FiscalApuracaoIcmsModel fiscalApuracaoIcmsModel}) async {
    if (fiscalApuracaoIcmsModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalApuracaoIcmsDriftProvider.update(fiscalApuracaoIcmsModel);
      } else {
        return await fiscalApuracaoIcmsApiProvider.update(fiscalApuracaoIcmsModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalApuracaoIcmsDriftProvider.insert(fiscalApuracaoIcmsModel);
      } else {
        return await fiscalApuracaoIcmsApiProvider.insert(fiscalApuracaoIcmsModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalApuracaoIcmsDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalApuracaoIcmsApiProvider.delete(id) ?? false;
    }
  }
}