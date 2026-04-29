import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_parametro_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_parametro_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalParametroRepository {
  final FiscalParametroApiProvider fiscalParametroApiProvider;
  final FiscalParametroDriftProvider fiscalParametroDriftProvider;

  FiscalParametroRepository({required this.fiscalParametroApiProvider, required this.fiscalParametroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalParametroDriftProvider.getList(filter: filter);
    } else {
      return await fiscalParametroApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalParametroModel?>? save({required FiscalParametroModel fiscalParametroModel}) async {
    if (fiscalParametroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalParametroDriftProvider.update(fiscalParametroModel);
      } else {
        return await fiscalParametroApiProvider.update(fiscalParametroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalParametroDriftProvider.insert(fiscalParametroModel);
      } else {
        return await fiscalParametroApiProvider.insert(fiscalParametroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalParametroDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalParametroApiProvider.delete(id) ?? false;
    }
  }
}