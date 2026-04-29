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
import 'package:compras/app/data/repository/compra_cotacao_repository.dart';
import 'package:compras/app/page/shared_page/shared_page_imports.dart';
import 'package:compras/app/page/shared_widget/message_dialog.dart';
import 'package:compras/app/mixin/controller_base_mixin.dart';

class CompraCotacaoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final CompraCotacaoRepository compraCotacaoRepository;
	CompraCotacaoController({required this.compraCotacaoRepository});

	// general
	final _dbColumns = CompraCotacaoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = CompraCotacaoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = compraCotacaoGridColumns();
	
	var _compraCotacaoModelList = <CompraCotacaoModel>[];

	var _compraCotacaoModelOld = CompraCotacaoModel();

	final _compraCotacaoModel = CompraCotacaoModel().obs;
	CompraCotacaoModel get compraCotacaoModel => _compraCotacaoModel.value;
	set compraCotacaoModel(value) => _compraCotacaoModel.value = value ?? CompraCotacaoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Cotação', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Fornecedores', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens Cotação', 
		),
	];

	List<Widget> tabPages() {
		return [
			CompraCotacaoEditPage(),
			const CompraFornecedorCotacaoListPage(),
			const CompraCotacaoDetalheListPage(),
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
		for (var compraCotacaoModel in _compraCotacaoModelList) {
			plutoRowList.add(_getPlutoRow(compraCotacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CompraCotacaoModel compraCotacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(compraCotacaoModel: compraCotacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CompraCotacaoModel? compraCotacaoModel}) {
		return {
			"id": PlutoCell(value: compraCotacaoModel?.id ?? 0),
			"compraRequisicao": PlutoCell(value: compraCotacaoModel?.compraRequisicaoModel?.descricao ?? ''),
			"dataCotacao": PlutoCell(value: compraCotacaoModel?.dataCotacao ?? ''),
			"descricao": PlutoCell(value: compraCotacaoModel?.descricao ?? ''),
			"idCompraRequisicao": PlutoCell(value: compraCotacaoModel?.idCompraRequisicao ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _compraCotacaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			compraCotacaoModel.plutoRowToObject(plutoRow);
		} else {
			compraCotacaoModel = modelFromRow[0];
			_compraCotacaoModelOld = compraCotacaoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Cotação]';
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
		await Get.find<CompraCotacaoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await compraCotacaoRepository.getList(filter: filter).then( (data){ _compraCotacaoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Cotação',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			compraRequisicaoModelController.text = currentRow.cells['compraRequisicao']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Fornecedores
			Get.put<CompraFornecedorCotacaoController>(CompraFornecedorCotacaoController()); 
			final compraFornecedorCotacaoController = Get.find<CompraFornecedorCotacaoController>(); 
			compraFornecedorCotacaoController.compraFornecedorCotacaoModelList = compraCotacaoModel.compraFornecedorCotacaoModelList!; 
			compraFornecedorCotacaoController.userMadeChanges = false; 

			//Itens Cotação
			Get.put<CompraCotacaoDetalheController>(CompraCotacaoDetalheController()); 
			final compraCotacaoDetalheController = Get.find<CompraCotacaoDetalheController>(); 
			compraCotacaoDetalheController.compraCotacaoDetalheModelList = compraCotacaoModel.compraCotacaoDetalheModelList!; 
			compraCotacaoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.compraCotacaoTabPage)!.then((value) {
				if (compraCotacaoModel.id == 0) {
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
		compraCotacaoModel = CompraCotacaoModel();
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
				if (await compraCotacaoRepository.delete(id: currentRow.cells['id']!.value)) {
					_compraCotacaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final compraRequisicaoModelController = TextEditingController();
	final descricaoController = TextEditingController();

	final compraCotacaoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final compraCotacaoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final compraCotacaoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = compraCotacaoModel.id;
		plutoRow.cells['idCompraRequisicao']?.value = compraCotacaoModel.idCompraRequisicao;
		plutoRow.cells['compraRequisicao']?.value = compraCotacaoModel.compraRequisicaoModel?.descricao;
		plutoRow.cells['dataCotacao']?.value = Util.formatDate(compraCotacaoModel.dataCotacao);
		plutoRow.cells['descricao']?.value = compraCotacaoModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await compraCotacaoRepository.save(compraCotacaoModel: compraCotacaoModel); 
				if (result != null) {
					compraCotacaoModel = result;
					if (_isInserting) {
						_compraCotacaoModelList.add(compraCotacaoModel);
						_isInserting = false;
					} else {
            _compraCotacaoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _compraCotacaoModelList.add(compraCotacaoModel);
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
		Get.find<CompraFornecedorCotacaoController>().userMadeChanges
		|| 
		Get.find<CompraCotacaoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_compraCotacaoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_compraCotacaoModelList.add(_compraCotacaoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(compraCotacaoModel.compraRequisicaoModel?.descricao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Requisicao]'); 
			return false; 
		}
		return true;
	}

	Future callCompraRequisicaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Requisicao]'; 
		lookupController.route = '/compra-requisicao/'; 
		lookupController.gridColumns = compraRequisicaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CompraRequisicaoModel.aliasColumns; 
		lookupController.dbColumns = CompraRequisicaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			compraCotacaoModel.idCompraRequisicao = plutoRowResult.cells['id']!.value; 
			compraCotacaoModel.compraRequisicaoModel!.plutoRowToObject(plutoRowResult); 
			compraRequisicaoModelController.text = compraCotacaoModel.compraRequisicaoModel?.descricao ?? ''; 
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
		functionName = "compra_cotacao";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		compraRequisicaoModelController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}