import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/page_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';

class ContabilDreDetalheController extends GetxController {

	// general
	final gridColumns = contabilDreDetalheGridColumns();
	
	var contabilDreDetalheModelList = <ContabilDreDetalheModel>[];

	final _contabilDreDetalheModel = ContabilDreDetalheModel().obs;
	ContabilDreDetalheModel get contabilDreDetalheModel => _contabilDreDetalheModel.value;
	set contabilDreDetalheModel(value) => _contabilDreDetalheModel.value = value ?? ContabilDreDetalheModel();
	
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
		for (var contabilDreDetalheModel in contabilDreDetalheModelList) {
			plutoRowList.add(_getPlutoRow(contabilDreDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilDreDetalheModel contabilDreDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilDreDetalheModel: contabilDreDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilDreDetalheModel? contabilDreDetalheModel}) {
		return {
			"id": PlutoCell(value: contabilDreDetalheModel?.id ?? 0),
			"classificacao": PlutoCell(value: contabilDreDetalheModel?.classificacao ?? ''),
			"descricao": PlutoCell(value: contabilDreDetalheModel?.descricao ?? ''),
			"formaCalculo": PlutoCell(value: contabilDreDetalheModel?.formaCalculo ?? ''),
			"sinal": PlutoCell(value: contabilDreDetalheModel?.sinal ?? ''),
			"natureza": PlutoCell(value: contabilDreDetalheModel?.natureza ?? ''),
			"valor": PlutoCell(value: contabilDreDetalheModel?.valor ?? 0),
			"idContabilDreCabecalho": PlutoCell(value: contabilDreDetalheModel?.idContabilDreCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		contabilDreDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return contabilDreDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			classificacaoController.text = currentRow.cells['classificacao']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ContabilDreDetalheEditPage());
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
	final classificacaoController = TextEditingController();
	final descricaoController = TextEditingController();
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
		plutoRow.cells['id']?.value = contabilDreDetalheModel.id;
		plutoRow.cells['idContabilDreCabecalho']?.value = contabilDreDetalheModel.idContabilDreCabecalho;
		plutoRow.cells['classificacao']?.value = contabilDreDetalheModel.classificacao;
		plutoRow.cells['descricao']?.value = contabilDreDetalheModel.descricao;
		plutoRow.cells['formaCalculo']?.value = contabilDreDetalheModel.formaCalculo;
		plutoRow.cells['sinal']?.value = contabilDreDetalheModel.sinal;
		plutoRow.cells['natureza']?.value = contabilDreDetalheModel.natureza;
		plutoRow.cells['valor']?.value = contabilDreDetalheModel.valor;
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
		contabilDreDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ContabilDreDetalheModel();
			model.plutoRowToObject(plutoRow);
			contabilDreDetalheModelList.add(model);
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
		classificacaoController.dispose();
		descricaoController.dispose();
		valorController.dispose();
		super.onClose();
	}
}