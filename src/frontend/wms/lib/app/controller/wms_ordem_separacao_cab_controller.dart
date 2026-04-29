import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/controller/controller_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/page/grid_columns/grid_columns_imports.dart';
import 'package:wms/app/page/page_imports.dart';

import 'package:wms/app/routes/app_routes.dart';
import 'package:wms/app/data/repository/wms_ordem_separacao_cab_repository.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';
import 'package:wms/app/mixin/controller_base_mixin.dart';

class WmsOrdemSeparacaoCabController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final WmsOrdemSeparacaoCabRepository wmsOrdemSeparacaoCabRepository;
	WmsOrdemSeparacaoCabController({required this.wmsOrdemSeparacaoCabRepository});

	// general
	final _dbColumns = WmsOrdemSeparacaoCabModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = WmsOrdemSeparacaoCabModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = wmsOrdemSeparacaoCabGridColumns();
	
	var _wmsOrdemSeparacaoCabModelList = <WmsOrdemSeparacaoCabModel>[];

	var _wmsOrdemSeparacaoCabModelOld = WmsOrdemSeparacaoCabModel();

	final _wmsOrdemSeparacaoCabModel = WmsOrdemSeparacaoCabModel().obs;
	WmsOrdemSeparacaoCabModel get wmsOrdemSeparacaoCabModel => _wmsOrdemSeparacaoCabModel.value;
	set wmsOrdemSeparacaoCabModel(value) => _wmsOrdemSeparacaoCabModel.value = value ?? WmsOrdemSeparacaoCabModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Ordem Separação', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens', 
		),
	];

	List<Widget> tabPages() {
		return [
			WmsOrdemSeparacaoCabEditPage(),
			const WmsOrdemSeparacaoDetListPage(),
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
		for (var wmsOrdemSeparacaoCabModel in _wmsOrdemSeparacaoCabModelList) {
			plutoRowList.add(_getPlutoRow(wmsOrdemSeparacaoCabModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(WmsOrdemSeparacaoCabModel wmsOrdemSeparacaoCabModel) {
		return PlutoRow(
			cells: _getPlutoCells(wmsOrdemSeparacaoCabModel: wmsOrdemSeparacaoCabModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ WmsOrdemSeparacaoCabModel? wmsOrdemSeparacaoCabModel}) {
		return {
			"id": PlutoCell(value: wmsOrdemSeparacaoCabModel?.id ?? 0),
			"origem": PlutoCell(value: wmsOrdemSeparacaoCabModel?.origem ?? ''),
			"dataSolicitacao": PlutoCell(value: wmsOrdemSeparacaoCabModel?.dataSolicitacao ?? ''),
			"dataLimite": PlutoCell(value: wmsOrdemSeparacaoCabModel?.dataLimite ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _wmsOrdemSeparacaoCabModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			wmsOrdemSeparacaoCabModel.plutoRowToObject(plutoRow);
		} else {
			wmsOrdemSeparacaoCabModel = modelFromRow[0];
			_wmsOrdemSeparacaoCabModelOld = wmsOrdemSeparacaoCabModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Ordem Separação]';
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
		await Get.find<WmsOrdemSeparacaoCabController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await wmsOrdemSeparacaoCabRepository.getList(filter: filter).then( (data){ _wmsOrdemSeparacaoCabModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Ordem Separação',
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
			
			//Itens
			Get.put<WmsOrdemSeparacaoDetController>(WmsOrdemSeparacaoDetController()); 
			final wmsOrdemSeparacaoDetController = Get.find<WmsOrdemSeparacaoDetController>(); 
			wmsOrdemSeparacaoDetController.wmsOrdemSeparacaoDetModelList = wmsOrdemSeparacaoCabModel.wmsOrdemSeparacaoDetModelList!; 
			wmsOrdemSeparacaoDetController.userMadeChanges = false; 


			Get.toNamed(Routes.wmsOrdemSeparacaoCabTabPage)!.then((value) {
				if (wmsOrdemSeparacaoCabModel.id == 0) {
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
		wmsOrdemSeparacaoCabModel = WmsOrdemSeparacaoCabModel();
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
				if (await wmsOrdemSeparacaoCabRepository.delete(id: currentRow.cells['id']!.value)) {
					_wmsOrdemSeparacaoCabModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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

	final wmsOrdemSeparacaoCabTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final wmsOrdemSeparacaoCabEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final wmsOrdemSeparacaoCabEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsOrdemSeparacaoCabModel.id;
		plutoRow.cells['origem']?.value = wmsOrdemSeparacaoCabModel.origem;
		plutoRow.cells['dataSolicitacao']?.value = Util.formatDate(wmsOrdemSeparacaoCabModel.dataSolicitacao);
		plutoRow.cells['dataLimite']?.value = Util.formatDate(wmsOrdemSeparacaoCabModel.dataLimite);
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await wmsOrdemSeparacaoCabRepository.save(wmsOrdemSeparacaoCabModel: wmsOrdemSeparacaoCabModel); 
				if (result != null) {
					wmsOrdemSeparacaoCabModel = result;
					if (_isInserting) {
						_wmsOrdemSeparacaoCabModelList.add(wmsOrdemSeparacaoCabModel);
						_isInserting = false;
					} else {
            _wmsOrdemSeparacaoCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _wmsOrdemSeparacaoCabModelList.add(wmsOrdemSeparacaoCabModel);
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
		Get.find<WmsOrdemSeparacaoDetController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_wmsOrdemSeparacaoCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_wmsOrdemSeparacaoCabModelList.add(_wmsOrdemSeparacaoCabModelOld);
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
		functionName = "wms_ordem_separacao_cab";
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