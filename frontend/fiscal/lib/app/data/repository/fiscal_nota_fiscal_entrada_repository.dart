import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_nota_fiscal_entrada_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_nota_fiscal_entrada_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalEntradaRepository {
  final FiscalNotaFiscalEntradaApiProvider fiscalNotaFiscalEntradaApiProvider;
  final FiscalNotaFiscalEntradaDriftProvider fiscalNotaFiscalEntradaDriftProvider;

  FiscalNotaFiscalEntradaRepository({required this.fiscalNotaFiscalEntradaApiProvider, required this.fiscalNotaFiscalEntradaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalNotaFiscalEntradaDriftProvider.getList(filter: filter);
    } else {
      return await fiscalNotaFiscalEntradaApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalNotaFiscalEntradaModel?>? save({required FiscalNotaFiscalEntradaModel fiscalNotaFiscalEntradaModel}) async {
    if (fiscalNotaFiscalEntradaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalNotaFiscalEntradaDriftProvider.update(fiscalNotaFiscalEntradaModel);
      } else {
        return await fiscalNotaFiscalEntradaApiProvider.update(fiscalNotaFiscalEntradaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalNotaFiscalEntradaDriftProvider.insert(fiscalNotaFiscalEntradaModel);
      } else {
        return await fiscalNotaFiscalEntradaApiProvider.insert(fiscalNotaFiscalEntradaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalNotaFiscalEntradaDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalNotaFiscalEntradaApiProvider.delete(id) ?? false;
    }
  }
}