import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_importacao_detalhe_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_importacao_detalhe_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeImportacaoDetalheRepository {
  final NfeImportacaoDetalheApiProvider nfeImportacaoDetalheApiProvider;
  final NfeImportacaoDetalheDriftProvider nfeImportacaoDetalheDriftProvider;

  NfeImportacaoDetalheRepository({required this.nfeImportacaoDetalheApiProvider, required this.nfeImportacaoDetalheDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeImportacaoDetalheDriftProvider.getList(filter: filter);
    } else {
      return await nfeImportacaoDetalheApiProvider.getList(filter: filter);
    }
  }

  Future<NfeImportacaoDetalheModel?>? save({required NfeImportacaoDetalheModel nfeImportacaoDetalheModel}) async {
    if (nfeImportacaoDetalheModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeImportacaoDetalheDriftProvider.update(nfeImportacaoDetalheModel);
      } else {
        return await nfeImportacaoDetalheApiProvider.update(nfeImportacaoDetalheModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeImportacaoDetalheDriftProvider.insert(nfeImportacaoDetalheModel);
      } else {
        return await nfeImportacaoDetalheApiProvider.insert(nfeImportacaoDetalheModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeImportacaoDetalheDriftProvider.delete(id) ?? false;
    } else {
      return await nfeImportacaoDetalheApiProvider.delete(id) ?? false;
    }
  }
}