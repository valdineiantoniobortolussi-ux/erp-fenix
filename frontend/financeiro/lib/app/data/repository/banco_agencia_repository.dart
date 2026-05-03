import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/banco_agencia_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/banco_agencia_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class BancoAgenciaRepository {
  final BancoAgenciaApiProvider bancoAgenciaApiProvider;
  final BancoAgenciaDriftProvider bancoAgenciaDriftProvider;

  BancoAgenciaRepository({required this.bancoAgenciaApiProvider, required this.bancoAgenciaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await bancoAgenciaDriftProvider.getList(filter: filter);
    } else {
      return await bancoAgenciaApiProvider.getList(filter: filter);
    }
  }

  Future<BancoAgenciaModel?>? save({required BancoAgenciaModel bancoAgenciaModel}) async {
    if (bancoAgenciaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await bancoAgenciaDriftProvider.update(bancoAgenciaModel);
      } else {
        return await bancoAgenciaApiProvider.update(bancoAgenciaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await bancoAgenciaDriftProvider.insert(bancoAgenciaModel);
      } else {
        return await bancoAgenciaApiProvider.insert(bancoAgenciaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await bancoAgenciaDriftProvider.delete(id) ?? false;
    } else {
      return await bancoAgenciaApiProvider.delete(id) ?? false;
    }
  }
}