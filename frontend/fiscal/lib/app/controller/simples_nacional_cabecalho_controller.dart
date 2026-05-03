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
import 'package:fiscal/app/data/repository/simples_nacional_cabecalho_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class SimplesNacionalCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final SimplesNacionalCabecalhoRepository simplesNacionalCabecalhoRepository;
	SimplesNacionalCabecalhoController({required this.simplesNacionalCabecalhoRepository});

	// general
	final _dbColumns = SimplesNacionalCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = SimplesNacionalCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = simplesNacionalCabecalhoGridColumns();
	
	var _simplesNacionalCabecalhoModelList = <SimplesNacionalCabecalhoModel>[];

	var _simplesNacionalCabecalhoModelOld = SimplesNacionalCabecalhoModel();

	final _simplesNacionalCabecalhoModel = SimplesNacionalCabecalhoModel().obs;
	SimplesNacionalCabecalhoModel get simplesNacionalCabecalhoModel => _simplesNacionalCabecalhoModel.value;
	set simplesNacionalCabecalhoModel(value) => _simplesNacionalCabecalhoModel.value = value ?? SimplesNacionalCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Simples Nacional', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Detalhes', 
		),
	];

	List<Widget> tabPages() {
		return [
			SimplesNacionalCabecalhoEditPage(),
			const SimplesNacionalDetalheListPage(),
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
		for (var simplesNacionalCabecalhoModel in _simplesNacionalCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(simplesNacionalCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(SimplesNacionalCabecalhoModel simplesNacionalCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(simplesNacionalCabecalhoModel: simplesNacionalCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ SimplesNacionalCabecalhoModel? simplesNacionalCabecalhoModel}) {
		return {
			"id": PlutoCell(value: simplesNacionalCabecalhoModel?.id ?? 0),
			"vigenciaInicial": PlutoCell(value: simplesNacionalCabecalhoModel?.vigenciaInicial ?? ''),
			"vigenciaFinal": PlutoCell(value: simplesNacionalCabecalhoModel?.vigenciaFinal ?? ''),
			"anexo": PlutoCell(value: simplesNacionalCabecalhoModel?.anexo ?? ''),
			"tabela": PlutoCell(value: simplesNacionalCabecalhoModel?.tabela ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _simplesNacionalCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			simplesNacionalCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			simplesNacionalCabecalhoModel = modelFromRow[0];
			_simplesNacionalCabecalhoModelOld = simplesNacionalCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Simples Nacional]';
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
		await Get.find<SimplesNacionalCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await simplesNacionalCabecalhoRepository.getList(filter: filter).then( (data){ _simplesNacionalCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Simples Nacional',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			anexoController.text = currentRow.cells['anexo']?.value ?? '';
			tabelaController.text = currentRow.cells['tabela']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Detalhes
			Get.put<SimplesNacionalDetalheController>(SimplesNacionalDetalheController()); 
			final simplesNacionalDetalheController = Get.find<SimplesNacionalDetalheController>(); 
			simplesNacionalDetalheController.simplesNacionalDetalheModelList = simplesNacionalCabecalhoModel.simplesNacionalDetalheModelList!; 
			simplesNacionalDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.simplesNacionalCabecalhoTabPage)!.then((value) {
				if (simplesNacionalCabecalhoModel.id == 0) {
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
		simplesNacionalCabecalhoModel = SimplesNacionalCabecalhoModel();
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
				if (await simplesNacionalCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_simplesNacionalCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final anexoController = TextEditingController();
	final tabelaController = TextEditingController();

	final simplesNacionalCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final simplesNacionalCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final simplesNacionalCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = simplesNacionalCabecalhoModel.id;
		plutoRow.cells['vigenciaInicial']?.value = Util.formatDate(simplesNacionalCabecalhoModel.vigenciaInicial);
		plutoRow.cells['vigenciaFinal']?.value = Util.formatDate(simplesNacionalCabecalhoModel.vigenciaFinal);
		plutoRow.cells['anexo']?.value = simplesNacionalCabecalhoModel.anexo;
		plutoRow.cells['tabela']?.value = simplesNacionalCabecalhoModel.tabela;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await simplesNacionalCabecalhoRepository.save(simplesNacionalCabecalhoModel: simplesNacionalCabecalhoModel); 
				if (result != null) {
					simplesNacionalCabecalhoModel = result;
					if (_isInserting) {
						_simplesNacionalCabecalhoModelList.add(simplesNacionalCabecalhoModel);
						_isInserting = false;
					} else {
            _simplesNacionalCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _simplesNacionalCabecalhoModelList.add(simplesNacionalCabecalhoModel);
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
		Get.find<SimplesNacionalDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_simplesNacionalCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_simplesNacionalCabecalhoModelList.add(_simplesNacionalCabecalhoModelOld);
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
		functionName = "simples_nacional_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		anexoController.dispose();
		tabelaController.dispose();
		super.onClose();
	}
}