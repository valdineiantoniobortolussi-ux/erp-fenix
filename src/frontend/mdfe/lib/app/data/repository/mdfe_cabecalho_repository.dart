import 'package:mdfe/app/infra/constants.dart';
import 'package:mdfe/app/data/provider/api/mdfe_cabecalho_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_cabecalho_drift_provider.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeCabecalhoRepository {
  final MdfeCabecalhoApiProvider mdfeCabecalhoApiProvider;
  final MdfeCabecalhoDriftProvider mdfeCabecalhoDriftProvider;

  MdfeCabecalhoRepository({required this.mdfeCabecalhoApiProvider, required this.mdfeCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await mdfeCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<MdfeCabecalhoModel?>? save({required MdfeCabecalhoModel mdfeCabecalhoModel}) async {
    if (mdfeCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await mdfeCabecalhoDriftProvider.update(mdfeCabecalhoModel);
      } else {
        return await mdfeCabecalhoApiProvider.update(mdfeCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await mdfeCabecalhoDriftProvider.insert(mdfeCabecalhoModel);
      } else {
        return await mdfeCabecalhoApiProvider.insert(mdfeCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await mdfeCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}