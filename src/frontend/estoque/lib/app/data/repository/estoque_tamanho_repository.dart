import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/estoque_tamanho_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_tamanho_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueTamanhoRepository {
  final EstoqueTamanhoApiProvider estoqueTamanhoApiProvider;
  final EstoqueTamanhoDriftProvider estoqueTamanhoDriftProvider;

  EstoqueTamanhoRepository({required this.estoqueTamanhoApiProvider, required this.estoqueTamanhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueTamanhoDriftProvider.getList(filter: filter);
    } else {
      return await estoqueTamanhoApiProvider.getList(filter: filter);
    }
  }

  Future<EstoqueTamanhoModel?>? save({required EstoqueTamanhoModel estoqueTamanhoModel}) async {
    if (estoqueTamanhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await estoqueTamanhoDriftProvider.update(estoqueTamanhoModel);
      } else {
        return await estoqueTamanhoApiProvider.update(estoqueTamanhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await estoqueTamanhoDriftProvider.insert(estoqueTamanhoModel);
      } else {
        return await estoqueTamanhoApiProvider.insert(estoqueTamanhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueTamanhoDriftProvider.delete(id) ?? false;
    } else {
      return await estoqueTamanhoApiProvider.delete(id) ?? false;
    }
  }
}