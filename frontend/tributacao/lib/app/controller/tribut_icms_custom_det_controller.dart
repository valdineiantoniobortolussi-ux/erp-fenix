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

class TributIcmsCustomDetController extends GetxController {

	// general
	final gridColumns = tributIcmsCustomDetGridColumns();
	
	var tributIcmsCustomDetModelList = <TributIcmsCustomDetModel>[];

	final _tributIcmsCustomDetModel = TributIcmsCustomDetModel().obs;
	TributIcmsCustomDetModel get tributIcmsCustomDetModel => _tributIcmsCustomDetModel.value;
	set tributIcmsCustomDetModel(value) => _tributIcmsCustomDetModel.value = value ?? TributIcmsCustomDetModel();
	
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
		for (var tributIcmsCustomDetModel in tributIcmsCustomDetModelList) {
			plutoRowList.add(_getPlutoRow(tributIcmsCustomDetModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(TributIcmsCustomDetModel tributIcmsCustomDetModel) {
		return PlutoRow(
			cells: _getPlutoCells(tributIcmsCustomDetModel: tributIcmsCustomDetModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ TributIcmsCustomDetModel? tributIcmsCustomDetModel}) {
		return {
			"id": PlutoCell(value: tributIcmsCustomDetModel?.id ?? 0),
			"ufDestino": PlutoCell(value: tributIcmsCustomDetModel?.ufDestino ?? ''),
			"cst": PlutoCell(value: tributIcmsCustomDetModel?.cst ?? ''),
			"csosn": PlutoCell(value: tributIcmsCustomDetModel?.csosn ?? ''),
			"modalidadeBc": PlutoCell(value: tributIcmsCustomDetModel?.modalidadeBc ?? ''),
			"cfop": PlutoCell(value: tributIcmsCustomDetModel?.cfop ?? 0),
			"aliquota": PlutoCell(value: tributIcmsCustomDetModel?.aliquota ?? 0),
			"valorPauta": PlutoCell(value: tributIcmsCustomDetModel?.valorPauta ?? 0),
			"valorPrecoMaximo": PlutoCell(value: tributIcmsCustomDetModel?.valorPrecoMaximo ?? 0),
			"mva": PlutoCell(value: tributIcmsCustomDetModel?.mva ?? 0),
			"porcentoBc": PlutoCell(value: tributIcmsCustomDetModel?.porcentoBc ?? 0),
			"modalidadeBcSt": PlutoCell(value: tributIcmsCustomDetModel?.modalidadeBcSt ?? ''),
			"aliquotaInternaSt": PlutoCell(value: tributIcmsCustomDetModel?.aliquotaInternaSt ?? 0),
			"aliquotaInterestadualSt": PlutoCell(value: tributIcmsCustomDetModel?.aliquotaInterestadualSt ?? 0),
			"porcentoBcSt": PlutoCell(value: tributIcmsCustomDetModel?.porcentoBcSt ?? 0),
			"aliquotaIcmsSt": PlutoCell(value: tributIcmsCustomDetModel?.aliquotaIcmsSt ?? 0),
			"valorPautaSt": PlutoCell(value: tributIcmsCustomDetModel?.valorPautaSt ?? 0),
			"valorPrecoMaximoSt": PlutoCell(value: tributIcmsCustomDetModel?.valorPrecoMaximoSt ?? 0),
			"idTributIcmsCustomCab": PlutoCell(value: tributIcmsCustomDetModel?.idTributIcmsCustomCab ?? 0),
		};
	}

	void plutoRowToObject() {
		tributIcmsCustomDetModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return tributIcmsCustomDetModelList;
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
			Get.to(() => TributIcmsCustomDetEditPage());
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
		plutoRow.cells['id']?.value = tributIcmsCustomDetModel.id;
		plutoRow.cells['idTributIcmsCustomCab']?.value = tributIcmsCustomDetModel.idTributIcmsCustomCab;
		plutoRow.cells['ufDestino']?.value = tributIcmsCustomDetModel.ufDestino;
		plutoRow.cells['cst']?.value = tributIcmsCustomDetModel.cst;
		plutoRow.cells['csosn']?.value = tributIcmsCustomDetModel.csosn;
		plutoRow.cells['modalidadeBc']?.value = tributIcmsCustomDetModel.modalidadeBc;
		plutoRow.cells['cfop']?.value = tributIcmsCustomDetModel.cfop;
		plutoRow.cells['aliquota']?.value = tributIcmsCustomDetModel.aliquota;
		plutoRow.cells['valorPauta']?.value = tributIcmsCustomDetModel.valorPauta;
		plutoRow.cells['valorPrecoMaximo']?.value = tributIcmsCustomDetModel.valorPrecoMaximo;
		plutoRow.cells['mva']?.value = tributIcmsCustomDetModel.mva;
		plutoRow.cells['porcentoBc']?.value = tributIcmsCustomDetModel.porcentoBc;
		plutoRow.cells['modalidadeBcSt']?.value = tributIcmsCustomDetModel.modalidadeBcSt;
		plutoRow.cells['aliquotaInternaSt']?.value = tributIcmsCustomDetModel.aliquotaInternaSt;
		plutoRow.cells['aliquotaInterestadualSt']?.value = tributIcmsCustomDetModel.aliquotaInterestadualSt;
		plutoRow.cells['porcentoBcSt']?.value = tributIcmsCustomDetModel.porcentoBcSt;
		plutoRow.cells['aliquotaIcmsSt']?.value = tributIcmsCustomDetModel.aliquotaIcmsSt;
		plutoRow.cells['valorPautaSt']?.value = tributIcmsCustomDetModel.valorPautaSt;
		plutoRow.cells['valorPrecoMaximoSt']?.value = tributIcmsCustomDetModel.valorPrecoMaximoSt;
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
		tributIcmsCustomDetModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = TributIcmsCustomDetModel();
			model.plutoRowToObject(plutoRow);
			tributIcmsCustomDetModelList.add(model);
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