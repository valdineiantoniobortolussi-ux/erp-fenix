import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_livro_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_livro_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLivroRepository {
  final ContabilLivroApiProvider contabilLivroApiProvider;
  final ContabilLivroDriftProvider contabilLivroDriftProvider;

  ContabilLivroRepository({required this.contabilLivroApiProvider, required this.contabilLivroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLivroDriftProvider.getList(filter: filter);
    } else {
      return await contabilLivroApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilLivroModel?>? save({required ContabilLivroModel contabilLivroModel}) async {
    if (contabilLivroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilLivroDriftProvider.update(contabilLivroModel);
      } else {
        return await contabilLivroApiProvider.update(contabilLivroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilLivroDriftProvider.insert(contabilLivroModel);
      } else {
        return await contabilLivroApiProvider.insert(contabilLivroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilLivroDriftProvider.delete(id) ?? false;
    } else {
      return await contabilLivroApiProvider.delete(id) ?? false;
    }
  }
}