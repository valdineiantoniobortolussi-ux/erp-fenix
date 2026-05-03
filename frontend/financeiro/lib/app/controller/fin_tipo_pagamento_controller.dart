import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/fin_tipo_pagamento_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinTipoPagamentoController extends GetxController with ControllerBaseMixin {
  final FinTipoPagamentoRepository finTipoPagamentoRepository;
  FinTipoPagamentoController({required this.finTipoPagamentoRepository});

  // general
  final _dbColumns = FinTipoPagamentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinTipoPagamentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finTipoPagamentoGridColumns();
  
  var _finTipoPagamentoModelList = <FinTipoPagamentoModel>[];

  final _finTipoPagamentoModel = FinTipoPagamentoModel().obs;
  FinTipoPagamentoModel get finTipoPagamentoModel => _finTipoPagamentoModel.value;
  set finTipoPagamentoModel(value) => _finTipoPagamentoModel.value = value ?? FinTipoPagamentoModel();

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
    for (var finTipoPagamentoModel in _finTipoPagamentoModelList) {
      plutoRowList.add(_getPlutoRow(finTipoPagamentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinTipoPagamentoModel finTipoPagamentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(finTipoPagamentoModel: finTipoPagamentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinTipoPagamentoModel? finTipoPagamentoModel}) {
    return {
			"id": PlutoCell(value: finTipoPagamentoModel?.id ?? 0),
			"codigo": PlutoCell(value: finTipoPagamentoModel?.codigo ?? ''),
			"descricao": PlutoCell(value: finTipoPagamentoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finTipoPagamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finTipoPagamentoModel.plutoRowToObject(plutoRow);
    } else {
      finTipoPagamentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Pagamento]';
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
    await Get.find<FinTipoPagamentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finTipoPagamentoRepository.getList(filter: filter).then( (data){ _finTipoPagamentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Pagamento',
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

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finTipoPagamentoEditPage)!.then((value) {
        if (finTipoPagamentoModel.id == 0) {
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
    finTipoPagamentoModel = FinTipoPagamentoModel();
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
        if (await finTipoPagamentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _finTipoPagamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finTipoPagamentoModel.id;
		plutoRow.cells['codigo']?.value = finTipoPagamentoModel.codigo;
		plutoRow.cells['descricao']?.value = finTipoPagamentoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finTipoPagamentoRepository.save(finTipoPagamentoModel: finTipoPagamentoModel); 
        if (result != null) {
          finTipoPagamentoModel = result;
          if (_isInserting) {
            _finTipoPagamentoModelList.add(result);
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
		functionName = "fin_tipo_pagamento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}