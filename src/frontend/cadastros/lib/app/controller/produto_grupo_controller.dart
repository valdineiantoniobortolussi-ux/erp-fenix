import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/produto_grupo_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class ProdutoGrupoController extends GetxController with ControllerBaseMixin {
  final ProdutoGrupoRepository produtoGrupoRepository;
  ProdutoGrupoController({required this.produtoGrupoRepository});

  // general
  final _dbColumns = ProdutoGrupoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ProdutoGrupoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = produtoGrupoGridColumns();
  
  var _produtoGrupoModelList = <ProdutoGrupoModel>[];

  final _produtoGrupoModel = ProdutoGrupoModel().obs;
  ProdutoGrupoModel get produtoGrupoModel => _produtoGrupoModel.value;
  set produtoGrupoModel(value) => _produtoGrupoModel.value = value ?? ProdutoGrupoModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter(); 

  var _isInserting = false;

  // list page
  late StreamSubscription _keyboardListener;
  get keyboardListener => _keyboardListener;
  set keyboardListener(value) => _keyboardListener = value;

  late PlutoGridStateManager _plutoGridStateManager;
  get plutoGridStateManager => _plutoGridStateManager;
  set plutoGridStateManager(value) => _plutoGridStateManager = value;

  final _plutoRow = PlutoRow(cells: {}).obs;
  get plutoRow => _plutoRow.value;
  set plutoRow(value) => _plutoRow.value = value;

  List<PlutoRow> plutoRows() {
    List<PlutoRow> plutoRowList = <PlutoRow>[];
    for (var produtoGrupoModel in _produtoGrupoModelList) {
      plutoRowList.add(_getPlutoRow(produtoGrupoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ProdutoGrupoModel produtoGrupoModel) {
    return PlutoRow(
      cells: _getPlutoCells(produtoGrupoModel: produtoGrupoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ProdutoGrupoModel? produtoGrupoModel}) {
    return {
			"id": PlutoCell(value: produtoGrupoModel?.id ?? 0),
			"nome": PlutoCell(value: produtoGrupoModel?.nome ?? ''),
			"descricao": PlutoCell(value: produtoGrupoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _produtoGrupoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      produtoGrupoModel.plutoRowToObject(plutoRow);
    } else {
      produtoGrupoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Grupo Produto]';
    filterController.standardFilter = true;
    filterController.aliasColumns = aliasColumns;
    filterController.dbColumns = dbColumns;
    filterController.filter.field = 'Id';

    filter = await Get.toNamed(Routes.filterPage);
    await loadData();
  }

  Future loadData() async {
    _plutoGridStateManager.setShowLoading(true);
    _plutoGridStateManager.removeAllRows();
    await Get.find<ProdutoGrupoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await produtoGrupoRepository.getList(filter: filter).then( (data){ _produtoGrupoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Grupo Produto',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.produtoGrupoEditPage)!.then((value) {
        if (produtoGrupoModel.id == 0) {
          _plutoGridStateManager.removeCurrentRow();
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
    }
  }

  void callEditPageToInsert() {
    _plutoGridStateManager.prependNewRows(); 
    final cell = _plutoGridStateManager.rows.first.cells.entries.elementAt(0).value;
    _plutoGridStateManager.setCurrentCell(cell, 0); 
    _isInserting = true;
    produtoGrupoModel = ProdutoGrupoModel();
    callEditPage();   
  }

  void handleKeyboard(PlutoKeyManagerEvent event) {
    if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
      if (canUpdate) {
        callEditPage();
      } else {
        noPrivilegeMessage();
      }
    }
  }  

  Future delete() async {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      showDeleteDialog(() async {
        if (await produtoGrupoRepository.delete(id: currentRow.cells['id']!.value)) {
          _produtoGrupoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
          _plutoGridStateManager.removeCurrentRow();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }


  // edit page
  final scrollController = ScrollController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = produtoGrupoModel.id;
		plutoRow.cells['nome']?.value = produtoGrupoModel.nome;
		plutoRow.cells['descricao']?.value = produtoGrupoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await produtoGrupoRepository.save(produtoGrupoModel: produtoGrupoModel); 
        if (result != null) {
          produtoGrupoModel = result;
          if (_isInserting) {
            _produtoGrupoModelList.add(result);
            _isInserting = false;
          }
          objectToPlutoRow();
          Get.back();
        }
      } else {
        Get.back();
      }
    }
  }

  void preventDataLoss() {
    if (formWasChanged) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      Get.back();
    }
  }  


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "produto_grupo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}