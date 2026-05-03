import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_cheque_emitido_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_cheque_emitido_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinChequeEmitidoRepository {
  final FinChequeEmitidoApiProvider finChequeEmitidoApiProvider;
  final FinChequeEmitidoDriftProvider finChequeEmitidoDriftProvider;

  FinChequeEmitidoRepository({required this.finChequeEmitidoApiProvider, required this.finChequeEmitidoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finChequeEmitidoDriftProvider.getList(filter: filter);
    } else {
      return await finChequeEmitidoApiProvider.getList(filter: filter);
    }
  }

  Future<FinChequeEmitidoModel?>? save({required FinChequeEmitidoModel finChequeEmitidoModel}) async {
    if (finChequeEmitidoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finChequeEmitidoDriftProvider.update(finChequeEmitidoModel);
      } else {
        return await finChequeEmitidoApiProvider.update(finChequeEmitidoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finChequeEmitidoDriftProvider.insert(finChequeEmitidoModel);
      } else {
        return await finChequeEmitidoApiProvider.insert(finChequeEmitidoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finChequeEmitidoDriftProvider.delete(id) ?? false;
    } else {
      return await finChequeEmitidoApiProvider.delete(id) ?? false;
    }
  }
}