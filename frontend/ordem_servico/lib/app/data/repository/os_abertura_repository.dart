import 'package:ordem_servico/app/infra/constants.dart';
import 'package:ordem_servico/app/data/provider/api/os_abertura_api_provider.dart';
import 'package:ordem_servico/app/data/provider/drift/os_abertura_drift_provider.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class OsAberturaRepository {
  final OsAberturaApiProvider osAberturaApiProvider;
  final OsAberturaDriftProvider osAberturaDriftProvider;

  OsAberturaRepository({required this.osAberturaApiProvider, required this.osAberturaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await osAberturaDriftProvider.getList(filter: filter);
    } else {
      return await osAberturaApiProvider.getList(filter: filter);
    }
  }

  Future<OsAberturaModel?>? save({required OsAberturaModel osAberturaModel}) async {
    if (osAberturaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await osAberturaDriftProvider.update(osAberturaModel);
      } else {
        return await osAberturaApiProvider.update(osAberturaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await osAberturaDriftProvider.insert(osAberturaModel);
      } else {
        return await osAberturaApiProvider.insert(osAberturaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await osAberturaDriftProvider.delete(id) ?? false;
    } else {
      return await osAberturaApiProvider.delete(id) ?? false;
    }
  }
}