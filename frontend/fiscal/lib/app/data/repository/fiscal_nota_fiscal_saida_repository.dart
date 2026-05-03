import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_nota_fiscal_saida_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_nota_fiscal_saida_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalSaidaRepository {
  final FiscalNotaFiscalSaidaApiProvider fiscalNotaFiscalSaidaApiProvider;
  final FiscalNotaFiscalSaidaDriftProvider fiscalNotaFiscalSaidaDriftProvider;

  FiscalNotaFiscalSaidaRepository({required this.fiscalNotaFiscalSaidaApiProvider, required this.fiscalNotaFiscalSaidaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalNotaFiscalSaidaDriftProvider.getList(filter: filter);
    } else {
      return await fiscalNotaFiscalSaidaApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalNotaFiscalSaidaModel?>? save({required FiscalNotaFiscalSaidaModel fiscalNotaFiscalSaidaModel}) async {
    if (fiscalNotaFiscalSaidaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalNotaFiscalSaidaDriftProvider.update(fiscalNotaFiscalSaidaModel);
      } else {
        return await fiscalNotaFiscalSaidaApiProvider.update(fiscalNotaFiscalSaidaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalNotaFiscalSaidaDriftProvider.insert(fiscalNotaFiscalSaidaModel);
      } else {
        return await fiscalNotaFiscalSaidaApiProvider.insert(fiscalNotaFiscalSaidaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalNotaFiscalSaidaDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalNotaFiscalSaidaApiProvider.delete(id) ?? false;
    }
  }
}