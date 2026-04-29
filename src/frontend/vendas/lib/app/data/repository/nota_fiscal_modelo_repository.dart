import 'package:vendas/app/infra/constants.dart';
import 'package:vendas/app/data/provider/api/nota_fiscal_modelo_api_provider.dart';
import 'package:vendas/app/data/provider/drift/nota_fiscal_modelo_drift_provider.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class NotaFiscalModeloRepository {
  final NotaFiscalModeloApiProvider notaFiscalModeloApiProvider;
  final NotaFiscalModeloDriftProvider notaFiscalModeloDriftProvider;

  NotaFiscalModeloRepository({required this.notaFiscalModeloApiProvider, required this.notaFiscalModeloDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await notaFiscalModeloDriftProvider.getList(filter: filter);
    } else {
      return await notaFiscalModeloApiProvider.getList(filter: filter);
    }
  }

  Future<NotaFiscalModeloModel?>? save({required NotaFiscalModeloModel notaFiscalModeloModel}) async {
    if (notaFiscalModeloModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await notaFiscalModeloDriftProvider.update(notaFiscalModeloModel);
      } else {
        return await notaFiscalModeloApiProvider.update(notaFiscalModeloModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await notaFiscalModeloDriftProvider.insert(notaFiscalModeloModel);
      } else {
        return await notaFiscalModeloApiProvider.insert(notaFiscalModeloModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await notaFiscalModeloDriftProvider.delete(id) ?? false;
    } else {
      return await notaFiscalModeloApiProvider.delete(id) ?? false;
    }
  }
}