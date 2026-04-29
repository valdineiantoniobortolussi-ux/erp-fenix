import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/controller/controller_imports.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:inventario/app/page/grid_columns/grid_columns_imports.dart';
import 'package:inventario/app/page/page_imports.dart';

import 'package:inventario/app/routes/app_routes.dart';
import 'package:inventario/app/data/repository/inventario_ajuste_cab_repository.dart';
import 'package:inventario/app/page/shared_page/shared_page_imports.dart';
import 'package:inventario/app/page/shared_widget/message_dialog.dart';
import 'package:inventario/app/mixin/controller_base_mixin.dart';

class InventarioAjusteCabController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final InventarioAjusteCabRepository inventarioAjusteCabRepository;
	InventarioAjusteCabController({required this.inventarioAjusteCabRepository});

	// general
	final _dbColumns = InventarioAjusteCabModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = InventarioAjusteCabModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = inventarioAjusteCabGridColumns();
	
	var _inventarioAjusteCabModelList = <InventarioAjusteCabModel>[];

	var _inventarioAjusteCabModelOld = InventarioAjusteCabModel();

	final _inventarioAjusteCabModel = InventarioAjusteCabModel().obs;
	InventarioAjusteCabModel get inventarioAjusteCabModel => _inventarioAjusteCabModel.value;
	set inventarioAjusteCabModel(value) => _inventarioAjusteCabModel.value = value ?? InventarioAjusteCabModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Ajustes de Preço', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Produtos', 
		),
	];

	List<Widget> tabPages() {
		return [
			InventarioAjusteCabEditPage(),
			const InventarioAjusteDetListPage(),
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
		for (var inventarioAjusteCabModel in _inventarioAjusteCabModelList) {
			plutoRowList.add(_getPlutoRow(inventarioAjusteCabModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(InventarioAjusteCabModel inventarioAjusteCabModel) {
		return PlutoRow(
			cells: _getPlutoCells(inventarioAjusteCabModel: inventarioAjusteCabModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ InventarioAjusteCabModel? inventarioAjusteCabModel}) {
		return {
			"id": PlutoCell(value: inventarioAjusteCabModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: inventarioAjusteCabModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataAjuste": PlutoCell(value: inventarioAjusteCabModel?.dataAjuste ?? ''),
			"tipo": PlutoCell(value: inventarioAjusteCabModel?.tipo ?? ''),
			"taxa": PlutoCell(value: inventarioAjusteCabModel?.taxa ?? 0),
			"justificativa": PlutoCell(value: inventarioAjusteCabModel?.justificativa ?? ''),
			"idViewPessoaColaborador": PlutoCell(value: inventarioAjusteCabModel?.idViewPessoaColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _inventarioAjusteCabModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			inventarioAjusteCabModel.plutoRowToObject(plutoRow);
		} else {
			inventarioAjusteCabModel = modelFromRow[0];
			_inventarioAjusteCabModelOld = inventarioAjusteCabModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Ajustes de Preço]';
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
		await Get.find<InventarioAjusteCabController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await inventarioAjusteCabRepository.getList(filter: filter).then( (data){ _inventarioAjusteCabModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Ajustes de Preço',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			taxaController.text = currentRow.cells['taxa']?.value?.toStringAsFixed(2) ?? '';
			justificativaController.text = currentRow.cells['justificativa']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Produtos
			Get.put<InventarioAjusteDetController>(InventarioAjusteDetController()); 
			final inventarioAjusteDetController = Get.find<InventarioAjusteDetController>(); 
			inventarioAjusteDetController.inventarioAjusteDetModelList = inventarioAjusteCabModel.inventarioAjusteDetModelList!; 
			inventarioAjusteDetController.userMadeChanges = false; 


			Get.toNamed(Routes.inventarioAjusteCabTabPage)!.then((value) {
				if (inventarioAjusteCabModel.id == 0) {
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
		inventarioAjusteCabModel = InventarioAjusteCabModel();
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
				if (await inventarioAjusteCabRepository.delete(id: currentRow.cells['id']!.value)) {
					_inventarioAjusteCabModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaColaboradorModelController = TextEditingController();
	final taxaController = MoneyMaskedTextController();
	final justificativaController = TextEditingController();

	final inventarioAjusteCabTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final inventarioAjusteCabEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final inventarioAjusteCabEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = inventarioAjusteCabModel.id;
		plutoRow.cells['idViewPessoaColaborador']?.value = inventarioAjusteCabModel.idViewPessoaColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = inventarioAjusteCabModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataAjuste']?.value = Util.formatDate(inventarioAjusteCabModel.dataAjuste);
		plutoRow.cells['tipo']?.value = inventarioAjusteCabModel.tipo;
		plutoRow.cells['taxa']?.value = inventarioAjusteCabModel.taxa;
		plutoRow.cells['justificativa']?.value = inventarioAjusteCabModel.justificativa;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await inventarioAjusteCabRepository.save(inventarioAjusteCabModel: inventarioAjusteCabModel); 
				if (result != null) {
					inventarioAjusteCabModel = result;
					if (_isInserting) {
						_inventarioAjusteCabModelList.add(inventarioAjusteCabModel);
						_isInserting = false;
					} else {
            _inventarioAjusteCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _inventarioAjusteCabModelList.add(inventarioAjusteCabModel);
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
		Get.find<InventarioAjusteDetController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_inventarioAjusteCabModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_inventarioAjusteCabModelList.add(_inventarioAjusteCabModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(inventarioAjusteCabModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
		return true;
	}

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			inventarioAjusteCabModel.idViewPessoaColaborador = plutoRowResult.cells['id']!.value; 
			inventarioAjusteCabModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = inventarioAjusteCabModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "inventario_ajuste_cab";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaColaboradorModelController.dispose();
		taxaController.dispose();
		justificativaController.dispose();
		super.onClose();
	}
}