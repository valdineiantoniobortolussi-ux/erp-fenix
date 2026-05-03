import 'package:contratos/app/infra/constants.dart';
import 'package:contratos/app/data/provider/api/view_pessoa_fornecedor_api_provider.dart';
import 'package:contratos/app/data/provider/drift/view_pessoa_fornecedor_drift_provider.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ViewPessoaFornecedorRepository {
  final ViewPessoaFornecedorApiProvider viewPessoaFornecedorApiProvider;
  final ViewPessoaFornecedorDriftProvider viewPessoaFornecedorDriftProvider;

  ViewPessoaFornecedorRepository({required this.viewPessoaFornecedorApiProvider, required this.viewPessoaFornecedorDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaFornecedorDriftProvider.getList(filter: filter);
    } else {
      return await viewPessoaFornecedorApiProvider.getList(filter: filter);
    }
  }

  Future<ViewPessoaFornecedorModel?>? save({required ViewPessoaFornecedorModel viewPessoaFornecedorModel}) async {
    if (viewPessoaFornecedorModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaFornecedorDriftProvider.update(viewPessoaFornecedorModel);
      } else {
        return await viewPessoaFornecedorApiProvider.update(viewPessoaFornecedorModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaFornecedorDriftProvider.insert(viewPessoaFornecedorModel);
      } else {
        return await viewPessoaFornecedorApiProvider.insert(viewPessoaFornecedorModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaFornecedorDriftProvider.delete(id) ?? false;
    } else {
      return await viewPessoaFornecedorApiProvider.delete(id) ?? false;
    }
  }
}