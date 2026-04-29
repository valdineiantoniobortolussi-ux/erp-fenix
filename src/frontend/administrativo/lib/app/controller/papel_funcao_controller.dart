import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/provider/api/funcao_api_provider.dart';

class PapelFuncaoController extends ControllerBase<PapelFuncaoModel, void> {

  PapelFuncaoController() : super(repository: null) {
    dbColumns = PapelFuncaoModel.dbColumns;
    aliasColumns = PapelFuncaoModel.aliasColumns;
    gridColumns = papelFuncaoGridColumns();
    functionName = "papel_funcao";
    screenTitle = "Controle de Acesso";
  }

  final _papelFuncaoModel = PapelFuncaoModel().obs;
  PapelFuncaoModel get papelFuncaoModel => _papelFuncaoModel.value;
  set papelFuncaoModel(value) => _papelFuncaoModel.value = value ?? PapelFuncaoModel();

  List<PapelFuncaoModel> get papelFuncaoModelList => Get.find<PapelController>().currentModel.papelFuncaoModelList ?? [];

  final _userMadeChanges = false.obs;
  get userMadeChanges => _userMadeChanges.value;
  set userMadeChanges(value) => _userMadeChanges.value = value;

  final _formWasChangedDetail = false.obs;
  bool get formWasChangedDetail => _formWasChangedDetail.value;
  set formWasChangedDetail(value) => _formWasChangedDetail.value = value;

  late PlutoGridStateManager _plutoGridStateManager;
  @override
  PlutoGridStateManager get plutoGridStateManager => _plutoGridStateManager;
  @override
  set plutoGridStateManager(value) => _plutoGridStateManager = value;

  final papelFuncaoScaffoldKey = GlobalKey<ScaffoldState>();
  final papelFuncaoFormKey = GlobalKey<FormState>();

  @override
  PapelFuncaoModel createNewModel() => PapelFuncaoModel();

  @override
  final standardFieldForFilter = PapelFuncaoModel.aliasColumns[PapelFuncaoModel.dbColumns.indexOf('habilitado')];

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['habilitado'],
    'secondaryColumns': ['pode_inserir'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((papelFuncao) => papelFuncao.toJson).toList();
  }

  @override
  List<PlutoRow> plutoRows() => List<PlutoRow>.from(papelFuncaoModelList.map((model) => model.toPlutoRow()));

  @override
  Future<void> getList({Filter? filter}) async {}

  @override
  void prepareForInsert() {
  }

  @override
  void selectRowForEditing(PlutoRow? row) async {
  }

  @override
  void selectRowForEditingById(int id) {}

  void selectRowForEditingByTempId(String tempId) {
  }

  void updateControllersFromModel() {
  }

  @override
  Future<void> save() async {
  }

  void gerarFuncoes() {
    showQuestionDialog("Deseja gerar as funções? O conteúdo atual será apagado.", () 
      async {
        _plutoGridStateManager.setShowLoading(true);

        papelFuncaoModelList.clear();
        _plutoGridStateManager.removeAllRows();
        
        FuncaoApiProvider funcaoApiProvider = FuncaoApiProvider();
        final listaFuncoes = await funcaoApiProvider.getList();
        if (listaFuncoes != null) {
          for (var funcao in listaFuncoes) {
            final papelFuncao = PapelFuncaoModel(
              idFuncao: funcao.id,
              funcaoModel: FuncaoModel(
                id: funcao.id,
                nome: funcao.nome,
                descricao: funcao.descricao,
              )
            );
            papelFuncaoModelList.add(papelFuncao);
          }
        }

        _plutoGridStateManager.appendRows(plutoRows());
        _plutoGridStateManager.setShowLoading(false);

        userMadeChanges = true;
      }
    ); 
  }

  void atualizarValorDaCelula(PlutoGridOnRowDoubleTapEvent event) {
    // Obtenha a célula clicada
    final celulaPressionada = event.cell;

    const camposAlvo = ['habilitado', 'podeInserir', 'podeAlterar', 'podeExcluir'];  
    
    // Atualiza dados visuais na celula
    final currentValue = celulaPressionada.value as String?;
    String? newValue;

    if (camposAlvo.contains(celulaPressionada.column.field)) {
      // Aplique a lógica de alternância
      if (currentValue == null || currentValue.isEmpty) {
        newValue = 'Sim';
      } else if (currentValue == 'Sim') {
        newValue = 'Não';
      } else if (currentValue == 'Não') {
        newValue = 'Sim';
      }

      // Atualize o valor da célula
      celulaPressionada.value = newValue;

      // Notifique o estado do PlutoGrid para atualizar a UI
      _plutoGridStateManager.notifyListeners();    

      // pega o objeto da lista papelFuncaoModelList
      final idFuncao = event.row.cells['idFuncao']?.value as int;
      final objetoPapelFuncao = papelFuncaoModelList.firstWhere(
        (model) => model.idFuncao == idFuncao,
      );
      switch (celulaPressionada.column.field) {
        case 'habilitado':
          objetoPapelFuncao.habilitado = newValue;
          break;
        case 'podeInserir':
          objetoPapelFuncao.podeInserir = newValue;
          break;
        case 'podeAlterar':
          objetoPapelFuncao.podeAlterar = newValue;
          break;
        case 'podeExcluir':
          objetoPapelFuncao.podeExcluir = newValue;
          break;
      }  
      
      // marca que o usuário fez alterações para salvar a lista
      userMadeChanges = true;
    }
  }

}