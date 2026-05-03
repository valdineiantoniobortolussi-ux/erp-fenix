import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/controller/controller_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ponto/app/page/page_imports.dart';

import 'package:ponto/app/routes/app_routes.dart';
import 'package:ponto/app/data/repository/ponto_banco_horas_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoBancoHorasController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final PontoBancoHorasRepository pontoBancoHorasRepository;
	PontoBancoHorasController({required this.pontoBancoHorasRepository});

	// general
	final _dbColumns = PontoBancoHorasModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PontoBancoHorasModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = pontoBancoHorasGridColumns();
	
	var _pontoBancoHorasModelList = <PontoBancoHorasModel>[];

	var _pontoBancoHorasModelOld = PontoBancoHorasModel();

	final _pontoBancoHorasModel = PontoBancoHorasModel().obs;
	PontoBancoHorasModel get pontoBancoHorasModel => _pontoBancoHorasModel.value;
	set pontoBancoHorasModel(value) => _pontoBancoHorasModel.value = value ?? PontoBancoHorasModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Banco de Horas', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Utilização', 
		),
	];

	List<Widget> tabPages() {
		return [
			PontoBancoHorasEditPage(),
			const PontoBancoHorasUtilizacaoListPage(),
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
		for (var pontoBancoHorasModel in _pontoBancoHorasModelList) {
			plutoRowList.add(_getPlutoRow(pontoBancoHorasModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PontoBancoHorasModel pontoBancoHorasModel) {
		return PlutoRow(
			cells: _getPlutoCells(pontoBancoHorasModel: pontoBancoHorasModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PontoBancoHorasModel? pontoBancoHorasModel}) {
		return {
			"id": PlutoCell(value: pontoBancoHorasModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: pontoBancoHorasModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataTrabalho": PlutoCell(value: pontoBancoHorasModel?.dataTrabalho ?? ''),
			"quantidade": PlutoCell(value: pontoBancoHorasModel?.quantidade ?? ''),
			"situacao": PlutoCell(value: pontoBancoHorasModel?.situacao ?? ''),
			"idColaborador": PlutoCell(value: pontoBancoHorasModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _pontoBancoHorasModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			pontoBancoHorasModel.plutoRowToObject(plutoRow);
		} else {
			pontoBancoHorasModel = modelFromRow[0];
			_pontoBancoHorasModelOld = pontoBancoHorasModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Banco de Horas]';
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
		await Get.find<PontoBancoHorasController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await pontoBancoHorasRepository.getList(filter: filter).then( (data){ _pontoBancoHorasModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Banco de Horas',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Utilização
			Get.put<PontoBancoHorasUtilizacaoController>(PontoBancoHorasUtilizacaoController()); 
			final pontoBancoHorasUtilizacaoController = Get.find<PontoBancoHorasUtilizacaoController>(); 
			pontoBancoHorasUtilizacaoController.pontoBancoHorasUtilizacaoModelList = pontoBancoHorasModel.pontoBancoHorasUtilizacaoModelList!; 
			pontoBancoHorasUtilizacaoController.userMadeChanges = false; 


			Get.toNamed(Routes.pontoBancoHorasTabPage)!.then((value) {
				if (pontoBancoHorasModel.id == 0) {
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
		pontoBancoHorasModel = PontoBancoHorasModel();
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
				if (await pontoBancoHorasRepository.delete(id: currentRow.cells['id']!.value)) {
					_pontoBancoHorasModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final quantidadeController = TextEditingController();

	final pontoBancoHorasTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final pontoBancoHorasEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final pontoBancoHorasEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoBancoHorasModel.id;
		plutoRow.cells['idColaborador']?.value = pontoBancoHorasModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = pontoBancoHorasModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataTrabalho']?.value = Util.formatDate(pontoBancoHorasModel.dataTrabalho);
		plutoRow.cells['quantidade']?.value = pontoBancoHorasModel.quantidade;
		plutoRow.cells['situacao']?.value = pontoBancoHorasModel.situacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await pontoBancoHorasRepository.save(pontoBancoHorasModel: pontoBancoHorasModel); 
				if (result != null) {
					pontoBancoHorasModel = result;
					if (_isInserting) {
						_pontoBancoHorasModelList.add(pontoBancoHorasModel);
						_isInserting = false;
					} else {
            _pontoBancoHorasModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _pontoBancoHorasModelList.add(pontoBancoHorasModel);
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
		Get.find<PontoBancoHorasUtilizacaoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_pontoBancoHorasModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_pontoBancoHorasModelList.add(_pontoBancoHorasModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(pontoBancoHorasModel.viewPessoaColaboradorModel?.nome); 
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
			pontoBancoHorasModel.idColaborador = plutoRowResult.cells['id']!.value; 
			pontoBancoHorasModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = pontoBancoHorasModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "ponto_banco_horas";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaColaboradorModelController.dispose();
		quantidadeController.dispose();
		super.onClose();
	}
}