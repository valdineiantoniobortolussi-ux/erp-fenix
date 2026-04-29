import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/sindicato_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/sindicato_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class SindicatoRepository {
  final SindicatoApiProvider sindicatoApiProvider;
  final SindicatoDriftProvider sindicatoDriftProvider;

  SindicatoRepository({required this.sindicatoApiProvider, required this.sindicatoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await sindicatoDriftProvider.getList(filter: filter);
    } else {
      return await sindicatoApiProvider.getList(filter: filter);
    }
  }

  Future<SindicatoModel?>? save({required SindicatoModel sindicatoModel}) async {
    if (sindicatoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await sindicatoDriftProvider.update(sindicatoModel);
      } else {
        return await sindicatoApiProvider.update(sindicatoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await sindicatoDriftProvider.insert(sindicatoModel);
      } else {
        return await sindicatoApiProvider.insert(sindicatoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await sindicatoDriftProvider.delete(id) ?? false;
    } else {
      return await sindicatoApiProvider.delete(id) ?? false;
    }
  }
}