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

class NfeDetalheImpostoIcmsUfdestController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoIcmsUfdestGridColumns();
	
	var nfeDetalheImpostoIcmsUfdestModelList = <NfeDetalheImpostoIcmsUfdestModel>[];

	final _nfeDetalheImpostoIcmsUfdestModel = NfeDetalheImpostoIcmsUfdestModel().obs;
	NfeDetalheImpostoIcmsUfdestModel get nfeDetalheImpostoIcmsUfdestModel => _nfeDetalheImpostoIcmsUfdestModel.value;
	set nfeDetalheImpostoIcmsUfdestModel(value) => _nfeDetalheImpostoIcmsUfdestModel.value = value ?? NfeDetalheImpostoIcmsUfdestModel();
	
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
		for (var nfeDetalheImpostoIcmsUfdestModel in nfeDetalheImpostoIcmsUfdestModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoIcmsUfdestModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoIcmsUfdestModel nfeDetalheImpostoIcmsUfdestModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoIcmsUfdestModel: nfeDetalheImpostoIcmsUfdestModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoIcmsUfdestModel? nfeDetalheImpostoIcmsUfdestModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.id ?? 0),
			"valorBcIcmsUfDestino": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.valorBcIcmsUfDestino ?? 0),
			"valorBcFcpUfDestino": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.valorBcFcpUfDestino ?? 0),
			"percentualFcpUfDestino": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.percentualFcpUfDestino ?? 0),
			"aliquotaInternaUfDestino": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.aliquotaInternaUfDestino ?? 0),
			"aliquotaInteresdatualUfEnvolvidas": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.aliquotaInteresdatualUfEnvolvidas ?? 0),
			"percentualProvisorioPartilhaIcms": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.percentualProvisorioPartilhaIcms ?? 0),
			"valorIcmsFcpUfDestino": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.valorIcmsFcpUfDestino ?? 0),
			"valorInterestadualUfDestino": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.valorInterestadualUfDestino ?? 0),
			"valorInterestadualUfRemetente": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.valorInterestadualUfRemetente ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoIcmsUfdestModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoIcmsUfdestModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoIcmsUfdestModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorBcIcmsUfDestinoController.text = currentRow.cells['valorBcIcmsUfDestino']?.value?.toStringAsFixed(2) ?? '';
			valorBcFcpUfDestinoController.text = currentRow.cells['valorBcFcpUfDestino']?.value?.toStringAsFixed(2) ?? '';
			percentualFcpUfDestinoController.text = currentRow.cells['percentualFcpUfDestino']?.value?.toStringAsFixed(2) ?? '';
			aliquotaInternaUfDestinoController.text = currentRow.cells['aliquotaInternaUfDestino']?.value?.toStringAsFixed(2) ?? '';
			aliquotaInteresdatualUfEnvolvidasController.text = currentRow.cells['aliquotaInteresdatualUfEnvolvidas']?.value?.toStringAsFixed(2) ?? '';
			percentualProvisorioPartilhaIcmsController.text = currentRow.cells['percentualProvisorioPartilhaIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsFcpUfDestinoController.text = currentRow.cells['valorIcmsFcpUfDestino']?.value?.toStringAsFixed(2) ?? '';
			valorInterestadualUfDestinoController.text = currentRow.cells['valorInterestadualUfDestino']?.value?.toStringAsFixed(2) ?? '';
			valorInterestadualUfRemetenteController.text = currentRow.cells['valorInterestadualUfRemetente']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoIcmsUfdestEditPage());
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
	final valorBcIcmsUfDestinoController = MoneyMaskedTextController();
	final valorBcFcpUfDestinoController = MoneyMaskedTextController();
	final percentualFcpUfDestinoController = MoneyMaskedTextController();
	final aliquotaInternaUfDestinoController = MoneyMaskedTextController();
	final aliquotaInteresdatualUfEnvolvidasController = MoneyMaskedTextController();
	final percentualProvisorioPartilhaIcmsController = MoneyMaskedTextController();
	final valorIcmsFcpUfDestinoController = MoneyMaskedTextController();
	final valorInterestadualUfDestinoController = MoneyMaskedTextController();
	final valorInterestadualUfRemetenteController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoIcmsUfdestModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoIcmsUfdestModel.idNfeDetalhe;
		plutoRow.cells['valorBcIcmsUfDestino']?.value = nfeDetalheImpostoIcmsUfdestModel.valorBcIcmsUfDestino;
		plutoRow.cells['valorBcFcpUfDestino']?.value = nfeDetalheImpostoIcmsUfdestModel.valorBcFcpUfDestino;
		plutoRow.cells['percentualFcpUfDestino']?.value = nfeDetalheImpostoIcmsUfdestModel.percentualFcpUfDestino;
		plutoRow.cells['aliquotaInternaUfDestino']?.value = nfeDetalheImpostoIcmsUfdestModel.aliquotaInternaUfDestino;
		plutoRow.cells['aliquotaInteresdatualUfEnvolvidas']?.value = nfeDetalheImpostoIcmsUfdestModel.aliquotaInteresdatualUfEnvolvidas;
		plutoRow.cells['percentualProvisorioPartilhaIcms']?.value = nfeDetalheImpostoIcmsUfdestModel.percentualProvisorioPartilhaIcms;
		plutoRow.cells['valorIcmsFcpUfDestino']?.value = nfeDetalheImpostoIcmsUfdestModel.valorIcmsFcpUfDestino;
		plutoRow.cells['valorInterestadualUfDestino']?.value = nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfDestino;
		plutoRow.cells['valorInterestadualUfRemetente']?.value = nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfRemetente;
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
		nfeDetalheImpostoIcmsUfdestModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoIcmsUfdestModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoIcmsUfdestModelList.add(model);
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
		valorBcIcmsUfDestinoController.dispose();
		valorBcFcpUfDestinoController.dispose();
		percentualFcpUfDestinoController.dispose();
		aliquotaInternaUfDestinoController.dispose();
		aliquotaInteresdatualUfEnvolvidasController.dispose();
		percentualProvisorioPartilhaIcmsController.dispose();
		valorIcmsFcpUfDestinoController.dispose();
		valorInterestadualUfDestinoController.dispose();
		valorInterestadualUfRemetenteController.dispose();
		super.onClose();
	}
}