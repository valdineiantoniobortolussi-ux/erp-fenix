import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pcp/app/controller/controller_imports.dart';
import 'package:pcp/app/routes/app_routes.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:pcp/app/page/page_imports.dart';
import 'package:pcp/app/page/grid_columns/grid_columns_imports.dart';
import 'package:pcp/app/page/shared_widget/message_dialog.dart';

class PcpServicoColaboradorController extends GetxController {

	// general
	final gridColumns = pcpServicoColaboradorGridColumns();
	
	var pcpServicoColaboradorModelList = <PcpServicoColaboradorModel>[];

	final _pcpServicoColaboradorModel = PcpServicoColaboradorModel().obs;
	PcpServicoColaboradorModel get pcpServicoColaboradorModel => _pcpServicoColaboradorModel.value;
	set pcpServicoColaboradorModel(value) => _pcpServicoColaboradorModel.value = value ?? PcpServicoColaboradorModel();
	
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
		for (var pcpServicoColaboradorModel in pcpServicoColaboradorModelList) {
			plutoRowList.add(_getPlutoRow(pcpServicoColaboradorModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PcpServicoColaboradorModel pcpServicoColaboradorModel) {
		return PlutoRow(
			cells: _getPlutoCells(pcpServicoColaboradorModel: pcpServicoColaboradorModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PcpServicoColaboradorModel? pcpServicoColaboradorModel}) {
		return {
			"id": PlutoCell(value: pcpServicoColaboradorModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: pcpServicoColaboradorModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"idPcpServico": PlutoCell(value: pcpServicoColaboradorModel?.idPcpServico ?? 0),
			"idColaborador": PlutoCell(value: pcpServicoColaboradorModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		pcpServicoColaboradorModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pcpServicoColaboradorModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PcpServicoColaboradorEditPage());
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
	final viewPessoaColaboradorModelController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pcpServicoColaboradorModel.id;
		plutoRow.cells['idPcpServico']?.value = pcpServicoColaboradorModel.idPcpServico;
		plutoRow.cells['idColaborador']?.value = pcpServicoColaboradorModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = pcpServicoColaboradorModel.viewPessoaColaboradorModel?.nome;
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
		pcpServicoColaboradorModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PcpServicoColaboradorModel();
			model.plutoRowToObject(plutoRow);
			pcpServicoColaboradorModelList.add(model);
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

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pcpServicoColaboradorModel.idColaborador = plutoRowResult.cells['id']!.value; 
			pcpServicoColaboradorModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = pcpServicoColaboradorModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
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
		viewPessoaColaboradorModelController.dispose();
		super.onClose();
	}
}