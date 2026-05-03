import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_tipo_recebimento_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_tipo_recebimento_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinTipoRecebimentoRepository {
  final FinTipoRecebimentoApiProvider finTipoRecebimentoApiProvider;
  final FinTipoRecebimentoDriftProvider finTipoRecebimentoDriftProvider;

  FinTipoRecebimentoRepository({required this.finTipoRecebimentoApiProvider, required this.finTipoRecebimentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finTipoRecebimentoDriftProvider.getList(filter: filter);
    } else {
      return await finTipoRecebimentoApiProvider.getList(filter: filter);
    }
  }

  Future<FinTipoRecebimentoModel?>? save({required FinTipoRecebimentoModel finTipoRecebimentoModel}) async {
    if (finTipoRecebimentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finTipoRecebimentoDriftProvider.update(finTipoRecebimentoModel);
      } else {
        return await finTipoRecebimentoApiProvider.update(finTipoRecebimentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finTipoRecebimentoDriftProvider.insert(finTipoRecebimentoModel);
      } else {
        return await finTipoRecebimentoApiProvider.insert(finTipoRecebimentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finTipoRecebimentoDriftProvider.delete(id) ?? false;
    } else {
      return await finTipoRecebimentoApiProvider.delete(id) ?? false;
    }
  }
}