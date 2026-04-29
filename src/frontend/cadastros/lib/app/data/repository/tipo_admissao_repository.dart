import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/tipo_admissao_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/tipo_admissao_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TipoAdmissaoRepository {
  final TipoAdmissaoApiProvider tipoAdmissaoApiProvider;
  final TipoAdmissaoDriftProvider tipoAdmissaoDriftProvider;

  TipoAdmissaoRepository({required this.tipoAdmissaoApiProvider, required this.tipoAdmissaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tipoAdmissaoDriftProvider.getList(filter: filter);
    } else {
      return await tipoAdmissaoApiProvider.getList(filter: filter);
    }
  }

  Future<TipoAdmissaoModel?>? save({required TipoAdmissaoModel tipoAdmissaoModel}) async {
    if (tipoAdmissaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tipoAdmissaoDriftProvider.update(tipoAdmissaoModel);
      } else {
        return await tipoAdmissaoApiProvider.update(tipoAdmissaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tipoAdmissaoDriftProvider.insert(tipoAdmissaoModel);
      } else {
        return await tipoAdmissaoApiProvider.insert(tipoAdmissaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tipoAdmissaoDriftProvider.delete(id) ?? false;
    } else {
      return await tipoAdmissaoApiProvider.delete(id) ?? false;
    }
  }
}