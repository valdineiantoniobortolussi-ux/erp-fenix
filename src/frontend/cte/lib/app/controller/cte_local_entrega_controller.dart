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

class CteLocalEntregaController extends GetxController {

	// general
	final gridColumns = cteLocalEntregaGridColumns();
	
	var cteLocalEntregaModelList = <CteLocalEntregaModel>[];

	final _cteLocalEntregaModel = CteLocalEntregaModel().obs;
	CteLocalEntregaModel get cteLocalEntregaModel => _cteLocalEntregaModel.value;
	set cteLocalEntregaModel(value) => _cteLocalEntregaModel.value = value ?? CteLocalEntregaModel();
	
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
		for (var cteLocalEntregaModel in cteLocalEntregaModelList) {
			plutoRowList.add(_getPlutoRow(cteLocalEntregaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteLocalEntregaModel cteLocalEntregaModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteLocalEntregaModel: cteLocalEntregaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteLocalEntregaModel? cteLocalEntregaModel}) {
		return {
			"id": PlutoCell(value: cteLocalEntregaModel?.id ?? 0),
			"cnpj": PlutoCell(value: cteLocalEntregaModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: cteLocalEntregaModel?.cpf ?? ''),
			"nome": PlutoCell(value: cteLocalEntregaModel?.nome ?? ''),
			"logradouro": PlutoCell(value: cteLocalEntregaModel?.logradouro ?? ''),
			"numero": PlutoCell(value: cteLocalEntregaModel?.numero ?? ''),
			"complemento": PlutoCell(value: cteLocalEntregaModel?.complemento ?? ''),
			"bairro": PlutoCell(value: cteLocalEntregaModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: cteLocalEntregaModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: cteLocalEntregaModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: cteLocalEntregaModel?.uf ?? ''),
			"idCteCabecalho": PlutoCell(value: cteLocalEntregaModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteLocalEntregaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteLocalEntregaModelList;
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
			Get.to(() => CteLocalEntregaEditPage());
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
		plutoRow.cells['id']?.value = cteLocalEntregaModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteLocalEntregaModel.idCteCabecalho;
		plutoRow.cells['cnpj']?.value = cteLocalEntregaModel.cnpj;
		plutoRow.cells['cpf']?.value = cteLocalEntregaModel.cpf;
		plutoRow.cells['nome']?.value = cteLocalEntregaModel.nome;
		plutoRow.cells['logradouro']?.value = cteLocalEntregaModel.logradouro;
		plutoRow.cells['numero']?.value = cteLocalEntregaModel.numero;
		plutoRow.cells['complemento']?.value = cteLocalEntregaModel.complemento;
		plutoRow.cells['bairro']?.value = cteLocalEntregaModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = cteLocalEntregaModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = cteLocalEntregaModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = cteLocalEntregaModel.uf;
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
		cteLocalEntregaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteLocalEntregaModel();
			model.plutoRowToObject(plutoRow);
			cteLocalEntregaModelList.add(model);
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