import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/controller/controller_imports.dart';
import 'package:nfse/app/data/model/model_imports.dart';
import 'package:nfse/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfse/app/page/page_imports.dart';

import 'package:nfse/app/routes/app_routes.dart';
import 'package:nfse/app/data/repository/nfse_cabecalho_repository.dart';
import 'package:nfse/app/page/shared_page/shared_page_imports.dart';
import 'package:nfse/app/page/shared_widget/message_dialog.dart';
import 'package:nfse/app/mixin/controller_base_mixin.dart';

class NfseCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final NfseCabecalhoRepository nfseCabecalhoRepository;
	NfseCabecalhoController({required this.nfseCabecalhoRepository});

	// general
	final _dbColumns = NfseCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = NfseCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = nfseCabecalhoGridColumns();
	
	var _nfseCabecalhoModelList = <NfseCabecalhoModel>[];

	var _nfseCabecalhoModelOld = NfseCabecalhoModel();

	final _nfseCabecalhoModel = NfseCabecalhoModel().obs;
	NfseCabecalhoModel get nfseCabecalhoModel => _nfseCabecalhoModel.value;
	set nfseCabecalhoModel(value) => _nfseCabecalhoModel.value = value ?? NfseCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'NFS-e', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens da NFS-e', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Intermediários', 
		),
	];

	List<Widget> tabPages() {
		return [
			NfseCabecalhoEditPage(),
			const NfseDetalheListPage(),
			const NfseIntermediarioListPage(),
		];
	}

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
		for (var nfseCabecalhoModel in _nfseCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(nfseCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfseCabecalhoModel nfseCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfseCabecalhoModel: nfseCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfseCabecalhoModel? nfseCabecalhoModel}) {
		return {
			"id": PlutoCell(value: nfseCabecalhoModel?.id ?? 0),
			"viewPessoaCliente": PlutoCell(value: nfseCabecalhoModel?.viewPessoaClienteModel?.nome ?? ''),
			"osAbertura": PlutoCell(value: nfseCabecalhoModel?.osAberturaModel?.numero ?? ''),
			"numero": PlutoCell(value: nfseCabecalhoModel?.numero ?? ''),
			"codigoVerificacao": PlutoCell(value: nfseCabecalhoModel?.codigoVerificacao ?? ''),
			"dataHoraEmissao": PlutoCell(value: nfseCabecalhoModel?.dataHoraEmissao ?? ''),
			"competencia": PlutoCell(value: nfseCabecalhoModel?.competencia ?? ''),
			"numeroSubstituida": PlutoCell(value: nfseCabecalhoModel?.numeroSubstituida ?? ''),
			"naturezaOperacao": PlutoCell(value: nfseCabecalhoModel?.naturezaOperacao ?? ''),
			"regimeEspecialTributacao": PlutoCell(value: nfseCabecalhoModel?.regimeEspecialTributacao ?? ''),
			"optanteSimplesNacional": PlutoCell(value: nfseCabecalhoModel?.optanteSimplesNacional ?? ''),
			"incentivadorCultural": PlutoCell(value: nfseCabecalhoModel?.incentivadorCultural ?? ''),
			"numeroRps": PlutoCell(value: nfseCabecalhoModel?.numeroRps ?? ''),
			"serieRps": PlutoCell(value: nfseCabecalhoModel?.serieRps ?? ''),
			"tipoRps": PlutoCell(value: nfseCabecalhoModel?.tipoRps ?? ''),
			"dataEmissaoRps": PlutoCell(value: nfseCabecalhoModel?.dataEmissaoRps ?? ''),
			"outrasInformacoes": PlutoCell(value: nfseCabecalhoModel?.outrasInformacoes ?? ''),
			"idCliente": PlutoCell(value: nfseCabecalhoModel?.idCliente ?? 0),
			"idOsAbertura": PlutoCell(value: nfseCabecalhoModel?.idOsAbertura ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _nfseCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			nfseCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			nfseCabecalhoModel = modelFromRow[0];
			_nfseCabecalhoModelOld = nfseCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [NFS-e]';
		filterController.standardFilter = true;
		filterController.aliasColumns = aliasColumns;
		filterController.dbColumns = dbColumns;
		filterController.filter.field = 'Id';

		filter = await Get.toNamed(Routes.filterPage);
		await loadData();
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		await Get.find<NfseCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await nfseCabecalhoRepository.getList(filter: filter).then( (data){ _nfseCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'NFS-e',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			osAberturaModelController.text = currentRow.cells['osAbertura']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			codigoVerificacaoController.text = currentRow.cells['codigoVerificacao']?.value ?? '';
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			numeroSubstituidaController.text = currentRow.cells['numeroSubstituida']?.value ?? '';
			numeroRpsController.text = currentRow.cells['numeroRps']?.value ?? '';
			serieRpsController.text = currentRow.cells['serieRps']?.value ?? '';
			outrasInformacoesController.text = currentRow.cells['outrasInformacoes']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens da NFS-e
			Get.put<NfseDetalheController>(NfseDetalheController()); 
			final nfseDetalheController = Get.find<NfseDetalheController>(); 
			nfseDetalheController.nfseDetalheModelList = nfseCabecalhoModel.nfseDetalheModelList!; 
			nfseDetalheController.userMadeChanges = false; 

			//Intermediários
			Get.put<NfseIntermediarioController>(NfseIntermediarioController()); 
			final nfseIntermediarioController = Get.find<NfseIntermediarioController>(); 
			nfseIntermediarioController.nfseIntermediarioModelList = nfseCabecalhoModel.nfseIntermediarioModelList!; 
			nfseIntermediarioController.userMadeChanges = false; 


			Get.toNamed(Routes.nfseCabecalhoTabPage)!.then((value) {
				if (nfseCabecalhoModel.id == 0) {
					_plutoGridStateManager.removeCurrentRow();
				}
			});
		} else {
			showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
		}
	}

	void callEditPageToInsert() {
		_plutoGridStateManager.prependNewRows(); 
		final cell = _plutoGridStateManager.rows.first.cells.entries.elementAt(0).value;
		_plutoGridStateManager.setCurrentCell(cell, 0); 
		_isInserting = true;
		nfseCabecalhoModel = NfseCabecalhoModel();
		callEditPage();	 
	}

  void handleKeyboard(PlutoKeyManagerEvent event) {
    if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
      if (canUpdate) {
        callEditPage();
      } else {
        noPrivilegeMessage();
      }
    }
  }  

	Future delete() async {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			showDeleteDialog(() async {
				if (await nfseCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_nfseCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
					_plutoGridStateManager.removeCurrentRow();
				} else {
					showErrorSnackBar(message: 'message_error_delete'.tr);
				}
			});
		} else {
			showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
		}
	}


	// edit page
	String? mandatoryMessage;
	
	final scrollController = ScrollController();
	final viewPessoaClienteModelController = TextEditingController();
	final osAberturaModelController = TextEditingController();
	final numeroController = TextEditingController();
	final codigoVerificacaoController = TextEditingController();
	final competenciaController = MaskedTextController(mask: '00/0000',);
	final numeroSubstituidaController = TextEditingController();
	final numeroRpsController = TextEditingController();
	final serieRpsController = TextEditingController();
	final outrasInformacoesController = TextEditingController();

	final nfseCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final nfseCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final nfseCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfseCabecalhoModel.id;
		plutoRow.cells['idCliente']?.value = nfseCabecalhoModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = nfseCabecalhoModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['idOsAbertura']?.value = nfseCabecalhoModel.idOsAbertura;
		plutoRow.cells['osAbertura']?.value = nfseCabecalhoModel.osAberturaModel?.numero;
		plutoRow.cells['numero']?.value = nfseCabecalhoModel.numero;
		plutoRow.cells['codigoVerificacao']?.value = nfseCabecalhoModel.codigoVerificacao;
		plutoRow.cells['dataHoraEmissao']?.value = Util.formatDate(nfseCabecalhoModel.dataHoraEmissao);
		plutoRow.cells['competencia']?.value = nfseCabecalhoModel.competencia;
		plutoRow.cells['numeroSubstituida']?.value = nfseCabecalhoModel.numeroSubstituida;
		plutoRow.cells['naturezaOperacao']?.value = nfseCabecalhoModel.naturezaOperacao;
		plutoRow.cells['regimeEspecialTributacao']?.value = nfseCabecalhoModel.regimeEspecialTributacao;
		plutoRow.cells['optanteSimplesNacional']?.value = nfseCabecalhoModel.optanteSimplesNacional;
		plutoRow.cells['incentivadorCultural']?.value = nfseCabecalhoModel.incentivadorCultural;
		plutoRow.cells['numeroRps']?.value = nfseCabecalhoModel.numeroRps;
		plutoRow.cells['serieRps']?.value = nfseCabecalhoModel.serieRps;
		plutoRow.cells['tipoRps']?.value = nfseCabecalhoModel.tipoRps;
		plutoRow.cells['dataEmissaoRps']?.value = Util.formatDate(nfseCabecalhoModel.dataEmissaoRps);
		plutoRow.cells['outrasInformacoes']?.value = nfseCabecalhoModel.outrasInformacoes;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await nfseCabecalhoRepository.save(nfseCabecalhoModel: nfseCabecalhoModel); 
				if (result != null) {
					nfseCabecalhoModel = result;
					if (_isInserting) {
						_nfseCabecalhoModelList.add(nfseCabecalhoModel);
						_isInserting = false;
					} else {
            _nfseCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _nfseCabecalhoModelList.add(nfseCabecalhoModel);
          }
					objectToPlutoRow();
					Get.back();
				}
			} else {
				Get.back();
			}
		} 
	}

	void preventDataLoss() {
		if (userMadeChanges()) {
			showQuestionDialog('message_data_loss'.tr, () { 
				clearUserChanges();
				Get.back(); 
			});
		} else {
			clearUserChanges();
			Get.back();
		}
	}	

	bool userMadeChanges() {
		return
		formWasChanged 
		|| 
		Get.find<NfseDetalheController>().userMadeChanges
		|| 
		Get.find<NfseIntermediarioController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_nfseCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_nfseCabecalhoModelList.add(_nfseCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(nfseCabecalhoModel.viewPessoaClienteModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Cliente]'); 
			return false; 
		}
		return true;
	}

	Future callViewPessoaClienteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Cliente]'; 
		lookupController.route = '/view-pessoa-cliente/'; 
		lookupController.gridColumns = viewPessoaClienteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaClienteModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaClienteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfseCabecalhoModel.idCliente = plutoRowResult.cells['id']!.value; 
			nfseCabecalhoModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = nfseCabecalhoModel.viewPessoaClienteModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callOsAberturaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Número OS]'; 
		lookupController.route = '/os-abertura/'; 
		lookupController.gridColumns = osAberturaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = OsAberturaModel.aliasColumns; 
		lookupController.dbColumns = OsAberturaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfseCabecalhoModel.idOsAbertura = plutoRowResult.cells['id']!.value; 
			nfseCabecalhoModel.osAberturaModel!.plutoRowToObject(plutoRowResult); 
			osAberturaModelController.text = nfseCabecalhoModel.osAberturaModel?.numero ?? ''; 
			formWasChanged = true; 
		}
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
		functionName = "nfse_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaClienteModelController.dispose();
		osAberturaModelController.dispose();
		numeroController.dispose();
		codigoVerificacaoController.dispose();
		competenciaController.dispose();
		numeroSubstituidaController.dispose();
		numeroRpsController.dispose();
		serieRpsController.dispose();
		outrasInformacoesController.dispose();
		super.onClose();
	}
}