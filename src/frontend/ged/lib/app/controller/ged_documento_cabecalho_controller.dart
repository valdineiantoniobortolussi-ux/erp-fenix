import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/controller/controller_imports.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:ged/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ged/app/page/page_imports.dart';

import 'package:ged/app/routes/app_routes.dart';
import 'package:ged/app/data/repository/ged_documento_cabecalho_repository.dart';
import 'package:ged/app/page/shared_page/shared_page_imports.dart';
import 'package:ged/app/page/shared_widget/message_dialog.dart';
import 'package:ged/app/mixin/controller_base_mixin.dart';

class GedDocumentoCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final GedDocumentoCabecalhoRepository gedDocumentoCabecalhoRepository;
	GedDocumentoCabecalhoController({required this.gedDocumentoCabecalhoRepository});

	// general
	final _dbColumns = GedDocumentoCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = GedDocumentoCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = gedDocumentoCabecalhoGridColumns();
	
	var _gedDocumentoCabecalhoModelList = <GedDocumentoCabecalhoModel>[];

	var _gedDocumentoCabecalhoModelOld = GedDocumentoCabecalhoModel();

	final _gedDocumentoCabecalhoModel = GedDocumentoCabecalhoModel().obs;
	GedDocumentoCabecalhoModel get gedDocumentoCabecalhoModel => _gedDocumentoCabecalhoModel.value;
	set gedDocumentoCabecalhoModel(value) => _gedDocumentoCabecalhoModel.value = value ?? GedDocumentoCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Documento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Detalhes', 
		),
	];

	List<Widget> tabPages() {
		return [
			GedDocumentoCabecalhoEditPage(),
			const GedDocumentoDetalheListPage(),
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
		for (var gedDocumentoCabecalhoModel in _gedDocumentoCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(gedDocumentoCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(GedDocumentoCabecalhoModel gedDocumentoCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(gedDocumentoCabecalhoModel: gedDocumentoCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ GedDocumentoCabecalhoModel? gedDocumentoCabecalhoModel}) {
		return {
			"id": PlutoCell(value: gedDocumentoCabecalhoModel?.id ?? 0),
			"nome": PlutoCell(value: gedDocumentoCabecalhoModel?.nome ?? ''),
			"dataInclusao": PlutoCell(value: gedDocumentoCabecalhoModel?.dataInclusao ?? ''),
			"descricao": PlutoCell(value: gedDocumentoCabecalhoModel?.descricao ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _gedDocumentoCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			gedDocumentoCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			gedDocumentoCabecalhoModel = modelFromRow[0];
			_gedDocumentoCabecalhoModelOld = gedDocumentoCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Documento]';
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
		await Get.find<GedDocumentoCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await gedDocumentoCabecalhoRepository.getList(filter: filter).then( (data){ _gedDocumentoCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Documento',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Detalhes
			Get.put<GedDocumentoDetalheController>(GedDocumentoDetalheController()); 
			final gedDocumentoDetalheController = Get.find<GedDocumentoDetalheController>(); 
			gedDocumentoDetalheController.gedDocumentoDetalheModelList = gedDocumentoCabecalhoModel.gedDocumentoDetalheModelList!; 
			gedDocumentoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.gedDocumentoCabecalhoTabPage)!.then((value) {
				if (gedDocumentoCabecalhoModel.id == 0) {
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
		gedDocumentoCabecalhoModel = GedDocumentoCabecalhoModel();
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
				if (await gedDocumentoCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_gedDocumentoCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();

	final gedDocumentoCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final gedDocumentoCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final gedDocumentoCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = gedDocumentoCabecalhoModel.id;
		plutoRow.cells['nome']?.value = gedDocumentoCabecalhoModel.nome;
		plutoRow.cells['dataInclusao']?.value = Util.formatDate(gedDocumentoCabecalhoModel.dataInclusao);
		plutoRow.cells['descricao']?.value = gedDocumentoCabecalhoModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await gedDocumentoCabecalhoRepository.save(gedDocumentoCabecalhoModel: gedDocumentoCabecalhoModel); 
				if (result != null) {
					gedDocumentoCabecalhoModel = result;
					if (_isInserting) {
						_gedDocumentoCabecalhoModelList.add(gedDocumentoCabecalhoModel);
						_isInserting = false;
					} else {
            _gedDocumentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _gedDocumentoCabecalhoModelList.add(gedDocumentoCabecalhoModel);
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
		Get.find<GedDocumentoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_gedDocumentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_gedDocumentoCabecalhoModelList.add(_gedDocumentoCabecalhoModelOld);
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
		functionName = "ged_documento_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}