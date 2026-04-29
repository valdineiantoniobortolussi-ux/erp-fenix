import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_historico_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_historico_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilHistoricoRepository {
  final ContabilHistoricoApiProvider contabilHistoricoApiProvider;
  final ContabilHistoricoDriftProvider contabilHistoricoDriftProvider;

  ContabilHistoricoRepository({required this.contabilHistoricoApiProvider, required this.contabilHistoricoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilHistoricoDriftProvider.getList(filter: filter);
    } else {
      return await contabilHistoricoApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilHistoricoModel?>? save({required ContabilHistoricoModel contabilHistoricoModel}) async {
    if (contabilHistoricoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilHistoricoDriftProvider.update(contabilHistoricoModel);
      } else {
        return await contabilHistoricoApiProvider.update(contabilHistoricoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilHistoricoDriftProvider.insert(contabilHistoricoModel);
      } else {
        return await contabilHistoricoApiProvider.insert(contabilHistoricoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilHistoricoDriftProvider.delete(id) ?? false;
    } else {
      return await contabilHistoricoApiProvider.delete(id) ?? false;
    }
  }
}