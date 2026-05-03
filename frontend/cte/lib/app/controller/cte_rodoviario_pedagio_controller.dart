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
import 'package:cte/app/data/repository/cte_rodoviario_pedagio_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteRodoviarioPedagioController extends GetxController with ControllerBaseMixin {
  final CteRodoviarioPedagioRepository cteRodoviarioPedagioRepository;
  CteRodoviarioPedagioController({required this.cteRodoviarioPedagioRepository});

  // general
  final _dbColumns = CteRodoviarioPedagioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteRodoviarioPedagioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteRodoviarioPedagioGridColumns();
  
  var _cteRodoviarioPedagioModelList = <CteRodoviarioPedagioModel>[];

  final _cteRodoviarioPedagioModel = CteRodoviarioPedagioModel().obs;
  CteRodoviarioPedagioModel get cteRodoviarioPedagioModel => _cteRodoviarioPedagioModel.value;
  set cteRodoviarioPedagioModel(value) => _cteRodoviarioPedagioModel.value = value ?? CteRodoviarioPedagioModel();

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
    for (var cteRodoviarioPedagioModel in _cteRodoviarioPedagioModelList) {
      plutoRowList.add(_getPlutoRow(cteRodoviarioPedagioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteRodoviarioPedagioModel cteRodoviarioPedagioModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteRodoviarioPedagioModel: cteRodoviarioPedagioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteRodoviarioPedagioModel? cteRodoviarioPedagioModel}) {
    return {
			"id": PlutoCell(value: cteRodoviarioPedagioModel?.id ?? 0),
			"cteRodoviario": PlutoCell(value: cteRodoviarioPedagioModel?.cteRodoviarioModel?.rntrc ?? ''),
			"cnpjFornecedor": PlutoCell(value: cteRodoviarioPedagioModel?.cnpjFornecedor ?? ''),
			"comprovanteCompra": PlutoCell(value: cteRodoviarioPedagioModel?.comprovanteCompra ?? ''),
			"cnpjResponsavel": PlutoCell(value: cteRodoviarioPedagioModel?.cnpjResponsavel ?? ''),
			"valor": PlutoCell(value: cteRodoviarioPedagioModel?.valor ?? 0),
			"idCteRodoviario": PlutoCell(value: cteRodoviarioPedagioModel?.idCteRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteRodoviarioPedagioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteRodoviarioPedagioModel.plutoRowToObject(plutoRow);
    } else {
      cteRodoviarioPedagioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Rodoviario Pedagio]';
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
    await Get.find<CteRodoviarioPedagioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteRodoviarioPedagioRepository.getList(filter: filter).then( (data){ _cteRodoviarioPedagioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Rodoviario Pedagio',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteRodoviarioModelController.text = currentRow.cells['cteRodoviario']?.value ?? '';
			cnpjFornecedorController.text = currentRow.cells['cnpjFornecedor']?.value ?? '';
			comprovanteCompraController.text = currentRow.cells['comprovanteCompra']?.value ?? '';
			cnpjResponsavelController.text = currentRow.cells['cnpjResponsavel']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteRodoviarioPedagioEditPage)!.then((value) {
        if (cteRodoviarioPedagioModel.id == 0) {
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
    cteRodoviarioPedagioModel = CteRodoviarioPedagioModel();
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
        if (await cteRodoviarioPedagioRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteRodoviarioPedagioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cnpjFornecedorController = MaskedTextController(mask: '00.000.000/0000-00',);
	final comprovanteCompraController = TextEditingController();
	final cnpjResponsavelController = MaskedTextController(mask: '00.000.000/0000-00',);
	final valorController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteRodoviarioPedagioModel.id;
		plutoRow.cells['idCteRodoviario']?.value = cteRodoviarioPedagioModel.idCteRodoviario;
		plutoRow.cells['cteRodoviario']?.value = cteRodoviarioPedagioModel.cteRodoviarioModel?.rntrc;
		plutoRow.cells['cnpjFornecedor']?.value = cteRodoviarioPedagioModel.cnpjFornecedor;
		plutoRow.cells['comprovanteCompra']?.value = cteRodoviarioPedagioModel.comprovanteCompra;
		plutoRow.cells['cnpjResponsavel']?.value = cteRodoviarioPedagioModel.cnpjResponsavel;
		plutoRow.cells['valor']?.value = cteRodoviarioPedagioModel.valor;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteRodoviarioPedagioRepository.save(cteRodoviarioPedagioModel: cteRodoviarioPedagioModel); 
        if (result != null) {
          cteRodoviarioPedagioModel = result;
          if (_isInserting) {
            _cteRodoviarioPedagioModelList.add(result);
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
			cteRodoviarioPedagioModel.idCteRodoviario = plutoRowResult.cells['id']!.value; 
			cteRodoviarioPedagioModel.cteRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			cteRodoviarioModelController.text = cteRodoviarioPedagioModel.cteRodoviarioModel?.rntrc ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_rodoviario_pedagio";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteRodoviarioModelController.dispose();
		cnpjFornecedorController.dispose();
		comprovanteCompraController.dispose();
		cnpjResponsavelController.dispose();
		valorController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}