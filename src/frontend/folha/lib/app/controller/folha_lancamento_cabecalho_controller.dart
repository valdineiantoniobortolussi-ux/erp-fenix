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
import 'package:folha/app/data/repository/folha_lancamento_cabecalho_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaLancamentoCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FolhaLancamentoCabecalhoRepository folhaLancamentoCabecalhoRepository;
	FolhaLancamentoCabecalhoController({required this.folhaLancamentoCabecalhoRepository});

	// general
	final _dbColumns = FolhaLancamentoCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FolhaLancamentoCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = folhaLancamentoCabecalhoGridColumns();
	
	var _folhaLancamentoCabecalhoModelList = <FolhaLancamentoCabecalhoModel>[];

	var _folhaLancamentoCabecalhoModelOld = FolhaLancamentoCabecalhoModel();

	final _folhaLancamentoCabecalhoModel = FolhaLancamentoCabecalhoModel().obs;
	FolhaLancamentoCabecalhoModel get folhaLancamentoCabecalhoModel => _folhaLancamentoCabecalhoModel.value;
	set folhaLancamentoCabecalhoModel(value) => _folhaLancamentoCabecalhoModel.value = value ?? FolhaLancamentoCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Lançamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Detalhes', 
		),
	];

	List<Widget> tabPages() {
		return [
			FolhaLancamentoCabecalhoEditPage(),
			const FolhaLancamentoDetalheListPage(),
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
		for (var folhaLancamentoCabecalhoModel in _folhaLancamentoCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(folhaLancamentoCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaLancamentoCabecalhoModel folhaLancamentoCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaLancamentoCabecalhoModel: folhaLancamentoCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaLancamentoCabecalhoModel? folhaLancamentoCabecalhoModel}) {
		return {
			"id": PlutoCell(value: folhaLancamentoCabecalhoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: folhaLancamentoCabecalhoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"competencia": PlutoCell(value: folhaLancamentoCabecalhoModel?.competencia ?? ''),
			"tipo": PlutoCell(value: folhaLancamentoCabecalhoModel?.tipo ?? ''),
			"idColaborador": PlutoCell(value: folhaLancamentoCabecalhoModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _folhaLancamentoCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			folhaLancamentoCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			folhaLancamentoCabecalhoModel = modelFromRow[0];
			_folhaLancamentoCabecalhoModelOld = folhaLancamentoCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Lançamento]';
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
		await Get.find<FolhaLancamentoCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await folhaLancamentoCabecalhoRepository.getList(filter: filter).then( (data){ _folhaLancamentoCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Lançamento',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Detalhes
			Get.put<FolhaLancamentoDetalheController>(FolhaLancamentoDetalheController()); 
			final folhaLancamentoDetalheController = Get.find<FolhaLancamentoDetalheController>(); 
			folhaLancamentoDetalheController.folhaLancamentoDetalheModelList = folhaLancamentoCabecalhoModel.folhaLancamentoDetalheModelList!; 
			folhaLancamentoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.folhaLancamentoCabecalhoTabPage)!.then((value) {
				if (folhaLancamentoCabecalhoModel.id == 0) {
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
		folhaLancamentoCabecalhoModel = FolhaLancamentoCabecalhoModel();
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
				if (await folhaLancamentoCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_folhaLancamentoCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final competenciaController = TextEditingController();

	final folhaLancamentoCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final folhaLancamentoCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final folhaLancamentoCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaLancamentoCabecalhoModel.id;
		plutoRow.cells['idColaborador']?.value = folhaLancamentoCabecalhoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaLancamentoCabecalhoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['competencia']?.value = folhaLancamentoCabecalhoModel.competencia;
		plutoRow.cells['tipo']?.value = folhaLancamentoCabecalhoModel.tipo;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await folhaLancamentoCabecalhoRepository.save(folhaLancamentoCabecalhoModel: folhaLancamentoCabecalhoModel); 
				if (result != null) {
					folhaLancamentoCabecalhoModel = result;
					if (_isInserting) {
						_folhaLancamentoCabecalhoModelList.add(folhaLancamentoCabecalhoModel);
						_isInserting = false;
					} else {
            _folhaLancamentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _folhaLancamentoCabecalhoModelList.add(folhaLancamentoCabecalhoModel);
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
		Get.find<FolhaLancamentoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_folhaLancamentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_folhaLancamentoCabecalhoModelList.add(_folhaLancamentoCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(folhaLancamentoCabecalhoModel.viewPessoaColaboradorModel?.nome); 
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
			folhaLancamentoCabecalhoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaLancamentoCabecalhoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaLancamentoCabecalhoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "folha_lancamento_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaColaboradorModelController.dispose();
		competenciaController.dispose();
		super.onClose();
	}
}