import 'package:estoque/app/infra/constants.dart';
import 'package:estoque/app/data/provider/api/estoque_grade_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_grade_drift_provider.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueGradeRepository {
  final EstoqueGradeApiProvider estoqueGradeApiProvider;
  final EstoqueGradeDriftProvider estoqueGradeDriftProvider;

  EstoqueGradeRepository({required this.estoqueGradeApiProvider, required this.estoqueGradeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueGradeDriftProvider.getList(filter: filter);
    } else {
      return await estoqueGradeApiProvider.getList(filter: filter);
    }
  }

  Future<EstoqueGradeModel?>? save({required EstoqueGradeModel estoqueGradeModel}) async {
    if (estoqueGradeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await estoqueGradeDriftProvider.update(estoqueGradeModel);
      } else {
        return await estoqueGradeApiProvider.update(estoqueGradeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await estoqueGradeDriftProvider.insert(estoqueGradeModel);
      } else {
        return await estoqueGradeApiProvider.insert(estoqueGradeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await estoqueGradeDriftProvider.delete(id) ?? false;
    } else {
      return await estoqueGradeApiProvider.delete(id) ?? false;
    }
  }
}