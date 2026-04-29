import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_fechamento_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilFechamentoController extends GetxController with ControllerBaseMixin {
  final ContabilFechamentoRepository contabilFechamentoRepository;
  ContabilFechamentoController({required this.contabilFechamentoRepository});

  // general
  final _dbColumns = ContabilFechamentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilFechamentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilFechamentoGridColumns();
  
  var _contabilFechamentoModelList = <ContabilFechamentoModel>[];

  final _contabilFechamentoModel = ContabilFechamentoModel().obs;
  ContabilFechamentoModel get contabilFechamentoModel => _contabilFechamentoModel.value;
  set contabilFechamentoModel(value) => _contabilFechamentoModel.value = value ?? ContabilFechamentoModel();

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
    for (var contabilFechamentoModel in _contabilFechamentoModelList) {
      plutoRowList.add(_getPlutoRow(contabilFechamentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilFechamentoModel contabilFechamentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilFechamentoModel: contabilFechamentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilFechamentoModel? contabilFechamentoModel}) {
    return {
			"id": PlutoCell(value: contabilFechamentoModel?.id ?? 0),
			"dataInicio": PlutoCell(value: contabilFechamentoModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: contabilFechamentoModel?.dataFim ?? ''),
			"criterioLancamento": PlutoCell(value: contabilFechamentoModel?.criterioLancamento ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilFechamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilFechamentoModel.plutoRowToObject(plutoRow);
    } else {
      contabilFechamentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Fechamento]';
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
    await Get.find<ContabilFechamentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilFechamentoRepository.getList(filter: filter).then( (data){ _contabilFechamentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Fechamento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilFechamentoEditPage)!.then((value) {
        if (contabilFechamentoModel.id == 0) {
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
    contabilFechamentoModel = ContabilFechamentoModel();
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
        if (await contabilFechamentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilFechamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilFechamentoModel.id;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(contabilFechamentoModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(contabilFechamentoModel.dataFim);
		plutoRow.cells['criterioLancamento']?.value = contabilFechamentoModel.criterioLancamento;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilFechamentoRepository.save(contabilFechamentoModel: contabilFechamentoModel); 
        if (result != null) {
          contabilFechamentoModel = result;
          if (_isInserting) {
            _contabilFechamentoModelList.add(result);
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
		functionName = "contabil_fechamento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}