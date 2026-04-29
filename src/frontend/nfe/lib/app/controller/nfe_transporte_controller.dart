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

class NfeTransporteController extends GetxController {

	// general
	final gridColumns = nfeTransporteGridColumns();
	
	var nfeTransporteModelList = <NfeTransporteModel>[];

	final _nfeTransporteModel = NfeTransporteModel().obs;
	NfeTransporteModel get nfeTransporteModel => _nfeTransporteModel.value;
	set nfeTransporteModel(value) => _nfeTransporteModel.value = value ?? NfeTransporteModel();
	
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
		for (var nfeTransporteModel in nfeTransporteModelList) {
			plutoRowList.add(_getPlutoRow(nfeTransporteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeTransporteModel nfeTransporteModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeTransporteModel: nfeTransporteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeTransporteModel? nfeTransporteModel}) {
		return {
			"id": PlutoCell(value: nfeTransporteModel?.id ?? 0),
			"idTransportadora": PlutoCell(value: nfeTransporteModel?.idTransportadora ?? 0),
			"modalidadeFrete": PlutoCell(value: nfeTransporteModel?.modalidadeFrete ?? ''),
			"cnpj": PlutoCell(value: nfeTransporteModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: nfeTransporteModel?.cpf ?? ''),
			"nome": PlutoCell(value: nfeTransporteModel?.nome ?? ''),
			"inscricaoEstadual": PlutoCell(value: nfeTransporteModel?.inscricaoEstadual ?? ''),
			"endereco": PlutoCell(value: nfeTransporteModel?.endereco ?? ''),
			"nomeMunicipio": PlutoCell(value: nfeTransporteModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: nfeTransporteModel?.uf ?? ''),
			"valorServico": PlutoCell(value: nfeTransporteModel?.valorServico ?? 0),
			"valorBcRetencaoIcms": PlutoCell(value: nfeTransporteModel?.valorBcRetencaoIcms ?? 0),
			"aliquotaRetencaoIcms": PlutoCell(value: nfeTransporteModel?.aliquotaRetencaoIcms ?? 0),
			"valorIcmsRetido": PlutoCell(value: nfeTransporteModel?.valorIcmsRetido ?? 0),
			"cfop": PlutoCell(value: nfeTransporteModel?.cfop ?? 0),
			"municipio": PlutoCell(value: nfeTransporteModel?.municipio ?? 0),
			"placaVeiculo": PlutoCell(value: nfeTransporteModel?.placaVeiculo ?? ''),
			"ufVeiculo": PlutoCell(value: nfeTransporteModel?.ufVeiculo ?? ''),
			"rntcVeiculo": PlutoCell(value: nfeTransporteModel?.rntcVeiculo ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeTransporteModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeTransporteModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeTransporteModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			idTransportadoraController.text = currentRow.cells['idTransportadora']?.value?.toString() ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			inscricaoEstadualController.text = currentRow.cells['inscricaoEstadual']?.value ?? '';
			enderecoController.text = currentRow.cells['endereco']?.value ?? '';
			nomeMunicipioController.text = currentRow.cells['nomeMunicipio']?.value ?? '';
			valorServicoController.text = currentRow.cells['valorServico']?.value?.toStringAsFixed(2) ?? '';
			valorBcRetencaoIcmsController.text = currentRow.cells['valorBcRetencaoIcms']?.value?.toStringAsFixed(2) ?? '';
			aliquotaRetencaoIcmsController.text = currentRow.cells['aliquotaRetencaoIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsRetidoController.text = currentRow.cells['valorIcmsRetido']?.value?.toStringAsFixed(2) ?? '';
			cfopController.text = currentRow.cells['cfop']?.value?.toString() ?? '';
			municipioController.text = currentRow.cells['municipio']?.value?.toString() ?? '';
			placaVeiculoController.text = currentRow.cells['placaVeiculo']?.value ?? '';
			rntcVeiculoController.text = currentRow.cells['rntcVeiculo']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeTransporteEditPage());
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
	final idTransportadoraController = TextEditingController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final nomeController = TextEditingController();
	final inscricaoEstadualController = TextEditingController();
	final enderecoController = TextEditingController();
	final nomeMunicipioController = TextEditingController();
	final valorServicoController = MoneyMaskedTextController();
	final valorBcRetencaoIcmsController = MoneyMaskedTextController();
	final aliquotaRetencaoIcmsController = MoneyMaskedTextController();
	final valorIcmsRetidoController = MoneyMaskedTextController();
	final cfopController = TextEditingController();
	final municipioController = TextEditingController();
	final placaVeiculoController = TextEditingController();
	final rntcVeiculoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeTransporteModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeTransporteModel.idNfeCabecalho;
		plutoRow.cells['idTransportadora']?.value = nfeTransporteModel.idTransportadora;
		plutoRow.cells['modalidadeFrete']?.value = nfeTransporteModel.modalidadeFrete;
		plutoRow.cells['cnpj']?.value = nfeTransporteModel.cnpj;
		plutoRow.cells['cpf']?.value = nfeTransporteModel.cpf;
		plutoRow.cells['nome']?.value = nfeTransporteModel.nome;
		plutoRow.cells['inscricaoEstadual']?.value = nfeTransporteModel.inscricaoEstadual;
		plutoRow.cells['endereco']?.value = nfeTransporteModel.endereco;
		plutoRow.cells['nomeMunicipio']?.value = nfeTransporteModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = nfeTransporteModel.uf;
		plutoRow.cells['valorServico']?.value = nfeTransporteModel.valorServico;
		plutoRow.cells['valorBcRetencaoIcms']?.value = nfeTransporteModel.valorBcRetencaoIcms;
		plutoRow.cells['aliquotaRetencaoIcms']?.value = nfeTransporteModel.aliquotaRetencaoIcms;
		plutoRow.cells['valorIcmsRetido']?.value = nfeTransporteModel.valorIcmsRetido;
		plutoRow.cells['cfop']?.value = nfeTransporteModel.cfop;
		plutoRow.cells['municipio']?.value = nfeTransporteModel.municipio;
		plutoRow.cells['placaVeiculo']?.value = nfeTransporteModel.placaVeiculo;
		plutoRow.cells['ufVeiculo']?.value = nfeTransporteModel.ufVeiculo;
		plutoRow.cells['rntcVeiculo']?.value = nfeTransporteModel.rntcVeiculo;
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
		nfeTransporteModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeTransporteModel();
			model.plutoRowToObject(plutoRow);
			nfeTransporteModelList.add(model);
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
		idTransportadoraController.dispose();
		cnpjController.dispose();
		cpfController.dispose();
		nomeController.dispose();
		inscricaoEstadualController.dispose();
		enderecoController.dispose();
		nomeMunicipioController.dispose();
		valorServicoController.dispose();
		valorBcRetencaoIcmsController.dispose();
		aliquotaRetencaoIcmsController.dispose();
		valorIcmsRetidoController.dispose();
		cfopController.dispose();
		municipioController.dispose();
		placaVeiculoController.dispose();
		rntcVeiculoController.dispose();
		super.onClose();
	}
}