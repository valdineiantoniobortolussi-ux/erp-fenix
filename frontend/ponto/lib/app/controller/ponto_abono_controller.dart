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
import 'package:ponto/app/data/repository/ponto_abono_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoAbonoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final PontoAbonoRepository pontoAbonoRepository;
	PontoAbonoController({required this.pontoAbonoRepository});

	// general
	final _dbColumns = PontoAbonoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PontoAbonoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = pontoAbonoGridColumns();
	
	var _pontoAbonoModelList = <PontoAbonoModel>[];

	var _pontoAbonoModelOld = PontoAbonoModel();

	final _pontoAbonoModel = PontoAbonoModel().obs;
	PontoAbonoModel get pontoAbonoModel => _pontoAbonoModel.value;
	set pontoAbonoModel(value) => _pontoAbonoModel.value = value ?? PontoAbonoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Abonos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Utilização', 
		),
	];

	List<Widget> tabPages() {
		return [
			PontoAbonoEditPage(),
			const PontoAbonoUtilizacaoListPage(),
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
		for (var pontoAbonoModel in _pontoAbonoModelList) {
			plutoRowList.add(_getPlutoRow(pontoAbonoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PontoAbonoModel pontoAbonoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pontoAbonoModel: pontoAbonoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PontoAbonoModel? pontoAbonoModel}) {
		return {
			"id": PlutoCell(value: pontoAbonoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: pontoAbonoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"quantidade": PlutoCell(value: pontoAbonoModel?.quantidade ?? 0),
			"utilizado": PlutoCell(value: pontoAbonoModel?.utilizado ?? 0),
			"saldo": PlutoCell(value: pontoAbonoModel?.saldo ?? 0),
			"dataCadastro": PlutoCell(value: pontoAbonoModel?.dataCadastro ?? ''),
			"inicioUtilizacao": PlutoCell(value: pontoAbonoModel?.inicioUtilizacao ?? ''),
			"dataValidade": PlutoCell(value: pontoAbonoModel?.dataValidade ?? ''),
			"observacao": PlutoCell(value: pontoAbonoModel?.observacao ?? ''),
			"idColaborador": PlutoCell(value: pontoAbonoModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _pontoAbonoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			pontoAbonoModel.plutoRowToObject(plutoRow);
		} else {
			pontoAbonoModel = modelFromRow[0];
			_pontoAbonoModelOld = pontoAbonoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Abonos]';
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
		await Get.find<PontoAbonoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await pontoAbonoRepository.getList(filter: filter).then( (data){ _pontoAbonoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Abonos',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';
			utilizadoController.text = currentRow.cells['utilizado']?.value?.toString() ?? '';
			saldoController.text = currentRow.cells['saldo']?.value?.toString() ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Utilização
			Get.put<PontoAbonoUtilizacaoController>(PontoAbonoUtilizacaoController()); 
			final pontoAbonoUtilizacaoController = Get.find<PontoAbonoUtilizacaoController>(); 
			pontoAbonoUtilizacaoController.pontoAbonoUtilizacaoModelList = pontoAbonoModel.pontoAbonoUtilizacaoModelList!; 
			pontoAbonoUtilizacaoController.userMadeChanges = false; 


			Get.toNamed(Routes.pontoAbonoTabPage)!.then((value) {
				if (pontoAbonoModel.id == 0) {
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
		pontoAbonoModel = PontoAbonoModel();
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
				if (await pontoAbonoRepository.delete(id: currentRow.cells['id']!.value)) {
					_pontoAbonoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final utilizadoController = TextEditingController();
	final saldoController = TextEditingController();
	final observacaoController = TextEditingController();

	final pontoAbonoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final pontoAbonoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final pontoAbonoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoAbonoModel.id;
		plutoRow.cells['idColaborador']?.value = pontoAbonoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = pontoAbonoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['quantidade']?.value = pontoAbonoModel.quantidade;
		plutoRow.cells['utilizado']?.value = pontoAbonoModel.utilizado;
		plutoRow.cells['saldo']?.value = pontoAbonoModel.saldo;
		plutoRow.cells['dataCadastro']?.value = Util.formatDate(pontoAbonoModel.dataCadastro);
		plutoRow.cells['inicioUtilizacao']?.value = Util.formatDate(pontoAbonoModel.inicioUtilizacao);
		plutoRow.cells['dataValidade']?.value = Util.formatDate(pontoAbonoModel.dataValidade);
		plutoRow.cells['observacao']?.value = pontoAbonoModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await pontoAbonoRepository.save(pontoAbonoModel: pontoAbonoModel); 
				if (result != null) {
					pontoAbonoModel = result;
					if (_isInserting) {
						_pontoAbonoModelList.add(pontoAbonoModel);
						_isInserting = false;
					} else {
            _pontoAbonoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _pontoAbonoModelList.add(pontoAbonoModel);
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
		Get.find<PontoAbonoUtilizacaoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_pontoAbonoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_pontoAbonoModelList.add(_pontoAbonoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(pontoAbonoModel.viewPessoaColaboradorModel?.nome); 
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
			pontoAbonoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			pontoAbonoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = pontoAbonoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "ponto_abono";
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
		utilizadoController.dispose();
		saldoController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}