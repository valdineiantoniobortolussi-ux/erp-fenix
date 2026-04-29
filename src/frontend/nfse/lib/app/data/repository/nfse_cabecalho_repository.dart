import 'package:nfse/app/infra/constants.dart';
import 'package:nfse/app/data/provider/api/nfse_cabecalho_api_provider.dart';
import 'package:nfse/app/data/provider/drift/nfse_cabecalho_drift_provider.dart';
import 'package:nfse/app/data/model/model_imports.dart';

class NfseCabecalhoRepository {
  final NfseCabecalhoApiProvider nfseCabecalhoApiProvider;
  final NfseCabecalhoDriftProvider nfseCabecalhoDriftProvider;

  NfseCabecalhoRepository({required this.nfseCabecalhoApiProvider, required this.nfseCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfseCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await nfseCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<NfseCabecalhoModel?>? save({required NfseCabecalhoModel nfseCabecalhoModel}) async {
    if (nfseCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfseCabecalhoDriftProvider.update(nfseCabecalhoModel);
      } else {
        return await nfseCabecalhoApiProvider.update(nfseCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfseCabecalhoDriftProvider.insert(nfseCabecalhoModel);
      } else {
        return await nfseCabecalhoApiProvider.insert(nfseCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfseCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await nfseCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}