import 'package:nfse/app/infra/constants.dart';
import 'package:nfse/app/data/provider/api/nfse_lista_servico_api_provider.dart';
import 'package:nfse/app/data/provider/drift/nfse_lista_servico_drift_provider.dart';
import 'package:nfse/app/data/model/model_imports.dart';

class NfseListaServicoRepository {
  final NfseListaServicoApiProvider nfseListaServicoApiProvider;
  final NfseListaServicoDriftProvider nfseListaServicoDriftProvider;

  NfseListaServicoRepository({required this.nfseListaServicoApiProvider, required this.nfseListaServicoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfseListaServicoDriftProvider.getList(filter: filter);
    } else {
      return await nfseListaServicoApiProvider.getList(filter: filter);
    }
  }

  Future<NfseListaServicoModel?>? save({required NfseListaServicoModel nfseListaServicoModel}) async {
    if (nfseListaServicoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfseListaServicoDriftProvider.update(nfseListaServicoModel);
      } else {
        return await nfseListaServicoApiProvider.update(nfseListaServicoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfseListaServicoDriftProvider.insert(nfseListaServicoModel);
      } else {
        return await nfseListaServicoApiProvider.insert(nfseListaServicoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfseListaServicoDriftProvider.delete(id) ?? false;
    } else {
      return await nfseListaServicoApiProvider.delete(id) ?? false;
    }
  }
}