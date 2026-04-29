import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_lote_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilLoteController extends GetxController with ControllerBaseMixin {
  final ContabilLoteRepository contabilLoteRepository;
  ContabilLoteController({required this.contabilLoteRepository});

  // general
  final _dbColumns = ContabilLoteModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilLoteModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilLoteGridColumns();
  
  var _contabilLoteModelList = <ContabilLoteModel>[];

  final _contabilLoteModel = ContabilLoteModel().obs;
  ContabilLoteModel get contabilLoteModel => _contabilLoteModel.value;
  set contabilLoteModel(value) => _contabilLoteModel.value = value ?? ContabilLoteModel();

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
    for (var contabilLoteModel in _contabilLoteModelList) {
      plutoRowList.add(_getPlutoRow(contabilLoteModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilLoteModel contabilLoteModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilLoteModel: contabilLoteModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilLoteModel? contabilLoteModel}) {
    return {
			"id": PlutoCell(value: contabilLoteModel?.id ?? 0),
			"descricao": PlutoCell(value: contabilLoteModel?.descricao ?? ''),
			"dataInclusao": PlutoCell(value: contabilLoteModel?.dataInclusao ?? ''),
			"dataLiberacao": PlutoCell(value: contabilLoteModel?.dataLiberacao ?? ''),
			"liberado": PlutoCell(value: contabilLoteModel?.liberado ?? ''),
			"programado": PlutoCell(value: contabilLoteModel?.programado ?? ''),
			"valor": PlutoCell(value: contabilLoteModel?.valor ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilLoteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilLoteModel.plutoRowToObject(plutoRow);
    } else {
      contabilLoteModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Lote Contábil]';
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
    await Get.find<ContabilLoteController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilLoteRepository.getList(filter: filter).then( (data){ _contabilLoteModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Lote Contábil',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilLoteEditPage)!.then((value) {
        if (contabilLoteModel.id == 0) {
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
    contabilLoteModel = ContabilLoteModel();
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
        if (await contabilLoteRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilLoteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();
	final valorController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilLoteModel.id;
		plutoRow.cells['descricao']?.value = contabilLoteModel.descricao;
		plutoRow.cells['dataInclusao']?.value = Util.formatDate(contabilLoteModel.dataInclusao);
		plutoRow.cells['dataLiberacao']?.value = Util.formatDate(contabilLoteModel.dataLiberacao);
		plutoRow.cells['liberado']?.value = contabilLoteModel.liberado;
		plutoRow.cells['programado']?.value = contabilLoteModel.programado;
		plutoRow.cells['valor']?.value = contabilLoteModel.valor;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilLoteRepository.save(contabilLoteModel: contabilLoteModel); 
        if (result != null) {
          contabilLoteModel = result;
          if (_isInserting) {
            _contabilLoteModelList.add(result);
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
		functionName = "contabil_lote";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		descricaoController.dispose();
		valorController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}