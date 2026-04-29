import 'package:gondolas/app/infra/constants.dart';
import 'package:gondolas/app/data/provider/api/gondola_caixa_api_provider.dart';
import 'package:gondolas/app/data/provider/drift/gondola_caixa_drift_provider.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaCaixaRepository {
  final GondolaCaixaApiProvider gondolaCaixaApiProvider;
  final GondolaCaixaDriftProvider gondolaCaixaDriftProvider;

  GondolaCaixaRepository({required this.gondolaCaixaApiProvider, required this.gondolaCaixaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await gondolaCaixaDriftProvider.getList(filter: filter);
    } else {
      return await gondolaCaixaApiProvider.getList(filter: filter);
    }
  }

  Future<GondolaCaixaModel?>? save({required GondolaCaixaModel gondolaCaixaModel}) async {
    if (gondolaCaixaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await gondolaCaixaDriftProvider.update(gondolaCaixaModel);
      } else {
        return await gondolaCaixaApiProvider.update(gondolaCaixaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await gondolaCaixaDriftProvider.insert(gondolaCaixaModel);
      } else {
        return await gondolaCaixaApiProvider.insert(gondolaCaixaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await gondolaCaixaDriftProvider.delete(id) ?? false;
    } else {
      return await gondolaCaixaApiProvider.delete(id) ?? false;
    }
  }
}