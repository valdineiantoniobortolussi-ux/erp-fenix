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
import 'package:cte/app/data/repository/cte_ferroviario_ferrovia_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteFerroviarioFerroviaController extends GetxController with ControllerBaseMixin {
  final CteFerroviarioFerroviaRepository cteFerroviarioFerroviaRepository;
  CteFerroviarioFerroviaController({required this.cteFerroviarioFerroviaRepository});

  // general
  final _dbColumns = CteFerroviarioFerroviaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteFerroviarioFerroviaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteFerroviarioFerroviaGridColumns();
  
  var _cteFerroviarioFerroviaModelList = <CteFerroviarioFerroviaModel>[];

  final _cteFerroviarioFerroviaModel = CteFerroviarioFerroviaModel().obs;
  CteFerroviarioFerroviaModel get cteFerroviarioFerroviaModel => _cteFerroviarioFerroviaModel.value;
  set cteFerroviarioFerroviaModel(value) => _cteFerroviarioFerroviaModel.value = value ?? CteFerroviarioFerroviaModel();

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
    for (var cteFerroviarioFerroviaModel in _cteFerroviarioFerroviaModelList) {
      plutoRowList.add(_getPlutoRow(cteFerroviarioFerroviaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteFerroviarioFerroviaModel cteFerroviarioFerroviaModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteFerroviarioFerroviaModel: cteFerroviarioFerroviaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteFerroviarioFerroviaModel? cteFerroviarioFerroviaModel}) {
    return {
			"id": PlutoCell(value: cteFerroviarioFerroviaModel?.id ?? 0),
			"cteFerroviario": PlutoCell(value: cteFerroviarioFerroviaModel?.cteFerroviarioModel?.fluxo ?? ''),
			"cnpj": PlutoCell(value: cteFerroviarioFerroviaModel?.cnpj ?? ''),
			"codigoInterno": PlutoCell(value: cteFerroviarioFerroviaModel?.codigoInterno ?? ''),
			"ie": PlutoCell(value: cteFerroviarioFerroviaModel?.ie ?? ''),
			"nome": PlutoCell(value: cteFerroviarioFerroviaModel?.nome ?? ''),
			"logradouro": PlutoCell(value: cteFerroviarioFerroviaModel?.logradouro ?? ''),
			"numero": PlutoCell(value: cteFerroviarioFerroviaModel?.numero ?? ''),
			"complemento": PlutoCell(value: cteFerroviarioFerroviaModel?.complemento ?? ''),
			"bairro": PlutoCell(value: cteFerroviarioFerroviaModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: cteFerroviarioFerroviaModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: cteFerroviarioFerroviaModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: cteFerroviarioFerroviaModel?.uf ?? ''),
			"cep": PlutoCell(value: cteFerroviarioFerroviaModel?.cep ?? ''),
			"idCteFerroviario": PlutoCell(value: cteFerroviarioFerroviaModel?.idCteFerroviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteFerroviarioFerroviaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteFerroviarioFerroviaModel.plutoRowToObject(plutoRow);
    } else {
      cteFerroviarioFerroviaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Ferroviario Ferrovia]';
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
    await Get.find<CteFerroviarioFerroviaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteFerroviarioFerroviaRepository.getList(filter: filter).then( (data){ _cteFerroviarioFerroviaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Ferroviario Ferrovia',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteFerroviarioModelController.text = currentRow.cells['cteFerroviario']?.value ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			codigoInternoController.text = currentRow.cells['codigoInterno']?.value ?? '';
			ieController.text = currentRow.cells['ie']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			codigoMunicipioController.text = currentRow.cells['codigoMunicipio']?.value?.toString() ?? '';
			nomeMunicipioController.text = currentRow.cells['nomeMunicipio']?.value ?? '';
			cepController.text = currentRow.cells['cep']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteFerroviarioFerroviaEditPage)!.then((value) {
        if (cteFerroviarioFerroviaModel.id == 0) {
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
    cteFerroviarioFerroviaModel = CteFerroviarioFerroviaModel();
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
        if (await cteFerroviarioFerroviaRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteFerroviarioFerroviaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final codigoInternoController = TextEditingController();
	final ieController = TextEditingController();
	final nomeController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final codigoMunicipioController = TextEditingController();
	final nomeMunicipioController = TextEditingController();
	final cepController = MaskedTextController(mask: '00000-000',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteFerroviarioFerroviaModel.id;
		plutoRow.cells['idCteFerroviario']?.value = cteFerroviarioFerroviaModel.idCteFerroviario;
		plutoRow.cells['cteFerroviario']?.value = cteFerroviarioFerroviaModel.cteFerroviarioModel?.fluxo;
		plutoRow.cells['cnpj']?.value = cteFerroviarioFerroviaModel.cnpj;
		plutoRow.cells['codigoInterno']?.value = cteFerroviarioFerroviaModel.codigoInterno;
		plutoRow.cells['ie']?.value = cteFerroviarioFerroviaModel.ie;
		plutoRow.cells['nome']?.value = cteFerroviarioFerroviaModel.nome;
		plutoRow.cells['logradouro']?.value = cteFerroviarioFerroviaModel.logradouro;
		plutoRow.cells['numero']?.value = cteFerroviarioFerroviaModel.numero;
		plutoRow.cells['complemento']?.value = cteFerroviarioFerroviaModel.complemento;
		plutoRow.cells['bairro']?.value = cteFerroviarioFerroviaModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = cteFerroviarioFerroviaModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = cteFerroviarioFerroviaModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = cteFerroviarioFerroviaModel.uf;
		plutoRow.cells['cep']?.value = cteFerroviarioFerroviaModel.cep;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteFerroviarioFerroviaRepository.save(cteFerroviarioFerroviaModel: cteFerroviarioFerroviaModel); 
        if (result != null) {
          cteFerroviarioFerroviaModel = result;
          if (_isInserting) {
            _cteFerroviarioFerroviaModelList.add(result);
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
			cteFerroviarioFerroviaModel.idCteFerroviario = plutoRowResult.cells['id']!.value; 
			cteFerroviarioFerroviaModel.cteFerroviarioModel!.plutoRowToObject(plutoRowResult); 
			cteFerroviarioModelController.text = cteFerroviarioFerroviaModel.cteFerroviarioModel?.fluxo ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_ferroviario_ferrovia";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteFerroviarioModelController.dispose();
		cnpjController.dispose();
		codigoInternoController.dispose();
		ieController.dispose();
		nomeController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		codigoMunicipioController.dispose();
		nomeMunicipioController.dispose();
		cepController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}