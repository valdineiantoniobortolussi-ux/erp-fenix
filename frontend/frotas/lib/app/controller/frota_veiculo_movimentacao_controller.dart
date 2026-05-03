import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:frotas/app/controller/controller_imports.dart';
import 'package:frotas/app/routes/app_routes.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/page/page_imports.dart';
import 'package:frotas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:frotas/app/page/shared_widget/message_dialog.dart';

class FrotaVeiculoMovimentacaoController extends GetxController {

	// general
	final gridColumns = frotaVeiculoMovimentacaoGridColumns();
	
	var frotaVeiculoMovimentacaoModelList = <FrotaVeiculoMovimentacaoModel>[];

	final _frotaVeiculoMovimentacaoModel = FrotaVeiculoMovimentacaoModel().obs;
	FrotaVeiculoMovimentacaoModel get frotaVeiculoMovimentacaoModel => _frotaVeiculoMovimentacaoModel.value;
	set frotaVeiculoMovimentacaoModel(value) => _frotaVeiculoMovimentacaoModel.value = value ?? FrotaVeiculoMovimentacaoModel();
	
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
		for (var frotaVeiculoMovimentacaoModel in frotaVeiculoMovimentacaoModelList) {
			plutoRowList.add(_getPlutoRow(frotaVeiculoMovimentacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FrotaVeiculoMovimentacaoModel frotaVeiculoMovimentacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(frotaVeiculoMovimentacaoModel: frotaVeiculoMovimentacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FrotaVeiculoMovimentacaoModel? frotaVeiculoMovimentacaoModel}) {
		return {
			"id": PlutoCell(value: frotaVeiculoMovimentacaoModel?.id ?? 0),
			"frotaMotorista": PlutoCell(value: frotaVeiculoMovimentacaoModel?.frotaMotoristaModel?.nome ?? ''),
			"dataSaida": PlutoCell(value: frotaVeiculoMovimentacaoModel?.dataSaida ?? ''),
			"horaSaida": PlutoCell(value: frotaVeiculoMovimentacaoModel?.horaSaida ?? ''),
			"dataEntrada": PlutoCell(value: frotaVeiculoMovimentacaoModel?.dataEntrada ?? ''),
			"horaEntrada": PlutoCell(value: frotaVeiculoMovimentacaoModel?.horaEntrada ?? ''),
			"observacao": PlutoCell(value: frotaVeiculoMovimentacaoModel?.observacao ?? ''),
			"idFrotaVeiculo": PlutoCell(value: frotaVeiculoMovimentacaoModel?.idFrotaVeiculo ?? 0),
			"idFrotaMotorista": PlutoCell(value: frotaVeiculoMovimentacaoModel?.idFrotaMotorista ?? 0),
		};
	}

	void plutoRowToObject() {
		frotaVeiculoMovimentacaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return frotaVeiculoMovimentacaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			frotaMotoristaModelController.text = currentRow.cells['frotaMotorista']?.value ?? '';
			horaSaidaController.text = currentRow.cells['horaSaida']?.value ?? '';
			horaEntradaController.text = currentRow.cells['horaEntrada']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FrotaVeiculoMovimentacaoEditPage());
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
	final frotaMotoristaModelController = TextEditingController();
	final horaSaidaController = MaskedTextController(mask: '00:00:00',);
	final horaEntradaController = MaskedTextController(mask: '00:00:00',);
	final observacaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = frotaVeiculoMovimentacaoModel.id;
		plutoRow.cells['idFrotaVeiculo']?.value = frotaVeiculoMovimentacaoModel.idFrotaVeiculo;
		plutoRow.cells['idFrotaMotorista']?.value = frotaVeiculoMovimentacaoModel.idFrotaMotorista;
		plutoRow.cells['frotaMotorista']?.value = frotaVeiculoMovimentacaoModel.frotaMotoristaModel?.nome;
		plutoRow.cells['dataSaida']?.value = Util.formatDate(frotaVeiculoMovimentacaoModel.dataSaida);
		plutoRow.cells['horaSaida']?.value = frotaVeiculoMovimentacaoModel.horaSaida;
		plutoRow.cells['dataEntrada']?.value = Util.formatDate(frotaVeiculoMovimentacaoModel.dataEntrada);
		plutoRow.cells['horaEntrada']?.value = frotaVeiculoMovimentacaoModel.horaEntrada;
		plutoRow.cells['observacao']?.value = frotaVeiculoMovimentacaoModel.observacao;
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
		frotaVeiculoMovimentacaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FrotaVeiculoMovimentacaoModel();
			model.plutoRowToObject(plutoRow);
			frotaVeiculoMovimentacaoModelList.add(model);
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

	Future callFrotaMotoristaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Motorista]'; 
		lookupController.route = '/frota-motorista/'; 
		lookupController.gridColumns = frotaMotoristaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FrotaMotoristaModel.aliasColumns; 
		lookupController.dbColumns = FrotaMotoristaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			frotaVeiculoMovimentacaoModel.idFrotaMotorista = plutoRowResult.cells['id']!.value; 
			frotaVeiculoMovimentacaoModel.frotaMotoristaModel!.plutoRowToObject(plutoRowResult); 
			frotaMotoristaModelController.text = frotaVeiculoMovimentacaoModel.frotaMotoristaModel?.nome ?? ''; 
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
		frotaMotoristaModelController.dispose();
		horaSaidaController.dispose();
		horaEntradaController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}