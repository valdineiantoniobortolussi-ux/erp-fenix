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
import 'package:contabil/app/data/repository/rateio_centro_resultado_cab_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class RateioCentroResultadoCabController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final RateioCentroResultadoCabRepository rateioCentroResultadoCabRepository;
	RateioCentroResultadoCabController({required this.rateioCentroResultadoCabRepository});

	// general
	final _dbColumns = RateioCentroResultadoCabModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = RateioCentroResultadoCabModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = rateioCentroResultadoCabGridColumns();
	
	var _rateioCentroResultadoCabModelList = <RateioCentroResultadoCabModel>[];

	var _rateioCentroResultadoCabModelOld = RateioCentroResultadoCabModel();

	final _rateioCentroResultadoCabModel = RateioCentroResultadoCabModel().obs;
	RateioCentroResultadoCabModel get rateioCentroResultadoCabModel => _rateioCentroResultadoCabModel.value;
	set rateioCentroResultadoCabModel(value) => _rateioCentroResultadoCabModel.value = value ?? RateioCentroResultadoCabModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Rateio Centro Resultado', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Detalhes', 
		),
	];

	List<Widget> tabPages() {
		return [
			RateioCentroResultadoCabEditPage(),
			const RateioCentroResultadoDetListPage(),
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
		for (var rateioCentroResultadoCabModel in _rateioCentroResultadoCabModelList) {
			plutoRowList.add(_getPlutoRow(rateioCentroResultadoCabModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(RateioCentroResultadoCabModel rateioCentroResultadoCabModel) {
		return PlutoRow(
			cells: _getPlutoCells(rateioCentroResultadoCabModel: rateioCentroResultadoCabModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ RateioCentroResultadoCabModel? rateioCentroResultadoCabModel}) {
		return {
			"id": PlutoCell(value: rateioCentroResultadoCabModel?.id ?? 0),
			"centroResultado": PlutoCell(value: rateioCentroResultadoCabModel?.centroResultadoModel?.descricao ?? ''),
			"descricao": PlutoCell(value: rateioCentroResultadoCabModel?.descricao ?? ''),
			"idCentroResultado": PlutoCell(value: rateioCentroResultadoCabModel?.idCentroResultado ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _rateioCentroResultadoCabModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			rateioCentroResultadoCabModel.plutoRowToObject(plutoRow);
		} else {
			rateioCentroResultadoCabModel = modelFromRow[0];
			_rateioCentroResultadoCabModelOld = rateioCentroResultadoCabModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Rateio Centro Resultado]';
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
		await Get.find<RateioCentroResultadoCabController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await rateioCentroResultadoCabRepository.getList(filter: filter).then( (data){ _rateioCentroResultadoCabModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Rateio Centro Resultado',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			centroResultadoModelController.text = currentRow.cells['centroResultado']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Detalhes
			Get.put<RateioCentroResultadoDetController>(RateioCentroResultadoDetController()); 
			final rateioCentroResultadoDetController = Get.find<RateioCentroResultadoDetController>(); 
			rateioCentroResultadoDetController.rateioCentroResultadoDetModelList = rateioCentroResultadoCabModel.rateioCentroResultadoDetModelList!; 
			rateioCentroResultadoDetController.userMadeChanges = false; 


			Get.toNamed(Routes.rateioCentroResultadoCabTabPage)!.then((value) {
				if (rateioCentroResultadoCabModel.id == 0) {
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
		rateioCentroResultadoCabModel = RateioCentroResultadoCabModel();
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
				if (await rateioCentroResultadoCabRepository.delete(id: currentRow.cells['id']!.value)) {
					_rateioCentroResultadoCabModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final centroResultadoModelController = TextEditingController();
	final descricaoController = TextEditingController();

	final rateioCentroResultadoCabTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final rateioCentroResultadoCabEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final rateioCentroResultadoCabEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = rateioCentroResultadoCabModel.id;
		plutoRow.cells['idCentroResultado']?.value = rateioCentroResultadoCabModel.idCentroResultado;
		plutoRow.cells['centroResultado']?.value = rateioCentroResultadoCabModel.centroResultadoModel?.descricao;
		plutoRow.cells['descricao']?.value = rateioCentroResultadoCabModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await rateioCentroResultadoCabRepository.save(rateioCentroResultadoCabModel: rateioCentroResultadoCabModel); 
				if (result != null) {
					rateioCentroResultadoCabModel = result;
					if (_isInserting) {
						_rateioCentroResultadoCabModelList.add(rateioCentroResultadoCabModel);
						_isInserting = false;
					} else {
            _rateioCentroResultadoCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _rateioCentroResultadoCabModelList.add(rateioCentroResultadoCabModel);
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
		Get.find<RateioCentroResultadoDetController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_rateioCentroResultadoCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_rateioCentroResultadoCabModelList.add(_rateioCentroResultadoCabModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(rateioCentroResultadoCabModel.centroResultadoModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Centro Resultado]'); 
			return false; 
		}
		return true;
	}

	Future callCentroResultadoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Centro Resultado]'; 
		lookupController.route = '/centro-resultado/'; 
		lookupController.gridColumns = centroResultadoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CentroResultadoModel.aliasColumns; 
		lookupController.dbColumns = CentroResultadoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			rateioCentroResultadoCabModel.idCentroResultado = plutoRowResult.cells['id']!.value; 
			rateioCentroResultadoCabModel.centroResultadoModel!.plutoRowToObject(plutoRowResult); 
			centroResultadoModelController.text = rateioCentroResultadoCabModel.centroResultadoModel?.descricao ?? ''; 
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
		functionName = "rateio_centro_resultado_cab";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		centroResultadoModelController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}