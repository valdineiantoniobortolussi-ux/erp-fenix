import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeDetEspecificoVeiculoController extends GetxController {

	// general
	final gridColumns = nfeDetEspecificoVeiculoGridColumns();
	
	var nfeDetEspecificoVeiculoModelList = <NfeDetEspecificoVeiculoModel>[];

	final _nfeDetEspecificoVeiculoModel = NfeDetEspecificoVeiculoModel().obs;
	NfeDetEspecificoVeiculoModel get nfeDetEspecificoVeiculoModel => _nfeDetEspecificoVeiculoModel.value;
	set nfeDetEspecificoVeiculoModel(value) => _nfeDetEspecificoVeiculoModel.value = value ?? NfeDetEspecificoVeiculoModel();
	
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
		for (var nfeDetEspecificoVeiculoModel in nfeDetEspecificoVeiculoModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetEspecificoVeiculoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetEspecificoVeiculoModel nfeDetEspecificoVeiculoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetEspecificoVeiculoModel: nfeDetEspecificoVeiculoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetEspecificoVeiculoModel? nfeDetEspecificoVeiculoModel}) {
		return {
			"id": PlutoCell(value: nfeDetEspecificoVeiculoModel?.id ?? 0),
			"tipoOperacao": PlutoCell(value: nfeDetEspecificoVeiculoModel?.tipoOperacao ?? ''),
			"chassi": PlutoCell(value: nfeDetEspecificoVeiculoModel?.chassi ?? ''),
			"cor": PlutoCell(value: nfeDetEspecificoVeiculoModel?.cor ?? ''),
			"descricaoCor": PlutoCell(value: nfeDetEspecificoVeiculoModel?.descricaoCor ?? ''),
			"potenciaMotor": PlutoCell(value: nfeDetEspecificoVeiculoModel?.potenciaMotor ?? ''),
			"cilindradas": PlutoCell(value: nfeDetEspecificoVeiculoModel?.cilindradas ?? ''),
			"pesoLiquido": PlutoCell(value: nfeDetEspecificoVeiculoModel?.pesoLiquido ?? ''),
			"pesoBruto": PlutoCell(value: nfeDetEspecificoVeiculoModel?.pesoBruto ?? ''),
			"numeroSerie": PlutoCell(value: nfeDetEspecificoVeiculoModel?.numeroSerie ?? ''),
			"tipoCombustivel": PlutoCell(value: nfeDetEspecificoVeiculoModel?.tipoCombustivel ?? ''),
			"numeroMotor": PlutoCell(value: nfeDetEspecificoVeiculoModel?.numeroMotor ?? ''),
			"capacidadeMaximaTracao": PlutoCell(value: nfeDetEspecificoVeiculoModel?.capacidadeMaximaTracao ?? ''),
			"distanciaEixos": PlutoCell(value: nfeDetEspecificoVeiculoModel?.distanciaEixos ?? ''),
			"anoModelo": PlutoCell(value: nfeDetEspecificoVeiculoModel?.anoModelo ?? ''),
			"anoFabricacao": PlutoCell(value: nfeDetEspecificoVeiculoModel?.anoFabricacao ?? ''),
			"tipoPintura": PlutoCell(value: nfeDetEspecificoVeiculoModel?.tipoPintura ?? ''),
			"tipoVeiculo": PlutoCell(value: nfeDetEspecificoVeiculoModel?.tipoVeiculo ?? ''),
			"especieVeiculo": PlutoCell(value: nfeDetEspecificoVeiculoModel?.especieVeiculo ?? ''),
			"condicaoVin": PlutoCell(value: nfeDetEspecificoVeiculoModel?.condicaoVin ?? ''),
			"condicaoVeiculo": PlutoCell(value: nfeDetEspecificoVeiculoModel?.condicaoVeiculo ?? ''),
			"codigoMarcaModelo": PlutoCell(value: nfeDetEspecificoVeiculoModel?.codigoMarcaModelo ?? ''),
			"codigoCorDenatran": PlutoCell(value: nfeDetEspecificoVeiculoModel?.codigoCorDenatran ?? ''),
			"lotacaoMaxima": PlutoCell(value: nfeDetEspecificoVeiculoModel?.lotacaoMaxima ?? 0),
			"restricao": PlutoCell(value: nfeDetEspecificoVeiculoModel?.restricao ?? ''),
			"idNfeDetalhe": PlutoCell(value: nfeDetEspecificoVeiculoModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetEspecificoVeiculoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetEspecificoVeiculoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			chassiController.text = currentRow.cells['chassi']?.value ?? '';
			corController.text = currentRow.cells['cor']?.value ?? '';
			descricaoCorController.text = currentRow.cells['descricaoCor']?.value ?? '';
			potenciaMotorController.text = currentRow.cells['potenciaMotor']?.value ?? '';
			cilindradasController.text = currentRow.cells['cilindradas']?.value ?? '';
			pesoLiquidoController.text = currentRow.cells['pesoLiquido']?.value ?? '';
			pesoBrutoController.text = currentRow.cells['pesoBruto']?.value ?? '';
			numeroSerieController.text = currentRow.cells['numeroSerie']?.value ?? '';
			numeroMotorController.text = currentRow.cells['numeroMotor']?.value ?? '';
			capacidadeMaximaTracaoController.text = currentRow.cells['capacidadeMaximaTracao']?.value ?? '';
			distanciaEixosController.text = currentRow.cells['distanciaEixos']?.value ?? '';
			codigoMarcaModeloController.text = currentRow.cells['codigoMarcaModelo']?.value ?? '';
			lotacaoMaximaController.text = currentRow.cells['lotacaoMaxima']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetEspecificoVeiculoEditPage());
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
	final chassiController = TextEditingController();
	final corController = TextEditingController();
	final descricaoCorController = TextEditingController();
	final potenciaMotorController = TextEditingController();
	final cilindradasController = TextEditingController();
	final pesoLiquidoController = TextEditingController();
	final pesoBrutoController = TextEditingController();
	final numeroSerieController = TextEditingController();
	final numeroMotorController = TextEditingController();
	final capacidadeMaximaTracaoController = TextEditingController();
	final distanciaEixosController = TextEditingController();
	final codigoMarcaModeloController = TextEditingController();
	final lotacaoMaximaController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetEspecificoVeiculoModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetEspecificoVeiculoModel.idNfeDetalhe;
		plutoRow.cells['tipoOperacao']?.value = nfeDetEspecificoVeiculoModel.tipoOperacao;
		plutoRow.cells['chassi']?.value = nfeDetEspecificoVeiculoModel.chassi;
		plutoRow.cells['cor']?.value = nfeDetEspecificoVeiculoModel.cor;
		plutoRow.cells['descricaoCor']?.value = nfeDetEspecificoVeiculoModel.descricaoCor;
		plutoRow.cells['potenciaMotor']?.value = nfeDetEspecificoVeiculoModel.potenciaMotor;
		plutoRow.cells['cilindradas']?.value = nfeDetEspecificoVeiculoModel.cilindradas;
		plutoRow.cells['pesoLiquido']?.value = nfeDetEspecificoVeiculoModel.pesoLiquido;
		plutoRow.cells['pesoBruto']?.value = nfeDetEspecificoVeiculoModel.pesoBruto;
		plutoRow.cells['numeroSerie']?.value = nfeDetEspecificoVeiculoModel.numeroSerie;
		plutoRow.cells['tipoCombustivel']?.value = nfeDetEspecificoVeiculoModel.tipoCombustivel;
		plutoRow.cells['numeroMotor']?.value = nfeDetEspecificoVeiculoModel.numeroMotor;
		plutoRow.cells['capacidadeMaximaTracao']?.value = nfeDetEspecificoVeiculoModel.capacidadeMaximaTracao;
		plutoRow.cells['distanciaEixos']?.value = nfeDetEspecificoVeiculoModel.distanciaEixos;
		plutoRow.cells['anoModelo']?.value = nfeDetEspecificoVeiculoModel.anoModelo;
		plutoRow.cells['anoFabricacao']?.value = nfeDetEspecificoVeiculoModel.anoFabricacao;
		plutoRow.cells['tipoPintura']?.value = nfeDetEspecificoVeiculoModel.tipoPintura;
		plutoRow.cells['tipoVeiculo']?.value = nfeDetEspecificoVeiculoModel.tipoVeiculo;
		plutoRow.cells['especieVeiculo']?.value = nfeDetEspecificoVeiculoModel.especieVeiculo;
		plutoRow.cells['condicaoVin']?.value = nfeDetEspecificoVeiculoModel.condicaoVin;
		plutoRow.cells['condicaoVeiculo']?.value = nfeDetEspecificoVeiculoModel.condicaoVeiculo;
		plutoRow.cells['codigoMarcaModelo']?.value = nfeDetEspecificoVeiculoModel.codigoMarcaModelo;
		plutoRow.cells['codigoCorDenatran']?.value = nfeDetEspecificoVeiculoModel.codigoCorDenatran;
		plutoRow.cells['lotacaoMaxima']?.value = nfeDetEspecificoVeiculoModel.lotacaoMaxima;
		plutoRow.cells['restricao']?.value = nfeDetEspecificoVeiculoModel.restricao;
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
		nfeDetEspecificoVeiculoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetEspecificoVeiculoModel();
			model.plutoRowToObject(plutoRow);
			nfeDetEspecificoVeiculoModelList.add(model);
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
		chassiController.dispose();
		corController.dispose();
		descricaoCorController.dispose();
		potenciaMotorController.dispose();
		cilindradasController.dispose();
		pesoLiquidoController.dispose();
		pesoBrutoController.dispose();
		numeroSerieController.dispose();
		numeroMotorController.dispose();
		capacidadeMaximaTracaoController.dispose();
		distanciaEixosController.dispose();
		codigoMarcaModeloController.dispose();
		lotacaoMaximaController.dispose();
		super.onClose();
	}
}