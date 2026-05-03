import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_inss_servico_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_inss_servico_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaInssServicoRepository {
  final FolhaInssServicoApiProvider folhaInssServicoApiProvider;
  final FolhaInssServicoDriftProvider folhaInssServicoDriftProvider;

  FolhaInssServicoRepository({required this.folhaInssServicoApiProvider, required this.folhaInssServicoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaInssServicoDriftProvider.getList(filter: filter);
    } else {
      return await folhaInssServicoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaInssServicoModel?>? save({required FolhaInssServicoModel folhaInssServicoModel}) async {
    if (folhaInssServicoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaInssServicoDriftProvider.update(folhaInssServicoModel);
      } else {
        return await folhaInssServicoApiProvider.update(folhaInssServicoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaInssServicoDriftProvider.insert(folhaInssServicoModel);
      } else {
        return await folhaInssServicoApiProvider.insert(folhaInssServicoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaInssServicoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaInssServicoApiProvider.delete(id) ?? false;
    }
  }
}