import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';
import 'package:folha/app/page/page_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_inss_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaInssController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FolhaInssRepository folhaInssRepository;
	FolhaInssController({required this.folhaInssRepository});

	// general
	final _dbColumns = FolhaInssModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FolhaInssModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = folhaInssGridColumns();
	
	var _folhaInssModelList = <FolhaInssModel>[];

	var _folhaInssModelOld = FolhaInssModel();

	final _folhaInssModel = FolhaInssModel().obs;
	FolhaInssModel get folhaInssModel => _folhaInssModel.value;
	set folhaInssModel(value) => _folhaInssModel.value = value ?? FolhaInssModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'INSS', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Retenções', 
		),
	];

	List<Widget> tabPages() {
		return [
			FolhaInssEditPage(),
			const FolhaInssRetencaoListPage(),
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
		for (var folhaInssModel in _folhaInssModelList) {
			plutoRowList.add(_getPlutoRow(folhaInssModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaInssModel folhaInssModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaInssModel: folhaInssModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaInssModel? folhaInssModel}) {
		return {
			"id": PlutoCell(value: folhaInssModel?.id ?? 0),
			"competencia": PlutoCell(value: folhaInssModel?.competencia ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _folhaInssModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			folhaInssModel.plutoRowToObject(plutoRow);
		} else {
			folhaInssModel = modelFromRow[0];
			_folhaInssModelOld = folhaInssModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [INSS]';
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
		await Get.find<FolhaInssController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await folhaInssRepository.getList(filter: filter).then( (data){ _folhaInssModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'INSS',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Retenções
			Get.put<FolhaInssRetencaoController>(FolhaInssRetencaoController()); 
			final folhaInssRetencaoController = Get.find<FolhaInssRetencaoController>(); 
			folhaInssRetencaoController.folhaInssRetencaoModelList = folhaInssModel.folhaInssRetencaoModelList!; 
			folhaInssRetencaoController.userMadeChanges = false; 


			Get.toNamed(Routes.folhaInssTabPage)!.then((value) {
				if (folhaInssModel.id == 0) {
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
		folhaInssModel = FolhaInssModel();
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
				if (await folhaInssRepository.delete(id: currentRow.cells['id']!.value)) {
					_folhaInssModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final competenciaController = MaskedTextController(mask: '00/0000',);

	final folhaInssTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final folhaInssEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final folhaInssEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaInssModel.id;
		plutoRow.cells['competencia']?.value = folhaInssModel.competencia;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await folhaInssRepository.save(folhaInssModel: folhaInssModel); 
				if (result != null) {
					folhaInssModel = result;
					if (_isInserting) {
						_folhaInssModelList.add(folhaInssModel);
						_isInserting = false;
					} else {
            _folhaInssModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _folhaInssModelList.add(folhaInssModel);
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
		Get.find<FolhaInssRetencaoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_folhaInssModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_folhaInssModelList.add(_folhaInssModelOld);
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
		functionName = "folha_inss";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		competenciaController.dispose();
		super.onClose();
	}
}