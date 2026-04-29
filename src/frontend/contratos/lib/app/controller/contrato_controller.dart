import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/controller/controller_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:contratos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contratos/app/page/page_imports.dart';

import 'package:contratos/app/routes/app_routes.dart';
import 'package:contratos/app/data/repository/contrato_repository.dart';
import 'package:contratos/app/page/shared_page/shared_page_imports.dart';
import 'package:contratos/app/page/shared_widget/message_dialog.dart';
import 'package:contratos/app/mixin/controller_base_mixin.dart';

class ContratoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ContratoRepository contratoRepository;
	ContratoController({required this.contratoRepository});

	// general
	final _dbColumns = ContratoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ContratoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = contratoGridColumns();
	
	var _contratoModelList = <ContratoModel>[];

	var _contratoModelOld = ContratoModel();

	final _contratoModel = ContratoModel().obs;
	ContratoModel get contratoModel => _contratoModel.value;
	set contratoModel(value) => _contratoModel.value = value ?? ContratoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Contrato', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Histórico de Reajustes', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Previsão de Faturamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Histórico de Faturamento', 
		),
	];

	List<Widget> tabPages() {
		return [
			ContratoEditPage(),
			const ContratoHistoricoReajusteListPage(),
			const ContratoPrevFaturamentoListPage(),
			const ContratoHistFaturamentoListPage(),
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
		for (var contratoModel in _contratoModelList) {
			plutoRowList.add(_getPlutoRow(contratoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContratoModel contratoModel) {
		return PlutoRow(
			cells: _getPlutoCells(contratoModel: contratoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContratoModel? contratoModel}) {
		return {
			"id": PlutoCell(value: contratoModel?.id ?? 0),
			"contratoSolicitacaoServico": PlutoCell(value: contratoModel?.contratoSolicitacaoServicoModel?.descricao ?? ''),
			"tipoContrato": PlutoCell(value: contratoModel?.tipoContratoModel?.nome ?? ''),
			"numero": PlutoCell(value: contratoModel?.numero ?? ''),
			"nome": PlutoCell(value: contratoModel?.nome ?? ''),
			"descricao": PlutoCell(value: contratoModel?.descricao ?? ''),
			"dataCadastro": PlutoCell(value: contratoModel?.dataCadastro ?? ''),
			"dataInicioVigencia": PlutoCell(value: contratoModel?.dataInicioVigencia ?? ''),
			"dataFimVigencia": PlutoCell(value: contratoModel?.dataFimVigencia ?? ''),
			"diaFaturamento": PlutoCell(value: contratoModel?.diaFaturamento ?? ''),
			"valor": PlutoCell(value: contratoModel?.valor ?? 0),
			"quantidadeParcelas": PlutoCell(value: contratoModel?.quantidadeParcelas ?? 0),
			"intervaloEntreParcelas": PlutoCell(value: contratoModel?.intervaloEntreParcelas ?? 0),
			"classificacaoContabilConta": PlutoCell(value: contratoModel?.classificacaoContabilConta ?? ''),
			"observacao": PlutoCell(value: contratoModel?.observacao ?? ''),
			"idSolicitacaoServico": PlutoCell(value: contratoModel?.idSolicitacaoServico ?? 0),
			"idTipoContrato": PlutoCell(value: contratoModel?.idTipoContrato ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _contratoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			contratoModel.plutoRowToObject(plutoRow);
		} else {
			contratoModel = modelFromRow[0];
			_contratoModelOld = contratoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Contrato]';
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
		await Get.find<ContratoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await contratoRepository.getList(filter: filter).then( (data){ _contratoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Contrato',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			contratoSolicitacaoServicoModelController.text = currentRow.cells['contratoSolicitacaoServico']?.value ?? '';
			tipoContratoModelController.text = currentRow.cells['tipoContrato']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			diaFaturamentoController.text = currentRow.cells['diaFaturamento']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			quantidadeParcelasController.text = currentRow.cells['quantidadeParcelas']?.value?.toString() ?? '';
			intervaloEntreParcelasController.text = currentRow.cells['intervaloEntreParcelas']?.value?.toString() ?? '';
			classificacaoContabilContaController.text = currentRow.cells['classificacaoContabilConta']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Histórico de Reajustes
			Get.put<ContratoHistoricoReajusteController>(ContratoHistoricoReajusteController()); 
			final contratoHistoricoReajusteController = Get.find<ContratoHistoricoReajusteController>(); 
			contratoHistoricoReajusteController.contratoHistoricoReajusteModelList = contratoModel.contratoHistoricoReajusteModelList!; 
			contratoHistoricoReajusteController.userMadeChanges = false; 

			//Previsão de Faturamento
			Get.put<ContratoPrevFaturamentoController>(ContratoPrevFaturamentoController()); 
			final contratoPrevFaturamentoController = Get.find<ContratoPrevFaturamentoController>(); 
			contratoPrevFaturamentoController.contratoPrevFaturamentoModelList = contratoModel.contratoPrevFaturamentoModelList!; 
			contratoPrevFaturamentoController.userMadeChanges = false; 

			//Histórico de Faturamento
			Get.put<ContratoHistFaturamentoController>(ContratoHistFaturamentoController()); 
			final contratoHistFaturamentoController = Get.find<ContratoHistFaturamentoController>(); 
			contratoHistFaturamentoController.contratoHistFaturamentoModelList = contratoModel.contratoHistFaturamentoModelList!; 
			contratoHistFaturamentoController.userMadeChanges = false; 


			Get.toNamed(Routes.contratoTabPage)!.then((value) {
				if (contratoModel.id == 0) {
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
		contratoModel = ContratoModel();
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
				if (await contratoRepository.delete(id: currentRow.cells['id']!.value)) {
					_contratoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final contratoSolicitacaoServicoModelController = TextEditingController();
	final tipoContratoModelController = TextEditingController();
	final numeroController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final diaFaturamentoController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final quantidadeParcelasController = TextEditingController();
	final intervaloEntreParcelasController = TextEditingController();
	final classificacaoContabilContaController = TextEditingController();
	final observacaoController = TextEditingController();

	final contratoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final contratoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final contratoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contratoModel.id;
		plutoRow.cells['idSolicitacaoServico']?.value = contratoModel.idSolicitacaoServico;
		plutoRow.cells['contratoSolicitacaoServico']?.value = contratoModel.contratoSolicitacaoServicoModel?.descricao;
		plutoRow.cells['idTipoContrato']?.value = contratoModel.idTipoContrato;
		plutoRow.cells['tipoContrato']?.value = contratoModel.tipoContratoModel?.nome;
		plutoRow.cells['numero']?.value = contratoModel.numero;
		plutoRow.cells['nome']?.value = contratoModel.nome;
		plutoRow.cells['descricao']?.value = contratoModel.descricao;
		plutoRow.cells['dataCadastro']?.value = Util.formatDate(contratoModel.dataCadastro);
		plutoRow.cells['dataInicioVigencia']?.value = Util.formatDate(contratoModel.dataInicioVigencia);
		plutoRow.cells['dataFimVigencia']?.value = Util.formatDate(contratoModel.dataFimVigencia);
		plutoRow.cells['diaFaturamento']?.value = contratoModel.diaFaturamento;
		plutoRow.cells['valor']?.value = contratoModel.valor;
		plutoRow.cells['quantidadeParcelas']?.value = contratoModel.quantidadeParcelas;
		plutoRow.cells['intervaloEntreParcelas']?.value = contratoModel.intervaloEntreParcelas;
		plutoRow.cells['classificacaoContabilConta']?.value = contratoModel.classificacaoContabilConta;
		plutoRow.cells['observacao']?.value = contratoModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await contratoRepository.save(contratoModel: contratoModel); 
				if (result != null) {
					contratoModel = result;
					if (_isInserting) {
						_contratoModelList.add(contratoModel);
						_isInserting = false;
					} else {
            _contratoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _contratoModelList.add(contratoModel);
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
		Get.find<ContratoHistoricoReajusteController>().userMadeChanges
		|| 
		Get.find<ContratoPrevFaturamentoController>().userMadeChanges
		|| 
		Get.find<ContratoHistFaturamentoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_contratoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_contratoModelList.add(_contratoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(contratoModel.contratoSolicitacaoServicoModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Solicitacao Servico]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(contratoModel.tipoContratoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Tipo Contrato]'); 
			return false; 
		}
		return true;
	}

	Future callContratoSolicitacaoServicoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Solicitacao Servico]'; 
		lookupController.route = '/contrato-solicitacao-servico/'; 
		lookupController.gridColumns = contratoSolicitacaoServicoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContratoSolicitacaoServicoModel.aliasColumns; 
		lookupController.dbColumns = ContratoSolicitacaoServicoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contratoModel.idSolicitacaoServico = plutoRowResult.cells['id']!.value; 
			contratoModel.contratoSolicitacaoServicoModel!.plutoRowToObject(plutoRowResult); 
			contratoSolicitacaoServicoModelController.text = contratoModel.contratoSolicitacaoServicoModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callTipoContratoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Contrato]'; 
		lookupController.route = '/tipo-contrato/'; 
		lookupController.gridColumns = tipoContratoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TipoContratoModel.aliasColumns; 
		lookupController.dbColumns = TipoContratoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contratoModel.idTipoContrato = plutoRowResult.cells['id']!.value; 
			contratoModel.tipoContratoModel!.plutoRowToObject(plutoRowResult); 
			tipoContratoModelController.text = contratoModel.tipoContratoModel?.nome ?? ''; 
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
		functionName = "contrato";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		contratoSolicitacaoServicoModelController.dispose();
		tipoContratoModelController.dispose();
		numeroController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		diaFaturamentoController.dispose();
		valorController.dispose();
		quantidadeParcelasController.dispose();
		intervaloEntreParcelasController.dispose();
		classificacaoContabilContaController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}