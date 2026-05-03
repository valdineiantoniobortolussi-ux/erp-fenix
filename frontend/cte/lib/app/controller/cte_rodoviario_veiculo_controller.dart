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
import 'package:cte/app/data/repository/cte_rodoviario_veiculo_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteRodoviarioVeiculoController extends GetxController with ControllerBaseMixin {
  final CteRodoviarioVeiculoRepository cteRodoviarioVeiculoRepository;
  CteRodoviarioVeiculoController({required this.cteRodoviarioVeiculoRepository});

  // general
  final _dbColumns = CteRodoviarioVeiculoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteRodoviarioVeiculoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteRodoviarioVeiculoGridColumns();
  
  var _cteRodoviarioVeiculoModelList = <CteRodoviarioVeiculoModel>[];

  final _cteRodoviarioVeiculoModel = CteRodoviarioVeiculoModel().obs;
  CteRodoviarioVeiculoModel get cteRodoviarioVeiculoModel => _cteRodoviarioVeiculoModel.value;
  set cteRodoviarioVeiculoModel(value) => _cteRodoviarioVeiculoModel.value = value ?? CteRodoviarioVeiculoModel();

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
    for (var cteRodoviarioVeiculoModel in _cteRodoviarioVeiculoModelList) {
      plutoRowList.add(_getPlutoRow(cteRodoviarioVeiculoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteRodoviarioVeiculoModel cteRodoviarioVeiculoModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteRodoviarioVeiculoModel: cteRodoviarioVeiculoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteRodoviarioVeiculoModel? cteRodoviarioVeiculoModel}) {
    return {
			"id": PlutoCell(value: cteRodoviarioVeiculoModel?.id ?? 0),
			"cteRodoviario": PlutoCell(value: cteRodoviarioVeiculoModel?.cteRodoviarioModel?.rntrc ?? ''),
			"codigoInterno": PlutoCell(value: cteRodoviarioVeiculoModel?.codigoInterno ?? ''),
			"renavam": PlutoCell(value: cteRodoviarioVeiculoModel?.renavam ?? ''),
			"placa": PlutoCell(value: cteRodoviarioVeiculoModel?.placa ?? ''),
			"tara": PlutoCell(value: cteRodoviarioVeiculoModel?.tara ?? 0),
			"capacidadeKg": PlutoCell(value: cteRodoviarioVeiculoModel?.capacidadeKg ?? 0),
			"capacidadeM3": PlutoCell(value: cteRodoviarioVeiculoModel?.capacidadeM3 ?? 0),
			"tipoPropriedade": PlutoCell(value: cteRodoviarioVeiculoModel?.tipoPropriedade ?? ''),
			"tipoVeiculo": PlutoCell(value: cteRodoviarioVeiculoModel?.tipoVeiculo ?? ''),
			"tipoRodado": PlutoCell(value: cteRodoviarioVeiculoModel?.tipoRodado ?? ''),
			"tipoCarroceria": PlutoCell(value: cteRodoviarioVeiculoModel?.tipoCarroceria ?? ''),
			"uf": PlutoCell(value: cteRodoviarioVeiculoModel?.uf ?? ''),
			"proprietarioCpf": PlutoCell(value: cteRodoviarioVeiculoModel?.proprietarioCpf ?? ''),
			"proprietarioCnpj": PlutoCell(value: cteRodoviarioVeiculoModel?.proprietarioCnpj ?? ''),
			"proprietarioRntrc": PlutoCell(value: cteRodoviarioVeiculoModel?.proprietarioRntrc ?? ''),
			"proprietarioNome": PlutoCell(value: cteRodoviarioVeiculoModel?.proprietarioNome ?? ''),
			"proprietarioIe": PlutoCell(value: cteRodoviarioVeiculoModel?.proprietarioIe ?? ''),
			"proprietarioUf": PlutoCell(value: cteRodoviarioVeiculoModel?.proprietarioUf ?? ''),
			"proprietarioTipo": PlutoCell(value: cteRodoviarioVeiculoModel?.proprietarioTipo ?? ''),
			"idCteRodoviario": PlutoCell(value: cteRodoviarioVeiculoModel?.idCteRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteRodoviarioVeiculoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteRodoviarioVeiculoModel.plutoRowToObject(plutoRow);
    } else {
      cteRodoviarioVeiculoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Rodoviario Veiculo]';
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
    await Get.find<CteRodoviarioVeiculoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteRodoviarioVeiculoRepository.getList(filter: filter).then( (data){ _cteRodoviarioVeiculoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Rodoviario Veiculo',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteRodoviarioModelController.text = currentRow.cells['cteRodoviario']?.value ?? '';
			codigoInternoController.text = currentRow.cells['codigoInterno']?.value ?? '';
			renavamController.text = currentRow.cells['renavam']?.value ?? '';
			placaController.text = currentRow.cells['placa']?.value ?? '';
			taraController.text = currentRow.cells['tara']?.value?.toString() ?? '';
			capacidadeKgController.text = currentRow.cells['capacidadeKg']?.value?.toString() ?? '';
			capacidadeM3Controller.text = currentRow.cells['capacidadeM3']?.value?.toString() ?? '';
			proprietarioCpfController.text = currentRow.cells['proprietarioCpf']?.value ?? '';
			proprietarioCnpjController.text = currentRow.cells['proprietarioCnpj']?.value ?? '';
			proprietarioRntrcController.text = currentRow.cells['proprietarioRntrc']?.value ?? '';
			proprietarioNomeController.text = currentRow.cells['proprietarioNome']?.value ?? '';
			proprietarioIeController.text = currentRow.cells['proprietarioIe']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteRodoviarioVeiculoEditPage)!.then((value) {
        if (cteRodoviarioVeiculoModel.id == 0) {
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
    cteRodoviarioVeiculoModel = CteRodoviarioVeiculoModel();
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
        if (await cteRodoviarioVeiculoRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteRodoviarioVeiculoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoInternoController = TextEditingController();
	final renavamController = TextEditingController();
	final placaController = TextEditingController();
	final taraController = TextEditingController();
	final capacidadeKgController = TextEditingController();
	final capacidadeM3Controller = TextEditingController();
	final proprietarioCpfController = MaskedTextController(mask: '000.000.000-00',);
	final proprietarioCnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final proprietarioRntrcController = TextEditingController();
	final proprietarioNomeController = TextEditingController();
	final proprietarioIeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteRodoviarioVeiculoModel.id;
		plutoRow.cells['idCteRodoviario']?.value = cteRodoviarioVeiculoModel.idCteRodoviario;
		plutoRow.cells['cteRodoviario']?.value = cteRodoviarioVeiculoModel.cteRodoviarioModel?.rntrc;
		plutoRow.cells['codigoInterno']?.value = cteRodoviarioVeiculoModel.codigoInterno;
		plutoRow.cells['renavam']?.value = cteRodoviarioVeiculoModel.renavam;
		plutoRow.cells['placa']?.value = cteRodoviarioVeiculoModel.placa;
		plutoRow.cells['tara']?.value = cteRodoviarioVeiculoModel.tara;
		plutoRow.cells['capacidadeKg']?.value = cteRodoviarioVeiculoModel.capacidadeKg;
		plutoRow.cells['capacidadeM3']?.value = cteRodoviarioVeiculoModel.capacidadeM3;
		plutoRow.cells['tipoPropriedade']?.value = cteRodoviarioVeiculoModel.tipoPropriedade;
		plutoRow.cells['tipoVeiculo']?.value = cteRodoviarioVeiculoModel.tipoVeiculo;
		plutoRow.cells['tipoRodado']?.value = cteRodoviarioVeiculoModel.tipoRodado;
		plutoRow.cells['tipoCarroceria']?.value = cteRodoviarioVeiculoModel.tipoCarroceria;
		plutoRow.cells['uf']?.value = cteRodoviarioVeiculoModel.uf;
		plutoRow.cells['proprietarioCpf']?.value = cteRodoviarioVeiculoModel.proprietarioCpf;
		plutoRow.cells['proprietarioCnpj']?.value = cteRodoviarioVeiculoModel.proprietarioCnpj;
		plutoRow.cells['proprietarioRntrc']?.value = cteRodoviarioVeiculoModel.proprietarioRntrc;
		plutoRow.cells['proprietarioNome']?.value = cteRodoviarioVeiculoModel.proprietarioNome;
		plutoRow.cells['proprietarioIe']?.value = cteRodoviarioVeiculoModel.proprietarioIe;
		plutoRow.cells['proprietarioUf']?.value = cteRodoviarioVeiculoModel.proprietarioUf;
		plutoRow.cells['proprietarioTipo']?.value = cteRodoviarioVeiculoModel.proprietarioTipo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteRodoviarioVeiculoRepository.save(cteRodoviarioVeiculoModel: cteRodoviarioVeiculoModel); 
        if (result != null) {
          cteRodoviarioVeiculoModel = result;
          if (_isInserting) {
            _cteRodoviarioVeiculoModelList.add(result);
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
			cteRodoviarioVeiculoModel.idCteRodoviario = plutoRowResult.cells['id']!.value; 
			cteRodoviarioVeiculoModel.cteRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			cteRodoviarioModelController.text = cteRodoviarioVeiculoModel.cteRodoviarioModel?.rntrc ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_rodoviario_veiculo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteRodoviarioModelController.dispose();
		codigoInternoController.dispose();
		renavamController.dispose();
		placaController.dispose();
		taraController.dispose();
		capacidadeKgController.dispose();
		capacidadeM3Controller.dispose();
		proprietarioCpfController.dispose();
		proprietarioCnpjController.dispose();
		proprietarioRntrcController.dispose();
		proprietarioNomeController.dispose();
		proprietarioIeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}