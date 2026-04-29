import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_numero_inutilizado_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_numero_inutilizado_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeNumeroInutilizadoRepository {
  final NfeNumeroInutilizadoApiProvider nfeNumeroInutilizadoApiProvider;
  final NfeNumeroInutilizadoDriftProvider nfeNumeroInutilizadoDriftProvider;

  NfeNumeroInutilizadoRepository({required this.nfeNumeroInutilizadoApiProvider, required this.nfeNumeroInutilizadoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeNumeroInutilizadoDriftProvider.getList(filter: filter);
    } else {
      return await nfeNumeroInutilizadoApiProvider.getList(filter: filter);
    }
  }

  Future<NfeNumeroInutilizadoModel?>? save({required NfeNumeroInutilizadoModel nfeNumeroInutilizadoModel}) async {
    if (nfeNumeroInutilizadoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeNumeroInutilizadoDriftProvider.update(nfeNumeroInutilizadoModel);
      } else {
        return await nfeNumeroInutilizadoApiProvider.update(nfeNumeroInutilizadoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeNumeroInutilizadoDriftProvider.insert(nfeNumeroInutilizadoModel);
      } else {
        return await nfeNumeroInutilizadoApiProvider.insert(nfeNumeroInutilizadoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeNumeroInutilizadoDriftProvider.delete(id) ?? false;
    } else {
      return await nfeNumeroInutilizadoApiProvider.delete(id) ?? false;
    }
  }
}