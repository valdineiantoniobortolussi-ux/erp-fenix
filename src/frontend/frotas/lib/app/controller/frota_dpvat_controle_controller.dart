import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/page/page_imports.dart';
import 'package:frotas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:frotas/app/page/shared_widget/message_dialog.dart';

class FrotaDpvatControleController extends GetxController {

	// general
	final gridColumns = frotaDpvatControleGridColumns();
	
	var frotaDpvatControleModelList = <FrotaDpvatControleModel>[];

	final _frotaDpvatControleModel = FrotaDpvatControleModel().obs;
	FrotaDpvatControleModel get frotaDpvatControleModel => _frotaDpvatControleModel.value;
	set frotaDpvatControleModel(value) => _frotaDpvatControleModel.value = value ?? FrotaDpvatControleModel();
	
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
		for (var frotaDpvatControleModel in frotaDpvatControleModelList) {
			plutoRowList.add(_getPlutoRow(frotaDpvatControleModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FrotaDpvatControleModel frotaDpvatControleModel) {
		return PlutoRow(
			cells: _getPlutoCells(frotaDpvatControleModel: frotaDpvatControleModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FrotaDpvatControleModel? frotaDpvatControleModel}) {
		return {
			"id": PlutoCell(value: frotaDpvatControleModel?.id ?? 0),
			"ano": PlutoCell(value: frotaDpvatControleModel?.ano ?? ''),
			"parcela": PlutoCell(value: frotaDpvatControleModel?.parcela ?? ''),
			"dataVencimento": PlutoCell(value: frotaDpvatControleModel?.dataVencimento ?? ''),
			"dataPagamento": PlutoCell(value: frotaDpvatControleModel?.dataPagamento ?? ''),
			"valor": PlutoCell(value: frotaDpvatControleModel?.valor ?? 0),
			"idFrotaVeiculo": PlutoCell(value: frotaDpvatControleModel?.idFrotaVeiculo ?? 0),
		};
	}

	void plutoRowToObject() {
		frotaDpvatControleModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return frotaDpvatControleModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			anoController.text = currentRow.cells['ano']?.value ?? '';
			parcelaController.text = currentRow.cells['parcela']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FrotaDpvatControleEditPage());
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
	final anoController = TextEditingController();
	final parcelaController = TextEditingController();
	final valorController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = frotaDpvatControleModel.id;
		plutoRow.cells['idFrotaVeiculo']?.value = frotaDpvatControleModel.idFrotaVeiculo;
		plutoRow.cells['ano']?.value = frotaDpvatControleModel.ano;
		plutoRow.cells['parcela']?.value = frotaDpvatControleModel.parcela;
		plutoRow.cells['dataVencimento']?.value = Util.formatDate(frotaDpvatControleModel.dataVencimento);
		plutoRow.cells['dataPagamento']?.value = Util.formatDate(frotaDpvatControleModel.dataPagamento);
		plutoRow.cells['valor']?.value = frotaDpvatControleModel.valor;
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
		frotaDpvatControleModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FrotaDpvatControleModel();
			model.plutoRowToObject(plutoRow);
			frotaDpvatControleModelList.add(model);
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
		anoController.dispose();
		parcelaController.dispose();
		valorController.dispose();
		super.onClose();
	}
}