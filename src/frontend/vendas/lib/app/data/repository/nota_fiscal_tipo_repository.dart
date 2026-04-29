import 'package:vendas/app/infra/constants.dart';
import 'package:vendas/app/data/provider/api/nota_fiscal_tipo_api_provider.dart';
import 'package:vendas/app/data/provider/drift/nota_fiscal_tipo_drift_provider.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class NotaFiscalTipoRepository {
  final NotaFiscalTipoApiProvider notaFiscalTipoApiProvider;
  final NotaFiscalTipoDriftProvider notaFiscalTipoDriftProvider;

  NotaFiscalTipoRepository({required this.notaFiscalTipoApiProvider, required this.notaFiscalTipoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await notaFiscalTipoDriftProvider.getList(filter: filter);
    } else {
      return await notaFiscalTipoApiProvider.getList(filter: filter);
    }
  }

  Future<NotaFiscalTipoModel?>? save({required NotaFiscalTipoModel notaFiscalTipoModel}) async {
    if (notaFiscalTipoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await notaFiscalTipoDriftProvider.update(notaFiscalTipoModel);
      } else {
        return await notaFiscalTipoApiProvider.update(notaFiscalTipoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await notaFiscalTipoDriftProvider.insert(notaFiscalTipoModel);
      } else {
        return await notaFiscalTipoApiProvider.insert(notaFiscalTipoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await notaFiscalTipoDriftProvider.delete(id) ?? false;
    } else {
      return await notaFiscalTipoApiProvider.delete(id) ?? false;
    }
  }
}