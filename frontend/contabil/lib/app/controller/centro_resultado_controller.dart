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
import 'package:contabil/app/data/repository/centro_resultado_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class CentroResultadoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final CentroResultadoRepository centroResultadoRepository;
	CentroResultadoController({required this.centroResultadoRepository});

	// general
	final _dbColumns = CentroResultadoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = CentroResultadoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = centroResultadoGridColumns();
	
	var _centroResultadoModelList = <CentroResultadoModel>[];

	var _centroResultadoModelOld = CentroResultadoModel();

	final _centroResultadoModel = CentroResultadoModel().obs;
	CentroResultadoModel get centroResultadoModel => _centroResultadoModel.value;
	set centroResultadoModel(value) => _centroResultadoModel.value = value ?? CentroResultadoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Centro de Resultado', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Natureza Financeira Vinculada', 
		),
	];

	List<Widget> tabPages() {
		return [
			CentroResultadoEditPage(),
			const CtResultadoNtFinanceiraListPage(),
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
		for (var centroResultadoModel in _centroResultadoModelList) {
			plutoRowList.add(_getPlutoRow(centroResultadoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CentroResultadoModel centroResultadoModel) {
		return PlutoRow(
			cells: _getPlutoCells(centroResultadoModel: centroResultadoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CentroResultadoModel? centroResultadoModel}) {
		return {
			"id": PlutoCell(value: centroResultadoModel?.id ?? 0),
			"planoCentroResultado": PlutoCell(value: centroResultadoModel?.planoCentroResultadoModel?.nome ?? ''),
			"descricao": PlutoCell(value: centroResultadoModel?.descricao ?? ''),
			"classificacao": PlutoCell(value: centroResultadoModel?.classificacao ?? ''),
			"sofreRateiro": PlutoCell(value: centroResultadoModel?.sofreRateiro ?? ''),
			"idPlanoCentroResultado": PlutoCell(value: centroResultadoModel?.idPlanoCentroResultado ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _centroResultadoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			centroResultadoModel.plutoRowToObject(plutoRow);
		} else {
			centroResultadoModel = modelFromRow[0];
			_centroResultadoModelOld = centroResultadoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Centro de Resultado]';
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
		await Get.find<CentroResultadoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await centroResultadoRepository.getList(filter: filter).then( (data){ _centroResultadoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Centro de Resultado',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			planoCentroResultadoModelController.text = currentRow.cells['planoCentroResultado']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			classificacaoController.text = currentRow.cells['classificacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Natureza Financeira Vinculada
			Get.put<CtResultadoNtFinanceiraController>(CtResultadoNtFinanceiraController()); 
			final ctResultadoNtFinanceiraController = Get.find<CtResultadoNtFinanceiraController>(); 
			ctResultadoNtFinanceiraController.ctResultadoNtFinanceiraModelList = centroResultadoModel.ctResultadoNtFinanceiraModelList!; 
			ctResultadoNtFinanceiraController.userMadeChanges = false; 


			Get.toNamed(Routes.centroResultadoTabPage)!.then((value) {
				if (centroResultadoModel.id == 0) {
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
		centroResultadoModel = CentroResultadoModel();
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
				if (await centroResultadoRepository.delete(id: currentRow.cells['id']!.value)) {
					_centroResultadoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final planoCentroResultadoModelController = TextEditingController();
	final descricaoController = TextEditingController();
	final classificacaoController = TextEditingController();

	final centroResultadoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final centroResultadoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final centroResultadoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = centroResultadoModel.id;
		plutoRow.cells['idPlanoCentroResultado']?.value = centroResultadoModel.idPlanoCentroResultado;
		plutoRow.cells['planoCentroResultado']?.value = centroResultadoModel.planoCentroResultadoModel?.nome;
		plutoRow.cells['descricao']?.value = centroResultadoModel.descricao;
		plutoRow.cells['classificacao']?.value = centroResultadoModel.classificacao;
		plutoRow.cells['sofreRateiro']?.value = centroResultadoModel.sofreRateiro;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await centroResultadoRepository.save(centroResultadoModel: centroResultadoModel); 
				if (result != null) {
					centroResultadoModel = result;
					if (_isInserting) {
						_centroResultadoModelList.add(centroResultadoModel);
						_isInserting = false;
					} else {
            _centroResultadoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _centroResultadoModelList.add(centroResultadoModel);
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
		Get.find<CtResultadoNtFinanceiraController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_centroResultadoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_centroResultadoModelList.add(_centroResultadoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(centroResultadoModel.planoCentroResultadoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Plano Centro Resultado]'); 
			return false; 
		}
		return true;
	}

	Future callPlanoCentroResultadoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Plano Centro Resultado]'; 
		lookupController.route = '/plano-centro-resultado/'; 
		lookupController.gridColumns = planoCentroResultadoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PlanoCentroResultadoModel.aliasColumns; 
		lookupController.dbColumns = PlanoCentroResultadoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			centroResultadoModel.idPlanoCentroResultado = plutoRowResult.cells['id']!.value; 
			centroResultadoModel.planoCentroResultadoModel!.plutoRowToObject(plutoRowResult); 
			planoCentroResultadoModelController.text = centroResultadoModel.planoCentroResultadoModel?.nome ?? ''; 
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
		functionName = "centro_resultado";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		planoCentroResultadoModelController.dispose();
		descricaoController.dispose();
		classificacaoController.dispose();
		super.onClose();
	}
}