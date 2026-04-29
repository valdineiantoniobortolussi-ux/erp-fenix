import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/fiscal_livro_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/fiscal_livro_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalLivroRepository {
  final FiscalLivroApiProvider fiscalLivroApiProvider;
  final FiscalLivroDriftProvider fiscalLivroDriftProvider;

  FiscalLivroRepository({required this.fiscalLivroApiProvider, required this.fiscalLivroDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalLivroDriftProvider.getList(filter: filter);
    } else {
      return await fiscalLivroApiProvider.getList(filter: filter);
    }
  }

  Future<FiscalLivroModel?>? save({required FiscalLivroModel fiscalLivroModel}) async {
    if (fiscalLivroModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await fiscalLivroDriftProvider.update(fiscalLivroModel);
      } else {
        return await fiscalLivroApiProvider.update(fiscalLivroModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await fiscalLivroDriftProvider.insert(fiscalLivroModel);
      } else {
        return await fiscalLivroApiProvider.insert(fiscalLivroModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await fiscalLivroDriftProvider.delete(id) ?? false;
    } else {
      return await fiscalLivroApiProvider.delete(id) ?? false;
    }
  }
}