import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/pessoa_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/pessoa_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class PessoaRepository {
  final PessoaApiProvider pessoaApiProvider;
  final PessoaDriftProvider pessoaDriftProvider;

  PessoaRepository({required this.pessoaApiProvider, required this.pessoaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pessoaDriftProvider.getList(filter: filter);
    } else {
      return await pessoaApiProvider.getList(filter: filter);
    }
  }

  Future<PessoaModel?>? save({required PessoaModel pessoaModel}) async {
    if (pessoaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pessoaDriftProvider.update(pessoaModel);
      } else {
        return await pessoaApiProvider.update(pessoaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pessoaDriftProvider.insert(pessoaModel);
      } else {
        return await pessoaApiProvider.insert(pessoaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pessoaDriftProvider.delete(id) ?? false;
    } else {
      return await pessoaApiProvider.delete(id) ?? false;
    }
  }
}