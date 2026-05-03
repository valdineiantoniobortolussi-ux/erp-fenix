import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/controller/controller_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';
import 'package:fiscal/app/page/page_imports.dart';

import 'package:fiscal/app/routes/app_routes.dart';
import 'package:fiscal/app/data/repository/fiscal_livro_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalLivroController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FiscalLivroRepository fiscalLivroRepository;
	FiscalLivroController({required this.fiscalLivroRepository});

	// general
	final _dbColumns = FiscalLivroModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FiscalLivroModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = fiscalLivroGridColumns();
	
	var _fiscalLivroModelList = <FiscalLivroModel>[];

	var _fiscalLivroModelOld = FiscalLivroModel();

	final _fiscalLivroModel = FiscalLivroModel().obs;
	FiscalLivroModel get fiscalLivroModel => _fiscalLivroModel.value;
	set fiscalLivroModel(value) => _fiscalLivroModel.value = value ?? FiscalLivroModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Livros', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Termos', 
		),
	];

	List<Widget> tabPages() {
		return [
			FiscalLivroEditPage(),
			const FiscalTermoListPage(),
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
		for (var fiscalLivroModel in _fiscalLivroModelList) {
			plutoRowList.add(_getPlutoRow(fiscalLivroModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FiscalLivroModel fiscalLivroModel) {
		return PlutoRow(
			cells: _getPlutoCells(fiscalLivroModel: fiscalLivroModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FiscalLivroModel? fiscalLivroModel}) {
		return {
			"id": PlutoCell(value: fiscalLivroModel?.id ?? 0),
			"descricao": PlutoCell(value: fiscalLivroModel?.descricao ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _fiscalLivroModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			fiscalLivroModel.plutoRowToObject(plutoRow);
		} else {
			fiscalLivroModel = modelFromRow[0];
			_fiscalLivroModelOld = fiscalLivroModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Livros]';
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
		await Get.find<FiscalLivroController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await fiscalLivroRepository.getList(filter: filter).then( (data){ _fiscalLivroModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Livros',
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
			
			//Termos
			Get.put<FiscalTermoController>(FiscalTermoController()); 
			final fiscalTermoController = Get.find<FiscalTermoController>(); 
			fiscalTermoController.fiscalTermoModelList = fiscalLivroModel.fiscalTermoModelList!; 
			fiscalTermoController.userMadeChanges = false; 


			Get.toNamed(Routes.fiscalLivroTabPage)!.then((value) {
				if (fiscalLivroModel.id == 0) {
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
		fiscalLivroModel = FiscalLivroModel();
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
				if (await fiscalLivroRepository.delete(id: currentRow.cells['id']!.value)) {
					_fiscalLivroModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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

	final fiscalLivroTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final fiscalLivroEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final fiscalLivroEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalLivroModel.id;
		plutoRow.cells['descricao']?.value = fiscalLivroModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await fiscalLivroRepository.save(fiscalLivroModel: fiscalLivroModel); 
				if (result != null) {
					fiscalLivroModel = result;
					if (_isInserting) {
						_fiscalLivroModelList.add(fiscalLivroModel);
						_isInserting = false;
					} else {
            _fiscalLivroModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _fiscalLivroModelList.add(fiscalLivroModel);
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
		Get.find<FiscalTermoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_fiscalLivroModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_fiscalLivroModelList.add(_fiscalLivroModelOld);
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
		functionName = "fiscal_livro";
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