import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/view_pessoa_vendedor_api_provider.dart';
import 'package:nfe/app/data/provider/drift/view_pessoa_vendedor_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaVendedorRepository {
  final ViewPessoaVendedorApiProvider viewPessoaVendedorApiProvider;
  final ViewPessoaVendedorDriftProvider viewPessoaVendedorDriftProvider;

  ViewPessoaVendedorRepository({required this.viewPessoaVendedorApiProvider, required this.viewPessoaVendedorDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaVendedorDriftProvider.getList(filter: filter);
    } else {
      return await viewPessoaVendedorApiProvider.getList(filter: filter);
    }
  }

  Future<ViewPessoaVendedorModel?>? save({required ViewPessoaVendedorModel viewPessoaVendedorModel}) async {
    if (viewPessoaVendedorModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaVendedorDriftProvider.update(viewPessoaVendedorModel);
      } else {
        return await viewPessoaVendedorApiProvider.update(viewPessoaVendedorModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaVendedorDriftProvider.insert(viewPessoaVendedorModel);
      } else {
        return await viewPessoaVendedorApiProvider.insert(viewPessoaVendedorModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaVendedorDriftProvider.delete(id) ?? false;
    } else {
      return await viewPessoaVendedorApiProvider.delete(id) ?? false;
    }
  }
}