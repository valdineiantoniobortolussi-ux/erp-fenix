import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CteLocalColetaController extends GetxController {

	// general
	final gridColumns = cteLocalColetaGridColumns();
	
	var cteLocalColetaModelList = <CteLocalColetaModel>[];

	final _cteLocalColetaModel = CteLocalColetaModel().obs;
	CteLocalColetaModel get cteLocalColetaModel => _cteLocalColetaModel.value;
	set cteLocalColetaModel(value) => _cteLocalColetaModel.value = value ?? CteLocalColetaModel();
	
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
		for (var cteLocalColetaModel in cteLocalColetaModelList) {
			plutoRowList.add(_getPlutoRow(cteLocalColetaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteLocalColetaModel cteLocalColetaModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteLocalColetaModel: cteLocalColetaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteLocalColetaModel? cteLocalColetaModel}) {
		return {
			"id": PlutoCell(value: cteLocalColetaModel?.id ?? 0),
			"cnpj": PlutoCell(value: cteLocalColetaModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: cteLocalColetaModel?.cpf ?? ''),
			"nome": PlutoCell(value: cteLocalColetaModel?.nome ?? ''),
			"logradouro": PlutoCell(value: cteLocalColetaModel?.logradouro ?? ''),
			"numero": PlutoCell(value: cteLocalColetaModel?.numero ?? ''),
			"complemento": PlutoCell(value: cteLocalColetaModel?.complemento ?? ''),
			"bairro": PlutoCell(value: cteLocalColetaModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: cteLocalColetaModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: cteLocalColetaModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: cteLocalColetaModel?.uf ?? ''),
			"idCteCabecalho": PlutoCell(value: cteLocalColetaModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteLocalColetaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteLocalColetaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			codigoMunicipioController.text = currentRow.cells['codigoMunicipio']?.value?.toString() ?? '';
			nomeMunicipioController.text = currentRow.cells['nomeMunicipio']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteLocalColetaEditPage());
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
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final nomeController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final codigoMunicipioController = TextEditingController();
	final nomeMunicipioController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteLocalColetaModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteLocalColetaModel.idCteCabecalho;
		plutoRow.cells['cnpj']?.value = cteLocalColetaModel.cnpj;
		plutoRow.cells['cpf']?.value = cteLocalColetaModel.cpf;
		plutoRow.cells['nome']?.value = cteLocalColetaModel.nome;
		plutoRow.cells['logradouro']?.value = cteLocalColetaModel.logradouro;
		plutoRow.cells['numero']?.value = cteLocalColetaModel.numero;
		plutoRow.cells['complemento']?.value = cteLocalColetaModel.complemento;
		plutoRow.cells['bairro']?.value = cteLocalColetaModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = cteLocalColetaModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = cteLocalColetaModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = cteLocalColetaModel.uf;
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
		cteLocalColetaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteLocalColetaModel();
			model.plutoRowToObject(plutoRow);
			cteLocalColetaModelList.add(model);
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
		cnpjController.dispose();
		cpfController.dispose();
		nomeController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		codigoMunicipioController.dispose();
		nomeMunicipioController.dispose();
		super.onClose();
	}
}