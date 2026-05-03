import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_estadual_porte_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_estadual_porte_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalEstadualPorteRepository {
  final FiscalEstadualPorteApiProvider fiscalEstadualPorteApiProvider;
  final FiscalEstadualPorteDriftProvider fiscalEstadualPorteDriftProvider;

  FiscalEstadualPorteRepository({required this.fiscalEstadualPorteApiProvider, required this.fiscalEstadualPorteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalEstadualPorteDriftProvider.getList(filter: filter);
    } else {
      return await fiscalEstadualPorteApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalEstadualPorteModel?>? save({required FiscalEstadualPorteModel fiscalEstadualPorteModel}) async {
    if (fiscalEstadualPorteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalEstadualPorteDriftProvider.update(fiscalEstadualPorteModel);
      } else {
        return await fiscalEstadualPorteApiProvider.update(fiscalEstadualPorteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalEstadualPorteDriftProvider.insert(fiscalEstadualPorteModel);
      } else {
        return await fiscalEstadualPorteApiProvider.insert(fiscalEstadualPorteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalEstadualPorteDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalEstadualPorteApiProvider.delete(id) ?? false;
    }
  }
}