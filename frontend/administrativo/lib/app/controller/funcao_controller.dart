import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/repository/funcao_repository.dart';

class FuncaoController extends ControllerBase<FuncaoModel, FuncaoRepository> {

  FuncaoController({required super.repository}) {
    dbColumns = FuncaoModel.dbColumns;
    aliasColumns = FuncaoModel.aliasColumns;
    gridColumns = funcaoGridColumns();
    functionName = "funcao";
    screenTitle = "Função";
  }

  @override
  FuncaoModel createNewModel() => FuncaoModel();

  @override
  final standardFieldForFilter = FuncaoModel.aliasColumns[FuncaoModel.dbColumns.indexOf('nome')];

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['nome'],
    'secondaryColumns': ['descricao'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((funcao) => funcao.toJson).toList();
  }

  @override
  void prepareForInsert() {
  }

  @override
  void selectRowForEditingById(int id) {
  }

  @override
  Future<void> save() async {
  }

}