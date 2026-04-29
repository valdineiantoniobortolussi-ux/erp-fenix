import 'package:mdfe/app/infra/constants.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_ciot_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_ciot_drift_provider.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioCiotRepository {
  final MdfeRodoviarioCiotApiProvider mdfeRodoviarioCiotApiProvider;
  final MdfeRodoviarioCiotDriftProvider mdfeRodoviarioCiotDriftProvider;

  MdfeRodoviarioCiotRepository({required this.mdfeRodoviarioCiotApiProvider, required this.mdfeRodoviarioCiotDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioCiotDriftProvider.getList(filter: filter);
    } else {
      return await mdfeRodoviarioCiotApiProvider.getList(filter: filter);
    }
  }

  Future<MdfeRodoviarioCiotModel?>? save({required MdfeRodoviarioCiotModel mdfeRodoviarioCiotModel}) async {
    if (mdfeRodoviarioCiotModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioCiotDriftProvider.update(mdfeRodoviarioCiotModel);
      } else {
        return await mdfeRodoviarioCiotApiProvider.update(mdfeRodoviarioCiotModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioCiotDriftProvider.insert(mdfeRodoviarioCiotModel);
      } else {
        return await mdfeRodoviarioCiotApiProvider.insert(mdfeRodoviarioCiotModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioCiotDriftProvider.delete(id) ?? false;
    } else {
      return await mdfeRodoviarioCiotApiProvider.delete(id) ?? false;
    }
  }
}