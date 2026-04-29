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
import 'package:cadastros/app/data/repository/produto_unidade_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class ProdutoUnidadeController extends GetxController with ControllerBaseMixin {
  final ProdutoUnidadeRepository produtoUnidadeRepository;
  ProdutoUnidadeController({required this.produtoUnidadeRepository});

  // general
  final _dbColumns = ProdutoUnidadeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ProdutoUnidadeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = produtoUnidadeGridColumns();
  
  var _produtoUnidadeModelList = <ProdutoUnidadeModel>[];

  final _produtoUnidadeModel = ProdutoUnidadeModel().obs;
  ProdutoUnidadeModel get produtoUnidadeModel => _produtoUnidadeModel.value;
  set produtoUnidadeModel(value) => _produtoUnidadeModel.value = value ?? ProdutoUnidadeModel();

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
    for (var produtoUnidadeModel in _produtoUnidadeModelList) {
      plutoRowList.add(_getPlutoRow(produtoUnidadeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ProdutoUnidadeModel produtoUnidadeModel) {
    return PlutoRow(
      cells: _getPlutoCells(produtoUnidadeModel: produtoUnidadeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ProdutoUnidadeModel? produtoUnidadeModel}) {
    return {
			"id": PlutoCell(value: produtoUnidadeModel?.id ?? 0),
			"sigla": PlutoCell(value: produtoUnidadeModel?.sigla ?? ''),
			"podeFracionar": PlutoCell(value: produtoUnidadeModel?.podeFracionar ?? ''),
			"descricao": PlutoCell(value: produtoUnidadeModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _produtoUnidadeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      produtoUnidadeModel.plutoRowToObject(plutoRow);
    } else {
      produtoUnidadeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Unidade Produto]';
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
    await Get.find<ProdutoUnidadeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await produtoUnidadeRepository.getList(filter: filter).then( (data){ _produtoUnidadeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Unidade Produto',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			siglaController.text = currentRow.cells['sigla']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.produtoUnidadeEditPage)!.then((value) {
        if (produtoUnidadeModel.id == 0) {
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
    produtoUnidadeModel = ProdutoUnidadeModel();
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
        if (await produtoUnidadeRepository.delete(id: currentRow.cells['id']!.value)) {
          _produtoUnidadeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final siglaController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = produtoUnidadeModel.id;
		plutoRow.cells['sigla']?.value = produtoUnidadeModel.sigla;
		plutoRow.cells['podeFracionar']?.value = produtoUnidadeModel.podeFracionar;
		plutoRow.cells['descricao']?.value = produtoUnidadeModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await produtoUnidadeRepository.save(produtoUnidadeModel: produtoUnidadeModel); 
        if (result != null) {
          produtoUnidadeModel = result;
          if (_isInserting) {
            _produtoUnidadeModelList.add(result);
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
		functionName = "produto_unidade";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		siglaController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}