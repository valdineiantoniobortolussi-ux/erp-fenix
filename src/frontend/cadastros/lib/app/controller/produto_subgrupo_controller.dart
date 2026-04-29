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
import 'package:cadastros/app/data/repository/produto_subgrupo_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class ProdutoSubgrupoController extends GetxController with ControllerBaseMixin {
  final ProdutoSubgrupoRepository produtoSubgrupoRepository;
  ProdutoSubgrupoController({required this.produtoSubgrupoRepository});

  // general
  final _dbColumns = ProdutoSubgrupoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ProdutoSubgrupoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = produtoSubgrupoGridColumns();
  
  var _produtoSubgrupoModelList = <ProdutoSubgrupoModel>[];

  final _produtoSubgrupoModel = ProdutoSubgrupoModel().obs;
  ProdutoSubgrupoModel get produtoSubgrupoModel => _produtoSubgrupoModel.value;
  set produtoSubgrupoModel(value) => _produtoSubgrupoModel.value = value ?? ProdutoSubgrupoModel();

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
    for (var produtoSubgrupoModel in _produtoSubgrupoModelList) {
      plutoRowList.add(_getPlutoRow(produtoSubgrupoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ProdutoSubgrupoModel produtoSubgrupoModel) {
    return PlutoRow(
      cells: _getPlutoCells(produtoSubgrupoModel: produtoSubgrupoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ProdutoSubgrupoModel? produtoSubgrupoModel}) {
    return {
			"id": PlutoCell(value: produtoSubgrupoModel?.id ?? 0),
			"produtoGrupo": PlutoCell(value: produtoSubgrupoModel?.produtoGrupoModel?.nome ?? ''),
			"nome": PlutoCell(value: produtoSubgrupoModel?.nome ?? ''),
			"descricao": PlutoCell(value: produtoSubgrupoModel?.descricao ?? ''),
			"idProdutoGrupo": PlutoCell(value: produtoSubgrupoModel?.idProdutoGrupo ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _produtoSubgrupoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      produtoSubgrupoModel.plutoRowToObject(plutoRow);
    } else {
      produtoSubgrupoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Subgrupo Produto]';
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
    await Get.find<ProdutoSubgrupoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await produtoSubgrupoRepository.getList(filter: filter).then( (data){ _produtoSubgrupoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Subgrupo Produto',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			produtoGrupoModelController.text = currentRow.cells['produtoGrupo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.produtoSubgrupoEditPage)!.then((value) {
        if (produtoSubgrupoModel.id == 0) {
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
    produtoSubgrupoModel = ProdutoSubgrupoModel();
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
        if (await produtoSubgrupoRepository.delete(id: currentRow.cells['id']!.value)) {
          _produtoSubgrupoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final produtoGrupoModelController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = produtoSubgrupoModel.id;
		plutoRow.cells['idProdutoGrupo']?.value = produtoSubgrupoModel.idProdutoGrupo;
		plutoRow.cells['produtoGrupo']?.value = produtoSubgrupoModel.produtoGrupoModel?.nome;
		plutoRow.cells['nome']?.value = produtoSubgrupoModel.nome;
		plutoRow.cells['descricao']?.value = produtoSubgrupoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await produtoSubgrupoRepository.save(produtoSubgrupoModel: produtoSubgrupoModel); 
        if (result != null) {
          produtoSubgrupoModel = result;
          if (_isInserting) {
            _produtoSubgrupoModelList.add(result);
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

	Future callProdutoGrupoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Grupo]'; 
		lookupController.route = '/produto-grupo/'; 
		lookupController.gridColumns = produtoGrupoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoGrupoModel.aliasColumns; 
		lookupController.dbColumns = ProdutoGrupoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			produtoSubgrupoModel.idProdutoGrupo = plutoRowResult.cells['id']!.value; 
			produtoSubgrupoModel.produtoGrupoModel!.plutoRowToObject(plutoRowResult); 
			produtoGrupoModelController.text = produtoSubgrupoModel.produtoGrupoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "produto_subgrupo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		produtoGrupoModelController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}