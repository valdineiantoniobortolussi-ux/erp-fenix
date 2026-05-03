import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/banco_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/banco_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class BancoRepository {
  final BancoApiProvider bancoApiProvider;
  final BancoDriftProvider bancoDriftProvider;

  BancoRepository({required this.bancoApiProvider, required this.bancoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await bancoDriftProvider.getList(filter: filter);
    } else {
      return await bancoApiProvider.getList(filter: filter);
    }
  }

  Future<BancoModel?>? save({required BancoModel bancoModel}) async {
    if (bancoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await bancoDriftProvider.update(bancoModel);
      } else {
        return await bancoApiProvider.update(bancoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await bancoDriftProvider.insert(bancoModel);
      } else {
        return await bancoApiProvider.insert(bancoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await bancoDriftProvider.delete(id) ?? false;
    } else {
      return await bancoApiProvider.delete(id) ?? false;
    }
  }
}