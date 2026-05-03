import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/page/page_imports.dart';
import 'package:tributacao/app/page/grid_columns/grid_columns_imports.dart';
import 'package:tributacao/app/page/shared_widget/message_dialog.dart';

class TributIcmsUfController extends GetxController {

	// general
	final gridColumns = tributIcmsUfGridColumns();
	
	var tributIcmsUfModelList = <TributIcmsUfModel>[];

	final _tributIcmsUfModel = TributIcmsUfModel().obs;
	TributIcmsUfModel get tributIcmsUfModel => _tributIcmsUfModel.value;
	set tributIcmsUfModel(value) => _tributIcmsUfModel.value = value ?? TributIcmsUfModel();
	
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
		for (var tributIcmsUfModel in tributIcmsUfModelList) {
			plutoRowList.add(_getPlutoRow(tributIcmsUfModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(TributIcmsUfModel tributIcmsUfModel) {
		return PlutoRow(
			cells: _getPlutoCells(tributIcmsUfModel: tributIcmsUfModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ TributIcmsUfModel? tributIcmsUfModel}) {
		return {
			"id": PlutoCell(value: tributIcmsUfModel?.id ?? 0),
			"ufDestino": PlutoCell(value: tributIcmsUfModel?.ufDestino ?? ''),
			"cst": PlutoCell(value: tributIcmsUfModel?.cst ?? ''),
			"csosn": PlutoCell(value: tributIcmsUfModel?.csosn ?? ''),
			"modalidadeBc": PlutoCell(value: tributIcmsUfModel?.modalidadeBc ?? ''),
			"cfop": PlutoCell(value: tributIcmsUfModel?.cfop ?? 0),
			"aliquota": PlutoCell(value: tributIcmsUfModel?.aliquota ?? 0),
			"valorPauta": PlutoCell(value: tributIcmsUfModel?.valorPauta ?? 0),
			"valorPrecoMaximo": PlutoCell(value: tributIcmsUfModel?.valorPrecoMaximo ?? 0),
			"mva": PlutoCell(value: tributIcmsUfModel?.mva ?? 0),
			"porcentoBc": PlutoCell(value: tributIcmsUfModel?.porcentoBc ?? 0),
			"modalidadeBcSt": PlutoCell(value: tributIcmsUfModel?.modalidadeBcSt ?? ''),
			"aliquotaInternaSt": PlutoCell(value: tributIcmsUfModel?.aliquotaInternaSt ?? 0),
			"aliquotaInterestadualSt": PlutoCell(value: tributIcmsUfModel?.aliquotaInterestadualSt ?? 0),
			"porcentoBcSt": PlutoCell(value: tributIcmsUfModel?.porcentoBcSt ?? 0),
			"aliquotaIcmsSt": PlutoCell(value: tributIcmsUfModel?.aliquotaIcmsSt ?? 0),
			"valorPautaSt": PlutoCell(value: tributIcmsUfModel?.valorPautaSt ?? 0),
			"valorPrecoMaximoSt": PlutoCell(value: tributIcmsUfModel?.valorPrecoMaximoSt ?? 0),
			"idTributConfiguraOfGt": PlutoCell(value: tributIcmsUfModel?.idTributConfiguraOfGt ?? 0),
		};
	}

	void plutoRowToObject() {
		tributIcmsUfModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return tributIcmsUfModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cfopController.text = currentRow.cells['cfop']?.value?.toString() ?? '';
			aliquotaController.text = currentRow.cells['aliquota']?.value?.toStringAsFixed(2) ?? '';
			valorPautaController.text = currentRow.cells['valorPauta']?.value?.toStringAsFixed(2) ?? '';
			valorPrecoMaximoController.text = currentRow.cells['valorPrecoMaximo']?.value?.toStringAsFixed(2) ?? '';
			mvaController.text = currentRow.cells['mva']?.value?.toStringAsFixed(2) ?? '';
			porcentoBcController.text = currentRow.cells['porcentoBc']?.value?.toStringAsFixed(2) ?? '';
			aliquotaInternaStController.text = currentRow.cells['aliquotaInternaSt']?.value?.toStringAsFixed(2) ?? '';
			aliquotaInterestadualStController.text = currentRow.cells['aliquotaInterestadualSt']?.value?.toStringAsFixed(2) ?? '';
			porcentoBcStController.text = currentRow.cells['porcentoBcSt']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsStController.text = currentRow.cells['aliquotaIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorPautaStController.text = currentRow.cells['valorPautaSt']?.value?.toStringAsFixed(2) ?? '';
			valorPrecoMaximoStController.text = currentRow.cells['valorPrecoMaximoSt']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => TributIcmsUfEditPage());
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
	final cfopController = TextEditingController();
	final aliquotaController = MoneyMaskedTextController();
	final valorPautaController = MoneyMaskedTextController();
	final valorPrecoMaximoController = MoneyMaskedTextController();
	final mvaController = MoneyMaskedTextController();
	final porcentoBcController = MoneyMaskedTextController();
	final aliquotaInternaStController = MoneyMaskedTextController();
	final aliquotaInterestadualStController = MoneyMaskedTextController();
	final porcentoBcStController = MoneyMaskedTextController();
	final aliquotaIcmsStController = MoneyMaskedTextController();
	final valorPautaStController = MoneyMaskedTextController();
	final valorPrecoMaximoStController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tributIcmsUfModel.id;
		plutoRow.cells['idTributConfiguraOfGt']?.value = tributIcmsUfModel.idTributConfiguraOfGt;
		plutoRow.cells['ufDestino']?.value = tributIcmsUfModel.ufDestino;
		plutoRow.cells['cst']?.value = tributIcmsUfModel.cst;
		plutoRow.cells['csosn']?.value = tributIcmsUfModel.csosn;
		plutoRow.cells['modalidadeBc']?.value = tributIcmsUfModel.modalidadeBc;
		plutoRow.cells['cfop']?.value = tributIcmsUfModel.cfop;
		plutoRow.cells['aliquota']?.value = tributIcmsUfModel.aliquota;
		plutoRow.cells['valorPauta']?.value = tributIcmsUfModel.valorPauta;
		plutoRow.cells['valorPrecoMaximo']?.value = tributIcmsUfModel.valorPrecoMaximo;
		plutoRow.cells['mva']?.value = tributIcmsUfModel.mva;
		plutoRow.cells['porcentoBc']?.value = tributIcmsUfModel.porcentoBc;
		plutoRow.cells['modalidadeBcSt']?.value = tributIcmsUfModel.modalidadeBcSt;
		plutoRow.cells['aliquotaInternaSt']?.value = tributIcmsUfModel.aliquotaInternaSt;
		plutoRow.cells['aliquotaInterestadualSt']?.value = tributIcmsUfModel.aliquotaInterestadualSt;
		plutoRow.cells['porcentoBcSt']?.value = tributIcmsUfModel.porcentoBcSt;
		plutoRow.cells['aliquotaIcmsSt']?.value = tributIcmsUfModel.aliquotaIcmsSt;
		plutoRow.cells['valorPautaSt']?.value = tributIcmsUfModel.valorPautaSt;
		plutoRow.cells['valorPrecoMaximoSt']?.value = tributIcmsUfModel.valorPrecoMaximoSt;
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
		tributIcmsUfModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = TributIcmsUfModel();
			model.plutoRowToObject(plutoRow);
			tributIcmsUfModelList.add(model);
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
		cfopController.dispose();
		aliquotaController.dispose();
		valorPautaController.dispose();
		valorPrecoMaximoController.dispose();
		mvaController.dispose();
		porcentoBcController.dispose();
		aliquotaInternaStController.dispose();
		aliquotaInterestadualStController.dispose();
		porcentoBcStController.dispose();
		aliquotaIcmsStController.dispose();
		valorPautaStController.dispose();
		valorPrecoMaximoStController.dispose();
		super.onClose();
	}
}