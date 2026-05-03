import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_numero_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_numero_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeNumeroRepository {
  final NfeNumeroApiProvider nfeNumeroApiProvider;
  final NfeNumeroDriftProvider nfeNumeroDriftProvider;

  NfeNumeroRepository({required this.nfeNumeroApiProvider, required this.nfeNumeroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeNumeroDriftProvider.getList(filter: filter);
    } else {
      return await nfeNumeroApiProvider.getList(filter: filter);
    }
  }

  Future<NfeNumeroModel?>? save({required NfeNumeroModel nfeNumeroModel}) async {
    if (nfeNumeroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeNumeroDriftProvider.update(nfeNumeroModel);
      } else {
        return await nfeNumeroApiProvider.update(nfeNumeroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeNumeroDriftProvider.insert(nfeNumeroModel);
      } else {
        return await nfeNumeroApiProvider.insert(nfeNumeroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeNumeroDriftProvider.delete(id) ?? false;
    } else {
      return await nfeNumeroApiProvider.delete(id) ?? false;
    }
  }
}