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

class CteVeiculoNovoController extends GetxController {

	// general
	final gridColumns = cteVeiculoNovoGridColumns();
	
	var cteVeiculoNovoModelList = <CteVeiculoNovoModel>[];

	final _cteVeiculoNovoModel = CteVeiculoNovoModel().obs;
	CteVeiculoNovoModel get cteVeiculoNovoModel => _cteVeiculoNovoModel.value;
	set cteVeiculoNovoModel(value) => _cteVeiculoNovoModel.value = value ?? CteVeiculoNovoModel();
	
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
		for (var cteVeiculoNovoModel in cteVeiculoNovoModelList) {
			plutoRowList.add(_getPlutoRow(cteVeiculoNovoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteVeiculoNovoModel cteVeiculoNovoModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteVeiculoNovoModel: cteVeiculoNovoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteVeiculoNovoModel? cteVeiculoNovoModel}) {
		return {
			"id": PlutoCell(value: cteVeiculoNovoModel?.id ?? 0),
			"chassi": PlutoCell(value: cteVeiculoNovoModel?.chassi ?? ''),
			"cor": PlutoCell(value: cteVeiculoNovoModel?.cor ?? ''),
			"descricaoCor": PlutoCell(value: cteVeiculoNovoModel?.descricaoCor ?? ''),
			"codigoMarcaModelo": PlutoCell(value: cteVeiculoNovoModel?.codigoMarcaModelo ?? ''),
			"valorUnitario": PlutoCell(value: cteVeiculoNovoModel?.valorUnitario ?? 0),
			"valorFrete": PlutoCell(value: cteVeiculoNovoModel?.valorFrete ?? 0),
			"idCteCabecalho": PlutoCell(value: cteVeiculoNovoModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteVeiculoNovoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteVeiculoNovoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			chassiController.text = currentRow.cells['chassi']?.value ?? '';
			corController.text = currentRow.cells['cor']?.value ?? '';
			descricaoCorController.text = currentRow.cells['descricaoCor']?.value ?? '';
			codigoMarcaModeloController.text = currentRow.cells['codigoMarcaModelo']?.value ?? '';
			valorUnitarioController.text = currentRow.cells['valorUnitario']?.value?.toStringAsFixed(2) ?? '';
			valorFreteController.text = currentRow.cells['valorFrete']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteVeiculoNovoEditPage());
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
	final codigoMarcaModeloController = TextEditingController();
	final valorUnitarioController = MoneyMaskedTextController();
	final valorFreteController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteVeiculoNovoModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteVeiculoNovoModel.idCteCabecalho;
		plutoRow.cells['chassi']?.value = cteVeiculoNovoModel.chassi;
		plutoRow.cells['cor']?.value = cteVeiculoNovoModel.cor;
		plutoRow.cells['descricaoCor']?.value = cteVeiculoNovoModel.descricaoCor;
		plutoRow.cells['codigoMarcaModelo']?.value = cteVeiculoNovoModel.codigoMarcaModelo;
		plutoRow.cells['valorUnitario']?.value = cteVeiculoNovoModel.valorUnitario;
		plutoRow.cells['valorFrete']?.value = cteVeiculoNovoModel.valorFrete;
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
		cteVeiculoNovoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteVeiculoNovoModel();
			model.plutoRowToObject(plutoRow);
			cteVeiculoNovoModelList.add(model);
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
		codigoMarcaModeloController.dispose();
		valorUnitarioController.dispose();
		valorFreteController.dispose();
		super.onClose();
	}
}