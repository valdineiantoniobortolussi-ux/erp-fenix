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
import 'package:orcamentos/app/data/repository/orcamento_empresarial_repository.dart';
import 'package:orcamentos/app/page/shared_page/shared_page_imports.dart';
import 'package:orcamentos/app/page/shared_widget/message_dialog.dart';
import 'package:orcamentos/app/mixin/controller_base_mixin.dart';

class OrcamentoEmpresarialController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final OrcamentoEmpresarialRepository orcamentoEmpresarialRepository;
	OrcamentoEmpresarialController({required this.orcamentoEmpresarialRepository});

	// general
	final _dbColumns = OrcamentoEmpresarialModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = OrcamentoEmpresarialModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = orcamentoEmpresarialGridColumns();
	
	var _orcamentoEmpresarialModelList = <OrcamentoEmpresarialModel>[];

	var _orcamentoEmpresarialModelOld = OrcamentoEmpresarialModel();

	final _orcamentoEmpresarialModel = OrcamentoEmpresarialModel().obs;
	OrcamentoEmpresarialModel get orcamentoEmpresarialModel => _orcamentoEmpresarialModel.value;
	set orcamentoEmpresarialModel(value) => _orcamentoEmpresarialModel.value = value ?? OrcamentoEmpresarialModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Orçamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens', 
		),
	];

	List<Widget> tabPages() {
		return [
			OrcamentoEmpresarialEditPage(),
			const OrcamentoDetalheListPage(),
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
		for (var orcamentoEmpresarialModel in _orcamentoEmpresarialModelList) {
			plutoRowList.add(_getPlutoRow(orcamentoEmpresarialModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(OrcamentoEmpresarialModel orcamentoEmpresarialModel) {
		return PlutoRow(
			cells: _getPlutoCells(orcamentoEmpresarialModel: orcamentoEmpresarialModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ OrcamentoEmpresarialModel? orcamentoEmpresarialModel}) {
		return {
			"id": PlutoCell(value: orcamentoEmpresarialModel?.id ?? 0),
			"orcamentoPeriodo": PlutoCell(value: orcamentoEmpresarialModel?.orcamentoPeriodoModel?.nome ?? ''),
			"nome": PlutoCell(value: orcamentoEmpresarialModel?.nome ?? ''),
			"dataInicial": PlutoCell(value: orcamentoEmpresarialModel?.dataInicial ?? ''),
			"numeroPeriodos": PlutoCell(value: orcamentoEmpresarialModel?.numeroPeriodos ?? 0),
			"dataBase": PlutoCell(value: orcamentoEmpresarialModel?.dataBase ?? ''),
			"descricao": PlutoCell(value: orcamentoEmpresarialModel?.descricao ?? ''),
			"idOrcamentoPeriodo": PlutoCell(value: orcamentoEmpresarialModel?.idOrcamentoPeriodo ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _orcamentoEmpresarialModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			orcamentoEmpresarialModel.plutoRowToObject(plutoRow);
		} else {
			orcamentoEmpresarialModel = modelFromRow[0];
			_orcamentoEmpresarialModelOld = orcamentoEmpresarialModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Orçamento]';
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
		await Get.find<OrcamentoEmpresarialController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await orcamentoEmpresarialRepository.getList(filter: filter).then( (data){ _orcamentoEmpresarialModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Orçamento',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			orcamentoPeriodoModelController.text = currentRow.cells['orcamentoPeriodo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			numeroPeriodosController.text = currentRow.cells['numeroPeriodos']?.value?.toString() ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens
			Get.put<OrcamentoDetalheController>(OrcamentoDetalheController()); 
			final orcamentoDetalheController = Get.find<OrcamentoDetalheController>(); 
			orcamentoDetalheController.orcamentoDetalheModelList = orcamentoEmpresarialModel.orcamentoDetalheModelList!; 
			orcamentoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.orcamentoEmpresarialTabPage)!.then((value) {
				if (orcamentoEmpresarialModel.id == 0) {
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
		orcamentoEmpresarialModel = OrcamentoEmpresarialModel();
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
				if (await orcamentoEmpresarialRepository.delete(id: currentRow.cells['id']!.value)) {
					_orcamentoEmpresarialModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final orcamentoPeriodoModelController = TextEditingController();
	final nomeController = TextEditingController();
	final numeroPeriodosController = TextEditingController();
	final descricaoController = TextEditingController();

	final orcamentoEmpresarialTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final orcamentoEmpresarialEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final orcamentoEmpresarialEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = orcamentoEmpresarialModel.id;
		plutoRow.cells['idOrcamentoPeriodo']?.value = orcamentoEmpresarialModel.idOrcamentoPeriodo;
		plutoRow.cells['orcamentoPeriodo']?.value = orcamentoEmpresarialModel.orcamentoPeriodoModel?.nome;
		plutoRow.cells['nome']?.value = orcamentoEmpresarialModel.nome;
		plutoRow.cells['dataInicial']?.value = Util.formatDate(orcamentoEmpresarialModel.dataInicial);
		plutoRow.cells['numeroPeriodos']?.value = orcamentoEmpresarialModel.numeroPeriodos;
		plutoRow.cells['dataBase']?.value = Util.formatDate(orcamentoEmpresarialModel.dataBase);
		plutoRow.cells['descricao']?.value = orcamentoEmpresarialModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await orcamentoEmpresarialRepository.save(orcamentoEmpresarialModel: orcamentoEmpresarialModel); 
				if (result != null) {
					orcamentoEmpresarialModel = result;
					if (_isInserting) {
						_orcamentoEmpresarialModelList.add(orcamentoEmpresarialModel);
						_isInserting = false;
					} else {
            _orcamentoEmpresarialModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _orcamentoEmpresarialModelList.add(orcamentoEmpresarialModel);
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
		Get.find<OrcamentoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_orcamentoEmpresarialModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_orcamentoEmpresarialModelList.add(_orcamentoEmpresarialModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(orcamentoEmpresarialModel.orcamentoPeriodoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Periodo]'); 
			return false; 
		}
		return true;
	}

	Future callOrcamentoPeriodoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Periodo]'; 
		lookupController.route = '/orcamento-periodo/'; 
		lookupController.gridColumns = orcamentoPeriodoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = OrcamentoPeriodoModel.aliasColumns; 
		lookupController.dbColumns = OrcamentoPeriodoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			orcamentoEmpresarialModel.idOrcamentoPeriodo = plutoRowResult.cells['id']!.value; 
			orcamentoEmpresarialModel.orcamentoPeriodoModel!.plutoRowToObject(plutoRowResult); 
			orcamentoPeriodoModelController.text = orcamentoEmpresarialModel.orcamentoPeriodoModel?.nome ?? ''; 
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
		functionName = "orcamento_empresarial";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		orcamentoPeriodoModelController.dispose();
		nomeController.dispose();
		numeroPeriodosController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}