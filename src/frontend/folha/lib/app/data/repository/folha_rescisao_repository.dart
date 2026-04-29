import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_rescisao_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_rescisao_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaRescisaoRepository {
  final FolhaRescisaoApiProvider folhaRescisaoApiProvider;
  final FolhaRescisaoDriftProvider folhaRescisaoDriftProvider;

  FolhaRescisaoRepository({required this.folhaRescisaoApiProvider, required this.folhaRescisaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaRescisaoDriftProvider.getList(filter: filter);
    } else {
      return await folhaRescisaoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaRescisaoModel?>? save({required FolhaRescisaoModel folhaRescisaoModel}) async {
    if (folhaRescisaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaRescisaoDriftProvider.update(folhaRescisaoModel);
      } else {
        return await folhaRescisaoApiProvider.update(folhaRescisaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaRescisaoDriftProvider.insert(folhaRescisaoModel);
      } else {
        return await folhaRescisaoApiProvider.insert(folhaRescisaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaRescisaoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaRescisaoApiProvider.delete(id) ?? false;
    }
  }
}