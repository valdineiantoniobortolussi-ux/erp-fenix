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
import 'package:tributacao/app/data/repository/tribut_icms_custom_cab_repository.dart';
import 'package:tributacao/app/page/shared_page/shared_page_imports.dart';
import 'package:tributacao/app/page/shared_widget/message_dialog.dart';

class TributIcmsCustomCabController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final TributIcmsCustomCabRepository tributIcmsCustomCabRepository;
	TributIcmsCustomCabController({required this.tributIcmsCustomCabRepository});

	// general
	final _dbColumns = TributIcmsCustomCabModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = TributIcmsCustomCabModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = tributIcmsCustomCabGridColumns();
	
	var _tributIcmsCustomCabModelList = <TributIcmsCustomCabModel>[];

	var _tributIcmsCustomCabModelOld = TributIcmsCustomCabModel();

	final _tributIcmsCustomCabModel = TributIcmsCustomCabModel().obs;
	TributIcmsCustomCabModel get tributIcmsCustomCabModel => _tributIcmsCustomCabModel.value;
	set tributIcmsCustomCabModel(value) => _tributIcmsCustomCabModel.value = value ?? TributIcmsCustomCabModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tribut Icms Custom Cab', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Tribut Icms Custom Det', 
		),
	];

	List<Widget> tabPages() {
		return [
			TributIcmsCustomCabEditPage(),
			const TributIcmsCustomDetListPage(),
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
		for (var tributIcmsCustomCabModel in _tributIcmsCustomCabModelList) {
			plutoRowList.add(_getPlutoRow(tributIcmsCustomCabModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(TributIcmsCustomCabModel tributIcmsCustomCabModel) {
		return PlutoRow(
			cells: _getPlutoCells(tributIcmsCustomCabModel: tributIcmsCustomCabModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ TributIcmsCustomCabModel? tributIcmsCustomCabModel}) {
		return {
			"id": PlutoCell(value: tributIcmsCustomCabModel?.id ?? 0),
			"descricao": PlutoCell(value: tributIcmsCustomCabModel?.descricao ?? ''),
			"origemMercadoria": PlutoCell(value: tributIcmsCustomCabModel?.origemMercadoria ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _tributIcmsCustomCabModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			tributIcmsCustomCabModel.plutoRowToObject(plutoRow);
		} else {
			tributIcmsCustomCabModel = modelFromRow[0];
			_tributIcmsCustomCabModelOld = tributIcmsCustomCabModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Tribut Icms Custom Cab]';
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
		await Get.find<TributIcmsCustomCabController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await tributIcmsCustomCabRepository.getList(filter: filter).then( (data){ _tributIcmsCustomCabModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Tribut Icms Custom Cab',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Tribut Icms Custom Det
			Get.put<TributIcmsCustomDetController>(TributIcmsCustomDetController()); 
			final tributIcmsCustomDetController = Get.find<TributIcmsCustomDetController>(); 
			tributIcmsCustomDetController.tributIcmsCustomDetModelList = tributIcmsCustomCabModel.tributIcmsCustomDetModelList!; 
			tributIcmsCustomDetController.userMadeChanges = false; 


			Get.toNamed(Routes.tributIcmsCustomCabTabPage)!.then((value) {
				if (tributIcmsCustomCabModel.id == 0) {
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
		tributIcmsCustomCabModel = TributIcmsCustomCabModel();
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
				if (await tributIcmsCustomCabRepository.delete(id: currentRow.cells['id']!.value)) {
					_tributIcmsCustomCabModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();

	final tributIcmsCustomCabTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final tributIcmsCustomCabEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final tributIcmsCustomCabEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tributIcmsCustomCabModel.id;
		plutoRow.cells['descricao']?.value = tributIcmsCustomCabModel.descricao;
		plutoRow.cells['origemMercadoria']?.value = tributIcmsCustomCabModel.origemMercadoria;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await tributIcmsCustomCabRepository.save(tributIcmsCustomCabModel: tributIcmsCustomCabModel); 
				if (result != null) {
					tributIcmsCustomCabModel = result;
					if (_isInserting) {
						_tributIcmsCustomCabModelList.add(tributIcmsCustomCabModel);
						_isInserting = false;
					} else {
            _tributIcmsCustomCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _tributIcmsCustomCabModelList.add(tributIcmsCustomCabModel);
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
		Get.find<TributIcmsCustomDetController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_tributIcmsCustomCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_tributIcmsCustomCabModelList.add(_tributIcmsCustomCabModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
		return true;
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
    functionName = "TRIBUT_ICMS_CUSTOM_CAB";
    setPrivilege();    
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}