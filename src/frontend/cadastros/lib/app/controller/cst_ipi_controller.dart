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
import 'package:cadastros/app/data/repository/cst_ipi_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class CstIpiController extends GetxController with ControllerBaseMixin {
  final CstIpiRepository cstIpiRepository;
  CstIpiController({required this.cstIpiRepository});

  // general
  final _dbColumns = CstIpiModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CstIpiModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cstIpiGridColumns();
  
  var _cstIpiModelList = <CstIpiModel>[];

  final _cstIpiModel = CstIpiModel().obs;
  CstIpiModel get cstIpiModel => _cstIpiModel.value;
  set cstIpiModel(value) => _cstIpiModel.value = value ?? CstIpiModel();

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
    for (var cstIpiModel in _cstIpiModelList) {
      plutoRowList.add(_getPlutoRow(cstIpiModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CstIpiModel cstIpiModel) {
    return PlutoRow(
      cells: _getPlutoCells(cstIpiModel: cstIpiModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CstIpiModel? cstIpiModel}) {
    return {
			"id": PlutoCell(value: cstIpiModel?.id ?? 0),
			"codigo": PlutoCell(value: cstIpiModel?.codigo ?? ''),
			"descricao": PlutoCell(value: cstIpiModel?.descricao ?? ''),
			"observacao": PlutoCell(value: cstIpiModel?.observacao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cstIpiModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cstIpiModel.plutoRowToObject(plutoRow);
    } else {
      cstIpiModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [CST IPI]';
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
    await Get.find<CstIpiController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cstIpiRepository.getList(filter: filter).then( (data){ _cstIpiModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'CST IPI',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cstIpiEditPage)!.then((value) {
        if (cstIpiModel.id == 0) {
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
    cstIpiModel = CstIpiModel();
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
        if (await cstIpiRepository.delete(id: currentRow.cells['id']!.value)) {
          _cstIpiModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoController = TextEditingController();
	final descricaoController = TextEditingController();
	final observacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cstIpiModel.id;
		plutoRow.cells['codigo']?.value = cstIpiModel.codigo;
		plutoRow.cells['descricao']?.value = cstIpiModel.descricao;
		plutoRow.cells['observacao']?.value = cstIpiModel.observacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cstIpiRepository.save(cstIpiModel: cstIpiModel); 
        if (result != null) {
          cstIpiModel = result;
          if (_isInserting) {
            _cstIpiModelList.add(result);
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
		functionName = "cst_ipi";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		descricaoController.dispose();
		observacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}