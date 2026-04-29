import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/folha_evento_api_provider.dart';
import 'package:folha/app/data/provider/drift/folha_evento_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaEventoRepository {
  final FolhaEventoApiProvider folhaEventoApiProvider;
  final FolhaEventoDriftProvider folhaEventoDriftProvider;

  FolhaEventoRepository({required this.folhaEventoApiProvider, required this.folhaEventoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaEventoDriftProvider.getList(filter: filter);
    } else {
      return await folhaEventoApiProvider.getList(filter: filter);
    }
  }

  Future<FolhaEventoModel?>? save({required FolhaEventoModel folhaEventoModel}) async {
    if (folhaEventoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await folhaEventoDriftProvider.update(folhaEventoModel);
      } else {
        return await folhaEventoApiProvider.update(folhaEventoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await folhaEventoDriftProvider.insert(folhaEventoModel);
      } else {
        return await folhaEventoApiProvider.insert(folhaEventoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await folhaEventoDriftProvider.delete(id) ?? false;
    } else {
      return await folhaEventoApiProvider.delete(id) ?? false;
    }
  }
}