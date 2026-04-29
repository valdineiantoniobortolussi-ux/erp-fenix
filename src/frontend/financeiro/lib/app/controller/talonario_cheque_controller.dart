import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';
import 'package:financeiro/app/page/page_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/talonario_cheque_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class TalonarioChequeController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final TalonarioChequeRepository talonarioChequeRepository;
	TalonarioChequeController({required this.talonarioChequeRepository});

	// general
	final _dbColumns = TalonarioChequeModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = TalonarioChequeModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = talonarioChequeGridColumns();
	
	var _talonarioChequeModelList = <TalonarioChequeModel>[];

	var _talonarioChequeModelOld = TalonarioChequeModel();

	final _talonarioChequeModel = TalonarioChequeModel().obs;
	TalonarioChequeModel get talonarioChequeModel => _talonarioChequeModel.value;
	set talonarioChequeModel(value) => _talonarioChequeModel.value = value ?? TalonarioChequeModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Talonário Cheque', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Cheque', 
		),
	];

	List<Widget> tabPages() {
		return [
			TalonarioChequeEditPage(),
			const ChequeListPage(),
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
		for (var talonarioChequeModel in _talonarioChequeModelList) {
			plutoRowList.add(_getPlutoRow(talonarioChequeModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(TalonarioChequeModel talonarioChequeModel) {
		return PlutoRow(
			cells: _getPlutoCells(talonarioChequeModel: talonarioChequeModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ TalonarioChequeModel? talonarioChequeModel}) {
		return {
			"id": PlutoCell(value: talonarioChequeModel?.id ?? 0),
			"bancoContaCaixa": PlutoCell(value: talonarioChequeModel?.bancoContaCaixaModel?.nome ?? ''),
			"talao": PlutoCell(value: talonarioChequeModel?.talao ?? ''),
			"numero": PlutoCell(value: talonarioChequeModel?.numero ?? 0),
			"statusTalao": PlutoCell(value: talonarioChequeModel?.statusTalao ?? ''),
			"idBancoContaCaixa": PlutoCell(value: talonarioChequeModel?.idBancoContaCaixa ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _talonarioChequeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			talonarioChequeModel.plutoRowToObject(plutoRow);
		} else {
			talonarioChequeModel = modelFromRow[0];
			_talonarioChequeModelOld = talonarioChequeModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Talonário Cheque]';
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
		await Get.find<TalonarioChequeController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await talonarioChequeRepository.getList(filter: filter).then( (data){ _talonarioChequeModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Talonário Cheque',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			bancoContaCaixaModelController.text = currentRow.cells['bancoContaCaixa']?.value ?? '';
			talaoController.text = currentRow.cells['talao']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Cheque
			Get.put<ChequeController>(ChequeController()); 
			final chequeController = Get.find<ChequeController>(); 
			chequeController.chequeModelList = talonarioChequeModel.chequeModelList!; 
			chequeController.userMadeChanges = false; 


			Get.toNamed(Routes.talonarioChequeTabPage)!.then((value) {
				if (talonarioChequeModel.id == 0) {
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
		talonarioChequeModel = TalonarioChequeModel();
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
				if (await talonarioChequeRepository.delete(id: currentRow.cells['id']!.value)) {
					_talonarioChequeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final bancoContaCaixaModelController = TextEditingController();
	final talaoController = TextEditingController();
	final numeroController = TextEditingController();

	final talonarioChequeTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final talonarioChequeEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final talonarioChequeEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = talonarioChequeModel.id;
		plutoRow.cells['idBancoContaCaixa']?.value = talonarioChequeModel.idBancoContaCaixa;
		plutoRow.cells['bancoContaCaixa']?.value = talonarioChequeModel.bancoContaCaixaModel?.nome;
		plutoRow.cells['talao']?.value = talonarioChequeModel.talao;
		plutoRow.cells['numero']?.value = talonarioChequeModel.numero;
		plutoRow.cells['statusTalao']?.value = talonarioChequeModel.statusTalao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await talonarioChequeRepository.save(talonarioChequeModel: talonarioChequeModel); 
				if (result != null) {
					talonarioChequeModel = result;
					if (_isInserting) {
						_talonarioChequeModelList.add(talonarioChequeModel);
						_isInserting = false;
					} else {
            _talonarioChequeModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _talonarioChequeModelList.add(talonarioChequeModel);
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
		Get.find<ChequeController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_talonarioChequeModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_talonarioChequeModelList.add(_talonarioChequeModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(talonarioChequeModel.bancoContaCaixaModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Conta/Caixa]'); 
			return false; 
		}
		return true;
	}

	Future callBancoContaCaixaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Conta/Caixa]'; 
		lookupController.route = '/banco-conta-caixa/'; 
		lookupController.gridColumns = bancoContaCaixaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = BancoContaCaixaModel.aliasColumns; 
		lookupController.dbColumns = BancoContaCaixaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			talonarioChequeModel.idBancoContaCaixa = plutoRowResult.cells['id']!.value; 
			talonarioChequeModel.bancoContaCaixaModel!.plutoRowToObject(plutoRowResult); 
			bancoContaCaixaModelController.text = talonarioChequeModel.bancoContaCaixaModel?.nome ?? ''; 
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
		functionName = "talonario_cheque";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		bancoContaCaixaModelController.dispose();
		talaoController.dispose();
		numeroController.dispose();
		super.onClose();
	}
}