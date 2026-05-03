import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';
import 'package:patrimonio/app/page/page_imports.dart';

import 'package:patrimonio/app/routes/app_routes.dart';
import 'package:patrimonio/app/data/repository/patrim_bem_repository.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';
import 'package:patrimonio/app/mixin/controller_base_mixin.dart';

class PatrimBemController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final PatrimBemRepository patrimBemRepository;
	PatrimBemController({required this.patrimBemRepository});

	// general
	final _dbColumns = PatrimBemModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PatrimBemModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = patrimBemGridColumns();
	
	var _patrimBemModelList = <PatrimBemModel>[];

	var _patrimBemModelOld = PatrimBemModel();

	final _patrimBemModel = PatrimBemModel().obs;
	PatrimBemModel get patrimBemModel => _patrimBemModel.value;
	set patrimBemModel(value) => _patrimBemModel.value = value ?? PatrimBemModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Bem', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Documentos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Depreciação', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Movimentação', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Apólices', 
		),
	];

	List<Widget> tabPages() {
		return [
			PatrimBemEditPage(),
			const PatrimDocumentoBemListPage(),
			const PatrimDepreciacaoBemListPage(),
			const PatrimMovimentacaoBemListPage(),
			const PatrimApoliceSeguroListPage(),
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
		for (var patrimBemModel in _patrimBemModelList) {
			plutoRowList.add(_getPlutoRow(patrimBemModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PatrimBemModel patrimBemModel) {
		return PlutoRow(
			cells: _getPlutoCells(patrimBemModel: patrimBemModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PatrimBemModel? patrimBemModel}) {
		return {
			"id": PlutoCell(value: patrimBemModel?.id ?? 0),
			"centroResultado": PlutoCell(value: patrimBemModel?.centroResultadoModel?.descricao ?? ''),
			"viewPessoaFornecedor": PlutoCell(value: patrimBemModel?.viewPessoaFornecedorModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: patrimBemModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"patrimTipoAquisicaoBem": PlutoCell(value: patrimBemModel?.patrimTipoAquisicaoBemModel?.nome ?? ''),
			"patrimEstadoConservacao": PlutoCell(value: patrimBemModel?.patrimEstadoConservacaoModel?.nome ?? ''),
			"patrimGrupoBem": PlutoCell(value: patrimBemModel?.patrimGrupoBemModel?.nome ?? ''),
			"setor": PlutoCell(value: patrimBemModel?.setorModel?.nome ?? ''),
			"numeroNb": PlutoCell(value: patrimBemModel?.numeroNb ?? ''),
			"nome": PlutoCell(value: patrimBemModel?.nome ?? ''),
			"descricao": PlutoCell(value: patrimBemModel?.descricao ?? ''),
			"dataAquisicao": PlutoCell(value: patrimBemModel?.dataAquisicao ?? ''),
			"dataAceite": PlutoCell(value: patrimBemModel?.dataAceite ?? ''),
			"dataCadastro": PlutoCell(value: patrimBemModel?.dataCadastro ?? ''),
			"dataContabilizado": PlutoCell(value: patrimBemModel?.dataContabilizado ?? ''),
			"dataVistoria": PlutoCell(value: patrimBemModel?.dataVistoria ?? ''),
			"dataMarcacao": PlutoCell(value: patrimBemModel?.dataMarcacao ?? ''),
			"dataBaixa": PlutoCell(value: patrimBemModel?.dataBaixa ?? ''),
			"vencimentoGarantia": PlutoCell(value: patrimBemModel?.vencimentoGarantia ?? ''),
			"numeroNotaFiscal": PlutoCell(value: patrimBemModel?.numeroNotaFiscal ?? ''),
			"numeroSerie": PlutoCell(value: patrimBemModel?.numeroSerie ?? ''),
			"chaveNfe": PlutoCell(value: patrimBemModel?.chaveNfe ?? ''),
			"valorOriginal": PlutoCell(value: patrimBemModel?.valorOriginal ?? 0),
			"valorCompra": PlutoCell(value: patrimBemModel?.valorCompra ?? 0),
			"valorAtualizado": PlutoCell(value: patrimBemModel?.valorAtualizado ?? 0),
			"valorBaixa": PlutoCell(value: patrimBemModel?.valorBaixa ?? 0),
			"deprecia": PlutoCell(value: patrimBemModel?.deprecia ?? ''),
			"metodoDepreciacao": PlutoCell(value: patrimBemModel?.metodoDepreciacao ?? ''),
			"inicioDepreciacao": PlutoCell(value: patrimBemModel?.inicioDepreciacao ?? ''),
			"ultimaDepreciacao": PlutoCell(value: patrimBemModel?.ultimaDepreciacao ?? ''),
			"tipoDepreciacao": PlutoCell(value: patrimBemModel?.tipoDepreciacao ?? ''),
			"taxaAnualDepreciacao": PlutoCell(value: patrimBemModel?.taxaAnualDepreciacao ?? 0),
			"taxaMensalDepreciacao": PlutoCell(value: patrimBemModel?.taxaMensalDepreciacao ?? 0),
			"taxaDepreciacaoAcelerada": PlutoCell(value: patrimBemModel?.taxaDepreciacaoAcelerada ?? 0),
			"taxaDepreciacaoIncentivada": PlutoCell(value: patrimBemModel?.taxaDepreciacaoIncentivada ?? 0),
			"funcao": PlutoCell(value: patrimBemModel?.funcao ?? ''),
			"idCentroResultado": PlutoCell(value: patrimBemModel?.idCentroResultado ?? 0),
			"idFornecedor": PlutoCell(value: patrimBemModel?.idFornecedor ?? 0),
			"idColaborador": PlutoCell(value: patrimBemModel?.idColaborador ?? 0),
			"idPatrimTipoAquisicaoBem": PlutoCell(value: patrimBemModel?.idPatrimTipoAquisicaoBem ?? 0),
			"idPatrimEstadoConservacao": PlutoCell(value: patrimBemModel?.idPatrimEstadoConservacao ?? 0),
			"idPatrimGrupoBem": PlutoCell(value: patrimBemModel?.idPatrimGrupoBem ?? 0),
			"idSetor": PlutoCell(value: patrimBemModel?.idSetor ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _patrimBemModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			patrimBemModel.plutoRowToObject(plutoRow);
		} else {
			patrimBemModel = modelFromRow[0];
			_patrimBemModelOld = patrimBemModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Bem]';
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
		await Get.find<PatrimBemController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await patrimBemRepository.getList(filter: filter).then( (data){ _patrimBemModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Bem',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			centroResultadoModelController.text = currentRow.cells['centroResultado']?.value ?? '';
			viewPessoaFornecedorModelController.text = currentRow.cells['viewPessoaFornecedor']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			patrimTipoAquisicaoBemModelController.text = currentRow.cells['patrimTipoAquisicaoBem']?.value ?? '';
			patrimEstadoConservacaoModelController.text = currentRow.cells['patrimEstadoConservacao']?.value ?? '';
			patrimGrupoBemModelController.text = currentRow.cells['patrimGrupoBem']?.value ?? '';
			setorModelController.text = currentRow.cells['setor']?.value ?? '';
			numeroNbController.text = currentRow.cells['numeroNb']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			numeroNotaFiscalController.text = currentRow.cells['numeroNotaFiscal']?.value ?? '';
			numeroSerieController.text = currentRow.cells['numeroSerie']?.value ?? '';
			chaveNfeController.text = currentRow.cells['chaveNfe']?.value ?? '';
			valorOriginalController.text = currentRow.cells['valorOriginal']?.value?.toStringAsFixed(2) ?? '';
			valorCompraController.text = currentRow.cells['valorCompra']?.value?.toStringAsFixed(2) ?? '';
			valorAtualizadoController.text = currentRow.cells['valorAtualizado']?.value?.toStringAsFixed(2) ?? '';
			valorBaixaController.text = currentRow.cells['valorBaixa']?.value?.toStringAsFixed(2) ?? '';
			taxaAnualDepreciacaoController.text = currentRow.cells['taxaAnualDepreciacao']?.value?.toStringAsFixed(2) ?? '';
			taxaMensalDepreciacaoController.text = currentRow.cells['taxaMensalDepreciacao']?.value?.toStringAsFixed(2) ?? '';
			taxaDepreciacaoAceleradaController.text = currentRow.cells['taxaDepreciacaoAcelerada']?.value?.toStringAsFixed(2) ?? '';
			taxaDepreciacaoIncentivadaController.text = currentRow.cells['taxaDepreciacaoIncentivada']?.value?.toStringAsFixed(2) ?? '';
			funcaoController.text = currentRow.cells['funcao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Documentos
			Get.put<PatrimDocumentoBemController>(PatrimDocumentoBemController()); 
			final patrimDocumentoBemController = Get.find<PatrimDocumentoBemController>(); 
			patrimDocumentoBemController.patrimDocumentoBemModelList = patrimBemModel.patrimDocumentoBemModelList!; 
			patrimDocumentoBemController.userMadeChanges = false; 

			//Depreciação
			Get.put<PatrimDepreciacaoBemController>(PatrimDepreciacaoBemController()); 
			final patrimDepreciacaoBemController = Get.find<PatrimDepreciacaoBemController>(); 
			patrimDepreciacaoBemController.patrimDepreciacaoBemModelList = patrimBemModel.patrimDepreciacaoBemModelList!; 
			patrimDepreciacaoBemController.userMadeChanges = false; 

			//Movimentação
			Get.put<PatrimMovimentacaoBemController>(PatrimMovimentacaoBemController()); 
			final patrimMovimentacaoBemController = Get.find<PatrimMovimentacaoBemController>(); 
			patrimMovimentacaoBemController.patrimMovimentacaoBemModelList = patrimBemModel.patrimMovimentacaoBemModelList!; 
			patrimMovimentacaoBemController.userMadeChanges = false; 

			//Apólices
			Get.put<PatrimApoliceSeguroController>(PatrimApoliceSeguroController()); 
			final patrimApoliceSeguroController = Get.find<PatrimApoliceSeguroController>(); 
			patrimApoliceSeguroController.patrimApoliceSeguroModelList = patrimBemModel.patrimApoliceSeguroModelList!; 
			patrimApoliceSeguroController.userMadeChanges = false; 


			Get.toNamed(Routes.patrimBemTabPage)!.then((value) {
				if (patrimBemModel.id == 0) {
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
		patrimBemModel = PatrimBemModel();
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
				if (await patrimBemRepository.delete(id: currentRow.cells['id']!.value)) {
					_patrimBemModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final centroResultadoModelController = TextEditingController();
	final viewPessoaFornecedorModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final patrimTipoAquisicaoBemModelController = TextEditingController();
	final patrimEstadoConservacaoModelController = TextEditingController();
	final patrimGrupoBemModelController = TextEditingController();
	final setorModelController = TextEditingController();
	final numeroNbController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final numeroNotaFiscalController = TextEditingController();
	final numeroSerieController = TextEditingController();
	final chaveNfeController = TextEditingController();
	final valorOriginalController = MoneyMaskedTextController();
	final valorCompraController = MoneyMaskedTextController();
	final valorAtualizadoController = MoneyMaskedTextController();
	final valorBaixaController = MoneyMaskedTextController();
	final taxaAnualDepreciacaoController = MoneyMaskedTextController();
	final taxaMensalDepreciacaoController = MoneyMaskedTextController();
	final taxaDepreciacaoAceleradaController = MoneyMaskedTextController();
	final taxaDepreciacaoIncentivadaController = MoneyMaskedTextController();
	final funcaoController = TextEditingController();

	final patrimBemTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final patrimBemEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final patrimBemEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimBemModel.id;
		plutoRow.cells['idCentroResultado']?.value = patrimBemModel.idCentroResultado;
		plutoRow.cells['centroResultado']?.value = patrimBemModel.centroResultadoModel?.descricao;
		plutoRow.cells['idFornecedor']?.value = patrimBemModel.idFornecedor;
		plutoRow.cells['viewPessoaFornecedor']?.value = patrimBemModel.viewPessoaFornecedorModel?.nome;
		plutoRow.cells['idColaborador']?.value = patrimBemModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = patrimBemModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['idPatrimTipoAquisicaoBem']?.value = patrimBemModel.idPatrimTipoAquisicaoBem;
		plutoRow.cells['patrimTipoAquisicaoBem']?.value = patrimBemModel.patrimTipoAquisicaoBemModel?.nome;
		plutoRow.cells['idPatrimEstadoConservacao']?.value = patrimBemModel.idPatrimEstadoConservacao;
		plutoRow.cells['patrimEstadoConservacao']?.value = patrimBemModel.patrimEstadoConservacaoModel?.nome;
		plutoRow.cells['idPatrimGrupoBem']?.value = patrimBemModel.idPatrimGrupoBem;
		plutoRow.cells['patrimGrupoBem']?.value = patrimBemModel.patrimGrupoBemModel?.nome;
		plutoRow.cells['idSetor']?.value = patrimBemModel.idSetor;
		plutoRow.cells['setor']?.value = patrimBemModel.setorModel?.nome;
		plutoRow.cells['numeroNb']?.value = patrimBemModel.numeroNb;
		plutoRow.cells['nome']?.value = patrimBemModel.nome;
		plutoRow.cells['descricao']?.value = patrimBemModel.descricao;
		plutoRow.cells['dataAquisicao']?.value = Util.formatDate(patrimBemModel.dataAquisicao);
		plutoRow.cells['dataAceite']?.value = Util.formatDate(patrimBemModel.dataAceite);
		plutoRow.cells['dataCadastro']?.value = Util.formatDate(patrimBemModel.dataCadastro);
		plutoRow.cells['dataContabilizado']?.value = Util.formatDate(patrimBemModel.dataContabilizado);
		plutoRow.cells['dataVistoria']?.value = Util.formatDate(patrimBemModel.dataVistoria);
		plutoRow.cells['dataMarcacao']?.value = Util.formatDate(patrimBemModel.dataMarcacao);
		plutoRow.cells['dataBaixa']?.value = Util.formatDate(patrimBemModel.dataBaixa);
		plutoRow.cells['vencimentoGarantia']?.value = Util.formatDate(patrimBemModel.vencimentoGarantia);
		plutoRow.cells['numeroNotaFiscal']?.value = patrimBemModel.numeroNotaFiscal;
		plutoRow.cells['numeroSerie']?.value = patrimBemModel.numeroSerie;
		plutoRow.cells['chaveNfe']?.value = patrimBemModel.chaveNfe;
		plutoRow.cells['valorOriginal']?.value = patrimBemModel.valorOriginal;
		plutoRow.cells['valorCompra']?.value = patrimBemModel.valorCompra;
		plutoRow.cells['valorAtualizado']?.value = patrimBemModel.valorAtualizado;
		plutoRow.cells['valorBaixa']?.value = patrimBemModel.valorBaixa;
		plutoRow.cells['deprecia']?.value = patrimBemModel.deprecia;
		plutoRow.cells['metodoDepreciacao']?.value = patrimBemModel.metodoDepreciacao;
		plutoRow.cells['inicioDepreciacao']?.value = Util.formatDate(patrimBemModel.inicioDepreciacao);
		plutoRow.cells['ultimaDepreciacao']?.value = Util.formatDate(patrimBemModel.ultimaDepreciacao);
		plutoRow.cells['tipoDepreciacao']?.value = patrimBemModel.tipoDepreciacao;
		plutoRow.cells['taxaAnualDepreciacao']?.value = patrimBemModel.taxaAnualDepreciacao;
		plutoRow.cells['taxaMensalDepreciacao']?.value = patrimBemModel.taxaMensalDepreciacao;
		plutoRow.cells['taxaDepreciacaoAcelerada']?.value = patrimBemModel.taxaDepreciacaoAcelerada;
		plutoRow.cells['taxaDepreciacaoIncentivada']?.value = patrimBemModel.taxaDepreciacaoIncentivada;
		plutoRow.cells['funcao']?.value = patrimBemModel.funcao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await patrimBemRepository.save(patrimBemModel: patrimBemModel); 
				if (result != null) {
					patrimBemModel = result;
					if (_isInserting) {
						_patrimBemModelList.add(patrimBemModel);
						_isInserting = false;
					} else {
            _patrimBemModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _patrimBemModelList.add(patrimBemModel);
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
		Get.find<PatrimDocumentoBemController>().userMadeChanges
		|| 
		Get.find<PatrimDepreciacaoBemController>().userMadeChanges
		|| 
		Get.find<PatrimMovimentacaoBemController>().userMadeChanges
		|| 
		Get.find<PatrimApoliceSeguroController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_patrimBemModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_patrimBemModelList.add(_patrimBemModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(patrimBemModel.centroResultadoModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Centro Resultado]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(patrimBemModel.viewPessoaFornecedorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Fornecedor]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(patrimBemModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(patrimBemModel.patrimTipoAquisicaoBemModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Tipo Aquisicao]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(patrimBemModel.patrimEstadoConservacaoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Estado Conservacao]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(patrimBemModel.patrimGrupoBemModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Grupo]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(patrimBemModel.setorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Setor]'); 
			return false; 
		}
		return true;
	}

	Future callCentroResultadoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Centro Resultado]'; 
		lookupController.route = '/centro-resultado/'; 
		lookupController.gridColumns = centroResultadoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CentroResultadoModel.aliasColumns; 
		lookupController.dbColumns = CentroResultadoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimBemModel.idCentroResultado = plutoRowResult.cells['id']!.value; 
			patrimBemModel.centroResultadoModel!.plutoRowToObject(plutoRowResult); 
			centroResultadoModelController.text = patrimBemModel.centroResultadoModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callViewPessoaFornecedorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Fornecedor]'; 
		lookupController.route = '/view-pessoa-fornecedor/'; 
		lookupController.gridColumns = viewPessoaFornecedorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaFornecedorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaFornecedorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimBemModel.idFornecedor = plutoRowResult.cells['id']!.value; 
			patrimBemModel.viewPessoaFornecedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaFornecedorModelController.text = patrimBemModel.viewPessoaFornecedorModel?.nome ?? ''; 
			formWasChanged = true; 
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
			patrimBemModel.idColaborador = plutoRowResult.cells['id']!.value; 
			patrimBemModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = patrimBemModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callPatrimTipoAquisicaoBemLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Aquisicao]'; 
		lookupController.route = '/patrim-tipo-aquisicao-bem/'; 
		lookupController.gridColumns = patrimTipoAquisicaoBemGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PatrimTipoAquisicaoBemModel.aliasColumns; 
		lookupController.dbColumns = PatrimTipoAquisicaoBemModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimBemModel.idPatrimTipoAquisicaoBem = plutoRowResult.cells['id']!.value; 
			patrimBemModel.patrimTipoAquisicaoBemModel!.plutoRowToObject(plutoRowResult); 
			patrimTipoAquisicaoBemModelController.text = patrimBemModel.patrimTipoAquisicaoBemModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callPatrimEstadoConservacaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Estado Conservacao]'; 
		lookupController.route = '/patrim-estado-conservacao/'; 
		lookupController.gridColumns = patrimEstadoConservacaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PatrimEstadoConservacaoModel.aliasColumns; 
		lookupController.dbColumns = PatrimEstadoConservacaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimBemModel.idPatrimEstadoConservacao = plutoRowResult.cells['id']!.value; 
			patrimBemModel.patrimEstadoConservacaoModel!.plutoRowToObject(plutoRowResult); 
			patrimEstadoConservacaoModelController.text = patrimBemModel.patrimEstadoConservacaoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callPatrimGrupoBemLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Grupo]'; 
		lookupController.route = '/patrim-grupo-bem/'; 
		lookupController.gridColumns = patrimGrupoBemGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PatrimGrupoBemModel.aliasColumns; 
		lookupController.dbColumns = PatrimGrupoBemModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimBemModel.idPatrimGrupoBem = plutoRowResult.cells['id']!.value; 
			patrimBemModel.patrimGrupoBemModel!.plutoRowToObject(plutoRowResult); 
			patrimGrupoBemModelController.text = patrimBemModel.patrimGrupoBemModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callSetorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Setor]'; 
		lookupController.route = '/setor/'; 
		lookupController.gridColumns = setorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = SetorModel.aliasColumns; 
		lookupController.dbColumns = SetorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimBemModel.idSetor = plutoRowResult.cells['id']!.value; 
			patrimBemModel.setorModel!.plutoRowToObject(plutoRowResult); 
			setorModelController.text = patrimBemModel.setorModel?.nome ?? ''; 
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
		functionName = "patrim_bem";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		centroResultadoModelController.dispose();
		viewPessoaFornecedorModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		patrimTipoAquisicaoBemModelController.dispose();
		patrimEstadoConservacaoModelController.dispose();
		patrimGrupoBemModelController.dispose();
		setorModelController.dispose();
		numeroNbController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		numeroNotaFiscalController.dispose();
		numeroSerieController.dispose();
		chaveNfeController.dispose();
		valorOriginalController.dispose();
		valorCompraController.dispose();
		valorAtualizadoController.dispose();
		valorBaixaController.dispose();
		taxaAnualDepreciacaoController.dispose();
		taxaMensalDepreciacaoController.dispose();
		taxaDepreciacaoAceleradaController.dispose();
		taxaDepreciacaoIncentivadaController.dispose();
		funcaoController.dispose();
		super.onClose();
	}
}