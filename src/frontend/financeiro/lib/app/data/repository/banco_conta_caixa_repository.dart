import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/banco_conta_caixa_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/banco_conta_caixa_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class BancoContaCaixaRepository {
  final BancoContaCaixaApiProvider bancoContaCaixaApiProvider;
  final BancoContaCaixaDriftProvider bancoContaCaixaDriftProvider;

  BancoContaCaixaRepository({required this.bancoContaCaixaApiProvider, required this.bancoContaCaixaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await bancoContaCaixaDriftProvider.getList(filter: filter);
    } else {
      return await bancoContaCaixaApiProvider.getList(filter: filter);
    }
  }

  Future<BancoContaCaixaModel?>? save({required BancoContaCaixaModel bancoContaCaixaModel}) async {
    if (bancoContaCaixaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await bancoContaCaixaDriftProvider.update(bancoContaCaixaModel);
      } else {
        return await bancoContaCaixaApiProvider.update(bancoContaCaixaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await bancoContaCaixaDriftProvider.insert(bancoContaCaixaModel);
      } else {
        return await bancoContaCaixaApiProvider.insert(bancoContaCaixaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await bancoContaCaixaDriftProvider.delete(id) ?? false;
    } else {
      return await bancoContaCaixaApiProvider.delete(id) ?? false;
    }
  }
}