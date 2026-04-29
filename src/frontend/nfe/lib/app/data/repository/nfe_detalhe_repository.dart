import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_detalhe_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_detalhe_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeDetalheRepository {
  final NfeDetalheApiProvider nfeDetalheApiProvider;
  final NfeDetalheDriftProvider nfeDetalheDriftProvider;

  NfeDetalheRepository({required this.nfeDetalheApiProvider, required this.nfeDetalheDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeDetalheDriftProvider.getList(filter: filter);
    } else {
      return await nfeDetalheApiProvider.getList(filter: filter);
    }
  }

  Future<NfeDetalheModel?>? save({required NfeDetalheModel nfeDetalheModel}) async {
    if (nfeDetalheModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeDetalheDriftProvider.update(nfeDetalheModel);
      } else {
        return await nfeDetalheApiProvider.update(nfeDetalheModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeDetalheDriftProvider.insert(nfeDetalheModel);
      } else {
        return await nfeDetalheApiProvider.insert(nfeDetalheModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeDetalheDriftProvider.delete(id) ?? false;
    } else {
      return await nfeDetalheApiProvider.delete(id) ?? false;
    }
  }
}