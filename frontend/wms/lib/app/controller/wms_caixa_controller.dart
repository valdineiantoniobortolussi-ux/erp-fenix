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
import 'package:wms/app/data/repository/wms_caixa_repository.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';
import 'package:wms/app/mixin/controller_base_mixin.dart';

class WmsCaixaController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final WmsCaixaRepository wmsCaixaRepository;
	WmsCaixaController({required this.wmsCaixaRepository});

	// general
	final _dbColumns = WmsCaixaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = WmsCaixaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = wmsCaixaGridColumns();
	
	var _wmsCaixaModelList = <WmsCaixaModel>[];

	var _wmsCaixaModelOld = WmsCaixaModel();

	final _wmsCaixaModel = WmsCaixaModel().obs;
	WmsCaixaModel get wmsCaixaModel => _wmsCaixaModel.value;
	set wmsCaixaModel(value) => _wmsCaixaModel.value = value ?? WmsCaixaModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Caixa', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Armazenamento', 
		),
	];

	List<Widget> tabPages() {
		return [
			WmsCaixaEditPage(),
			const WmsArmazenamentoListPage(),
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
		for (var wmsCaixaModel in _wmsCaixaModelList) {
			plutoRowList.add(_getPlutoRow(wmsCaixaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(WmsCaixaModel wmsCaixaModel) {
		return PlutoRow(
			cells: _getPlutoCells(wmsCaixaModel: wmsCaixaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ WmsCaixaModel? wmsCaixaModel}) {
		return {
			"id": PlutoCell(value: wmsCaixaModel?.id ?? 0),
			"wmsEstante": PlutoCell(value: wmsCaixaModel?.wmsEstanteModel?.codigo ?? ''),
			"codigo": PlutoCell(value: wmsCaixaModel?.codigo ?? ''),
			"altura": PlutoCell(value: wmsCaixaModel?.altura ?? 0),
			"largura": PlutoCell(value: wmsCaixaModel?.largura ?? 0),
			"profundidade": PlutoCell(value: wmsCaixaModel?.profundidade ?? 0),
			"idWmsEstante": PlutoCell(value: wmsCaixaModel?.idWmsEstante ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _wmsCaixaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			wmsCaixaModel.plutoRowToObject(plutoRow);
		} else {
			wmsCaixaModel = modelFromRow[0];
			_wmsCaixaModelOld = wmsCaixaModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Caixa]';
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
		await Get.find<WmsCaixaController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await wmsCaixaRepository.getList(filter: filter).then( (data){ _wmsCaixaModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Caixa',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			wmsEstanteModelController.text = currentRow.cells['wmsEstante']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			alturaController.text = currentRow.cells['altura']?.value?.toString() ?? '';
			larguraController.text = currentRow.cells['largura']?.value?.toString() ?? '';
			profundidadeController.text = currentRow.cells['profundidade']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Armazenamento
			Get.put<WmsArmazenamentoController>(WmsArmazenamentoController()); 
			final wmsArmazenamentoController = Get.find<WmsArmazenamentoController>(); 
			wmsArmazenamentoController.wmsArmazenamentoModelList = wmsCaixaModel.wmsArmazenamentoModelList!; 
			wmsArmazenamentoController.userMadeChanges = false; 


			Get.toNamed(Routes.wmsCaixaTabPage)!.then((value) {
				if (wmsCaixaModel.id == 0) {
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
		wmsCaixaModel = WmsCaixaModel();
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
				if (await wmsCaixaRepository.delete(id: currentRow.cells['id']!.value)) {
					_wmsCaixaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final wmsEstanteModelController = TextEditingController();
	final codigoController = TextEditingController();
	final alturaController = TextEditingController();
	final larguraController = TextEditingController();
	final profundidadeController = TextEditingController();

	final wmsCaixaTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final wmsCaixaEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final wmsCaixaEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsCaixaModel.id;
		plutoRow.cells['idWmsEstante']?.value = wmsCaixaModel.idWmsEstante;
		plutoRow.cells['wmsEstante']?.value = wmsCaixaModel.wmsEstanteModel?.codigo;
		plutoRow.cells['codigo']?.value = wmsCaixaModel.codigo;
		plutoRow.cells['altura']?.value = wmsCaixaModel.altura;
		plutoRow.cells['largura']?.value = wmsCaixaModel.largura;
		plutoRow.cells['profundidade']?.value = wmsCaixaModel.profundidade;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await wmsCaixaRepository.save(wmsCaixaModel: wmsCaixaModel); 
				if (result != null) {
					wmsCaixaModel = result;
					if (_isInserting) {
						_wmsCaixaModelList.add(wmsCaixaModel);
						_isInserting = false;
					} else {
            _wmsCaixaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _wmsCaixaModelList.add(wmsCaixaModel);
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
		Get.find<WmsArmazenamentoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_wmsCaixaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_wmsCaixaModelList.add(_wmsCaixaModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(wmsCaixaModel.wmsEstanteModel?.codigo); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Estante]'); 
			return false; 
		}
		return true;
	}

	Future callWmsEstanteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Estante]'; 
		lookupController.route = '/wms-estante/'; 
		lookupController.gridColumns = wmsEstanteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = WmsEstanteModel.aliasColumns; 
		lookupController.dbColumns = WmsEstanteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			wmsCaixaModel.idWmsEstante = plutoRowResult.cells['id']!.value; 
			wmsCaixaModel.wmsEstanteModel!.plutoRowToObject(plutoRowResult); 
			wmsEstanteModelController.text = wmsCaixaModel.wmsEstanteModel?.codigo ?? ''; 
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
		functionName = "wms_caixa";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		wmsEstanteModelController.dispose();
		codigoController.dispose();
		alturaController.dispose();
		larguraController.dispose();
		profundidadeController.dispose();
		super.onClose();
	}
}