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
import 'package:contabil/app/data/repository/contabil_dre_cabecalho_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilDreCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ContabilDreCabecalhoRepository contabilDreCabecalhoRepository;
	ContabilDreCabecalhoController({required this.contabilDreCabecalhoRepository});

	// general
	final _dbColumns = ContabilDreCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ContabilDreCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = contabilDreCabecalhoGridColumns();
	
	var _contabilDreCabecalhoModelList = <ContabilDreCabecalhoModel>[];

	var _contabilDreCabecalhoModelOld = ContabilDreCabecalhoModel();

	final _contabilDreCabecalhoModel = ContabilDreCabecalhoModel().obs;
	ContabilDreCabecalhoModel get contabilDreCabecalhoModel => _contabilDreCabecalhoModel.value;
	set contabilDreCabecalhoModel(value) => _contabilDreCabecalhoModel.value = value ?? ContabilDreCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'DRE', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Detalhes', 
		),
	];

	List<Widget> tabPages() {
		return [
			ContabilDreCabecalhoEditPage(),
			const ContabilDreDetalheListPage(),
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
		for (var contabilDreCabecalhoModel in _contabilDreCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(contabilDreCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilDreCabecalhoModel contabilDreCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilDreCabecalhoModel: contabilDreCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilDreCabecalhoModel? contabilDreCabecalhoModel}) {
		return {
			"id": PlutoCell(value: contabilDreCabecalhoModel?.id ?? 0),
			"descricao": PlutoCell(value: contabilDreCabecalhoModel?.descricao ?? ''),
			"padrao": PlutoCell(value: contabilDreCabecalhoModel?.padrao ?? ''),
			"periodoInicial": PlutoCell(value: contabilDreCabecalhoModel?.periodoInicial ?? ''),
			"periodoFinal": PlutoCell(value: contabilDreCabecalhoModel?.periodoFinal ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _contabilDreCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			contabilDreCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			contabilDreCabecalhoModel = modelFromRow[0];
			_contabilDreCabecalhoModelOld = contabilDreCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [DRE]';
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
		await Get.find<ContabilDreCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await contabilDreCabecalhoRepository.getList(filter: filter).then( (data){ _contabilDreCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'DRE',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			periodoInicialController.text = currentRow.cells['periodoInicial']?.value ?? '';
			periodoFinalController.text = currentRow.cells['periodoFinal']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Detalhes
			Get.put<ContabilDreDetalheController>(ContabilDreDetalheController()); 
			final contabilDreDetalheController = Get.find<ContabilDreDetalheController>(); 
			contabilDreDetalheController.contabilDreDetalheModelList = contabilDreCabecalhoModel.contabilDreDetalheModelList!; 
			contabilDreDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.contabilDreCabecalhoTabPage)!.then((value) {
				if (contabilDreCabecalhoModel.id == 0) {
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
		contabilDreCabecalhoModel = ContabilDreCabecalhoModel();
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
				if (await contabilDreCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_contabilDreCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();
	final periodoInicialController = MaskedTextController(mask: '00/0000',);
	final periodoFinalController = MaskedTextController(mask: '00/0000',);

	final contabilDreCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final contabilDreCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final contabilDreCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilDreCabecalhoModel.id;
		plutoRow.cells['descricao']?.value = contabilDreCabecalhoModel.descricao;
		plutoRow.cells['padrao']?.value = contabilDreCabecalhoModel.padrao;
		plutoRow.cells['periodoInicial']?.value = contabilDreCabecalhoModel.periodoInicial;
		plutoRow.cells['periodoFinal']?.value = contabilDreCabecalhoModel.periodoFinal;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await contabilDreCabecalhoRepository.save(contabilDreCabecalhoModel: contabilDreCabecalhoModel); 
				if (result != null) {
					contabilDreCabecalhoModel = result;
					if (_isInserting) {
						_contabilDreCabecalhoModelList.add(contabilDreCabecalhoModel);
						_isInserting = false;
					} else {
            _contabilDreCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _contabilDreCabecalhoModelList.add(contabilDreCabecalhoModel);
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
		Get.find<ContabilDreDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_contabilDreCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_contabilDreCabecalhoModelList.add(_contabilDreCabecalhoModelOld);
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
		functionName = "contabil_dre_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		descricaoController.dispose();
		periodoInicialController.dispose();
		periodoFinalController.dispose();
		super.onClose();
	}
}