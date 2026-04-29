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
import 'package:contabil/app/data/repository/contabil_livro_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilLivroController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ContabilLivroRepository contabilLivroRepository;
	ContabilLivroController({required this.contabilLivroRepository});

	// general
	final _dbColumns = ContabilLivroModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ContabilLivroModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = contabilLivroGridColumns();
	
	var _contabilLivroModelList = <ContabilLivroModel>[];

	var _contabilLivroModelOld = ContabilLivroModel();

	final _contabilLivroModel = ContabilLivroModel().obs;
	ContabilLivroModel get contabilLivroModel => _contabilLivroModel.value;
	set contabilLivroModel(value) => _contabilLivroModel.value = value ?? ContabilLivroModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Livros', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Termos', 
		),
	];

	List<Widget> tabPages() {
		return [
			ContabilLivroEditPage(),
			const ContabilTermoListPage(),
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
		for (var contabilLivroModel in _contabilLivroModelList) {
			plutoRowList.add(_getPlutoRow(contabilLivroModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilLivroModel contabilLivroModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilLivroModel: contabilLivroModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilLivroModel? contabilLivroModel}) {
		return {
			"id": PlutoCell(value: contabilLivroModel?.id ?? 0),
			"competencia": PlutoCell(value: contabilLivroModel?.competencia ?? ''),
			"formaEscrituracao": PlutoCell(value: contabilLivroModel?.formaEscrituracao ?? ''),
			"descricao": PlutoCell(value: contabilLivroModel?.descricao ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _contabilLivroModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			contabilLivroModel.plutoRowToObject(plutoRow);
		} else {
			contabilLivroModel = modelFromRow[0];
			_contabilLivroModelOld = contabilLivroModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Livros]';
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
		await Get.find<ContabilLivroController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await contabilLivroRepository.getList(filter: filter).then( (data){ _contabilLivroModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Livros',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Termos
			Get.put<ContabilTermoController>(ContabilTermoController()); 
			final contabilTermoController = Get.find<ContabilTermoController>(); 
			contabilTermoController.contabilTermoModelList = contabilLivroModel.contabilTermoModelList!; 
			contabilTermoController.userMadeChanges = false; 


			Get.toNamed(Routes.contabilLivroTabPage)!.then((value) {
				if (contabilLivroModel.id == 0) {
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
		contabilLivroModel = ContabilLivroModel();
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
				if (await contabilLivroRepository.delete(id: currentRow.cells['id']!.value)) {
					_contabilLivroModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final competenciaController = MaskedTextController(mask: '00:0000',);
	final descricaoController = TextEditingController();

	final contabilLivroTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final contabilLivroEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final contabilLivroEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilLivroModel.id;
		plutoRow.cells['competencia']?.value = contabilLivroModel.competencia;
		plutoRow.cells['formaEscrituracao']?.value = contabilLivroModel.formaEscrituracao;
		plutoRow.cells['descricao']?.value = contabilLivroModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await contabilLivroRepository.save(contabilLivroModel: contabilLivroModel); 
				if (result != null) {
					contabilLivroModel = result;
					if (_isInserting) {
						_contabilLivroModelList.add(contabilLivroModel);
						_isInserting = false;
					} else {
            _contabilLivroModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _contabilLivroModelList.add(contabilLivroModel);
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
		Get.find<ContabilTermoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_contabilLivroModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_contabilLivroModelList.add(_contabilLivroModelOld);
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
		functionName = "contabil_livro";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		competenciaController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}