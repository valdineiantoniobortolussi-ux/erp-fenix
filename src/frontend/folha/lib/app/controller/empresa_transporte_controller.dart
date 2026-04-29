import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';
import 'package:folha/app/page/page_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/empresa_transporte_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class EmpresaTransporteController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final EmpresaTransporteRepository empresaTransporteRepository;
	EmpresaTransporteController({required this.empresaTransporteRepository});

	// general
	final _dbColumns = EmpresaTransporteModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = EmpresaTransporteModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = empresaTransporteGridColumns();
	
	var _empresaTransporteModelList = <EmpresaTransporteModel>[];

	var _empresaTransporteModelOld = EmpresaTransporteModel();

	final _empresaTransporteModel = EmpresaTransporteModel().obs;
	EmpresaTransporteModel get empresaTransporteModel => _empresaTransporteModel.value;
	set empresaTransporteModel(value) => _empresaTransporteModel.value = value ?? EmpresaTransporteModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Empresa de Transporte', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itinerario', 
		),
	];

	List<Widget> tabPages() {
		return [
			EmpresaTransporteEditPage(),
			const EmpresaTransporteItinerarioListPage(),
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
		for (var empresaTransporteModel in _empresaTransporteModelList) {
			plutoRowList.add(_getPlutoRow(empresaTransporteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(EmpresaTransporteModel empresaTransporteModel) {
		return PlutoRow(
			cells: _getPlutoCells(empresaTransporteModel: empresaTransporteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ EmpresaTransporteModel? empresaTransporteModel}) {
		return {
			"id": PlutoCell(value: empresaTransporteModel?.id ?? 0),
			"nome": PlutoCell(value: empresaTransporteModel?.nome ?? ''),
			"uf": PlutoCell(value: empresaTransporteModel?.uf ?? ''),
			"classificacaoContabilConta": PlutoCell(value: empresaTransporteModel?.classificacaoContabilConta ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _empresaTransporteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			empresaTransporteModel.plutoRowToObject(plutoRow);
		} else {
			empresaTransporteModel = modelFromRow[0];
			_empresaTransporteModelOld = empresaTransporteModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Empresa de Transporte]';
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
		await Get.find<EmpresaTransporteController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await empresaTransporteRepository.getList(filter: filter).then( (data){ _empresaTransporteModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Empresa de Transporte',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			classificacaoContabilContaController.text = currentRow.cells['classificacaoContabilConta']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itinerario
			Get.put<EmpresaTransporteItinerarioController>(EmpresaTransporteItinerarioController()); 
			final empresaTransporteItinerarioController = Get.find<EmpresaTransporteItinerarioController>(); 
			empresaTransporteItinerarioController.empresaTransporteItinerarioModelList = empresaTransporteModel.empresaTransporteItinerarioModelList!; 
			empresaTransporteItinerarioController.userMadeChanges = false; 


			Get.toNamed(Routes.empresaTransporteTabPage)!.then((value) {
				if (empresaTransporteModel.id == 0) {
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
		empresaTransporteModel = EmpresaTransporteModel();
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
				if (await empresaTransporteRepository.delete(id: currentRow.cells['id']!.value)) {
					_empresaTransporteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();
	final classificacaoContabilContaController = TextEditingController();

	final empresaTransporteTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final empresaTransporteEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final empresaTransporteEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = empresaTransporteModel.id;
		plutoRow.cells['nome']?.value = empresaTransporteModel.nome;
		plutoRow.cells['uf']?.value = empresaTransporteModel.uf;
		plutoRow.cells['classificacaoContabilConta']?.value = empresaTransporteModel.classificacaoContabilConta;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await empresaTransporteRepository.save(empresaTransporteModel: empresaTransporteModel); 
				if (result != null) {
					empresaTransporteModel = result;
					if (_isInserting) {
						_empresaTransporteModelList.add(empresaTransporteModel);
						_isInserting = false;
					} else {
            _empresaTransporteModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _empresaTransporteModelList.add(empresaTransporteModel);
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
		Get.find<EmpresaTransporteItinerarioController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_empresaTransporteModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_empresaTransporteModelList.add(_empresaTransporteModelOld);
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
		functionName = "empresa_transporte";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		nomeController.dispose();
		classificacaoContabilContaController.dispose();
		super.onClose();
	}
}