import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/controller/controller_imports.dart';
import 'package:gondolas/app/data/model/model_imports.dart';
import 'package:gondolas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:gondolas/app/page/page_imports.dart';

import 'package:gondolas/app/routes/app_routes.dart';
import 'package:gondolas/app/data/repository/gondola_caixa_repository.dart';
import 'package:gondolas/app/page/shared_page/shared_page_imports.dart';
import 'package:gondolas/app/page/shared_widget/message_dialog.dart';
import 'package:gondolas/app/mixin/controller_base_mixin.dart';

class GondolaCaixaController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final GondolaCaixaRepository gondolaCaixaRepository;
	GondolaCaixaController({required this.gondolaCaixaRepository});

	// general
	final _dbColumns = GondolaCaixaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = GondolaCaixaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = gondolaCaixaGridColumns();
	
	var _gondolaCaixaModelList = <GondolaCaixaModel>[];

	var _gondolaCaixaModelOld = GondolaCaixaModel();

	final _gondolaCaixaModel = GondolaCaixaModel().obs;
	GondolaCaixaModel get gondolaCaixaModel => _gondolaCaixaModel.value;
	set gondolaCaixaModel(value) => _gondolaCaixaModel.value = value ?? GondolaCaixaModel();

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
			GondolaCaixaEditPage(),
			const GondolaArmazenamentoListPage(),
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
		for (var gondolaCaixaModel in _gondolaCaixaModelList) {
			plutoRowList.add(_getPlutoRow(gondolaCaixaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(GondolaCaixaModel gondolaCaixaModel) {
		return PlutoRow(
			cells: _getPlutoCells(gondolaCaixaModel: gondolaCaixaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ GondolaCaixaModel? gondolaCaixaModel}) {
		return {
			"id": PlutoCell(value: gondolaCaixaModel?.id ?? 0),
			"gondolaEstante": PlutoCell(value: gondolaCaixaModel?.gondolaEstanteModel?.codigo ?? ''),
			"codigo": PlutoCell(value: gondolaCaixaModel?.codigo ?? ''),
			"altura": PlutoCell(value: gondolaCaixaModel?.altura ?? 0),
			"largura": PlutoCell(value: gondolaCaixaModel?.largura ?? 0),
			"profundidade": PlutoCell(value: gondolaCaixaModel?.profundidade ?? 0),
			"idGondolaEstante": PlutoCell(value: gondolaCaixaModel?.idGondolaEstante ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _gondolaCaixaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			gondolaCaixaModel.plutoRowToObject(plutoRow);
		} else {
			gondolaCaixaModel = modelFromRow[0];
			_gondolaCaixaModelOld = gondolaCaixaModel.clone();
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
		await Get.find<GondolaCaixaController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await gondolaCaixaRepository.getList(filter: filter).then( (data){ _gondolaCaixaModelList = data; } );
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
			gondolaEstanteModelController.text = currentRow.cells['gondolaEstante']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			alturaController.text = currentRow.cells['altura']?.value?.toString() ?? '';
			larguraController.text = currentRow.cells['largura']?.value?.toString() ?? '';
			profundidadeController.text = currentRow.cells['profundidade']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Armazenamento
			Get.put<GondolaArmazenamentoController>(GondolaArmazenamentoController()); 
			final gondolaArmazenamentoController = Get.find<GondolaArmazenamentoController>(); 
			gondolaArmazenamentoController.gondolaArmazenamentoModelList = gondolaCaixaModel.gondolaArmazenamentoModelList!; 
			gondolaArmazenamentoController.userMadeChanges = false; 


			Get.toNamed(Routes.gondolaCaixaTabPage)!.then((value) {
				if (gondolaCaixaModel.id == 0) {
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
		gondolaCaixaModel = GondolaCaixaModel();
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
				if (await gondolaCaixaRepository.delete(id: currentRow.cells['id']!.value)) {
					_gondolaCaixaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final gondolaEstanteModelController = TextEditingController();
	final codigoController = TextEditingController();
	final alturaController = TextEditingController();
	final larguraController = TextEditingController();
	final profundidadeController = TextEditingController();

	final gondolaCaixaTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final gondolaCaixaEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final gondolaCaixaEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = gondolaCaixaModel.id;
		plutoRow.cells['idGondolaEstante']?.value = gondolaCaixaModel.idGondolaEstante;
		plutoRow.cells['gondolaEstante']?.value = gondolaCaixaModel.gondolaEstanteModel?.codigo;
		plutoRow.cells['codigo']?.value = gondolaCaixaModel.codigo;
		plutoRow.cells['altura']?.value = gondolaCaixaModel.altura;
		plutoRow.cells['largura']?.value = gondolaCaixaModel.largura;
		plutoRow.cells['profundidade']?.value = gondolaCaixaModel.profundidade;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await gondolaCaixaRepository.save(gondolaCaixaModel: gondolaCaixaModel); 
				if (result != null) {
					gondolaCaixaModel = result;
					if (_isInserting) {
						_gondolaCaixaModelList.add(gondolaCaixaModel);
						_isInserting = false;
					} else {
            _gondolaCaixaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _gondolaCaixaModelList.add(gondolaCaixaModel);
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
		Get.find<GondolaArmazenamentoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_gondolaCaixaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_gondolaCaixaModelList.add(_gondolaCaixaModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(gondolaCaixaModel.gondolaEstanteModel?.codigo); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Estante]'); 
			return false; 
		}
		return true;
	}

	Future callGondolaEstanteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Estante]'; 
		lookupController.route = '/gondola-estante/'; 
		lookupController.gridColumns = gondolaEstanteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = GondolaEstanteModel.aliasColumns; 
		lookupController.dbColumns = GondolaEstanteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			gondolaCaixaModel.idGondolaEstante = plutoRowResult.cells['id']!.value; 
			gondolaCaixaModel.gondolaEstanteModel!.plutoRowToObject(plutoRowResult); 
			gondolaEstanteModelController.text = gondolaCaixaModel.gondolaEstanteModel?.codigo ?? ''; 
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
		functionName = "gondola_caixa";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		gondolaEstanteModelController.dispose();
		codigoController.dispose();
		alturaController.dispose();
		larguraController.dispose();
		profundidadeController.dispose();
		super.onClose();
	}
}