import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/controller/controller_imports.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:inventario/app/page/grid_columns/grid_columns_imports.dart';
import 'package:inventario/app/page/page_imports.dart';

import 'package:inventario/app/routes/app_routes.dart';
import 'package:inventario/app/data/repository/inventario_contagem_cab_repository.dart';
import 'package:inventario/app/page/shared_page/shared_page_imports.dart';
import 'package:inventario/app/page/shared_widget/message_dialog.dart';
import 'package:inventario/app/mixin/controller_base_mixin.dart';

class InventarioContagemCabController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final InventarioContagemCabRepository inventarioContagemCabRepository;
	InventarioContagemCabController({required this.inventarioContagemCabRepository});

	// general
	final _dbColumns = InventarioContagemCabModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = InventarioContagemCabModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = inventarioContagemCabGridColumns();
	
	var _inventarioContagemCabModelList = <InventarioContagemCabModel>[];

	var _inventarioContagemCabModelOld = InventarioContagemCabModel();

	final _inventarioContagemCabModel = InventarioContagemCabModel().obs;
	InventarioContagemCabModel get inventarioContagemCabModel => _inventarioContagemCabModel.value;
	set inventarioContagemCabModel(value) => _inventarioContagemCabModel.value = value ?? InventarioContagemCabModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Contagem de Produtos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Produtos', 
		),
	];

	List<Widget> tabPages() {
		return [
			InventarioContagemCabEditPage(),
			const InventarioContagemDetListPage(),
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
		for (var inventarioContagemCabModel in _inventarioContagemCabModelList) {
			plutoRowList.add(_getPlutoRow(inventarioContagemCabModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(InventarioContagemCabModel inventarioContagemCabModel) {
		return PlutoRow(
			cells: _getPlutoCells(inventarioContagemCabModel: inventarioContagemCabModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ InventarioContagemCabModel? inventarioContagemCabModel}) {
		return {
			"id": PlutoCell(value: inventarioContagemCabModel?.id ?? 0),
			"dataContagem": PlutoCell(value: inventarioContagemCabModel?.dataContagem ?? ''),
			"estoqueAtualizado": PlutoCell(value: inventarioContagemCabModel?.estoqueAtualizado ?? ''),
			"tipo": PlutoCell(value: inventarioContagemCabModel?.tipo ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _inventarioContagemCabModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			inventarioContagemCabModel.plutoRowToObject(plutoRow);
		} else {
			inventarioContagemCabModel = modelFromRow[0];
			_inventarioContagemCabModelOld = inventarioContagemCabModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Contagem de Produtos]';
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
		await Get.find<InventarioContagemCabController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await inventarioContagemCabRepository.getList(filter: filter).then( (data){ _inventarioContagemCabModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Contagem de Produtos',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Produtos
			Get.put<InventarioContagemDetController>(InventarioContagemDetController()); 
			final inventarioContagemDetController = Get.find<InventarioContagemDetController>(); 
			inventarioContagemDetController.inventarioContagemDetModelList = inventarioContagemCabModel.inventarioContagemDetModelList!; 
			inventarioContagemDetController.userMadeChanges = false; 


			Get.toNamed(Routes.inventarioContagemCabTabPage)!.then((value) {
				if (inventarioContagemCabModel.id == 0) {
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
		inventarioContagemCabModel = InventarioContagemCabModel();
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
				if (await inventarioContagemCabRepository.delete(id: currentRow.cells['id']!.value)) {
					_inventarioContagemCabModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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

	final inventarioContagemCabTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final inventarioContagemCabEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final inventarioContagemCabEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = inventarioContagemCabModel.id;
		plutoRow.cells['dataContagem']?.value = Util.formatDate(inventarioContagemCabModel.dataContagem);
		plutoRow.cells['estoqueAtualizado']?.value = inventarioContagemCabModel.estoqueAtualizado;
		plutoRow.cells['tipo']?.value = inventarioContagemCabModel.tipo;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await inventarioContagemCabRepository.save(inventarioContagemCabModel: inventarioContagemCabModel); 
				if (result != null) {
					inventarioContagemCabModel = result;
					if (_isInserting) {
						_inventarioContagemCabModelList.add(inventarioContagemCabModel);
						_isInserting = false;
					} else {
            _inventarioContagemCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _inventarioContagemCabModelList.add(inventarioContagemCabModel);
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
		Get.find<InventarioContagemDetController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_inventarioContagemCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_inventarioContagemCabModelList.add(_inventarioContagemCabModelOld);
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
		functionName = "inventario_contagem_cab";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		super.onClose();
	}
}