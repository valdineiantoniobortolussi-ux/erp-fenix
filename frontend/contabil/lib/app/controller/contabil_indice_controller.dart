import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contabil/app/page/page_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_indice_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilIndiceController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ContabilIndiceRepository contabilIndiceRepository;
	ContabilIndiceController({required this.contabilIndiceRepository});

	// general
	final _dbColumns = ContabilIndiceModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ContabilIndiceModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = contabilIndiceGridColumns();
	
	var _contabilIndiceModelList = <ContabilIndiceModel>[];

	var _contabilIndiceModelOld = ContabilIndiceModel();

	final _contabilIndiceModel = ContabilIndiceModel().obs;
	ContabilIndiceModel get contabilIndiceModel => _contabilIndiceModel.value;
	set contabilIndiceModel(value) => _contabilIndiceModel.value = value ?? ContabilIndiceModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Índices', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Valores', 
		),
	];

	List<Widget> tabPages() {
		return [
			ContabilIndiceEditPage(),
			const ContabilIndiceValorListPage(),
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
		for (var contabilIndiceModel in _contabilIndiceModelList) {
			plutoRowList.add(_getPlutoRow(contabilIndiceModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilIndiceModel contabilIndiceModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilIndiceModel: contabilIndiceModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilIndiceModel? contabilIndiceModel}) {
		return {
			"id": PlutoCell(value: contabilIndiceModel?.id ?? 0),
			"indice": PlutoCell(value: contabilIndiceModel?.indice ?? ''),
			"periodicidade": PlutoCell(value: contabilIndiceModel?.periodicidade ?? ''),
			"diarioAPartirDe": PlutoCell(value: contabilIndiceModel?.diarioAPartirDe ?? ''),
			"mensalMesAno": PlutoCell(value: contabilIndiceModel?.mensalMesAno ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _contabilIndiceModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			contabilIndiceModel.plutoRowToObject(plutoRow);
		} else {
			contabilIndiceModel = modelFromRow[0];
			_contabilIndiceModelOld = contabilIndiceModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Índices]';
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
		await Get.find<ContabilIndiceController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await contabilIndiceRepository.getList(filter: filter).then( (data){ _contabilIndiceModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Índices',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			indiceController.text = currentRow.cells['indice']?.value ?? '';
			mensalMesAnoController.text = currentRow.cells['mensalMesAno']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Valores
			Get.put<ContabilIndiceValorController>(ContabilIndiceValorController()); 
			final contabilIndiceValorController = Get.find<ContabilIndiceValorController>(); 
			contabilIndiceValorController.contabilIndiceValorModelList = contabilIndiceModel.contabilIndiceValorModelList!; 
			contabilIndiceValorController.userMadeChanges = false; 


			Get.toNamed(Routes.contabilIndiceTabPage)!.then((value) {
				if (contabilIndiceModel.id == 0) {
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
		contabilIndiceModel = ContabilIndiceModel();
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
				if (await contabilIndiceRepository.delete(id: currentRow.cells['id']!.value)) {
					_contabilIndiceModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final indiceController = TextEditingController();
	final mensalMesAnoController = MaskedTextController(mask: '00/0000',);

	final contabilIndiceTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final contabilIndiceEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final contabilIndiceEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilIndiceModel.id;
		plutoRow.cells['indice']?.value = contabilIndiceModel.indice;
		plutoRow.cells['periodicidade']?.value = contabilIndiceModel.periodicidade;
		plutoRow.cells['diarioAPartirDe']?.value = Util.formatDate(contabilIndiceModel.diarioAPartirDe);
		plutoRow.cells['mensalMesAno']?.value = contabilIndiceModel.mensalMesAno;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await contabilIndiceRepository.save(contabilIndiceModel: contabilIndiceModel); 
				if (result != null) {
					contabilIndiceModel = result;
					if (_isInserting) {
						_contabilIndiceModelList.add(contabilIndiceModel);
						_isInserting = false;
					} else {
            _contabilIndiceModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _contabilIndiceModelList.add(contabilIndiceModel);
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
		Get.find<ContabilIndiceValorController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_contabilIndiceModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_contabilIndiceModelList.add(_contabilIndiceModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(contabilIndiceModel.periodicidade); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Periodicidade]'); 
			return false; 
		}
		return true;
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
		functionName = "contabil_indice";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		indiceController.dispose();
		mensalMesAnoController.dispose();
		super.onClose();
	}
}