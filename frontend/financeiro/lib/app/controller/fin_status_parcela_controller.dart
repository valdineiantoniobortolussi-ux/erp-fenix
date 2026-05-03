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
import 'package:financeiro/app/data/repository/fin_status_parcela_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinStatusParcelaController extends GetxController with ControllerBaseMixin {
  final FinStatusParcelaRepository finStatusParcelaRepository;
  FinStatusParcelaController({required this.finStatusParcelaRepository});

  // general
  final _dbColumns = FinStatusParcelaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinStatusParcelaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finStatusParcelaGridColumns();
  
  var _finStatusParcelaModelList = <FinStatusParcelaModel>[];

  final _finStatusParcelaModel = FinStatusParcelaModel().obs;
  FinStatusParcelaModel get finStatusParcelaModel => _finStatusParcelaModel.value;
  set finStatusParcelaModel(value) => _finStatusParcelaModel.value = value ?? FinStatusParcelaModel();

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
    for (var finStatusParcelaModel in _finStatusParcelaModelList) {
      plutoRowList.add(_getPlutoRow(finStatusParcelaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinStatusParcelaModel finStatusParcelaModel) {
    return PlutoRow(
      cells: _getPlutoCells(finStatusParcelaModel: finStatusParcelaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinStatusParcelaModel? finStatusParcelaModel}) {
    return {
			"id": PlutoCell(value: finStatusParcelaModel?.id ?? 0),
			"situacao": PlutoCell(value: finStatusParcelaModel?.situacao ?? ''),
			"descricao": PlutoCell(value: finStatusParcelaModel?.descricao ?? ''),
			"procedimento": PlutoCell(value: finStatusParcelaModel?.procedimento ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finStatusParcelaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finStatusParcelaModel.plutoRowToObject(plutoRow);
    } else {
      finStatusParcelaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Status Parcela]';
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
    await Get.find<FinStatusParcelaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finStatusParcelaRepository.getList(filter: filter).then( (data){ _finStatusParcelaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Status Parcela',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			procedimentoController.text = currentRow.cells['procedimento']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finStatusParcelaEditPage)!.then((value) {
        if (finStatusParcelaModel.id == 0) {
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
    finStatusParcelaModel = FinStatusParcelaModel();
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
        if (await finStatusParcelaRepository.delete(id: currentRow.cells['id']!.value)) {
          _finStatusParcelaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final procedimentoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finStatusParcelaModel.id;
		plutoRow.cells['situacao']?.value = finStatusParcelaModel.situacao;
		plutoRow.cells['descricao']?.value = finStatusParcelaModel.descricao;
		plutoRow.cells['procedimento']?.value = finStatusParcelaModel.procedimento;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finStatusParcelaRepository.save(finStatusParcelaModel: finStatusParcelaModel); 
        if (result != null) {
          finStatusParcelaModel = result;
          if (_isInserting) {
            _finStatusParcelaModelList.add(result);
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
		functionName = "fin_status_parcela";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		descricaoController.dispose();
		procedimentoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}