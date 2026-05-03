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
import 'package:contabil/app/data/repository/contabil_lancamento_cabecalho_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilLancamentoCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ContabilLancamentoCabecalhoRepository contabilLancamentoCabecalhoRepository;
	ContabilLancamentoCabecalhoController({required this.contabilLancamentoCabecalhoRepository});

	// general
	final _dbColumns = ContabilLancamentoCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ContabilLancamentoCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = contabilLancamentoCabecalhoGridColumns();
	
	var _contabilLancamentoCabecalhoModelList = <ContabilLancamentoCabecalhoModel>[];

	var _contabilLancamentoCabecalhoModelOld = ContabilLancamentoCabecalhoModel();

	final _contabilLancamentoCabecalhoModel = ContabilLancamentoCabecalhoModel().obs;
	ContabilLancamentoCabecalhoModel get contabilLancamentoCabecalhoModel => _contabilLancamentoCabecalhoModel.value;
	set contabilLancamentoCabecalhoModel(value) => _contabilLancamentoCabecalhoModel.value = value ?? ContabilLancamentoCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Lancamento Contábil', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Detalhes', 
		),
	];

	List<Widget> tabPages() {
		return [
			ContabilLancamentoCabecalhoEditPage(),
			const ContabilLancamentoDetalheListPage(),
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
		for (var contabilLancamentoCabecalhoModel in _contabilLancamentoCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(contabilLancamentoCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilLancamentoCabecalhoModel contabilLancamentoCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilLancamentoCabecalhoModel: contabilLancamentoCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilLancamentoCabecalhoModel? contabilLancamentoCabecalhoModel}) {
		return {
			"id": PlutoCell(value: contabilLancamentoCabecalhoModel?.id ?? 0),
			"contabilLote": PlutoCell(value: contabilLancamentoCabecalhoModel?.contabilLoteModel?.descricao ?? ''),
			"dataLancamento": PlutoCell(value: contabilLancamentoCabecalhoModel?.dataLancamento ?? ''),
			"dataInclusao": PlutoCell(value: contabilLancamentoCabecalhoModel?.dataInclusao ?? ''),
			"tipo": PlutoCell(value: contabilLancamentoCabecalhoModel?.tipo ?? ''),
			"liberado": PlutoCell(value: contabilLancamentoCabecalhoModel?.liberado ?? ''),
			"valor": PlutoCell(value: contabilLancamentoCabecalhoModel?.valor ?? 0),
			"idContabilLote": PlutoCell(value: contabilLancamentoCabecalhoModel?.idContabilLote ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _contabilLancamentoCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			contabilLancamentoCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			contabilLancamentoCabecalhoModel = modelFromRow[0];
			_contabilLancamentoCabecalhoModelOld = contabilLancamentoCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Lancamento Contábil]';
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
		await Get.find<ContabilLancamentoCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await contabilLancamentoCabecalhoRepository.getList(filter: filter).then( (data){ _contabilLancamentoCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Lancamento Contábil',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			contabilLoteModelController.text = currentRow.cells['contabilLote']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Detalhes
			Get.put<ContabilLancamentoDetalheController>(ContabilLancamentoDetalheController()); 
			final contabilLancamentoDetalheController = Get.find<ContabilLancamentoDetalheController>(); 
			contabilLancamentoDetalheController.contabilLancamentoDetalheModelList = contabilLancamentoCabecalhoModel.contabilLancamentoDetalheModelList!; 
			contabilLancamentoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.contabilLancamentoCabecalhoTabPage)!.then((value) {
				if (contabilLancamentoCabecalhoModel.id == 0) {
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
		contabilLancamentoCabecalhoModel = ContabilLancamentoCabecalhoModel();
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
				if (await contabilLancamentoCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_contabilLancamentoCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final contabilLoteModelController = TextEditingController();
	final valorController = MoneyMaskedTextController();

	final contabilLancamentoCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final contabilLancamentoCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final contabilLancamentoCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilLancamentoCabecalhoModel.id;
		plutoRow.cells['idContabilLote']?.value = contabilLancamentoCabecalhoModel.idContabilLote;
		plutoRow.cells['contabilLote']?.value = contabilLancamentoCabecalhoModel.contabilLoteModel?.descricao;
		plutoRow.cells['dataLancamento']?.value = Util.formatDate(contabilLancamentoCabecalhoModel.dataLancamento);
		plutoRow.cells['dataInclusao']?.value = Util.formatDate(contabilLancamentoCabecalhoModel.dataInclusao);
		plutoRow.cells['tipo']?.value = contabilLancamentoCabecalhoModel.tipo;
		plutoRow.cells['liberado']?.value = contabilLancamentoCabecalhoModel.liberado;
		plutoRow.cells['valor']?.value = contabilLancamentoCabecalhoModel.valor;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await contabilLancamentoCabecalhoRepository.save(contabilLancamentoCabecalhoModel: contabilLancamentoCabecalhoModel); 
				if (result != null) {
					contabilLancamentoCabecalhoModel = result;
					if (_isInserting) {
						_contabilLancamentoCabecalhoModelList.add(contabilLancamentoCabecalhoModel);
						_isInserting = false;
					} else {
            _contabilLancamentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _contabilLancamentoCabecalhoModelList.add(contabilLancamentoCabecalhoModel);
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
		Get.find<ContabilLancamentoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_contabilLancamentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_contabilLancamentoCabecalhoModelList.add(_contabilLancamentoCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
		return true;
	}

	Future callContabilLoteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Lote Contábil]'; 
		lookupController.route = '/contabil-lote/'; 
		lookupController.gridColumns = contabilLoteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContabilLoteModel.aliasColumns; 
		lookupController.dbColumns = ContabilLoteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilLancamentoCabecalhoModel.idContabilLote = plutoRowResult.cells['id']!.value; 
			contabilLancamentoCabecalhoModel.contabilLoteModel!.plutoRowToObject(plutoRowResult); 
			contabilLoteModelController.text = contabilLancamentoCabecalhoModel.contabilLoteModel?.descricao ?? ''; 
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
		functionName = "contabil_lancamento_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		contabilLoteModelController.dispose();
		valorController.dispose();
		super.onClose();
	}
}