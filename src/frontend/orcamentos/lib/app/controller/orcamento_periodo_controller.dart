import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/controller/controller_imports.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/page/grid_columns/grid_columns_imports.dart';

import 'package:orcamentos/app/routes/app_routes.dart';
import 'package:orcamentos/app/data/repository/orcamento_periodo_repository.dart';
import 'package:orcamentos/app/page/shared_page/shared_page_imports.dart';
import 'package:orcamentos/app/page/shared_widget/message_dialog.dart';
import 'package:orcamentos/app/mixin/controller_base_mixin.dart';

class OrcamentoPeriodoController extends GetxController with ControllerBaseMixin {
  final OrcamentoPeriodoRepository orcamentoPeriodoRepository;
  OrcamentoPeriodoController({required this.orcamentoPeriodoRepository});

  // general
  final _dbColumns = OrcamentoPeriodoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = OrcamentoPeriodoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = orcamentoPeriodoGridColumns();
  
  var _orcamentoPeriodoModelList = <OrcamentoPeriodoModel>[];

  final _orcamentoPeriodoModel = OrcamentoPeriodoModel().obs;
  OrcamentoPeriodoModel get orcamentoPeriodoModel => _orcamentoPeriodoModel.value;
  set orcamentoPeriodoModel(value) => _orcamentoPeriodoModel.value = value ?? OrcamentoPeriodoModel();

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
    for (var orcamentoPeriodoModel in _orcamentoPeriodoModelList) {
      plutoRowList.add(_getPlutoRow(orcamentoPeriodoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(OrcamentoPeriodoModel orcamentoPeriodoModel) {
    return PlutoRow(
      cells: _getPlutoCells(orcamentoPeriodoModel: orcamentoPeriodoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ OrcamentoPeriodoModel? orcamentoPeriodoModel}) {
    return {
			"id": PlutoCell(value: orcamentoPeriodoModel?.id ?? 0),
			"periodo": PlutoCell(value: orcamentoPeriodoModel?.periodo ?? ''),
			"nome": PlutoCell(value: orcamentoPeriodoModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _orcamentoPeriodoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      orcamentoPeriodoModel.plutoRowToObject(plutoRow);
    } else {
      orcamentoPeriodoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Períodos do Orçamento]';
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
    await Get.find<OrcamentoPeriodoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await orcamentoPeriodoRepository.getList(filter: filter).then( (data){ _orcamentoPeriodoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Períodos do Orçamento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.orcamentoPeriodoEditPage)!.then((value) {
        if (orcamentoPeriodoModel.id == 0) {
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
    orcamentoPeriodoModel = OrcamentoPeriodoModel();
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
        if (await orcamentoPeriodoRepository.delete(id: currentRow.cells['id']!.value)) {
          _orcamentoPeriodoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = orcamentoPeriodoModel.id;
		plutoRow.cells['periodo']?.value = orcamentoPeriodoModel.periodo;
		plutoRow.cells['nome']?.value = orcamentoPeriodoModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await orcamentoPeriodoRepository.save(orcamentoPeriodoModel: orcamentoPeriodoModel); 
        if (result != null) {
          orcamentoPeriodoModel = result;
          if (_isInserting) {
            _orcamentoPeriodoModelList.add(result);
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
		functionName = "orcamento_periodo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}