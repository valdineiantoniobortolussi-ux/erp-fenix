import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/controller/controller_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:mdfe/app/routes/app_routes.dart';
import 'package:mdfe/app/data/repository/mdfe_rodoviario_veiculo_repository.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';
import 'package:mdfe/app/mixin/controller_base_mixin.dart';

class MdfeRodoviarioVeiculoController extends GetxController with ControllerBaseMixin {
  final MdfeRodoviarioVeiculoRepository mdfeRodoviarioVeiculoRepository;
  MdfeRodoviarioVeiculoController({required this.mdfeRodoviarioVeiculoRepository});

  // general
  final _dbColumns = MdfeRodoviarioVeiculoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = MdfeRodoviarioVeiculoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = mdfeRodoviarioVeiculoGridColumns();
  
  var _mdfeRodoviarioVeiculoModelList = <MdfeRodoviarioVeiculoModel>[];

  final _mdfeRodoviarioVeiculoModel = MdfeRodoviarioVeiculoModel().obs;
  MdfeRodoviarioVeiculoModel get mdfeRodoviarioVeiculoModel => _mdfeRodoviarioVeiculoModel.value;
  set mdfeRodoviarioVeiculoModel(value) => _mdfeRodoviarioVeiculoModel.value = value ?? MdfeRodoviarioVeiculoModel();

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
    for (var mdfeRodoviarioVeiculoModel in _mdfeRodoviarioVeiculoModelList) {
      plutoRowList.add(_getPlutoRow(mdfeRodoviarioVeiculoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(MdfeRodoviarioVeiculoModel mdfeRodoviarioVeiculoModel) {
    return PlutoRow(
      cells: _getPlutoCells(mdfeRodoviarioVeiculoModel: mdfeRodoviarioVeiculoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ MdfeRodoviarioVeiculoModel? mdfeRodoviarioVeiculoModel}) {
    return {
			"id": PlutoCell(value: mdfeRodoviarioVeiculoModel?.id ?? 0),
			"mdfeRodoviario": PlutoCell(value: mdfeRodoviarioVeiculoModel?.mdfeRodoviarioModel?.codigoAgendamento ?? ''),
			"codigoInterno": PlutoCell(value: mdfeRodoviarioVeiculoModel?.codigoInterno ?? ''),
			"placa": PlutoCell(value: mdfeRodoviarioVeiculoModel?.placa ?? ''),
			"renavam": PlutoCell(value: mdfeRodoviarioVeiculoModel?.renavam ?? ''),
			"tara": PlutoCell(value: mdfeRodoviarioVeiculoModel?.tara ?? 0),
			"capacidadeKg": PlutoCell(value: mdfeRodoviarioVeiculoModel?.capacidadeKg ?? 0),
			"capacidadeM3": PlutoCell(value: mdfeRodoviarioVeiculoModel?.capacidadeM3 ?? 0),
			"tipoRodado": PlutoCell(value: mdfeRodoviarioVeiculoModel?.tipoRodado ?? ''),
			"tipoCarroceria": PlutoCell(value: mdfeRodoviarioVeiculoModel?.tipoCarroceria ?? ''),
			"ufLicenciamento": PlutoCell(value: mdfeRodoviarioVeiculoModel?.ufLicenciamento ?? ''),
			"proprietarioCpf": PlutoCell(value: mdfeRodoviarioVeiculoModel?.proprietarioCpf ?? ''),
			"proprietarioCnpj": PlutoCell(value: mdfeRodoviarioVeiculoModel?.proprietarioCnpj ?? ''),
			"proprietarioRntrc": PlutoCell(value: mdfeRodoviarioVeiculoModel?.proprietarioRntrc ?? ''),
			"proprietarioNome": PlutoCell(value: mdfeRodoviarioVeiculoModel?.proprietarioNome ?? ''),
			"proprietarioIe": PlutoCell(value: mdfeRodoviarioVeiculoModel?.proprietarioIe ?? ''),
			"proprietarioTipo": PlutoCell(value: mdfeRodoviarioVeiculoModel?.proprietarioTipo ?? 0),
			"idMdfeRodoviario": PlutoCell(value: mdfeRodoviarioVeiculoModel?.idMdfeRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _mdfeRodoviarioVeiculoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      mdfeRodoviarioVeiculoModel.plutoRowToObject(plutoRow);
    } else {
      mdfeRodoviarioVeiculoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Rodoviario Veiculo]';
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
    await Get.find<MdfeRodoviarioVeiculoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await mdfeRodoviarioVeiculoRepository.getList(filter: filter).then( (data){ _mdfeRodoviarioVeiculoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Rodoviario Veiculo',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			mdfeRodoviarioModelController.text = currentRow.cells['mdfeRodoviario']?.value ?? '';
			codigoInternoController.text = currentRow.cells['codigoInterno']?.value ?? '';
			placaController.text = currentRow.cells['placa']?.value ?? '';
			renavamController.text = currentRow.cells['renavam']?.value ?? '';
			taraController.text = currentRow.cells['tara']?.value?.toString() ?? '';
			capacidadeKgController.text = currentRow.cells['capacidadeKg']?.value?.toString() ?? '';
			capacidadeM3Controller.text = currentRow.cells['capacidadeM3']?.value?.toString() ?? '';
			proprietarioCpfController.text = currentRow.cells['proprietarioCpf']?.value ?? '';
			proprietarioCnpjController.text = currentRow.cells['proprietarioCnpj']?.value ?? '';
			proprietarioRntrcController.text = currentRow.cells['proprietarioRntrc']?.value ?? '';
			proprietarioNomeController.text = currentRow.cells['proprietarioNome']?.value ?? '';
			proprietarioIeController.text = currentRow.cells['proprietarioIe']?.value ?? '';
			proprietarioTipoController.text = currentRow.cells['proprietarioTipo']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.mdfeRodoviarioVeiculoEditPage)!.then((value) {
        if (mdfeRodoviarioVeiculoModel.id == 0) {
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
    mdfeRodoviarioVeiculoModel = MdfeRodoviarioVeiculoModel();
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
        if (await mdfeRodoviarioVeiculoRepository.delete(id: currentRow.cells['id']!.value)) {
          _mdfeRodoviarioVeiculoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final mdfeRodoviarioModelController = TextEditingController();
	final codigoInternoController = TextEditingController();
	final placaController = TextEditingController();
	final renavamController = TextEditingController();
	final taraController = TextEditingController();
	final capacidadeKgController = TextEditingController();
	final capacidadeM3Controller = TextEditingController();
	final proprietarioCpfController = MaskedTextController(mask: '000.000.000-00',);
	final proprietarioCnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final proprietarioRntrcController = TextEditingController();
	final proprietarioNomeController = TextEditingController();
	final proprietarioIeController = TextEditingController();
	final proprietarioTipoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeRodoviarioVeiculoModel.id;
		plutoRow.cells['idMdfeRodoviario']?.value = mdfeRodoviarioVeiculoModel.idMdfeRodoviario;
		plutoRow.cells['mdfeRodoviario']?.value = mdfeRodoviarioVeiculoModel.mdfeRodoviarioModel?.codigoAgendamento;
		plutoRow.cells['codigoInterno']?.value = mdfeRodoviarioVeiculoModel.codigoInterno;
		plutoRow.cells['placa']?.value = mdfeRodoviarioVeiculoModel.placa;
		plutoRow.cells['renavam']?.value = mdfeRodoviarioVeiculoModel.renavam;
		plutoRow.cells['tara']?.value = mdfeRodoviarioVeiculoModel.tara;
		plutoRow.cells['capacidadeKg']?.value = mdfeRodoviarioVeiculoModel.capacidadeKg;
		plutoRow.cells['capacidadeM3']?.value = mdfeRodoviarioVeiculoModel.capacidadeM3;
		plutoRow.cells['tipoRodado']?.value = mdfeRodoviarioVeiculoModel.tipoRodado;
		plutoRow.cells['tipoCarroceria']?.value = mdfeRodoviarioVeiculoModel.tipoCarroceria;
		plutoRow.cells['ufLicenciamento']?.value = mdfeRodoviarioVeiculoModel.ufLicenciamento;
		plutoRow.cells['proprietarioCpf']?.value = mdfeRodoviarioVeiculoModel.proprietarioCpf;
		plutoRow.cells['proprietarioCnpj']?.value = mdfeRodoviarioVeiculoModel.proprietarioCnpj;
		plutoRow.cells['proprietarioRntrc']?.value = mdfeRodoviarioVeiculoModel.proprietarioRntrc;
		plutoRow.cells['proprietarioNome']?.value = mdfeRodoviarioVeiculoModel.proprietarioNome;
		plutoRow.cells['proprietarioIe']?.value = mdfeRodoviarioVeiculoModel.proprietarioIe;
		plutoRow.cells['proprietarioTipo']?.value = mdfeRodoviarioVeiculoModel.proprietarioTipo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await mdfeRodoviarioVeiculoRepository.save(mdfeRodoviarioVeiculoModel: mdfeRodoviarioVeiculoModel); 
        if (result != null) {
          mdfeRodoviarioVeiculoModel = result;
          if (_isInserting) {
            _mdfeRodoviarioVeiculoModelList.add(result);
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

	Future callMdfeRodoviarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Mdfe Rodoviario]'; 
		lookupController.route = '/mdfe-rodoviario/'; 
		lookupController.gridColumns = mdfeRodoviarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = MdfeRodoviarioModel.aliasColumns; 
		lookupController.dbColumns = MdfeRodoviarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			mdfeRodoviarioVeiculoModel.idMdfeRodoviario = plutoRowResult.cells['id']!.value; 
			mdfeRodoviarioVeiculoModel.mdfeRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			mdfeRodoviarioModelController.text = mdfeRodoviarioVeiculoModel.mdfeRodoviarioModel?.codigoAgendamento ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "mdfe_rodoviario_veiculo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mdfeRodoviarioModelController.dispose();
		codigoInternoController.dispose();
		placaController.dispose();
		renavamController.dispose();
		taraController.dispose();
		capacidadeKgController.dispose();
		capacidadeM3Controller.dispose();
		proprietarioCpfController.dispose();
		proprietarioCnpjController.dispose();
		proprietarioRntrcController.dispose();
		proprietarioNomeController.dispose();
		proprietarioIeController.dispose();
		proprietarioTipoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}