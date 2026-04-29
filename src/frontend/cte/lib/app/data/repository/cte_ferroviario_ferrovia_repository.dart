import 'package:cte/app/infra/constants.dart';
import 'package:cte/app/data/provider/api/cte_ferroviario_ferrovia_api_provider.dart';
import 'package:cte/app/data/provider/drift/cte_ferroviario_ferrovia_drift_provider.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteFerroviarioFerroviaRepository {
  final CteFerroviarioFerroviaApiProvider cteFerroviarioFerroviaApiProvider;
  final CteFerroviarioFerroviaDriftProvider cteFerroviarioFerroviaDriftProvider;

  CteFerroviarioFerroviaRepository({required this.cteFerroviarioFerroviaApiProvider, required this.cteFerroviarioFerroviaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await cteFerroviarioFerroviaDriftProvider.getList(filter: filter);
    } else {
      return await cteFerroviarioFerroviaApiProvider.getList(filter: filter);
    }
  }

  Future<CteFerroviarioFerroviaModel?>? save({required CteFerroviarioFerroviaModel cteFerroviarioFerroviaModel}) async {
    if (cteFerroviarioFerroviaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await cteFerroviarioFerroviaDriftProvider.update(cteFerroviarioFerroviaModel);
      } else {
        return await cteFerroviarioFerroviaApiProvider.update(cteFerroviarioFerroviaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await cteFerroviarioFerroviaDriftProvider.insert(cteFerroviarioFerroviaModel);
      } else {
        return await cteFerroviarioFerroviaApiProvider.insert(cteFerroviarioFerroviaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await cteFerroviarioFerroviaDriftProvider.delete(id) ?? false;
    } else {
      return await cteFerroviarioFerroviaApiProvider.delete(id) ?? false;
    }
  }
}