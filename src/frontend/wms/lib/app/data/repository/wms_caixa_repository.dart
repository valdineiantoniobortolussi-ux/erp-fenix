import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_caixa_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_caixa_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsCaixaRepository {
  final WmsCaixaApiProvider wmsCaixaApiProvider;
  final WmsCaixaDriftProvider wmsCaixaDriftProvider;

  WmsCaixaRepository({required this.wmsCaixaApiProvider, required this.wmsCaixaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsCaixaDriftProvider.getList(filter: filter);
    } else {
      return await wmsCaixaApiProvider.getList(filter: filter);
    }
  }

  Future<WmsCaixaModel?>? save({required WmsCaixaModel wmsCaixaModel}) async {
    if (wmsCaixaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsCaixaDriftProvider.update(wmsCaixaModel);
      } else {
        return await wmsCaixaApiProvider.update(wmsCaixaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsCaixaDriftProvider.insert(wmsCaixaModel);
      } else {
        return await wmsCaixaApiProvider.insert(wmsCaixaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsCaixaDriftProvider.delete(id) ?? false;
    } else {
      return await wmsCaixaApiProvider.delete(id) ?? false;
    }
  }
}