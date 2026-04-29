import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contabil/app/page/page_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_encerramento_exe_cab_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilEncerramentoExeCabController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ContabilEncerramentoExeCabRepository contabilEncerramentoExeCabRepository;
	ContabilEncerramentoExeCabController({required this.contabilEncerramentoExeCabRepository});

	// general
	final _dbColumns = ContabilEncerramentoExeCabModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ContabilEncerramentoExeCabModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = contabilEncerramentoExeCabGridColumns();
	
	var _contabilEncerramentoExeCabModelList = <ContabilEncerramentoExeCabModel>[];

	var _contabilEncerramentoExeCabModelOld = ContabilEncerramentoExeCabModel();

	final _contabilEncerramentoExeCabModel = ContabilEncerramentoExeCabModel().obs;
	ContabilEncerramentoExeCabModel get contabilEncerramentoExeCabModel => _contabilEncerramentoExeCabModel.value;
	set contabilEncerramentoExeCabModel(value) => _contabilEncerramentoExeCabModel.value = value ?? ContabilEncerramentoExeCabModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Encerramento do Exercício', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Detalhes', 
		),
	];

	List<Widget> tabPages() {
		return [
			ContabilEncerramentoExeCabEditPage(),
			const ContabilEncerramentoExeDetListPage(),
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
		for (var contabilEncerramentoExeCabModel in _contabilEncerramentoExeCabModelList) {
			plutoRowList.add(_getPlutoRow(contabilEncerramentoExeCabModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilEncerramentoExeCabModel contabilEncerramentoExeCabModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilEncerramentoExeCabModel: contabilEncerramentoExeCabModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilEncerramentoExeCabModel? contabilEncerramentoExeCabModel}) {
		return {
			"id": PlutoCell(value: contabilEncerramentoExeCabModel?.id ?? 0),
			"dataInicio": PlutoCell(value: contabilEncerramentoExeCabModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: contabilEncerramentoExeCabModel?.dataFim ?? ''),
			"dataInclusao": PlutoCell(value: contabilEncerramentoExeCabModel?.dataInclusao ?? ''),
			"motivo": PlutoCell(value: contabilEncerramentoExeCabModel?.motivo ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _contabilEncerramentoExeCabModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			contabilEncerramentoExeCabModel.plutoRowToObject(plutoRow);
		} else {
			contabilEncerramentoExeCabModel = modelFromRow[0];
			_contabilEncerramentoExeCabModelOld = contabilEncerramentoExeCabModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Encerramento do Exercício]';
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
		await Get.find<ContabilEncerramentoExeCabController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await contabilEncerramentoExeCabRepository.getList(filter: filter).then( (data){ _contabilEncerramentoExeCabModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Encerramento do Exercício',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			motivoController.text = currentRow.cells['motivo']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Detalhes
			Get.put<ContabilEncerramentoExeDetController>(ContabilEncerramentoExeDetController()); 
			final contabilEncerramentoExeDetController = Get.find<ContabilEncerramentoExeDetController>(); 
			contabilEncerramentoExeDetController.contabilEncerramentoExeDetModelList = contabilEncerramentoExeCabModel.contabilEncerramentoExeDetModelList!; 
			contabilEncerramentoExeDetController.userMadeChanges = false; 


			Get.toNamed(Routes.contabilEncerramentoExeCabTabPage)!.then((value) {
				if (contabilEncerramentoExeCabModel.id == 0) {
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
		contabilEncerramentoExeCabModel = ContabilEncerramentoExeCabModel();
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
				if (await contabilEncerramentoExeCabRepository.delete(id: currentRow.cells['id']!.value)) {
					_contabilEncerramentoExeCabModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final motivoController = TextEditingController();

	final contabilEncerramentoExeCabTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final contabilEncerramentoExeCabEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final contabilEncerramentoExeCabEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilEncerramentoExeCabModel.id;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(contabilEncerramentoExeCabModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(contabilEncerramentoExeCabModel.dataFim);
		plutoRow.cells['dataInclusao']?.value = Util.formatDate(contabilEncerramentoExeCabModel.dataInclusao);
		plutoRow.cells['motivo']?.value = contabilEncerramentoExeCabModel.motivo;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await contabilEncerramentoExeCabRepository.save(contabilEncerramentoExeCabModel: contabilEncerramentoExeCabModel); 
				if (result != null) {
					contabilEncerramentoExeCabModel = result;
					if (_isInserting) {
						_contabilEncerramentoExeCabModelList.add(contabilEncerramentoExeCabModel);
						_isInserting = false;
					} else {
            _contabilEncerramentoExeCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _contabilEncerramentoExeCabModelList.add(contabilEncerramentoExeCabModel);
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
		Get.find<ContabilEncerramentoExeDetController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_contabilEncerramentoExeCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_contabilEncerramentoExeCabModelList.add(_contabilEncerramentoExeCabModelOld);
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
		functionName = "contabil_encerramento_exe_cab";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		motivoController.dispose();
		super.onClose();
	}
}