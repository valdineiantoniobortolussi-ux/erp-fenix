import 'package:ordem_servico/app/infra/constants.dart';
import 'package:ordem_servico/app/data/provider/api/view_pessoa_colaborador_api_provider.dart';
import 'package:ordem_servico/app/data/provider/drift/view_pessoa_colaborador_drift_provider.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class ViewPessoaColaboradorRepository {
  final ViewPessoaColaboradorApiProvider viewPessoaColaboradorApiProvider;
  final ViewPessoaColaboradorDriftProvider viewPessoaColaboradorDriftProvider;

  ViewPessoaColaboradorRepository({required this.viewPessoaColaboradorApiProvider, required this.viewPessoaColaboradorDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaColaboradorDriftProvider.getList(filter: filter);
    } else {
      return await viewPessoaColaboradorApiProvider.getList(filter: filter);
    }
  }

  Future<ViewPessoaColaboradorModel?>? save({required ViewPessoaColaboradorModel viewPessoaColaboradorModel}) async {
    if (viewPessoaColaboradorModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaColaboradorDriftProvider.update(viewPessoaColaboradorModel);
      } else {
        return await viewPessoaColaboradorApiProvider.update(viewPessoaColaboradorModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await viewPessoaColaboradorDriftProvider.insert(viewPessoaColaboradorModel);
      } else {
        return await viewPessoaColaboradorApiProvider.insert(viewPessoaColaboradorModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await viewPessoaColaboradorDriftProvider.delete(id) ?? false;
    } else {
      return await viewPessoaColaboradorApiProvider.delete(id) ?? false;
    }
  }
}