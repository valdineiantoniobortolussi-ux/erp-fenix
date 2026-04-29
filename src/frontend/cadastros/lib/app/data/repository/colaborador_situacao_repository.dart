import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/colaborador_situacao_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/colaborador_situacao_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ColaboradorSituacaoRepository {
  final ColaboradorSituacaoApiProvider colaboradorSituacaoApiProvider;
  final ColaboradorSituacaoDriftProvider colaboradorSituacaoDriftProvider;

  ColaboradorSituacaoRepository({required this.colaboradorSituacaoApiProvider, required this.colaboradorSituacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await colaboradorSituacaoDriftProvider.getList(filter: filter);
    } else {
      return await colaboradorSituacaoApiProvider.getList(filter: filter);
    }
  }

  Future<ColaboradorSituacaoModel?>? save({required ColaboradorSituacaoModel colaboradorSituacaoModel}) async {
    if (colaboradorSituacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await colaboradorSituacaoDriftProvider.update(colaboradorSituacaoModel);
      } else {
        return await colaboradorSituacaoApiProvider.update(colaboradorSituacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await colaboradorSituacaoDriftProvider.insert(colaboradorSituacaoModel);
      } else {
        return await colaboradorSituacaoApiProvider.insert(colaboradorSituacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await colaboradorSituacaoDriftProvider.delete(id) ?? false;
    } else {
      return await colaboradorSituacaoApiProvider.delete(id) ?? false;
    }
  }
}