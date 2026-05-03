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
import 'package:contabil/app/data/repository/contabil_historico_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilHistoricoController extends GetxController with ControllerBaseMixin {
  final ContabilHistoricoRepository contabilHistoricoRepository;
  ContabilHistoricoController({required this.contabilHistoricoRepository});

  // general
  final _dbColumns = ContabilHistoricoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilHistoricoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilHistoricoGridColumns();
  
  var _contabilHistoricoModelList = <ContabilHistoricoModel>[];

  final _contabilHistoricoModel = ContabilHistoricoModel().obs;
  ContabilHistoricoModel get contabilHistoricoModel => _contabilHistoricoModel.value;
  set contabilHistoricoModel(value) => _contabilHistoricoModel.value = value ?? ContabilHistoricoModel();

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
    for (var contabilHistoricoModel in _contabilHistoricoModelList) {
      plutoRowList.add(_getPlutoRow(contabilHistoricoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilHistoricoModel contabilHistoricoModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilHistoricoModel: contabilHistoricoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilHistoricoModel? contabilHistoricoModel}) {
    return {
			"id": PlutoCell(value: contabilHistoricoModel?.id ?? 0),
			"descricao": PlutoCell(value: contabilHistoricoModel?.descricao ?? ''),
			"pedeComplemento": PlutoCell(value: contabilHistoricoModel?.pedeComplemento ?? ''),
			"historico": PlutoCell(value: contabilHistoricoModel?.historico ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilHistoricoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilHistoricoModel.plutoRowToObject(plutoRow);
    } else {
      contabilHistoricoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Históricos]';
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
    await Get.find<ContabilHistoricoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilHistoricoRepository.getList(filter: filter).then( (data){ _contabilHistoricoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Históricos',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			historicoController.text = currentRow.cells['historico']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilHistoricoEditPage)!.then((value) {
        if (contabilHistoricoModel.id == 0) {
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
    contabilHistoricoModel = ContabilHistoricoModel();
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
        if (await contabilHistoricoRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilHistoricoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final historicoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilHistoricoModel.id;
		plutoRow.cells['descricao']?.value = contabilHistoricoModel.descricao;
		plutoRow.cells['pedeComplemento']?.value = contabilHistoricoModel.pedeComplemento;
		plutoRow.cells['historico']?.value = contabilHistoricoModel.historico;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilHistoricoRepository.save(contabilHistoricoModel: contabilHistoricoModel); 
        if (result != null) {
          contabilHistoricoModel = result;
          if (_isInserting) {
            _contabilHistoricoModelList.add(result);
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
		functionName = "contabil_historico";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		descricaoController.dispose();
		historicoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}