import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/patrim_tipo_movimentacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_tipo_movimentacao_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimTipoMovimentacaoRepository {
  final PatrimTipoMovimentacaoApiProvider patrimTipoMovimentacaoApiProvider;
  final PatrimTipoMovimentacaoDriftProvider patrimTipoMovimentacaoDriftProvider;

  PatrimTipoMovimentacaoRepository({required this.patrimTipoMovimentacaoApiProvider, required this.patrimTipoMovimentacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimTipoMovimentacaoDriftProvider.getList(filter: filter);
    } else {
      return await patrimTipoMovimentacaoApiProvider.getList(filter: filter);
    }
  }

  Future<PatrimTipoMovimentacaoModel?>? save({required PatrimTipoMovimentacaoModel patrimTipoMovimentacaoModel}) async {
    if (patrimTipoMovimentacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await patrimTipoMovimentacaoDriftProvider.update(patrimTipoMovimentacaoModel);
      } else {
        return await patrimTipoMovimentacaoApiProvider.update(patrimTipoMovimentacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await patrimTipoMovimentacaoDriftProvider.insert(patrimTipoMovimentacaoModel);
      } else {
        return await patrimTipoMovimentacaoApiProvider.insert(patrimTipoMovimentacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimTipoMovimentacaoDriftProvider.delete(id) ?? false;
    } else {
      return await patrimTipoMovimentacaoApiProvider.delete(id) ?? false;
    }
  }
}