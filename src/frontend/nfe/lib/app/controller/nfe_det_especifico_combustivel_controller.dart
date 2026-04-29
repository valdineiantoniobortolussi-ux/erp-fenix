import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeDetEspecificoCombustivelController extends GetxController {

	// general
	final gridColumns = nfeDetEspecificoCombustivelGridColumns();
	
	var nfeDetEspecificoCombustivelModelList = <NfeDetEspecificoCombustivelModel>[];

	final _nfeDetEspecificoCombustivelModel = NfeDetEspecificoCombustivelModel().obs;
	NfeDetEspecificoCombustivelModel get nfeDetEspecificoCombustivelModel => _nfeDetEspecificoCombustivelModel.value;
	set nfeDetEspecificoCombustivelModel(value) => _nfeDetEspecificoCombustivelModel.value = value ?? NfeDetEspecificoCombustivelModel();
	
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
		for (var nfeDetEspecificoCombustivelModel in nfeDetEspecificoCombustivelModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetEspecificoCombustivelModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetEspecificoCombustivelModel nfeDetEspecificoCombustivelModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetEspecificoCombustivelModel: nfeDetEspecificoCombustivelModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetEspecificoCombustivelModel? nfeDetEspecificoCombustivelModel}) {
		return {
			"id": PlutoCell(value: nfeDetEspecificoCombustivelModel?.id ?? 0),
			"codigoAnp": PlutoCell(value: nfeDetEspecificoCombustivelModel?.codigoAnp ?? 0),
			"descricaoAnp": PlutoCell(value: nfeDetEspecificoCombustivelModel?.descricaoAnp ?? ''),
			"percentualGlp": PlutoCell(value: nfeDetEspecificoCombustivelModel?.percentualGlp ?? 0),
			"percentualGasNacional": PlutoCell(value: nfeDetEspecificoCombustivelModel?.percentualGasNacional ?? 0),
			"percentualGasImportado": PlutoCell(value: nfeDetEspecificoCombustivelModel?.percentualGasImportado ?? 0),
			"valorPartida": PlutoCell(value: nfeDetEspecificoCombustivelModel?.valorPartida ?? 0),
			"codif": PlutoCell(value: nfeDetEspecificoCombustivelModel?.codif ?? ''),
			"quantidadeTempAmbiente": PlutoCell(value: nfeDetEspecificoCombustivelModel?.quantidadeTempAmbiente ?? 0),
			"ufConsumo": PlutoCell(value: nfeDetEspecificoCombustivelModel?.ufConsumo ?? ''),
			"cideBaseCalculo": PlutoCell(value: nfeDetEspecificoCombustivelModel?.cideBaseCalculo ?? 0),
			"cideAliquota": PlutoCell(value: nfeDetEspecificoCombustivelModel?.cideAliquota ?? 0),
			"cideValor": PlutoCell(value: nfeDetEspecificoCombustivelModel?.cideValor ?? 0),
			"encerranteBico": PlutoCell(value: nfeDetEspecificoCombustivelModel?.encerranteBico ?? 0),
			"encerranteBomba": PlutoCell(value: nfeDetEspecificoCombustivelModel?.encerranteBomba ?? 0),
			"encerranteTanque": PlutoCell(value: nfeDetEspecificoCombustivelModel?.encerranteTanque ?? 0),
			"encerranteValorInicio": PlutoCell(value: nfeDetEspecificoCombustivelModel?.encerranteValorInicio ?? 0),
			"encerranteValorFim": PlutoCell(value: nfeDetEspecificoCombustivelModel?.encerranteValorFim ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetEspecificoCombustivelModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetEspecificoCombustivelModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetEspecificoCombustivelModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			codigoAnpController.text = currentRow.cells['codigoAnp']?.value?.toString() ?? '';
			descricaoAnpController.text = currentRow.cells['descricaoAnp']?.value ?? '';
			percentualGlpController.text = currentRow.cells['percentualGlp']?.value?.toStringAsFixed(2) ?? '';
			percentualGasNacionalController.text = currentRow.cells['percentualGasNacional']?.value?.toStringAsFixed(2) ?? '';
			percentualGasImportadoController.text = currentRow.cells['percentualGasImportado']?.value?.toStringAsFixed(2) ?? '';
			valorPartidaController.text = currentRow.cells['valorPartida']?.value?.toStringAsFixed(2) ?? '';
			codifController.text = currentRow.cells['codif']?.value ?? '';
			quantidadeTempAmbienteController.text = currentRow.cells['quantidadeTempAmbiente']?.value?.toStringAsFixed(2) ?? '';
			cideBaseCalculoController.text = currentRow.cells['cideBaseCalculo']?.value?.toStringAsFixed(2) ?? '';
			cideAliquotaController.text = currentRow.cells['cideAliquota']?.value?.toStringAsFixed(2) ?? '';
			cideValorController.text = currentRow.cells['cideValor']?.value?.toStringAsFixed(2) ?? '';
			encerranteBicoController.text = currentRow.cells['encerranteBico']?.value?.toString() ?? '';
			encerranteBombaController.text = currentRow.cells['encerranteBomba']?.value?.toString() ?? '';
			encerranteTanqueController.text = currentRow.cells['encerranteTanque']?.value?.toString() ?? '';
			encerranteValorInicioController.text = currentRow.cells['encerranteValorInicio']?.value?.toStringAsFixed(2) ?? '';
			encerranteValorFimController.text = currentRow.cells['encerranteValorFim']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetEspecificoCombustivelEditPage());
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
	final codigoAnpController = TextEditingController();
	final descricaoAnpController = TextEditingController();
	final percentualGlpController = MoneyMaskedTextController();
	final percentualGasNacionalController = MoneyMaskedTextController();
	final percentualGasImportadoController = MoneyMaskedTextController();
	final valorPartidaController = MoneyMaskedTextController();
	final codifController = TextEditingController();
	final quantidadeTempAmbienteController = MoneyMaskedTextController();
	final cideBaseCalculoController = MoneyMaskedTextController();
	final cideAliquotaController = MoneyMaskedTextController();
	final cideValorController = MoneyMaskedTextController();
	final encerranteBicoController = TextEditingController();
	final encerranteBombaController = TextEditingController();
	final encerranteTanqueController = TextEditingController();
	final encerranteValorInicioController = MoneyMaskedTextController();
	final encerranteValorFimController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetEspecificoCombustivelModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetEspecificoCombustivelModel.idNfeDetalhe;
		plutoRow.cells['codigoAnp']?.value = nfeDetEspecificoCombustivelModel.codigoAnp;
		plutoRow.cells['descricaoAnp']?.value = nfeDetEspecificoCombustivelModel.descricaoAnp;
		plutoRow.cells['percentualGlp']?.value = nfeDetEspecificoCombustivelModel.percentualGlp;
		plutoRow.cells['percentualGasNacional']?.value = nfeDetEspecificoCombustivelModel.percentualGasNacional;
		plutoRow.cells['percentualGasImportado']?.value = nfeDetEspecificoCombustivelModel.percentualGasImportado;
		plutoRow.cells['valorPartida']?.value = nfeDetEspecificoCombustivelModel.valorPartida;
		plutoRow.cells['codif']?.value = nfeDetEspecificoCombustivelModel.codif;
		plutoRow.cells['quantidadeTempAmbiente']?.value = nfeDetEspecificoCombustivelModel.quantidadeTempAmbiente;
		plutoRow.cells['ufConsumo']?.value = nfeDetEspecificoCombustivelModel.ufConsumo;
		plutoRow.cells['cideBaseCalculo']?.value = nfeDetEspecificoCombustivelModel.cideBaseCalculo;
		plutoRow.cells['cideAliquota']?.value = nfeDetEspecificoCombustivelModel.cideAliquota;
		plutoRow.cells['cideValor']?.value = nfeDetEspecificoCombustivelModel.cideValor;
		plutoRow.cells['encerranteBico']?.value = nfeDetEspecificoCombustivelModel.encerranteBico;
		plutoRow.cells['encerranteBomba']?.value = nfeDetEspecificoCombustivelModel.encerranteBomba;
		plutoRow.cells['encerranteTanque']?.value = nfeDetEspecificoCombustivelModel.encerranteTanque;
		plutoRow.cells['encerranteValorInicio']?.value = nfeDetEspecificoCombustivelModel.encerranteValorInicio;
		plutoRow.cells['encerranteValorFim']?.value = nfeDetEspecificoCombustivelModel.encerranteValorFim;
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
		nfeDetEspecificoCombustivelModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetEspecificoCombustivelModel();
			model.plutoRowToObject(plutoRow);
			nfeDetEspecificoCombustivelModelList.add(model);
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
		codigoAnpController.dispose();
		descricaoAnpController.dispose();
		percentualGlpController.dispose();
		percentualGasNacionalController.dispose();
		percentualGasImportadoController.dispose();
		valorPartidaController.dispose();
		codifController.dispose();
		quantidadeTempAmbienteController.dispose();
		cideBaseCalculoController.dispose();
		cideAliquotaController.dispose();
		cideValorController.dispose();
		encerranteBicoController.dispose();
		encerranteBombaController.dispose();
		encerranteTanqueController.dispose();
		encerranteValorInicioController.dispose();
		encerranteValorFimController.dispose();
		super.onClose();
	}
}