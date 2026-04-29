import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_extrato_conta_banco_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_extrato_conta_banco_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinExtratoContaBancoRepository {
  final FinExtratoContaBancoApiProvider finExtratoContaBancoApiProvider;
  final FinExtratoContaBancoDriftProvider finExtratoContaBancoDriftProvider;

  FinExtratoContaBancoRepository({required this.finExtratoContaBancoApiProvider, required this.finExtratoContaBancoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finExtratoContaBancoDriftProvider.getList(filter: filter);
    } else {
      return await finExtratoContaBancoApiProvider.getList(filter: filter);
    }
  }

  Future<FinExtratoContaBancoModel?>? save({required FinExtratoContaBancoModel finExtratoContaBancoModel}) async {
    if (finExtratoContaBancoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finExtratoContaBancoDriftProvider.update(finExtratoContaBancoModel);
      } else {
        return await finExtratoContaBancoApiProvider.update(finExtratoContaBancoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finExtratoContaBancoDriftProvider.insert(finExtratoContaBancoModel);
      } else {
        return await finExtratoContaBancoApiProvider.insert(finExtratoContaBancoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finExtratoContaBancoDriftProvider.delete(id) ?? false;
    } else {
      return await finExtratoContaBancoApiProvider.delete(id) ?? false;
    }
  }
}