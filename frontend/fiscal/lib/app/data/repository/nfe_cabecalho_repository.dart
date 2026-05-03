import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/nfe_cabecalho_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/nfe_cabecalho_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class NfeCabecalhoRepository {
  final NfeCabecalhoApiProvider nfeCabecalhoApiProvider;
  final NfeCabecalhoDriftProvider nfeCabecalhoDriftProvider;

  NfeCabecalhoRepository({required this.nfeCabecalhoApiProvider, required this.nfeCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await nfeCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<NfeCabecalhoModel?>? save({required NfeCabecalhoModel nfeCabecalhoModel}) async {
    if (nfeCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeCabecalhoDriftProvider.update(nfeCabecalhoModel);
      } else {
        return await nfeCabecalhoApiProvider.update(nfeCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeCabecalhoDriftProvider.insert(nfeCabecalhoModel);
      } else {
        return await nfeCabecalhoApiProvider.insert(nfeCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await nfeCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}