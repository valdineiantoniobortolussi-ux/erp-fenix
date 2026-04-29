import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/tipo_relacionamento_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/tipo_relacionamento_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TipoRelacionamentoRepository {
  final TipoRelacionamentoApiProvider tipoRelacionamentoApiProvider;
  final TipoRelacionamentoDriftProvider tipoRelacionamentoDriftProvider;

  TipoRelacionamentoRepository({required this.tipoRelacionamentoApiProvider, required this.tipoRelacionamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tipoRelacionamentoDriftProvider.getList(filter: filter);
    } else {
      return await tipoRelacionamentoApiProvider.getList(filter: filter);
    }
  }

  Future<TipoRelacionamentoModel?>? save({required TipoRelacionamentoModel tipoRelacionamentoModel}) async {
    if (tipoRelacionamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tipoRelacionamentoDriftProvider.update(tipoRelacionamentoModel);
      } else {
        return await tipoRelacionamentoApiProvider.update(tipoRelacionamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tipoRelacionamentoDriftProvider.insert(tipoRelacionamentoModel);
      } else {
        return await tipoRelacionamentoApiProvider.insert(tipoRelacionamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tipoRelacionamentoDriftProvider.delete(id) ?? false;
    } else {
      return await tipoRelacionamentoApiProvider.delete(id) ?? false;
    }
  }
}