import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/controller/controller_imports.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/page/grid_columns/grid_columns_imports.dart';

import 'package:ordem_servico/app/routes/app_routes.dart';
import 'package:ordem_servico/app/data/repository/os_status_repository.dart';
import 'package:ordem_servico/app/page/shared_page/shared_page_imports.dart';
import 'package:ordem_servico/app/page/shared_widget/message_dialog.dart';
import 'package:ordem_servico/app/mixin/controller_base_mixin.dart';

class OsStatusController extends GetxController with ControllerBaseMixin {
  final OsStatusRepository osStatusRepository;
  OsStatusController({required this.osStatusRepository});

  // general
  final _dbColumns = OsStatusModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = OsStatusModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = osStatusGridColumns();
  
  var _osStatusModelList = <OsStatusModel>[];

  final _osStatusModel = OsStatusModel().obs;
  OsStatusModel get osStatusModel => _osStatusModel.value;
  set osStatusModel(value) => _osStatusModel.value = value ?? OsStatusModel();

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
    for (var osStatusModel in _osStatusModelList) {
      plutoRowList.add(_getPlutoRow(osStatusModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(OsStatusModel osStatusModel) {
    return PlutoRow(
      cells: _getPlutoCells(osStatusModel: osStatusModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ OsStatusModel? osStatusModel}) {
    return {
			"id": PlutoCell(value: osStatusModel?.id ?? 0),
			"codigo": PlutoCell(value: osStatusModel?.codigo ?? ''),
			"nome": PlutoCell(value: osStatusModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _osStatusModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      osStatusModel.plutoRowToObject(plutoRow);
    } else {
      osStatusModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Status da OS]';
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
    await Get.find<OsStatusController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await osStatusRepository.getList(filter: filter).then( (data){ _osStatusModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Status da OS',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.osStatusEditPage)!.then((value) {
        if (osStatusModel.id == 0) {
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
    osStatusModel = OsStatusModel();
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
        if (await osStatusRepository.delete(id: currentRow.cells['id']!.value)) {
          _osStatusModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = osStatusModel.id;
		plutoRow.cells['codigo']?.value = osStatusModel.codigo;
		plutoRow.cells['nome']?.value = osStatusModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await osStatusRepository.save(osStatusModel: osStatusModel); 
        if (result != null) {
          osStatusModel = result;
          if (_isInserting) {
            _osStatusModelList.add(result);
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
		functionName = "os_status";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}