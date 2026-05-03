import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/controller/controller_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:compras/app/page/grid_columns/grid_columns_imports.dart';
import 'package:compras/app/page/page_imports.dart';

import 'package:compras/app/routes/app_routes.dart';
import 'package:compras/app/data/repository/compra_requisicao_repository.dart';
import 'package:compras/app/page/shared_page/shared_page_imports.dart';
import 'package:compras/app/page/shared_widget/message_dialog.dart';
import 'package:compras/app/mixin/controller_base_mixin.dart';

class CompraRequisicaoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final CompraRequisicaoRepository compraRequisicaoRepository;
	CompraRequisicaoController({required this.compraRequisicaoRepository});

	// general
	final _dbColumns = CompraRequisicaoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = CompraRequisicaoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = compraRequisicaoGridColumns();
	
	var _compraRequisicaoModelList = <CompraRequisicaoModel>[];

	var _compraRequisicaoModelOld = CompraRequisicaoModel();

	final _compraRequisicaoModel = CompraRequisicaoModel().obs;
	CompraRequisicaoModel get compraRequisicaoModel => _compraRequisicaoModel.value;
	set compraRequisicaoModel(value) => _compraRequisicaoModel.value = value ?? CompraRequisicaoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Requisição', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens Requisição', 
		),
	];

	List<Widget> tabPages() {
		return [
			CompraRequisicaoEditPage(),
			const CompraRequisicaoDetalheListPage(),
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
		for (var compraRequisicaoModel in _compraRequisicaoModelList) {
			plutoRowList.add(_getPlutoRow(compraRequisicaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CompraRequisicaoModel compraRequisicaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(compraRequisicaoModel: compraRequisicaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CompraRequisicaoModel? compraRequisicaoModel}) {
		return {
			"id": PlutoCell(value: compraRequisicaoModel?.id ?? 0),
			"compraTipoRequisicao": PlutoCell(value: compraRequisicaoModel?.compraTipoRequisicaoModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: compraRequisicaoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"descricao": PlutoCell(value: compraRequisicaoModel?.descricao ?? ''),
			"dataRequisicao": PlutoCell(value: compraRequisicaoModel?.dataRequisicao ?? ''),
			"observacao": PlutoCell(value: compraRequisicaoModel?.observacao ?? ''),
			"idCompraTipoRequisicao": PlutoCell(value: compraRequisicaoModel?.idCompraTipoRequisicao ?? 0),
			"idColaborador": PlutoCell(value: compraRequisicaoModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _compraRequisicaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			compraRequisicaoModel.plutoRowToObject(plutoRow);
		} else {
			compraRequisicaoModel = modelFromRow[0];
			_compraRequisicaoModelOld = compraRequisicaoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Requisição]';
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
		await Get.find<CompraRequisicaoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await compraRequisicaoRepository.getList(filter: filter).then( (data){ _compraRequisicaoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Requisição',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			compraTipoRequisicaoModelController.text = currentRow.cells['compraTipoRequisicao']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens Requisição
			Get.put<CompraRequisicaoDetalheController>(CompraRequisicaoDetalheController()); 
			final compraRequisicaoDetalheController = Get.find<CompraRequisicaoDetalheController>(); 
			compraRequisicaoDetalheController.compraRequisicaoDetalheModelList = compraRequisicaoModel.compraRequisicaoDetalheModelList!; 
			compraRequisicaoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.compraRequisicaoTabPage)!.then((value) {
				if (compraRequisicaoModel.id == 0) {
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
		compraRequisicaoModel = CompraRequisicaoModel();
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
				if (await compraRequisicaoRepository.delete(id: currentRow.cells['id']!.value)) {
					_compraRequisicaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final compraTipoRequisicaoModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final descricaoController = TextEditingController();
	final observacaoController = TextEditingController();

	final compraRequisicaoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final compraRequisicaoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final compraRequisicaoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = compraRequisicaoModel.id;
		plutoRow.cells['idCompraTipoRequisicao']?.value = compraRequisicaoModel.idCompraTipoRequisicao;
		plutoRow.cells['compraTipoRequisicao']?.value = compraRequisicaoModel.compraTipoRequisicaoModel?.nome;
		plutoRow.cells['idColaborador']?.value = compraRequisicaoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = compraRequisicaoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['descricao']?.value = compraRequisicaoModel.descricao;
		plutoRow.cells['dataRequisicao']?.value = Util.formatDate(compraRequisicaoModel.dataRequisicao);
		plutoRow.cells['observacao']?.value = compraRequisicaoModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await compraRequisicaoRepository.save(compraRequisicaoModel: compraRequisicaoModel); 
				if (result != null) {
					compraRequisicaoModel = result;
					if (_isInserting) {
						_compraRequisicaoModelList.add(compraRequisicaoModel);
						_isInserting = false;
					} else {
            _compraRequisicaoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _compraRequisicaoModelList.add(compraRequisicaoModel);
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
		Get.find<CompraRequisicaoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_compraRequisicaoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_compraRequisicaoModelList.add(_compraRequisicaoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(compraRequisicaoModel.compraTipoRequisicaoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Tipo Requisicao]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(compraRequisicaoModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
		return true;
	}

	Future callCompraTipoRequisicaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Requisicao]'; 
		lookupController.route = '/compra-tipo-requisicao/'; 
		lookupController.gridColumns = compraTipoRequisicaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CompraTipoRequisicaoModel.aliasColumns; 
		lookupController.dbColumns = CompraTipoRequisicaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			compraRequisicaoModel.idCompraTipoRequisicao = plutoRowResult.cells['id']!.value; 
			compraRequisicaoModel.compraTipoRequisicaoModel!.plutoRowToObject(plutoRowResult); 
			compraTipoRequisicaoModelController.text = compraRequisicaoModel.compraTipoRequisicaoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
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
			compraRequisicaoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			compraRequisicaoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = compraRequisicaoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "compra_requisicao";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		compraTipoRequisicaoModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		descricaoController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}