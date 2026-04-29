import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/controller/controller_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cte/app/routes/app_routes.dart';
import 'package:cte/app/data/repository/cte_ferroviario_vagao_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteFerroviarioVagaoController extends GetxController with ControllerBaseMixin {
  final CteFerroviarioVagaoRepository cteFerroviarioVagaoRepository;
  CteFerroviarioVagaoController({required this.cteFerroviarioVagaoRepository});

  // general
  final _dbColumns = CteFerroviarioVagaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteFerroviarioVagaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteFerroviarioVagaoGridColumns();
  
  var _cteFerroviarioVagaoModelList = <CteFerroviarioVagaoModel>[];

  final _cteFerroviarioVagaoModel = CteFerroviarioVagaoModel().obs;
  CteFerroviarioVagaoModel get cteFerroviarioVagaoModel => _cteFerroviarioVagaoModel.value;
  set cteFerroviarioVagaoModel(value) => _cteFerroviarioVagaoModel.value = value ?? CteFerroviarioVagaoModel();

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
    for (var cteFerroviarioVagaoModel in _cteFerroviarioVagaoModelList) {
      plutoRowList.add(_getPlutoRow(cteFerroviarioVagaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteFerroviarioVagaoModel cteFerroviarioVagaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteFerroviarioVagaoModel: cteFerroviarioVagaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteFerroviarioVagaoModel? cteFerroviarioVagaoModel}) {
    return {
			"id": PlutoCell(value: cteFerroviarioVagaoModel?.id ?? 0),
			"cteFerroviario": PlutoCell(value: cteFerroviarioVagaoModel?.cteFerroviarioModel?.fluxo ?? ''),
			"numeroVagao": PlutoCell(value: cteFerroviarioVagaoModel?.numeroVagao ?? 0),
			"capacidade": PlutoCell(value: cteFerroviarioVagaoModel?.capacidade ?? 0),
			"tipoVagao": PlutoCell(value: cteFerroviarioVagaoModel?.tipoVagao ?? ''),
			"pesoReal": PlutoCell(value: cteFerroviarioVagaoModel?.pesoReal ?? 0),
			"pesoBc": PlutoCell(value: cteFerroviarioVagaoModel?.pesoBc ?? 0),
			"idCteFerroviario": PlutoCell(value: cteFerroviarioVagaoModel?.idCteFerroviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteFerroviarioVagaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteFerroviarioVagaoModel.plutoRowToObject(plutoRow);
    } else {
      cteFerroviarioVagaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Ferroviario Vagao]';
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
    await Get.find<CteFerroviarioVagaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteFerroviarioVagaoRepository.getList(filter: filter).then( (data){ _cteFerroviarioVagaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Ferroviario Vagao',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteFerroviarioModelController.text = currentRow.cells['cteFerroviario']?.value ?? '';
			numeroVagaoController.text = currentRow.cells['numeroVagao']?.value?.toString() ?? '';
			capacidadeController.text = currentRow.cells['capacidade']?.value?.toStringAsFixed(2) ?? '';
			pesoRealController.text = currentRow.cells['pesoReal']?.value?.toStringAsFixed(2) ?? '';
			pesoBcController.text = currentRow.cells['pesoBc']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteFerroviarioVagaoEditPage)!.then((value) {
        if (cteFerroviarioVagaoModel.id == 0) {
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
    cteFerroviarioVagaoModel = CteFerroviarioVagaoModel();
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
        if (await cteFerroviarioVagaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteFerroviarioVagaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteFerroviarioModelController = TextEditingController();
	final numeroVagaoController = TextEditingController();
	final capacidadeController = MoneyMaskedTextController();
	final pesoRealController = MoneyMaskedTextController();
	final pesoBcController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteFerroviarioVagaoModel.id;
		plutoRow.cells['idCteFerroviario']?.value = cteFerroviarioVagaoModel.idCteFerroviario;
		plutoRow.cells['cteFerroviario']?.value = cteFerroviarioVagaoModel.cteFerroviarioModel?.fluxo;
		plutoRow.cells['numeroVagao']?.value = cteFerroviarioVagaoModel.numeroVagao;
		plutoRow.cells['capacidade']?.value = cteFerroviarioVagaoModel.capacidade;
		plutoRow.cells['tipoVagao']?.value = cteFerroviarioVagaoModel.tipoVagao;
		plutoRow.cells['pesoReal']?.value = cteFerroviarioVagaoModel.pesoReal;
		plutoRow.cells['pesoBc']?.value = cteFerroviarioVagaoModel.pesoBc;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteFerroviarioVagaoRepository.save(cteFerroviarioVagaoModel: cteFerroviarioVagaoModel); 
        if (result != null) {
          cteFerroviarioVagaoModel = result;
          if (_isInserting) {
            _cteFerroviarioVagaoModelList.add(result);
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

	Future callCteFerroviarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Ferroviario]'; 
		lookupController.route = '/cte-ferroviario/'; 
		lookupController.gridColumns = cteFerroviarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteFerroviarioModel.aliasColumns; 
		lookupController.dbColumns = CteFerroviarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteFerroviarioVagaoModel.idCteFerroviario = plutoRowResult.cells['id']!.value; 
			cteFerroviarioVagaoModel.cteFerroviarioModel!.plutoRowToObject(plutoRowResult); 
			cteFerroviarioModelController.text = cteFerroviarioVagaoModel.cteFerroviarioModel?.fluxo ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_ferroviario_vagao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteFerroviarioModelController.dispose();
		numeroVagaoController.dispose();
		capacidadeController.dispose();
		pesoRealController.dispose();
		pesoBcController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}