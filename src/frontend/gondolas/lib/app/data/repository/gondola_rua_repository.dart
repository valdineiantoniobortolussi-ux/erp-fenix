import 'package:gondolas/app/infra/constants.dart';
import 'package:gondolas/app/data/provider/api/gondola_rua_api_provider.dart';
import 'package:gondolas/app/data/provider/drift/gondola_rua_drift_provider.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaRuaRepository {
  final GondolaRuaApiProvider gondolaRuaApiProvider;
  final GondolaRuaDriftProvider gondolaRuaDriftProvider;

  GondolaRuaRepository({required this.gondolaRuaApiProvider, required this.gondolaRuaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await gondolaRuaDriftProvider.getList(filter: filter);
    } else {
      return await gondolaRuaApiProvider.getList(filter: filter);
    }
  }

  Future<GondolaRuaModel?>? save({required GondolaRuaModel gondolaRuaModel}) async {
    if (gondolaRuaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await gondolaRuaDriftProvider.update(gondolaRuaModel);
      } else {
        return await gondolaRuaApiProvider.update(gondolaRuaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await gondolaRuaDriftProvider.insert(gondolaRuaModel);
      } else {
        return await gondolaRuaApiProvider.insert(gondolaRuaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await gondolaRuaDriftProvider.delete(id) ?? false;
    } else {
      return await gondolaRuaApiProvider.delete(id) ?? false;
    }
  }
}