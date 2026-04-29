import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/controller/controller_imports.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:orcamentos/app/page/page_imports.dart';

import 'package:orcamentos/app/routes/app_routes.dart';
import 'package:orcamentos/app/data/repository/orcamento_fluxo_caixa_repository.dart';
import 'package:orcamentos/app/page/shared_page/shared_page_imports.dart';
import 'package:orcamentos/app/page/shared_widget/message_dialog.dart';
import 'package:orcamentos/app/mixin/controller_base_mixin.dart';

class OrcamentoFluxoCaixaController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final OrcamentoFluxoCaixaRepository orcamentoFluxoCaixaRepository;
	OrcamentoFluxoCaixaController({required this.orcamentoFluxoCaixaRepository});

	// general
	final _dbColumns = OrcamentoFluxoCaixaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = OrcamentoFluxoCaixaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = orcamentoFluxoCaixaGridColumns();
	
	var _orcamentoFluxoCaixaModelList = <OrcamentoFluxoCaixaModel>[];

	var _orcamentoFluxoCaixaModelOld = OrcamentoFluxoCaixaModel();

	final _orcamentoFluxoCaixaModel = OrcamentoFluxoCaixaModel().obs;
	OrcamentoFluxoCaixaModel get orcamentoFluxoCaixaModel => _orcamentoFluxoCaixaModel.value;
	set orcamentoFluxoCaixaModel(value) => _orcamentoFluxoCaixaModel.value = value ?? OrcamentoFluxoCaixaModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Orçamento - Fluxo de Caixa', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens', 
		),
	];

	List<Widget> tabPages() {
		return [
			OrcamentoFluxoCaixaEditPage(),
			const OrcamentoFluxoCaixaDetalheListPage(),
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
		for (var orcamentoFluxoCaixaModel in _orcamentoFluxoCaixaModelList) {
			plutoRowList.add(_getPlutoRow(orcamentoFluxoCaixaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(OrcamentoFluxoCaixaModel orcamentoFluxoCaixaModel) {
		return PlutoRow(
			cells: _getPlutoCells(orcamentoFluxoCaixaModel: orcamentoFluxoCaixaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ OrcamentoFluxoCaixaModel? orcamentoFluxoCaixaModel}) {
		return {
			"id": PlutoCell(value: orcamentoFluxoCaixaModel?.id ?? 0),
			"orcamentoFluxoCaixaPeriodo": PlutoCell(value: orcamentoFluxoCaixaModel?.orcamentoFluxoCaixaPeriodoModel?.nome ?? ''),
			"nome": PlutoCell(value: orcamentoFluxoCaixaModel?.nome ?? ''),
			"dataInicial": PlutoCell(value: orcamentoFluxoCaixaModel?.dataInicial ?? ''),
			"numeroPeriodos": PlutoCell(value: orcamentoFluxoCaixaModel?.numeroPeriodos ?? 0),
			"dataBase": PlutoCell(value: orcamentoFluxoCaixaModel?.dataBase ?? ''),
			"descricao": PlutoCell(value: orcamentoFluxoCaixaModel?.descricao ?? ''),
			"idOrcFluxoCaixaPeriodo": PlutoCell(value: orcamentoFluxoCaixaModel?.idOrcFluxoCaixaPeriodo ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _orcamentoFluxoCaixaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			orcamentoFluxoCaixaModel.plutoRowToObject(plutoRow);
		} else {
			orcamentoFluxoCaixaModel = modelFromRow[0];
			_orcamentoFluxoCaixaModelOld = orcamentoFluxoCaixaModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Orçamento - Fluxo de Caixa]';
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
		await Get.find<OrcamentoFluxoCaixaController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await orcamentoFluxoCaixaRepository.getList(filter: filter).then( (data){ _orcamentoFluxoCaixaModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Orçamento - Fluxo de Caixa',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			orcamentoFluxoCaixaPeriodoModelController.text = currentRow.cells['orcamentoFluxoCaixaPeriodo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			numeroPeriodosController.text = currentRow.cells['numeroPeriodos']?.value?.toString() ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens
			Get.put<OrcamentoFluxoCaixaDetalheController>(OrcamentoFluxoCaixaDetalheController()); 
			final orcamentoFluxoCaixaDetalheController = Get.find<OrcamentoFluxoCaixaDetalheController>(); 
			orcamentoFluxoCaixaDetalheController.orcamentoFluxoCaixaDetalheModelList = orcamentoFluxoCaixaModel.orcamentoFluxoCaixaDetalheModelList!; 
			orcamentoFluxoCaixaDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.orcamentoFluxoCaixaTabPage)!.then((value) {
				if (orcamentoFluxoCaixaModel.id == 0) {
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
		orcamentoFluxoCaixaModel = OrcamentoFluxoCaixaModel();
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
				if (await orcamentoFluxoCaixaRepository.delete(id: currentRow.cells['id']!.value)) {
					_orcamentoFluxoCaixaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final orcamentoFluxoCaixaPeriodoModelController = TextEditingController();
	final nomeController = TextEditingController();
	final numeroPeriodosController = TextEditingController();
	final descricaoController = TextEditingController();

	final orcamentoFluxoCaixaTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final orcamentoFluxoCaixaEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final orcamentoFluxoCaixaEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = orcamentoFluxoCaixaModel.id;
		plutoRow.cells['idOrcFluxoCaixaPeriodo']?.value = orcamentoFluxoCaixaModel.idOrcFluxoCaixaPeriodo;
		plutoRow.cells['orcamentoFluxoCaixaPeriodo']?.value = orcamentoFluxoCaixaModel.orcamentoFluxoCaixaPeriodoModel?.nome;
		plutoRow.cells['nome']?.value = orcamentoFluxoCaixaModel.nome;
		plutoRow.cells['dataInicial']?.value = Util.formatDate(orcamentoFluxoCaixaModel.dataInicial);
		plutoRow.cells['numeroPeriodos']?.value = orcamentoFluxoCaixaModel.numeroPeriodos;
		plutoRow.cells['dataBase']?.value = Util.formatDate(orcamentoFluxoCaixaModel.dataBase);
		plutoRow.cells['descricao']?.value = orcamentoFluxoCaixaModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await orcamentoFluxoCaixaRepository.save(orcamentoFluxoCaixaModel: orcamentoFluxoCaixaModel); 
				if (result != null) {
					orcamentoFluxoCaixaModel = result;
					if (_isInserting) {
						_orcamentoFluxoCaixaModelList.add(orcamentoFluxoCaixaModel);
						_isInserting = false;
					} else {
            _orcamentoFluxoCaixaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _orcamentoFluxoCaixaModelList.add(orcamentoFluxoCaixaModel);
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
		Get.find<OrcamentoFluxoCaixaDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_orcamentoFluxoCaixaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_orcamentoFluxoCaixaModelList.add(_orcamentoFluxoCaixaModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(orcamentoFluxoCaixaModel.orcamentoFluxoCaixaPeriodoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Periodo]'); 
			return false; 
		}
		return true;
	}

	Future callOrcamentoFluxoCaixaPeriodoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Periodo]'; 
		lookupController.route = '/orcamento-fluxo-caixa-periodo/'; 
		lookupController.gridColumns = orcamentoFluxoCaixaPeriodoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = OrcamentoFluxoCaixaPeriodoModel.aliasColumns; 
		lookupController.dbColumns = OrcamentoFluxoCaixaPeriodoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			orcamentoFluxoCaixaModel.idOrcFluxoCaixaPeriodo = plutoRowResult.cells['id']!.value; 
			orcamentoFluxoCaixaModel.orcamentoFluxoCaixaPeriodoModel!.plutoRowToObject(plutoRowResult); 
			orcamentoFluxoCaixaPeriodoModelController.text = orcamentoFluxoCaixaModel.orcamentoFluxoCaixaPeriodoModel?.nome ?? ''; 
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
		functionName = "orcamento_fluxo_caixa";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		orcamentoFluxoCaixaPeriodoModelController.dispose();
		nomeController.dispose();
		numeroPeriodosController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}