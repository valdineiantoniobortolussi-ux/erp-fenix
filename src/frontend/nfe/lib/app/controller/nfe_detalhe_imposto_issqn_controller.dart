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

class NfeDetalheImpostoIssqnController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoIssqnGridColumns();
	
	var nfeDetalheImpostoIssqnModelList = <NfeDetalheImpostoIssqnModel>[];

	final _nfeDetalheImpostoIssqnModel = NfeDetalheImpostoIssqnModel().obs;
	NfeDetalheImpostoIssqnModel get nfeDetalheImpostoIssqnModel => _nfeDetalheImpostoIssqnModel.value;
	set nfeDetalheImpostoIssqnModel(value) => _nfeDetalheImpostoIssqnModel.value = value ?? NfeDetalheImpostoIssqnModel();
	
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
		for (var nfeDetalheImpostoIssqnModel in nfeDetalheImpostoIssqnModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoIssqnModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoIssqnModel nfeDetalheImpostoIssqnModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoIssqnModel: nfeDetalheImpostoIssqnModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoIssqnModel? nfeDetalheImpostoIssqnModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoIssqnModel?.id ?? 0),
			"baseCalculoIssqn": PlutoCell(value: nfeDetalheImpostoIssqnModel?.baseCalculoIssqn ?? 0),
			"aliquotaIssqn": PlutoCell(value: nfeDetalheImpostoIssqnModel?.aliquotaIssqn ?? 0),
			"valorIssqn": PlutoCell(value: nfeDetalheImpostoIssqnModel?.valorIssqn ?? 0),
			"municipioIssqn": PlutoCell(value: nfeDetalheImpostoIssqnModel?.municipioIssqn ?? 0),
			"itemListaServicos": PlutoCell(value: nfeDetalheImpostoIssqnModel?.itemListaServicos ?? 0),
			"valorDeducao": PlutoCell(value: nfeDetalheImpostoIssqnModel?.valorDeducao ?? 0),
			"valorOutrasRetencoes": PlutoCell(value: nfeDetalheImpostoIssqnModel?.valorOutrasRetencoes ?? 0),
			"valorDescontoIncondicionado": PlutoCell(value: nfeDetalheImpostoIssqnModel?.valorDescontoIncondicionado ?? 0),
			"valorDescontoCondicionado": PlutoCell(value: nfeDetalheImpostoIssqnModel?.valorDescontoCondicionado ?? 0),
			"valorRetencaoIss": PlutoCell(value: nfeDetalheImpostoIssqnModel?.valorRetencaoIss ?? 0),
			"indicadorExigibilidadeIss": PlutoCell(value: nfeDetalheImpostoIssqnModel?.indicadorExigibilidadeIss ?? ''),
			"codigoServico": PlutoCell(value: nfeDetalheImpostoIssqnModel?.codigoServico ?? ''),
			"municipioIncidencia": PlutoCell(value: nfeDetalheImpostoIssqnModel?.municipioIncidencia ?? 0),
			"paisSevicoPrestado": PlutoCell(value: nfeDetalheImpostoIssqnModel?.paisSevicoPrestado ?? 0),
			"numeroProcesso": PlutoCell(value: nfeDetalheImpostoIssqnModel?.numeroProcesso ?? ''),
			"indicadorIncentivoFiscal": PlutoCell(value: nfeDetalheImpostoIssqnModel?.indicadorIncentivoFiscal ?? ''),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoIssqnModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoIssqnModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoIssqnModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			baseCalculoIssqnController.text = currentRow.cells['baseCalculoIssqn']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIssqnController.text = currentRow.cells['aliquotaIssqn']?.value?.toStringAsFixed(2) ?? '';
			valorIssqnController.text = currentRow.cells['valorIssqn']?.value?.toStringAsFixed(2) ?? '';
			municipioIssqnController.text = currentRow.cells['municipioIssqn']?.value?.toString() ?? '';
			itemListaServicosController.text = currentRow.cells['itemListaServicos']?.value?.toString() ?? '';
			valorDeducaoController.text = currentRow.cells['valorDeducao']?.value?.toStringAsFixed(2) ?? '';
			valorOutrasRetencoesController.text = currentRow.cells['valorOutrasRetencoes']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoIncondicionadoController.text = currentRow.cells['valorDescontoIncondicionado']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoCondicionadoController.text = currentRow.cells['valorDescontoCondicionado']?.value?.toStringAsFixed(2) ?? '';
			valorRetencaoIssController.text = currentRow.cells['valorRetencaoIss']?.value?.toStringAsFixed(2) ?? '';
			codigoServicoController.text = currentRow.cells['codigoServico']?.value ?? '';
			municipioIncidenciaController.text = currentRow.cells['municipioIncidencia']?.value?.toString() ?? '';
			paisSevicoPrestadoController.text = currentRow.cells['paisSevicoPrestado']?.value?.toString() ?? '';
			numeroProcessoController.text = currentRow.cells['numeroProcesso']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoIssqnEditPage());
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
	final baseCalculoIssqnController = MoneyMaskedTextController();
	final aliquotaIssqnController = MoneyMaskedTextController();
	final valorIssqnController = MoneyMaskedTextController();
	final municipioIssqnController = TextEditingController();
	final itemListaServicosController = TextEditingController();
	final valorDeducaoController = MoneyMaskedTextController();
	final valorOutrasRetencoesController = MoneyMaskedTextController();
	final valorDescontoIncondicionadoController = MoneyMaskedTextController();
	final valorDescontoCondicionadoController = MoneyMaskedTextController();
	final valorRetencaoIssController = MoneyMaskedTextController();
	final codigoServicoController = TextEditingController();
	final municipioIncidenciaController = TextEditingController();
	final paisSevicoPrestadoController = TextEditingController();
	final numeroProcessoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoIssqnModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoIssqnModel.idNfeDetalhe;
		plutoRow.cells['baseCalculoIssqn']?.value = nfeDetalheImpostoIssqnModel.baseCalculoIssqn;
		plutoRow.cells['aliquotaIssqn']?.value = nfeDetalheImpostoIssqnModel.aliquotaIssqn;
		plutoRow.cells['valorIssqn']?.value = nfeDetalheImpostoIssqnModel.valorIssqn;
		plutoRow.cells['municipioIssqn']?.value = nfeDetalheImpostoIssqnModel.municipioIssqn;
		plutoRow.cells['itemListaServicos']?.value = nfeDetalheImpostoIssqnModel.itemListaServicos;
		plutoRow.cells['valorDeducao']?.value = nfeDetalheImpostoIssqnModel.valorDeducao;
		plutoRow.cells['valorOutrasRetencoes']?.value = nfeDetalheImpostoIssqnModel.valorOutrasRetencoes;
		plutoRow.cells['valorDescontoIncondicionado']?.value = nfeDetalheImpostoIssqnModel.valorDescontoIncondicionado;
		plutoRow.cells['valorDescontoCondicionado']?.value = nfeDetalheImpostoIssqnModel.valorDescontoCondicionado;
		plutoRow.cells['valorRetencaoIss']?.value = nfeDetalheImpostoIssqnModel.valorRetencaoIss;
		plutoRow.cells['indicadorExigibilidadeIss']?.value = nfeDetalheImpostoIssqnModel.indicadorExigibilidadeIss;
		plutoRow.cells['codigoServico']?.value = nfeDetalheImpostoIssqnModel.codigoServico;
		plutoRow.cells['municipioIncidencia']?.value = nfeDetalheImpostoIssqnModel.municipioIncidencia;
		plutoRow.cells['paisSevicoPrestado']?.value = nfeDetalheImpostoIssqnModel.paisSevicoPrestado;
		plutoRow.cells['numeroProcesso']?.value = nfeDetalheImpostoIssqnModel.numeroProcesso;
		plutoRow.cells['indicadorIncentivoFiscal']?.value = nfeDetalheImpostoIssqnModel.indicadorIncentivoFiscal;
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
		nfeDetalheImpostoIssqnModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoIssqnModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoIssqnModelList.add(model);
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
		baseCalculoIssqnController.dispose();
		aliquotaIssqnController.dispose();
		valorIssqnController.dispose();
		municipioIssqnController.dispose();
		itemListaServicosController.dispose();
		valorDeducaoController.dispose();
		valorOutrasRetencoesController.dispose();
		valorDescontoIncondicionadoController.dispose();
		valorDescontoCondicionadoController.dispose();
		valorRetencaoIssController.dispose();
		codigoServicoController.dispose();
		municipioIncidenciaController.dispose();
		paisSevicoPrestadoController.dispose();
		numeroProcessoController.dispose();
		super.onClose();
	}
}