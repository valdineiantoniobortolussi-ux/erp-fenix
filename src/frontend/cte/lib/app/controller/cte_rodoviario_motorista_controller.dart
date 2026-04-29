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
import 'package:cte/app/data/repository/cte_rodoviario_motorista_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteRodoviarioMotoristaController extends GetxController with ControllerBaseMixin {
  final CteRodoviarioMotoristaRepository cteRodoviarioMotoristaRepository;
  CteRodoviarioMotoristaController({required this.cteRodoviarioMotoristaRepository});

  // general
  final _dbColumns = CteRodoviarioMotoristaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteRodoviarioMotoristaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteRodoviarioMotoristaGridColumns();
  
  var _cteRodoviarioMotoristaModelList = <CteRodoviarioMotoristaModel>[];

  final _cteRodoviarioMotoristaModel = CteRodoviarioMotoristaModel().obs;
  CteRodoviarioMotoristaModel get cteRodoviarioMotoristaModel => _cteRodoviarioMotoristaModel.value;
  set cteRodoviarioMotoristaModel(value) => _cteRodoviarioMotoristaModel.value = value ?? CteRodoviarioMotoristaModel();

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
    for (var cteRodoviarioMotoristaModel in _cteRodoviarioMotoristaModelList) {
      plutoRowList.add(_getPlutoRow(cteRodoviarioMotoristaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteRodoviarioMotoristaModel cteRodoviarioMotoristaModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteRodoviarioMotoristaModel: cteRodoviarioMotoristaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteRodoviarioMotoristaModel? cteRodoviarioMotoristaModel}) {
    return {
			"id": PlutoCell(value: cteRodoviarioMotoristaModel?.id ?? 0),
			"cteRodoviario": PlutoCell(value: cteRodoviarioMotoristaModel?.cteRodoviarioModel?.rntrc ?? ''),
			"nome": PlutoCell(value: cteRodoviarioMotoristaModel?.nome ?? ''),
			"cpf": PlutoCell(value: cteRodoviarioMotoristaModel?.cpf ?? ''),
			"idCteRodoviario": PlutoCell(value: cteRodoviarioMotoristaModel?.idCteRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteRodoviarioMotoristaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteRodoviarioMotoristaModel.plutoRowToObject(plutoRow);
    } else {
      cteRodoviarioMotoristaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Rodoviario Motorista]';
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
    await Get.find<CteRodoviarioMotoristaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteRodoviarioMotoristaRepository.getList(filter: filter).then( (data){ _cteRodoviarioMotoristaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Rodoviario Motorista',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteRodoviarioModelController.text = currentRow.cells['cteRodoviario']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteRodoviarioMotoristaEditPage)!.then((value) {
        if (cteRodoviarioMotoristaModel.id == 0) {
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
    cteRodoviarioMotoristaModel = CteRodoviarioMotoristaModel();
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
        if (await cteRodoviarioMotoristaRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteRodoviarioMotoristaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteRodoviarioModelController = TextEditingController();
	final nomeController = TextEditingController();
	final cpfController = MaskedTextController(mask: '000.000.000-00',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteRodoviarioMotoristaModel.id;
		plutoRow.cells['idCteRodoviario']?.value = cteRodoviarioMotoristaModel.idCteRodoviario;
		plutoRow.cells['cteRodoviario']?.value = cteRodoviarioMotoristaModel.cteRodoviarioModel?.rntrc;
		plutoRow.cells['nome']?.value = cteRodoviarioMotoristaModel.nome;
		plutoRow.cells['cpf']?.value = cteRodoviarioMotoristaModel.cpf;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteRodoviarioMotoristaRepository.save(cteRodoviarioMotoristaModel: cteRodoviarioMotoristaModel); 
        if (result != null) {
          cteRodoviarioMotoristaModel = result;
          if (_isInserting) {
            _cteRodoviarioMotoristaModelList.add(result);
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

	Future callCteRodoviarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Rodoviario]'; 
		lookupController.route = '/cte-rodoviario/'; 
		lookupController.gridColumns = cteRodoviarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteRodoviarioModel.aliasColumns; 
		lookupController.dbColumns = CteRodoviarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteRodoviarioMotoristaModel.idCteRodoviario = plutoRowResult.cells['id']!.value; 
			cteRodoviarioMotoristaModel.cteRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			cteRodoviarioModelController.text = cteRodoviarioMotoristaModel.cteRodoviarioModel?.rntrc ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_rodoviario_motorista";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteRodoviarioModelController.dispose();
		nomeController.dispose();
		cpfController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}