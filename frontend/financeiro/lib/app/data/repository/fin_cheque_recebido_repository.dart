import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_cheque_recebido_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_cheque_recebido_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinChequeRecebidoRepository {
  final FinChequeRecebidoApiProvider finChequeRecebidoApiProvider;
  final FinChequeRecebidoDriftProvider finChequeRecebidoDriftProvider;

  FinChequeRecebidoRepository({required this.finChequeRecebidoApiProvider, required this.finChequeRecebidoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finChequeRecebidoDriftProvider.getList(filter: filter);
    } else {
      return await finChequeRecebidoApiProvider.getList(filter: filter);
    }
  }

  Future<FinChequeRecebidoModel?>? save({required FinChequeRecebidoModel finChequeRecebidoModel}) async {
    if (finChequeRecebidoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finChequeRecebidoDriftProvider.update(finChequeRecebidoModel);
      } else {
        return await finChequeRecebidoApiProvider.update(finChequeRecebidoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finChequeRecebidoDriftProvider.insert(finChequeRecebidoModel);
      } else {
        return await finChequeRecebidoApiProvider.insert(finChequeRecebidoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finChequeRecebidoDriftProvider.delete(id) ?? false;
    } else {
      return await finChequeRecebidoApiProvider.delete(id) ?? false;
    }
  }
}