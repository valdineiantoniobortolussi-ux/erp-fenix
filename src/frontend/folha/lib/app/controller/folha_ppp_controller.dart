import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';
import 'package:folha/app/page/page_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_ppp_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaPppController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FolhaPppRepository folhaPppRepository;
	FolhaPppController({required this.folhaPppRepository});

	// general
	final _dbColumns = FolhaPppModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FolhaPppModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = folhaPppGridColumns();
	
	var _folhaPppModelList = <FolhaPppModel>[];

	var _folhaPppModelOld = FolhaPppModel();

	final _folhaPppModel = FolhaPppModel().obs;
	FolhaPppModel get folhaPppModel => _folhaPppModel.value;
	set folhaPppModel(value) => _folhaPppModel.value = value ?? FolhaPppModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'PPP', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'CAT', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Atividade', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Fator de Risco', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Exame Médico', 
		),
	];

	List<Widget> tabPages() {
		return [
			FolhaPppEditPage(),
			const FolhaPppCatListPage(),
			const FolhaPppAtividadeListPage(),
			const FolhaPppFatorRiscoListPage(),
			const FolhaPppExameMedicoListPage(),
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
		for (var folhaPppModel in _folhaPppModelList) {
			plutoRowList.add(_getPlutoRow(folhaPppModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaPppModel folhaPppModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaPppModel: folhaPppModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaPppModel? folhaPppModel}) {
		return {
			"id": PlutoCell(value: folhaPppModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: folhaPppModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"observacao": PlutoCell(value: folhaPppModel?.observacao ?? ''),
			"idColaborador": PlutoCell(value: folhaPppModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _folhaPppModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			folhaPppModel.plutoRowToObject(plutoRow);
		} else {
			folhaPppModel = modelFromRow[0];
			_folhaPppModelOld = folhaPppModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [PPP]';
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
		await Get.find<FolhaPppController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await folhaPppRepository.getList(filter: filter).then( (data){ _folhaPppModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'PPP',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//CAT
			Get.put<FolhaPppCatController>(FolhaPppCatController()); 
			final folhaPppCatController = Get.find<FolhaPppCatController>(); 
			folhaPppCatController.folhaPppCatModelList = folhaPppModel.folhaPppCatModelList!; 
			folhaPppCatController.userMadeChanges = false; 

			//Atividade
			Get.put<FolhaPppAtividadeController>(FolhaPppAtividadeController()); 
			final folhaPppAtividadeController = Get.find<FolhaPppAtividadeController>(); 
			folhaPppAtividadeController.folhaPppAtividadeModelList = folhaPppModel.folhaPppAtividadeModelList!; 
			folhaPppAtividadeController.userMadeChanges = false; 

			//Fator de Risco
			Get.put<FolhaPppFatorRiscoController>(FolhaPppFatorRiscoController()); 
			final folhaPppFatorRiscoController = Get.find<FolhaPppFatorRiscoController>(); 
			folhaPppFatorRiscoController.folhaPppFatorRiscoModelList = folhaPppModel.folhaPppFatorRiscoModelList!; 
			folhaPppFatorRiscoController.userMadeChanges = false; 

			//Exame Médico
			Get.put<FolhaPppExameMedicoController>(FolhaPppExameMedicoController()); 
			final folhaPppExameMedicoController = Get.find<FolhaPppExameMedicoController>(); 
			folhaPppExameMedicoController.folhaPppExameMedicoModelList = folhaPppModel.folhaPppExameMedicoModelList!; 
			folhaPppExameMedicoController.userMadeChanges = false; 


			Get.toNamed(Routes.folhaPppTabPage)!.then((value) {
				if (folhaPppModel.id == 0) {
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
		folhaPppModel = FolhaPppModel();
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
				if (await folhaPppRepository.delete(id: currentRow.cells['id']!.value)) {
					_folhaPppModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaColaboradorModelController = TextEditingController();
	final observacaoController = TextEditingController();

	final folhaPppTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final folhaPppEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final folhaPppEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaPppModel.id;
		plutoRow.cells['idColaborador']?.value = folhaPppModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaPppModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['observacao']?.value = folhaPppModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await folhaPppRepository.save(folhaPppModel: folhaPppModel); 
				if (result != null) {
					folhaPppModel = result;
					if (_isInserting) {
						_folhaPppModelList.add(folhaPppModel);
						_isInserting = false;
					} else {
            _folhaPppModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _folhaPppModelList.add(folhaPppModel);
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
		Get.find<FolhaPppCatController>().userMadeChanges
		|| 
		Get.find<FolhaPppAtividadeController>().userMadeChanges
		|| 
		Get.find<FolhaPppFatorRiscoController>().userMadeChanges
		|| 
		Get.find<FolhaPppExameMedicoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_folhaPppModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_folhaPppModelList.add(_folhaPppModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(folhaPppModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
		return true;
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
			folhaPppModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaPppModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaPppModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "folha_ppp";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaColaboradorModelController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}