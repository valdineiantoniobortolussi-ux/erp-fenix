import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/controller/controller_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';
import 'package:fiscal/app/page/page_imports.dart';

import 'package:fiscal/app/routes/app_routes.dart';
import 'package:fiscal/app/data/repository/fiscal_parametro_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalParametroController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FiscalParametroRepository fiscalParametroRepository;
	FiscalParametroController({required this.fiscalParametroRepository});

	// general
	final _dbColumns = FiscalParametroModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FiscalParametroModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = fiscalParametroGridColumns();
	
	var _fiscalParametroModelList = <FiscalParametroModel>[];

	var _fiscalParametroModelOld = FiscalParametroModel();

	final _fiscalParametroModel = FiscalParametroModel().obs;
	FiscalParametroModel get fiscalParametroModel => _fiscalParametroModel.value;
	set fiscalParametroModel(value) => _fiscalParametroModel.value = value ?? FiscalParametroModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Parâmetros', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Inscrições Substitutas', 
		),
	];

	List<Widget> tabPages() {
		return [
			FiscalParametroEditPage(),
			const FiscalInscricoesSubstitutasListPage(),
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
		for (var fiscalParametroModel in _fiscalParametroModelList) {
			plutoRowList.add(_getPlutoRow(fiscalParametroModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FiscalParametroModel fiscalParametroModel) {
		return PlutoRow(
			cells: _getPlutoCells(fiscalParametroModel: fiscalParametroModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FiscalParametroModel? fiscalParametroModel}) {
		return {
			"id": PlutoCell(value: fiscalParametroModel?.id ?? 0),
			"fiscalEstadualPorte": PlutoCell(value: fiscalParametroModel?.fiscalEstadualPorteModel?.nome ?? ''),
			"fiscalEstadualRegime": PlutoCell(value: fiscalParametroModel?.fiscalEstadualRegimeModel?.nome ?? ''),
			"fiscalMunicipalRegime": PlutoCell(value: fiscalParametroModel?.fiscalMunicipalRegimeModel?.nome ?? ''),
			"vigencia": PlutoCell(value: fiscalParametroModel?.vigencia ?? ''),
			"descricaoVigencia": PlutoCell(value: fiscalParametroModel?.descricaoVigencia ?? ''),
			"criterioLancamento": PlutoCell(value: fiscalParametroModel?.criterioLancamento ?? ''),
			"apuracao": PlutoCell(value: fiscalParametroModel?.apuracao ?? ''),
			"microempreeIndividual": PlutoCell(value: fiscalParametroModel?.microempreeIndividual ?? ''),
			"calcPisCofinsEfd": PlutoCell(value: fiscalParametroModel?.calcPisCofinsEfd ?? ''),
			"simplesCodigoAcesso": PlutoCell(value: fiscalParametroModel?.simplesCodigoAcesso ?? ''),
			"simplesTabela": PlutoCell(value: fiscalParametroModel?.simplesTabela ?? ''),
			"simplesAtividade": PlutoCell(value: fiscalParametroModel?.simplesAtividade ?? ''),
			"perfilSped": PlutoCell(value: fiscalParametroModel?.perfilSped ?? ''),
			"apuracaoConsolidada": PlutoCell(value: fiscalParametroModel?.apuracaoConsolidada ?? ''),
			"substituicaoTributaria": PlutoCell(value: fiscalParametroModel?.substituicaoTributaria ?? ''),
			"formaCalculoIss": PlutoCell(value: fiscalParametroModel?.formaCalculoIss ?? ''),
			"idFiscalEstadualPorte": PlutoCell(value: fiscalParametroModel?.idFiscalEstadualPorte ?? 0),
			"idFiscalEstadualRegime": PlutoCell(value: fiscalParametroModel?.idFiscalEstadualRegime ?? 0),
			"idFiscalMunicipalRegime": PlutoCell(value: fiscalParametroModel?.idFiscalMunicipalRegime ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _fiscalParametroModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			fiscalParametroModel.plutoRowToObject(plutoRow);
		} else {
			fiscalParametroModel = modelFromRow[0];
			_fiscalParametroModelOld = fiscalParametroModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Parâmetros]';
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
		await Get.find<FiscalParametroController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await fiscalParametroRepository.getList(filter: filter).then( (data){ _fiscalParametroModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Parâmetros',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			fiscalEstadualPorteModelController.text = currentRow.cells['fiscalEstadualPorte']?.value ?? '';
			fiscalEstadualRegimeModelController.text = currentRow.cells['fiscalEstadualRegime']?.value ?? '';
			fiscalMunicipalRegimeModelController.text = currentRow.cells['fiscalMunicipalRegime']?.value ?? '';
			vigenciaController.text = currentRow.cells['vigencia']?.value ?? '';
			descricaoVigenciaController.text = currentRow.cells['descricaoVigencia']?.value ?? '';
			simplesCodigoAcessoController.text = currentRow.cells['simplesCodigoAcesso']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Inscrições Substitutas
			Get.put<FiscalInscricoesSubstitutasController>(FiscalInscricoesSubstitutasController()); 
			final fiscalInscricoesSubstitutasController = Get.find<FiscalInscricoesSubstitutasController>(); 
			fiscalInscricoesSubstitutasController.fiscalInscricoesSubstitutasModelList = fiscalParametroModel.fiscalInscricoesSubstitutasModelList!; 
			fiscalInscricoesSubstitutasController.userMadeChanges = false; 


			Get.toNamed(Routes.fiscalParametroTabPage)!.then((value) {
				if (fiscalParametroModel.id == 0) {
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
		fiscalParametroModel = FiscalParametroModel();
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
				if (await fiscalParametroRepository.delete(id: currentRow.cells['id']!.value)) {
					_fiscalParametroModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final fiscalEstadualPorteModelController = TextEditingController();
	final fiscalEstadualRegimeModelController = TextEditingController();
	final fiscalMunicipalRegimeModelController = TextEditingController();
	final vigenciaController = MaskedTextController(mask: '00/0000',);
	final descricaoVigenciaController = TextEditingController();
	final simplesCodigoAcessoController = TextEditingController();

	final fiscalParametroTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final fiscalParametroEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final fiscalParametroEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalParametroModel.id;
		plutoRow.cells['idFiscalEstadualPorte']?.value = fiscalParametroModel.idFiscalEstadualPorte;
		plutoRow.cells['fiscalEstadualPorte']?.value = fiscalParametroModel.fiscalEstadualPorteModel?.nome;
		plutoRow.cells['idFiscalEstadualRegime']?.value = fiscalParametroModel.idFiscalEstadualRegime;
		plutoRow.cells['fiscalEstadualRegime']?.value = fiscalParametroModel.fiscalEstadualRegimeModel?.nome;
		plutoRow.cells['idFiscalMunicipalRegime']?.value = fiscalParametroModel.idFiscalMunicipalRegime;
		plutoRow.cells['fiscalMunicipalRegime']?.value = fiscalParametroModel.fiscalMunicipalRegimeModel?.nome;
		plutoRow.cells['vigencia']?.value = fiscalParametroModel.vigencia;
		plutoRow.cells['descricaoVigencia']?.value = fiscalParametroModel.descricaoVigencia;
		plutoRow.cells['criterioLancamento']?.value = fiscalParametroModel.criterioLancamento;
		plutoRow.cells['apuracao']?.value = fiscalParametroModel.apuracao;
		plutoRow.cells['microempreeIndividual']?.value = fiscalParametroModel.microempreeIndividual;
		plutoRow.cells['calcPisCofinsEfd']?.value = fiscalParametroModel.calcPisCofinsEfd;
		plutoRow.cells['simplesCodigoAcesso']?.value = fiscalParametroModel.simplesCodigoAcesso;
		plutoRow.cells['simplesTabela']?.value = fiscalParametroModel.simplesTabela;
		plutoRow.cells['simplesAtividade']?.value = fiscalParametroModel.simplesAtividade;
		plutoRow.cells['perfilSped']?.value = fiscalParametroModel.perfilSped;
		plutoRow.cells['apuracaoConsolidada']?.value = fiscalParametroModel.apuracaoConsolidada;
		plutoRow.cells['substituicaoTributaria']?.value = fiscalParametroModel.substituicaoTributaria;
		plutoRow.cells['formaCalculoIss']?.value = fiscalParametroModel.formaCalculoIss;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await fiscalParametroRepository.save(fiscalParametroModel: fiscalParametroModel); 
				if (result != null) {
					fiscalParametroModel = result;
					if (_isInserting) {
						_fiscalParametroModelList.add(fiscalParametroModel);
						_isInserting = false;
					} else {
            _fiscalParametroModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _fiscalParametroModelList.add(fiscalParametroModel);
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
		Get.find<FiscalInscricoesSubstitutasController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_fiscalParametroModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_fiscalParametroModelList.add(_fiscalParametroModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
		return true;
	}

	Future callFiscalEstadualPorteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Porte Estadual]'; 
		lookupController.route = '/fiscal-estadual-porte/'; 
		lookupController.gridColumns = fiscalEstadualPorteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FiscalEstadualPorteModel.aliasColumns; 
		lookupController.dbColumns = FiscalEstadualPorteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			fiscalParametroModel.idFiscalEstadualPorte = plutoRowResult.cells['id']!.value; 
			fiscalParametroModel.fiscalEstadualPorteModel!.plutoRowToObject(plutoRowResult); 
			fiscalEstadualPorteModelController.text = fiscalParametroModel.fiscalEstadualPorteModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFiscalEstadualRegimeLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Regime Estadual]'; 
		lookupController.route = '/fiscal-estadual-regime/'; 
		lookupController.gridColumns = fiscalEstadualRegimeGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FiscalEstadualRegimeModel.aliasColumns; 
		lookupController.dbColumns = FiscalEstadualRegimeModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			fiscalParametroModel.idFiscalEstadualRegime = plutoRowResult.cells['id']!.value; 
			fiscalParametroModel.fiscalEstadualRegimeModel!.plutoRowToObject(plutoRowResult); 
			fiscalEstadualRegimeModelController.text = fiscalParametroModel.fiscalEstadualRegimeModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFiscalMunicipalRegimeLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Regime Municipal]'; 
		lookupController.route = '/fiscal-municipal-regime/'; 
		lookupController.gridColumns = fiscalMunicipalRegimeGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FiscalMunicipalRegimeModel.aliasColumns; 
		lookupController.dbColumns = FiscalMunicipalRegimeModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			fiscalParametroModel.idFiscalMunicipalRegime = plutoRowResult.cells['id']!.value; 
			fiscalParametroModel.fiscalMunicipalRegimeModel!.plutoRowToObject(plutoRowResult); 
			fiscalMunicipalRegimeModelController.text = fiscalParametroModel.fiscalMunicipalRegimeModel?.nome ?? ''; 
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
		functionName = "fiscal_parametro";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		fiscalEstadualPorteModelController.dispose();
		fiscalEstadualRegimeModelController.dispose();
		fiscalMunicipalRegimeModelController.dispose();
		vigenciaController.dispose();
		descricaoVigenciaController.dispose();
		simplesCodigoAcessoController.dispose();
		super.onClose();
	}
}