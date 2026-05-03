import 'package:projetos/app/infra/constants.dart';
import 'package:projetos/app/data/provider/api/projeto_principal_api_provider.dart';
import 'package:projetos/app/data/provider/drift/projeto_principal_drift_provider.dart';
import 'package:projetos/app/data/model/model_imports.dart';

class ProjetoPrincipalRepository {
  final ProjetoPrincipalApiProvider projetoPrincipalApiProvider;
  final ProjetoPrincipalDriftProvider projetoPrincipalDriftProvider;

  ProjetoPrincipalRepository({required this.projetoPrincipalApiProvider, required this.projetoPrincipalDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await projetoPrincipalDriftProvider.getList(filter: filter);
    } else {
      return await projetoPrincipalApiProvider.getList(filter: filter);
    }
  }

  Future<ProjetoPrincipalModel?>? save({required ProjetoPrincipalModel projetoPrincipalModel}) async {
    if (projetoPrincipalModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await projetoPrincipalDriftProvider.update(projetoPrincipalModel);
      } else {
        return await projetoPrincipalApiProvider.update(projetoPrincipalModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await projetoPrincipalDriftProvider.insert(projetoPrincipalModel);
      } else {
        return await projetoPrincipalApiProvider.insert(projetoPrincipalModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await projetoPrincipalDriftProvider.delete(id) ?? false;
    } else {
      return await projetoPrincipalApiProvider.delete(id) ?? false;
    }
  }
}