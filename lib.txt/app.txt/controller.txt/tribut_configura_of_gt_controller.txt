import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/controller/controller_imports.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/page/grid_columns/grid_columns_imports.dart';
import 'package:tributacao/app/page/page_imports.dart';
import 'package:tributacao/app/mixin/controller_base_mixin.dart';

import 'package:tributacao/app/routes/app_routes.dart';
import 'package:tributacao/app/data/repository/tribut_configura_of_gt_repository.dart';
import 'package:tributacao/app/page/shared_page/shared_page_imports.dart';
import 'package:tributacao/app/page/shared_widget/message_dialog.dart';

class TributConfiguraOfGtController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final TributConfiguraOfGtRepository tributConfiguraOfGtRepository;
	TributConfiguraOfGtController({required this.tributConfiguraOfGtRepository});

	// general
	final _dbColumns = TributConfiguraOfGtModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = TributConfiguraOfGtModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = tributConfiguraOfGtGridColumns();
	
	var _tributConfiguraOfGtModelList = <TributConfiguraOfGtModel>[];

	var _tributConfiguraOfGtModelOld = TributConfiguraOfGtModel();

	final _tributConfiguraOfGtModel = TributConfiguraOfGtModel().obs;
	TributConfiguraOfGtModel get tributConfiguraOfGtModel => _tributConfiguraOfGtModel.value;
	set tributConfiguraOfGtModel(value) => _tributConfiguraOfGtModel.value = value ?? TributConfiguraOfGtModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tribut Configura Of Gt', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tribut Ipi', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tribut Cofins', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tribut Pis', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tribut Icms Uf', 
		),
	];

	List<Widget> tabPages() {
		return [
			TributConfiguraOfGtEditPage(),
			TributIpiEditPage(),
			TributCofinsEditPage(),
			TributPisEditPage(),
			const TributIcmsUfListPage(),
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
		for (var tributConfiguraOfGtModel in _tributConfiguraOfGtModelList) {
			plutoRowList.add(_getPlutoRow(tributConfiguraOfGtModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(TributConfiguraOfGtModel tributConfiguraOfGtModel) {
		return PlutoRow(
			cells: _getPlutoCells(tributConfiguraOfGtModel: tributConfiguraOfGtModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ TributConfiguraOfGtModel? tributConfiguraOfGtModel}) {
		return {
			"id": PlutoCell(value: tributConfiguraOfGtModel?.id ?? 0),
			"tributGrupoTributario": PlutoCell(value: tributConfiguraOfGtModel?.tributGrupoTributarioModel?.descricao ?? ''),
			"tributOperacaoFiscal": PlutoCell(value: tributConfiguraOfGtModel?.tributOperacaoFiscalModel?.descricao ?? ''),
			"idTributGrupoTributario": PlutoCell(value: tributConfiguraOfGtModel?.idTributGrupoTributario ?? 0),
			"idTributOperacaoFiscal": PlutoCell(value: tributConfiguraOfGtModel?.idTributOperacaoFiscal ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _tributConfiguraOfGtModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			tributConfiguraOfGtModel.plutoRowToObject(plutoRow);
		} else {
			tributConfiguraOfGtModel = modelFromRow[0];
			_tributConfiguraOfGtModelOld = tributConfiguraOfGtModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Tribut Configura Of Gt]';
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
		await Get.find<TributConfiguraOfGtController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await tributConfiguraOfGtRepository.getList(filter: filter).then( (data){ _tributConfiguraOfGtModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Tribut Configura Of Gt',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			tributGrupoTributarioModelController.text = currentRow.cells['tributGrupoTributario']?.value ?? '';
			tributOperacaoFiscalModelController.text = currentRow.cells['tributOperacaoFiscal']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Tribut Ipi
			Get.put<TributIpiController>(TributIpiController()); 
			final tributIpiController = Get.find<TributIpiController>(); 
			tributIpiController.tributIpiModel = tributConfiguraOfGtModel.tributIpiModel; 
			tributIpiController.formWasChanged = false; 
			tributIpiController.callEditPage(); 

			//Tribut Cofins
			Get.put<TributCofinsController>(TributCofinsController()); 
			final tributCofinsController = Get.find<TributCofinsController>(); 
			tributCofinsController.tributCofinsModel = tributConfiguraOfGtModel.tributCofinsModel; 
			tributCofinsController.formWasChanged = false; 
			tributCofinsController.callEditPage(); 

			//Tribut Pis
			Get.put<TributPisController>(TributPisController()); 
			final tributPisController = Get.find<TributPisController>(); 
			tributPisController.tributPisModel = tributConfiguraOfGtModel.tributPisModel; 
			tributPisController.formWasChanged = false; 
			tributPisController.callEditPage(); 

			//Tribut Icms Uf
			Get.put<TributIcmsUfController>(TributIcmsUfController()); 
			final tributIcmsUfController = Get.find<TributIcmsUfController>(); 
			tributIcmsUfController.tributIcmsUfModelList = tributConfiguraOfGtModel.tributIcmsUfModelList!; 
			tributIcmsUfController.userMadeChanges = false; 


			Get.toNamed(Routes.tributConfiguraOfGtTabPage)!.then((value) {
				if (tributConfiguraOfGtModel.id == 0) {
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
		tributConfiguraOfGtModel = TributConfiguraOfGtModel();
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
				if (await tributConfiguraOfGtRepository.delete(id: currentRow.cells['id']!.value)) {
					_tributConfiguraOfGtModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final tributGrupoTributarioModelController = TextEditingController();
	final tributOperacaoFiscalModelController = TextEditingController();

	final tributConfiguraOfGtTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final tributConfiguraOfGtEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final tributConfiguraOfGtEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tributConfiguraOfGtModel.id;
		plutoRow.cells['idTributGrupoTributario']?.value = tributConfiguraOfGtModel.idTributGrupoTributario;
		plutoRow.cells['tributGrupoTributario']?.value = tributConfiguraOfGtModel.tributGrupoTributarioModel?.descricao;
		plutoRow.cells['idTributOperacaoFiscal']?.value = tributConfiguraOfGtModel.idTributOperacaoFiscal;
		plutoRow.cells['tributOperacaoFiscal']?.value = tributConfiguraOfGtModel.tributOperacaoFiscalModel?.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await tributConfiguraOfGtRepository.save(tributConfiguraOfGtModel: tributConfiguraOfGtModel); 
				if (result != null) {
					tributConfiguraOfGtModel = result;
					if (_isInserting) {
						_tributConfiguraOfGtModelList.add(tributConfiguraOfGtModel);
						_isInserting = false;
					} else {
            _tributConfiguraOfGtModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _tributConfiguraOfGtModelList.add(tributConfiguraOfGtModel);
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
		Get.find<TributIpiController>().formWasChanged
		|| 
		Get.find<TributCofinsController>().formWasChanged
		|| 
		Get.find<TributPisController>().formWasChanged
		|| 
		Get.find<TributIcmsUfController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_tributConfiguraOfGtModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_tributConfiguraOfGtModelList.add(_tributConfiguraOfGtModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(tributConfiguraOfGtModel.tributGrupoTributarioModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Grupo Tributário]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(tributConfiguraOfGtModel.tributOperacaoFiscalModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Operação Fiscal]'); 
			return false; 
		}
		final resultTributIpi = Get.find<TributIpiController>().validateForm(); 
		if (!resultTributIpi) { 
			return false; 
		}
		final resultTributCofins = Get.find<TributCofinsController>().validateForm(); 
		if (!resultTributCofins) { 
			return false; 
		}
		final resultTributPis = Get.find<TributPisController>().validateForm(); 
		if (!resultTributPis) { 
			return false; 
		}
		return true;
	}

	Future callTributGrupoTributarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tribut Grupo Tributario]'; 
		lookupController.route = '/tribut-grupo-tributario/'; 
		lookupController.gridColumns = tributGrupoTributarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TributGrupoTributarioModel.aliasColumns; 
		lookupController.dbColumns = TributGrupoTributarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			tributConfiguraOfGtModel.idTributGrupoTributario = plutoRowResult.cells['id']!.value; 
			tributConfiguraOfGtModel.tributGrupoTributarioModel!.plutoRowToObject(plutoRowResult); 
			tributGrupoTributarioModelController.text = tributConfiguraOfGtModel.tributGrupoTributarioModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callTributOperacaoFiscalLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tribut Operacao Fiscal]'; 
		lookupController.route = '/tribut-operacao-fiscal/'; 
		lookupController.gridColumns = tributOperacaoFiscalGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TributOperacaoFiscalModel.aliasColumns; 
		lookupController.dbColumns = TributOperacaoFiscalModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			tributConfiguraOfGtModel.idTributOperacaoFiscal = plutoRowResult.cells['id']!.value; 
			tributConfiguraOfGtModel.tributOperacaoFiscalModel!.plutoRowToObject(plutoRowResult); 
			tributOperacaoFiscalModelController.text = tributConfiguraOfGtModel.tributOperacaoFiscalModel?.descricao ?? ''; 
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
    functionName = "TRIBUT_CONFIGURA_OF_GT";
    setPrivilege();    
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		tributGrupoTributarioModelController.dispose();
		tributOperacaoFiscalModelController.dispose();
		super.onClose();
	}
}