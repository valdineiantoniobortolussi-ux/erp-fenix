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

class CteEmitenteController extends GetxController {

	// general
	final gridColumns = cteEmitenteGridColumns();
	
	var cteEmitenteModelList = <CteEmitenteModel>[];

	final _cteEmitenteModel = CteEmitenteModel().obs;
	CteEmitenteModel get cteEmitenteModel => _cteEmitenteModel.value;
	set cteEmitenteModel(value) => _cteEmitenteModel.value = value ?? CteEmitenteModel();
	
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
		for (var cteEmitenteModel in cteEmitenteModelList) {
			plutoRowList.add(_getPlutoRow(cteEmitenteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteEmitenteModel cteEmitenteModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteEmitenteModel: cteEmitenteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteEmitenteModel? cteEmitenteModel}) {
		return {
			"id": PlutoCell(value: cteEmitenteModel?.id ?? 0),
			"cnpj": PlutoCell(value: cteEmitenteModel?.cnpj ?? ''),
			"ie": PlutoCell(value: cteEmitenteModel?.ie ?? ''),
			"nome": PlutoCell(value: cteEmitenteModel?.nome ?? ''),
			"fantasia": PlutoCell(value: cteEmitenteModel?.fantasia ?? ''),
			"logradouro": PlutoCell(value: cteEmitenteModel?.logradouro ?? ''),
			"numero": PlutoCell(value: cteEmitenteModel?.numero ?? ''),
			"complemento": PlutoCell(value: cteEmitenteModel?.complemento ?? ''),
			"bairro": PlutoCell(value: cteEmitenteModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: cteEmitenteModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: cteEmitenteModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: cteEmitenteModel?.uf ?? ''),
			"cep": PlutoCell(value: cteEmitenteModel?.cep ?? ''),
			"telefone": PlutoCell(value: cteEmitenteModel?.telefone ?? ''),
			"idCteCabecalho": PlutoCell(value: cteEmitenteModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteEmitenteModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteEmitenteModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			ieController.text = currentRow.cells['ie']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			fantasiaController.text = currentRow.cells['fantasia']?.value ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			codigoMunicipioController.text = currentRow.cells['codigoMunicipio']?.value?.toString() ?? '';
			nomeMunicipioController.text = currentRow.cells['nomeMunicipio']?.value ?? '';
			cepController.text = currentRow.cells['cep']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteEmitenteEditPage());
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
	final ieController = TextEditingController();
	final nomeController = TextEditingController();
	final fantasiaController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final codigoMunicipioController = TextEditingController();
	final nomeMunicipioController = TextEditingController();
	final cepController = MaskedTextController(mask: '00000-000',);
	final telefoneController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteEmitenteModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteEmitenteModel.idCteCabecalho;
		plutoRow.cells['cnpj']?.value = cteEmitenteModel.cnpj;
		plutoRow.cells['ie']?.value = cteEmitenteModel.ie;
		plutoRow.cells['nome']?.value = cteEmitenteModel.nome;
		plutoRow.cells['fantasia']?.value = cteEmitenteModel.fantasia;
		plutoRow.cells['logradouro']?.value = cteEmitenteModel.logradouro;
		plutoRow.cells['numero']?.value = cteEmitenteModel.numero;
		plutoRow.cells['complemento']?.value = cteEmitenteModel.complemento;
		plutoRow.cells['bairro']?.value = cteEmitenteModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = cteEmitenteModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = cteEmitenteModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = cteEmitenteModel.uf;
		plutoRow.cells['cep']?.value = cteEmitenteModel.cep;
		plutoRow.cells['telefone']?.value = cteEmitenteModel.telefone;
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
		cteEmitenteModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteEmitenteModel();
			model.plutoRowToObject(plutoRow);
			cteEmitenteModelList.add(model);
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
		ieController.dispose();
		nomeController.dispose();
		fantasiaController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		codigoMunicipioController.dispose();
		nomeMunicipioController.dispose();
		cepController.dispose();
		telefoneController.dispose();
		super.onClose();
	}
}