import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:ged/app/controller/controller_imports.dart';
import 'package:ged/app/routes/app_routes.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:ged/app/page/page_imports.dart';
import 'package:ged/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ged/app/page/shared_widget/message_dialog.dart';

class GedDocumentoDetalheController extends GetxController {

	// general
	final gridColumns = gedDocumentoDetalheGridColumns();
	
	var gedDocumentoDetalheModelList = <GedDocumentoDetalheModel>[];

	final _gedDocumentoDetalheModel = GedDocumentoDetalheModel().obs;
	GedDocumentoDetalheModel get gedDocumentoDetalheModel => _gedDocumentoDetalheModel.value;
	set gedDocumentoDetalheModel(value) => _gedDocumentoDetalheModel.value = value ?? GedDocumentoDetalheModel();
	
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
		for (var gedDocumentoDetalheModel in gedDocumentoDetalheModelList) {
			plutoRowList.add(_getPlutoRow(gedDocumentoDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(GedDocumentoDetalheModel gedDocumentoDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(gedDocumentoDetalheModel: gedDocumentoDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ GedDocumentoDetalheModel? gedDocumentoDetalheModel}) {
		return {
			"id": PlutoCell(value: gedDocumentoDetalheModel?.id ?? 0),
			"gedTipoDocumento": PlutoCell(value: gedDocumentoDetalheModel?.gedTipoDocumentoModel?.nome ?? ''),
			"nome": PlutoCell(value: gedDocumentoDetalheModel?.nome ?? ''),
			"descricao": PlutoCell(value: gedDocumentoDetalheModel?.descricao ?? ''),
			"palavrasChave": PlutoCell(value: gedDocumentoDetalheModel?.palavrasChave ?? ''),
			"podeExcluir": PlutoCell(value: gedDocumentoDetalheModel?.podeExcluir ?? ''),
			"podeAlterar": PlutoCell(value: gedDocumentoDetalheModel?.podeAlterar ?? ''),
			"assinado": PlutoCell(value: gedDocumentoDetalheModel?.assinado ?? ''),
			"dataFimVigencia": PlutoCell(value: gedDocumentoDetalheModel?.dataFimVigencia ?? ''),
			"dataExclusao": PlutoCell(value: gedDocumentoDetalheModel?.dataExclusao ?? ''),
			"idGedDocumentoCabecalho": PlutoCell(value: gedDocumentoDetalheModel?.idGedDocumentoCabecalho ?? 0),
			"idGedTipoDocumento": PlutoCell(value: gedDocumentoDetalheModel?.idGedTipoDocumento ?? 0),
		};
	}

	void plutoRowToObject() {
		gedDocumentoDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return gedDocumentoDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			gedTipoDocumentoModelController.text = currentRow.cells['gedTipoDocumento']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			palavrasChaveController.text = currentRow.cells['palavrasChave']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => GedDocumentoDetalheEditPage());
		} else {
			showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
		}
	}

	void callEditPageToInsert() {
		_plutoGridStateManager.prependNewRows(); 
		final cell = _plutoGridStateManager.rows.first.cells.entries.elementAt(0).value;
		_plutoGridStateManager.setCurrentCell(cell, 0); 
		callEditPage();	 
	}

	void handleKeyboard(PlutoKeyManagerEvent event) {
		if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
			callEditPage();
		}
	} 

	Future delete() async {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			showDeleteDialog(() async {
				_plutoGridStateManager.removeCurrentRow();
				userMadeChanges = true;
				refreshList();
			});
		} else {
			showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
		}
	}

	// edit page
	final scrollController = ScrollController();
	final gedTipoDocumentoModelController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final palavrasChaveController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = gedDocumentoDetalheModel.id;
		plutoRow.cells['idGedDocumentoCabecalho']?.value = gedDocumentoDetalheModel.idGedDocumentoCabecalho;
		plutoRow.cells['idGedTipoDocumento']?.value = gedDocumentoDetalheModel.idGedTipoDocumento;
		plutoRow.cells['gedTipoDocumento']?.value = gedDocumentoDetalheModel.gedTipoDocumentoModel?.nome;
		plutoRow.cells['nome']?.value = gedDocumentoDetalheModel.nome;
		plutoRow.cells['descricao']?.value = gedDocumentoDetalheModel.descricao;
		plutoRow.cells['palavrasChave']?.value = gedDocumentoDetalheModel.palavrasChave;
		plutoRow.cells['podeExcluir']?.value = gedDocumentoDetalheModel.podeExcluir;
		plutoRow.cells['podeAlterar']?.value = gedDocumentoDetalheModel.podeAlterar;
		plutoRow.cells['assinado']?.value = gedDocumentoDetalheModel.assinado;
		plutoRow.cells['dataFimVigencia']?.value = Util.formatDate(gedDocumentoDetalheModel.dataFimVigencia);
		plutoRow.cells['dataExclusao']?.value = Util.formatDate(gedDocumentoDetalheModel.dataExclusao);
	}

	Future<void> save() async {
		final FormState form = formKey.currentState!;
		if (!form.validate()) {
			showErrorSnackBar(message: 'validator_form_message'.tr);
		} else {
			if (formWasChanged) {
				userMadeChanges = true;		 
				objectToPlutoRow();
				refreshList();
				Get.back();
			} else {
				Get.back();
			}
		}
	}

  void refreshList() {
		gedDocumentoDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = GedDocumentoDetalheModel();
			model.plutoRowToObject(plutoRow);
			gedDocumentoDetalheModelList.add(model);
		}
  }

	void preventDataLoss() {
		if (formWasChanged) {
			showQuestionDialog('message_data_loss'.tr, () => Get.back());
		} else {
			formWasChanged = false;
			Get.back();
		}
	}	

	Future callGedTipoDocumentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Documento]'; 
		lookupController.route = '/ged-tipo-documento/'; 
		lookupController.gridColumns = gedTipoDocumentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = GedTipoDocumentoModel.aliasColumns; 
		lookupController.dbColumns = GedTipoDocumentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			gedDocumentoDetalheModel.idGedTipoDocumento = plutoRowResult.cells['id']!.value; 
			gedDocumentoDetalheModel.gedTipoDocumentoModel!.plutoRowToObject(plutoRowResult); 
			gedTipoDocumentoModelController.text = gedDocumentoDetalheModel.gedTipoDocumentoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		keyboardListener = const Stream.empty().listen((event) { });
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose();		 
		gedTipoDocumentoModelController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		palavrasChaveController.dispose();
		super.onClose();
	}
}