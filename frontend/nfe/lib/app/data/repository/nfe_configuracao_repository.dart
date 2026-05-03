import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_configuracao_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_configuracao_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeConfiguracaoRepository {
  final NfeConfiguracaoApiProvider nfeConfiguracaoApiProvider;
  final NfeConfiguracaoDriftProvider nfeConfiguracaoDriftProvider;

  NfeConfiguracaoRepository({required this.nfeConfiguracaoApiProvider, required this.nfeConfiguracaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeConfiguracaoDriftProvider.getList(filter: filter);
    } else {
      return await nfeConfiguracaoApiProvider.getList(filter: filter);
    }
  }

  Future<NfeConfiguracaoModel?>? save({required NfeConfiguracaoModel nfeConfiguracaoModel}) async {
    if (nfeConfiguracaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeConfiguracaoDriftProvider.update(nfeConfiguracaoModel);
      } else {
        return await nfeConfiguracaoApiProvider.update(nfeConfiguracaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeConfiguracaoDriftProvider.insert(nfeConfiguracaoModel);
      } else {
        return await nfeConfiguracaoApiProvider.insert(nfeConfiguracaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeConfiguracaoDriftProvider.delete(id) ?? false;
    } else {
      return await nfeConfiguracaoApiProvider.delete(id) ?? false;
    }
  }
}