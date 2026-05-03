import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/controller/controller_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/page/grid_columns/grid_columns_imports.dart';
import 'package:estoque/app/page/page_imports.dart';

import 'package:estoque/app/routes/app_routes.dart';
import 'package:estoque/app/data/repository/estoque_reajuste_cabecalho_repository.dart';
import 'package:estoque/app/page/shared_page/shared_page_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';
import 'package:estoque/app/mixin/controller_base_mixin.dart';

class EstoqueReajusteCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final EstoqueReajusteCabecalhoRepository estoqueReajusteCabecalhoRepository;
	EstoqueReajusteCabecalhoController({required this.estoqueReajusteCabecalhoRepository});

	// general
	final _dbColumns = EstoqueReajusteCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = EstoqueReajusteCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = estoqueReajusteCabecalhoGridColumns();
	
	var _estoqueReajusteCabecalhoModelList = <EstoqueReajusteCabecalhoModel>[];

	var _estoqueReajusteCabecalhoModelOld = EstoqueReajusteCabecalhoModel();

	final _estoqueReajusteCabecalhoModel = EstoqueReajusteCabecalhoModel().obs;
	EstoqueReajusteCabecalhoModel get estoqueReajusteCabecalhoModel => _estoqueReajusteCabecalhoModel.value;
	set estoqueReajusteCabecalhoModel(value) => _estoqueReajusteCabecalhoModel.value = value ?? EstoqueReajusteCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Reajuste de Preços', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens do Reajuste', 
		),
	];

	List<Widget> tabPages() {
		return [
			EstoqueReajusteCabecalhoEditPage(),
			const EstoqueReajusteDetalheListPage(),
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
		for (var estoqueReajusteCabecalhoModel in _estoqueReajusteCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(estoqueReajusteCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(EstoqueReajusteCabecalhoModel estoqueReajusteCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(estoqueReajusteCabecalhoModel: estoqueReajusteCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ EstoqueReajusteCabecalhoModel? estoqueReajusteCabecalhoModel}) {
		return {
			"id": PlutoCell(value: estoqueReajusteCabecalhoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: estoqueReajusteCabecalhoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataReajuste": PlutoCell(value: estoqueReajusteCabecalhoModel?.dataReajuste ?? ''),
			"taxa": PlutoCell(value: estoqueReajusteCabecalhoModel?.taxa ?? 0),
			"tipoReajuste": PlutoCell(value: estoqueReajusteCabecalhoModel?.tipoReajuste ?? ''),
			"justificativa": PlutoCell(value: estoqueReajusteCabecalhoModel?.justificativa ?? ''),
			"idColaborador": PlutoCell(value: estoqueReajusteCabecalhoModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _estoqueReajusteCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			estoqueReajusteCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			estoqueReajusteCabecalhoModel = modelFromRow[0];
			_estoqueReajusteCabecalhoModelOld = estoqueReajusteCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Reajuste de Preços]';
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
		await Get.find<EstoqueReajusteCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await estoqueReajusteCabecalhoRepository.getList(filter: filter).then( (data){ _estoqueReajusteCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Reajuste de Preços',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			taxaController.text = currentRow.cells['taxa']?.value?.toStringAsFixed(2) ?? '';
			justificativaController.text = currentRow.cells['justificativa']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens do Reajuste
			Get.put<EstoqueReajusteDetalheController>(EstoqueReajusteDetalheController()); 
			final estoqueReajusteDetalheController = Get.find<EstoqueReajusteDetalheController>(); 
			estoqueReajusteDetalheController.estoqueReajusteDetalheModelList = estoqueReajusteCabecalhoModel.estoqueReajusteDetalheModelList!; 
			estoqueReajusteDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.estoqueReajusteCabecalhoTabPage)!.then((value) {
				if (estoqueReajusteCabecalhoModel.id == 0) {
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
		estoqueReajusteCabecalhoModel = EstoqueReajusteCabecalhoModel();
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
				if (await estoqueReajusteCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_estoqueReajusteCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final taxaController = MoneyMaskedTextController();
	final justificativaController = TextEditingController();

	final estoqueReajusteCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final estoqueReajusteCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final estoqueReajusteCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = estoqueReajusteCabecalhoModel.id;
		plutoRow.cells['idColaborador']?.value = estoqueReajusteCabecalhoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = estoqueReajusteCabecalhoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataReajuste']?.value = Util.formatDate(estoqueReajusteCabecalhoModel.dataReajuste);
		plutoRow.cells['taxa']?.value = estoqueReajusteCabecalhoModel.taxa;
		plutoRow.cells['tipoReajuste']?.value = estoqueReajusteCabecalhoModel.tipoReajuste;
		plutoRow.cells['justificativa']?.value = estoqueReajusteCabecalhoModel.justificativa;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await estoqueReajusteCabecalhoRepository.save(estoqueReajusteCabecalhoModel: estoqueReajusteCabecalhoModel); 
				if (result != null) {
					estoqueReajusteCabecalhoModel = result;
					if (_isInserting) {
						_estoqueReajusteCabecalhoModelList.add(estoqueReajusteCabecalhoModel);
						_isInserting = false;
					} else {
            _estoqueReajusteCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _estoqueReajusteCabecalhoModelList.add(estoqueReajusteCabecalhoModel);
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
		Get.find<EstoqueReajusteDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_estoqueReajusteCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_estoqueReajusteCabecalhoModelList.add(_estoqueReajusteCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(estoqueReajusteCabecalhoModel.viewPessoaColaboradorModel?.nome); 
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
			estoqueReajusteCabecalhoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			estoqueReajusteCabecalhoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = estoqueReajusteCabecalhoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "estoque_reajuste_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaColaboradorModelController.dispose();
		taxaController.dispose();
		justificativaController.dispose();
		super.onClose();
	}
}