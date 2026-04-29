import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/municipio_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/municipio_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class MunicipioRepository {
  final MunicipioApiProvider municipioApiProvider;
  final MunicipioDriftProvider municipioDriftProvider;

  MunicipioRepository({required this.municipioApiProvider, required this.municipioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await municipioDriftProvider.getList(filter: filter);
    } else {
      return await municipioApiProvider.getList(filter: filter);
    }
  }

  Future<MunicipioModel?>? save({required MunicipioModel municipioModel}) async {
    if (municipioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await municipioDriftProvider.update(municipioModel);
      } else {
        return await municipioApiProvider.update(municipioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await municipioDriftProvider.insert(municipioModel);
      } else {
        return await municipioApiProvider.insert(municipioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await municipioDriftProvider.delete(id) ?? false;
    } else {
      return await municipioApiProvider.delete(id) ?? false;
    }
  }
}