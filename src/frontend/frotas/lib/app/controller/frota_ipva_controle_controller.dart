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

class FrotaIpvaControleController extends GetxController {

	// general
	final gridColumns = frotaIpvaControleGridColumns();
	
	var frotaIpvaControleModelList = <FrotaIpvaControleModel>[];

	final _frotaIpvaControleModel = FrotaIpvaControleModel().obs;
	FrotaIpvaControleModel get frotaIpvaControleModel => _frotaIpvaControleModel.value;
	set frotaIpvaControleModel(value) => _frotaIpvaControleModel.value = value ?? FrotaIpvaControleModel();
	
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
		for (var frotaIpvaControleModel in frotaIpvaControleModelList) {
			plutoRowList.add(_getPlutoRow(frotaIpvaControleModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FrotaIpvaControleModel frotaIpvaControleModel) {
		return PlutoRow(
			cells: _getPlutoCells(frotaIpvaControleModel: frotaIpvaControleModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FrotaIpvaControleModel? frotaIpvaControleModel}) {
		return {
			"id": PlutoCell(value: frotaIpvaControleModel?.id ?? 0),
			"ano": PlutoCell(value: frotaIpvaControleModel?.ano ?? ''),
			"parcela": PlutoCell(value: frotaIpvaControleModel?.parcela ?? ''),
			"dataVencimento": PlutoCell(value: frotaIpvaControleModel?.dataVencimento ?? ''),
			"dataPagamento": PlutoCell(value: frotaIpvaControleModel?.dataPagamento ?? ''),
			"valor": PlutoCell(value: frotaIpvaControleModel?.valor ?? 0),
			"idFrotaVeiculo": PlutoCell(value: frotaIpvaControleModel?.idFrotaVeiculo ?? 0),
		};
	}

	void plutoRowToObject() {
		frotaIpvaControleModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return frotaIpvaControleModelList;
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
			Get.to(() => FrotaIpvaControleEditPage());
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
		plutoRow.cells['id']?.value = frotaIpvaControleModel.id;
		plutoRow.cells['idFrotaVeiculo']?.value = frotaIpvaControleModel.idFrotaVeiculo;
		plutoRow.cells['ano']?.value = frotaIpvaControleModel.ano;
		plutoRow.cells['parcela']?.value = frotaIpvaControleModel.parcela;
		plutoRow.cells['dataVencimento']?.value = Util.formatDate(frotaIpvaControleModel.dataVencimento);
		plutoRow.cells['dataPagamento']?.value = Util.formatDate(frotaIpvaControleModel.dataPagamento);
		plutoRow.cells['valor']?.value = frotaIpvaControleModel.valor;
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
		frotaIpvaControleModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FrotaIpvaControleModel();
			model.plutoRowToObject(plutoRow);
			frotaIpvaControleModelList.add(model);
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