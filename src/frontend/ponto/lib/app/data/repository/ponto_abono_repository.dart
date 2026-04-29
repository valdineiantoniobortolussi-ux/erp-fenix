import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_abono_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_abono_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoAbonoRepository {
  final PontoAbonoApiProvider pontoAbonoApiProvider;
  final PontoAbonoDriftProvider pontoAbonoDriftProvider;

  PontoAbonoRepository({required this.pontoAbonoApiProvider, required this.pontoAbonoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoAbonoDriftProvider.getList(filter: filter);
    } else {
      return await pontoAbonoApiProvider.getList(filter: filter);
    }
  }

  Future<PontoAbonoModel?>? save({required PontoAbonoModel pontoAbonoModel}) async {
    if (pontoAbonoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoAbonoDriftProvider.update(pontoAbonoModel);
      } else {
        return await pontoAbonoApiProvider.update(pontoAbonoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoAbonoDriftProvider.insert(pontoAbonoModel);
      } else {
        return await pontoAbonoApiProvider.insert(pontoAbonoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoAbonoDriftProvider.delete(id) ?? false;
    } else {
      return await pontoAbonoApiProvider.delete(id) ?? false;
    }
  }
}