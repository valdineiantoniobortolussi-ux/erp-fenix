import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/routes/app_routes.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/page_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';

class ColaboradorRelacionamentoController extends GetxController {

	// general
	final gridColumns = colaboradorRelacionamentoGridColumns();
	
	var colaboradorRelacionamentoModelList = <ColaboradorRelacionamentoModel>[];

	final _colaboradorRelacionamentoModel = ColaboradorRelacionamentoModel().obs;
	ColaboradorRelacionamentoModel get colaboradorRelacionamentoModel => _colaboradorRelacionamentoModel.value;
	set colaboradorRelacionamentoModel(value) => _colaboradorRelacionamentoModel.value = value ?? ColaboradorRelacionamentoModel();
	
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
		for (var colaboradorRelacionamentoModel in colaboradorRelacionamentoModelList) {
			plutoRowList.add(_getPlutoRow(colaboradorRelacionamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ColaboradorRelacionamentoModel colaboradorRelacionamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(colaboradorRelacionamentoModel: colaboradorRelacionamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ColaboradorRelacionamentoModel? colaboradorRelacionamentoModel}) {
		return {
			"id": PlutoCell(value: colaboradorRelacionamentoModel?.id ?? 0),
			"tipoRelacionamento": PlutoCell(value: colaboradorRelacionamentoModel?.tipoRelacionamentoModel?.nome ?? ''),
			"nome": PlutoCell(value: colaboradorRelacionamentoModel?.nome ?? ''),
			"dataNascimento": PlutoCell(value: colaboradorRelacionamentoModel?.dataNascimento ?? ''),
			"cpf": PlutoCell(value: colaboradorRelacionamentoModel?.cpf ?? ''),
			"registroMatricula": PlutoCell(value: colaboradorRelacionamentoModel?.registroMatricula ?? ''),
			"registroCartorio": PlutoCell(value: colaboradorRelacionamentoModel?.registroCartorio ?? ''),
			"registroCartorioNumero": PlutoCell(value: colaboradorRelacionamentoModel?.registroCartorioNumero ?? ''),
			"registroNumeroLivro": PlutoCell(value: colaboradorRelacionamentoModel?.registroNumeroLivro ?? ''),
			"registroNumeroFolha": PlutoCell(value: colaboradorRelacionamentoModel?.registroNumeroFolha ?? ''),
			"dataEntregaDocumento": PlutoCell(value: colaboradorRelacionamentoModel?.dataEntregaDocumento ?? ''),
			"salarioFamilia": PlutoCell(value: colaboradorRelacionamentoModel?.salarioFamilia ?? ''),
			"salarioFamiliaIdadeLimite": PlutoCell(value: colaboradorRelacionamentoModel?.salarioFamiliaIdadeLimite ?? 0),
			"salarioFamiliaDataFim": PlutoCell(value: colaboradorRelacionamentoModel?.salarioFamiliaDataFim ?? ''),
			"impostoRendaIdadeLimite": PlutoCell(value: colaboradorRelacionamentoModel?.impostoRendaIdadeLimite ?? 0),
			"impostoRendaDataFim": PlutoCell(value: colaboradorRelacionamentoModel?.impostoRendaDataFim ?? 0),
			"idColaborador": PlutoCell(value: colaboradorRelacionamentoModel?.idColaborador ?? 0),
			"idTipoRelacionamento": PlutoCell(value: colaboradorRelacionamentoModel?.idTipoRelacionamento ?? 0),
		};
	}

	void plutoRowToObject() {
		colaboradorRelacionamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return colaboradorRelacionamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			tipoRelacionamentoModelController.text = currentRow.cells['tipoRelacionamento']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			registroMatriculaController.text = currentRow.cells['registroMatricula']?.value ?? '';
			registroCartorioController.text = currentRow.cells['registroCartorio']?.value ?? '';
			registroCartorioNumeroController.text = currentRow.cells['registroCartorioNumero']?.value ?? '';
			registroNumeroLivroController.text = currentRow.cells['registroNumeroLivro']?.value ?? '';
			registroNumeroFolhaController.text = currentRow.cells['registroNumeroFolha']?.value ?? '';
			salarioFamiliaIdadeLimiteController.text = currentRow.cells['salarioFamiliaIdadeLimite']?.value?.toString() ?? '';
			impostoRendaIdadeLimiteController.text = currentRow.cells['impostoRendaIdadeLimite']?.value?.toString() ?? '';
			impostoRendaDataFimController.text = currentRow.cells['impostoRendaDataFim']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ColaboradorRelacionamentoEditPage());
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
	final tipoRelacionamentoModelController = TextEditingController();
	final nomeController = TextEditingController();
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final registroMatriculaController = TextEditingController();
	final registroCartorioController = TextEditingController();
	final registroCartorioNumeroController = TextEditingController();
	final registroNumeroLivroController = TextEditingController();
	final registroNumeroFolhaController = TextEditingController();
	final salarioFamiliaIdadeLimiteController = TextEditingController();
	final impostoRendaIdadeLimiteController = TextEditingController();
	final impostoRendaDataFimController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = colaboradorRelacionamentoModel.id;
		plutoRow.cells['idColaborador']?.value = colaboradorRelacionamentoModel.idColaborador;
		plutoRow.cells['idTipoRelacionamento']?.value = colaboradorRelacionamentoModel.idTipoRelacionamento;
		plutoRow.cells['tipoRelacionamento']?.value = colaboradorRelacionamentoModel.tipoRelacionamentoModel?.nome;
		plutoRow.cells['nome']?.value = colaboradorRelacionamentoModel.nome;
		plutoRow.cells['dataNascimento']?.value = Util.formatDate(colaboradorRelacionamentoModel.dataNascimento);
		plutoRow.cells['cpf']?.value = colaboradorRelacionamentoModel.cpf;
		plutoRow.cells['registroMatricula']?.value = colaboradorRelacionamentoModel.registroMatricula;
		plutoRow.cells['registroCartorio']?.value = colaboradorRelacionamentoModel.registroCartorio;
		plutoRow.cells['registroCartorioNumero']?.value = colaboradorRelacionamentoModel.registroCartorioNumero;
		plutoRow.cells['registroNumeroLivro']?.value = colaboradorRelacionamentoModel.registroNumeroLivro;
		plutoRow.cells['registroNumeroFolha']?.value = colaboradorRelacionamentoModel.registroNumeroFolha;
		plutoRow.cells['dataEntregaDocumento']?.value = Util.formatDate(colaboradorRelacionamentoModel.dataEntregaDocumento);
		plutoRow.cells['salarioFamilia']?.value = colaboradorRelacionamentoModel.salarioFamilia;
		plutoRow.cells['salarioFamiliaIdadeLimite']?.value = colaboradorRelacionamentoModel.salarioFamiliaIdadeLimite;
		plutoRow.cells['salarioFamiliaDataFim']?.value = Util.formatDate(colaboradorRelacionamentoModel.salarioFamiliaDataFim);
		plutoRow.cells['impostoRendaIdadeLimite']?.value = colaboradorRelacionamentoModel.impostoRendaIdadeLimite;
		plutoRow.cells['impostoRendaDataFim']?.value = colaboradorRelacionamentoModel.impostoRendaDataFim;
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
		colaboradorRelacionamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ColaboradorRelacionamentoModel();
			model.plutoRowToObject(plutoRow);
			colaboradorRelacionamentoModelList.add(model);
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

	Future callTipoRelacionamentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Relacionamento]'; 
		lookupController.route = '/tipo-relacionamento/'; 
		lookupController.gridColumns = tipoRelacionamentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TipoRelacionamentoModel.aliasColumns; 
		lookupController.dbColumns = TipoRelacionamentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorRelacionamentoModel.idTipoRelacionamento = plutoRowResult.cells['id']!.value; 
			colaboradorRelacionamentoModel.tipoRelacionamentoModel!.plutoRowToObject(plutoRowResult); 
			tipoRelacionamentoModelController.text = colaboradorRelacionamentoModel.tipoRelacionamentoModel?.nome ?? ''; 
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
		tipoRelacionamentoModelController.dispose();
		nomeController.dispose();
		cpfController.dispose();
		registroMatriculaController.dispose();
		registroCartorioController.dispose();
		registroCartorioNumeroController.dispose();
		registroNumeroLivroController.dispose();
		registroNumeroFolhaController.dispose();
		salarioFamiliaIdadeLimiteController.dispose();
		impostoRendaIdadeLimiteController.dispose();
		impostoRendaDataFimController.dispose();
		super.onClose();
	}
}