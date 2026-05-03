import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/controller/controller_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:vendas/app/page/page_imports.dart';

import 'package:vendas/app/routes/app_routes.dart';
import 'package:vendas/app/data/repository/venda_condicoes_pagamento_repository.dart';
import 'package:vendas/app/page/shared_page/shared_page_imports.dart';
import 'package:vendas/app/page/shared_widget/message_dialog.dart';
import 'package:vendas/app/mixin/controller_base_mixin.dart';

class VendaCondicoesPagamentoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final VendaCondicoesPagamentoRepository vendaCondicoesPagamentoRepository;
	VendaCondicoesPagamentoController({required this.vendaCondicoesPagamentoRepository});

	// general
	final _dbColumns = VendaCondicoesPagamentoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = VendaCondicoesPagamentoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = vendaCondicoesPagamentoGridColumns();
	
	var _vendaCondicoesPagamentoModelList = <VendaCondicoesPagamentoModel>[];

	var _vendaCondicoesPagamentoModelOld = VendaCondicoesPagamentoModel();

	final _vendaCondicoesPagamentoModel = VendaCondicoesPagamentoModel().obs;
	VendaCondicoesPagamentoModel get vendaCondicoesPagamentoModel => _vendaCondicoesPagamentoModel.value;
	set vendaCondicoesPagamentoModel(value) => _vendaCondicoesPagamentoModel.value = value ?? VendaCondicoesPagamentoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Condições de Pagamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Parcelas', 
		),
	];

	List<Widget> tabPages() {
		return [
			VendaCondicoesPagamentoEditPage(),
			const VendaCondicoesParcelasListPage(),
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
		for (var vendaCondicoesPagamentoModel in _vendaCondicoesPagamentoModelList) {
			plutoRowList.add(_getPlutoRow(vendaCondicoesPagamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(VendaCondicoesPagamentoModel vendaCondicoesPagamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(vendaCondicoesPagamentoModel: vendaCondicoesPagamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ VendaCondicoesPagamentoModel? vendaCondicoesPagamentoModel}) {
		return {
			"id": PlutoCell(value: vendaCondicoesPagamentoModel?.id ?? 0),
			"nome": PlutoCell(value: vendaCondicoesPagamentoModel?.nome ?? ''),
			"descricao": PlutoCell(value: vendaCondicoesPagamentoModel?.descricao ?? ''),
			"faturamentoMinimo": PlutoCell(value: vendaCondicoesPagamentoModel?.faturamentoMinimo ?? 0),
			"faturamentoMaximo": PlutoCell(value: vendaCondicoesPagamentoModel?.faturamentoMaximo ?? 0),
			"indiceCorrecao": PlutoCell(value: vendaCondicoesPagamentoModel?.indiceCorrecao ?? 0),
			"diasTolerancia": PlutoCell(value: vendaCondicoesPagamentoModel?.diasTolerancia ?? 0),
			"valorTolerancia": PlutoCell(value: vendaCondicoesPagamentoModel?.valorTolerancia ?? 0),
			"prazoMedio": PlutoCell(value: vendaCondicoesPagamentoModel?.prazoMedio ?? 0),
			"vistaPrazo": PlutoCell(value: vendaCondicoesPagamentoModel?.vistaPrazo ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _vendaCondicoesPagamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			vendaCondicoesPagamentoModel.plutoRowToObject(plutoRow);
		} else {
			vendaCondicoesPagamentoModel = modelFromRow[0];
			_vendaCondicoesPagamentoModelOld = vendaCondicoesPagamentoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Condições de Pagamento]';
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
		await Get.find<VendaCondicoesPagamentoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await vendaCondicoesPagamentoRepository.getList(filter: filter).then( (data){ _vendaCondicoesPagamentoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Condições de Pagamento',
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
			faturamentoMinimoController.text = currentRow.cells['faturamentoMinimo']?.value?.toStringAsFixed(2) ?? '';
			faturamentoMaximoController.text = currentRow.cells['faturamentoMaximo']?.value?.toStringAsFixed(2) ?? '';
			indiceCorrecaoController.text = currentRow.cells['indiceCorrecao']?.value?.toStringAsFixed(2) ?? '';
			diasToleranciaController.text = currentRow.cells['diasTolerancia']?.value?.toString() ?? '';
			valorToleranciaController.text = currentRow.cells['valorTolerancia']?.value?.toStringAsFixed(2) ?? '';
			prazoMedioController.text = currentRow.cells['prazoMedio']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Parcelas
			Get.put<VendaCondicoesParcelasController>(VendaCondicoesParcelasController()); 
			final vendaCondicoesParcelasController = Get.find<VendaCondicoesParcelasController>(); 
			vendaCondicoesParcelasController.vendaCondicoesParcelasModelList = vendaCondicoesPagamentoModel.vendaCondicoesParcelasModelList!; 
			vendaCondicoesParcelasController.userMadeChanges = false; 


			Get.toNamed(Routes.vendaCondicoesPagamentoTabPage)!.then((value) {
				if (vendaCondicoesPagamentoModel.id == 0) {
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
		vendaCondicoesPagamentoModel = VendaCondicoesPagamentoModel();
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
				if (await vendaCondicoesPagamentoRepository.delete(id: currentRow.cells['id']!.value)) {
					_vendaCondicoesPagamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final faturamentoMinimoController = MoneyMaskedTextController();
	final faturamentoMaximoController = MoneyMaskedTextController();
	final indiceCorrecaoController = MoneyMaskedTextController();
	final diasToleranciaController = TextEditingController();
	final valorToleranciaController = MoneyMaskedTextController();
	final prazoMedioController = TextEditingController();

	final vendaCondicoesPagamentoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final vendaCondicoesPagamentoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final vendaCondicoesPagamentoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = vendaCondicoesPagamentoModel.id;
		plutoRow.cells['nome']?.value = vendaCondicoesPagamentoModel.nome;
		plutoRow.cells['descricao']?.value = vendaCondicoesPagamentoModel.descricao;
		plutoRow.cells['faturamentoMinimo']?.value = vendaCondicoesPagamentoModel.faturamentoMinimo;
		plutoRow.cells['faturamentoMaximo']?.value = vendaCondicoesPagamentoModel.faturamentoMaximo;
		plutoRow.cells['indiceCorrecao']?.value = vendaCondicoesPagamentoModel.indiceCorrecao;
		plutoRow.cells['diasTolerancia']?.value = vendaCondicoesPagamentoModel.diasTolerancia;
		plutoRow.cells['valorTolerancia']?.value = vendaCondicoesPagamentoModel.valorTolerancia;
		plutoRow.cells['prazoMedio']?.value = vendaCondicoesPagamentoModel.prazoMedio;
		plutoRow.cells['vistaPrazo']?.value = vendaCondicoesPagamentoModel.vistaPrazo;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await vendaCondicoesPagamentoRepository.save(vendaCondicoesPagamentoModel: vendaCondicoesPagamentoModel); 
				if (result != null) {
					vendaCondicoesPagamentoModel = result;
					if (_isInserting) {
						_vendaCondicoesPagamentoModelList.add(vendaCondicoesPagamentoModel);
						_isInserting = false;
					} else {
            _vendaCondicoesPagamentoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _vendaCondicoesPagamentoModelList.add(vendaCondicoesPagamentoModel);
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
		Get.find<VendaCondicoesParcelasController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_vendaCondicoesPagamentoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_vendaCondicoesPagamentoModelList.add(_vendaCondicoesPagamentoModelOld);
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
		functionName = "venda_condicoes_pagamento";
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
		faturamentoMinimoController.dispose();
		faturamentoMaximoController.dispose();
		indiceCorrecaoController.dispose();
		diasToleranciaController.dispose();
		valorToleranciaController.dispose();
		prazoMedioController.dispose();
		super.onClose();
	}
}