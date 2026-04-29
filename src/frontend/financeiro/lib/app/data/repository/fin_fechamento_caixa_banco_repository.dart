import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_fechamento_caixa_banco_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_fechamento_caixa_banco_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinFechamentoCaixaBancoRepository {
  final FinFechamentoCaixaBancoApiProvider finFechamentoCaixaBancoApiProvider;
  final FinFechamentoCaixaBancoDriftProvider finFechamentoCaixaBancoDriftProvider;

  FinFechamentoCaixaBancoRepository({required this.finFechamentoCaixaBancoApiProvider, required this.finFechamentoCaixaBancoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finFechamentoCaixaBancoDriftProvider.getList(filter: filter);
    } else {
      return await finFechamentoCaixaBancoApiProvider.getList(filter: filter);
    }
  }

  Future<FinFechamentoCaixaBancoModel?>? save({required FinFechamentoCaixaBancoModel finFechamentoCaixaBancoModel}) async {
    if (finFechamentoCaixaBancoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finFechamentoCaixaBancoDriftProvider.update(finFechamentoCaixaBancoModel);
      } else {
        return await finFechamentoCaixaBancoApiProvider.update(finFechamentoCaixaBancoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finFechamentoCaixaBancoDriftProvider.insert(finFechamentoCaixaBancoModel);
      } else {
        return await finFechamentoCaixaBancoApiProvider.insert(finFechamentoCaixaBancoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finFechamentoCaixaBancoDriftProvider.delete(id) ?? false;
    } else {
      return await finFechamentoCaixaBancoApiProvider.delete(id) ?? false;
    }
  }
}