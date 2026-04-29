import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_lancamento_orcado_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_lancamento_orcado_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoOrcadoRepository {
  final ContabilLancamentoOrcadoApiProvider contabilLancamentoOrcadoApiProvider;
  final ContabilLancamentoOrcadoDriftProvider contabilLancamentoOrcadoDriftProvider;

  ContabilLancamentoOrcadoRepository({required this.contabilLancamentoOrcadoApiProvider, required this.contabilLancamentoOrcadoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLancamentoOrcadoDriftProvider.getList(filter: filter);
    } else {
      return await contabilLancamentoOrcadoApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilLancamentoOrcadoModel?>? save({required ContabilLancamentoOrcadoModel contabilLancamentoOrcadoModel}) async {
    if (contabilLancamentoOrcadoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilLancamentoOrcadoDriftProvider.update(contabilLancamentoOrcadoModel);
      } else {
        return await contabilLancamentoOrcadoApiProvider.update(contabilLancamentoOrcadoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilLancamentoOrcadoDriftProvider.insert(contabilLancamentoOrcadoModel);
      } else {
        return await contabilLancamentoOrcadoApiProvider.insert(contabilLancamentoOrcadoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLancamentoOrcadoDriftProvider.delete(id) ?? false;
    } else {
      return await contabilLancamentoOrcadoApiProvider.delete(id) ?? false;
    }
  }
}