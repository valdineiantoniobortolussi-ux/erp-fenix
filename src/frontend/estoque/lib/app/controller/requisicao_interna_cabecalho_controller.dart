import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/controller/controller_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/page/grid_columns/grid_columns_imports.dart';
import 'package:estoque/app/page/page_imports.dart';

import 'package:estoque/app/routes/app_routes.dart';
import 'package:estoque/app/data/repository/requisicao_interna_cabecalho_repository.dart';
import 'package:estoque/app/page/shared_page/shared_page_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';
import 'package:estoque/app/mixin/controller_base_mixin.dart';

class RequisicaoInternaCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final RequisicaoInternaCabecalhoRepository requisicaoInternaCabecalhoRepository;
	RequisicaoInternaCabecalhoController({required this.requisicaoInternaCabecalhoRepository});

	// general
	final _dbColumns = RequisicaoInternaCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = RequisicaoInternaCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = requisicaoInternaCabecalhoGridColumns();
	
	var _requisicaoInternaCabecalhoModelList = <RequisicaoInternaCabecalhoModel>[];

	var _requisicaoInternaCabecalhoModelOld = RequisicaoInternaCabecalhoModel();

	final _requisicaoInternaCabecalhoModel = RequisicaoInternaCabecalhoModel().obs;
	RequisicaoInternaCabecalhoModel get requisicaoInternaCabecalhoModel => _requisicaoInternaCabecalhoModel.value;
	set requisicaoInternaCabecalhoModel(value) => _requisicaoInternaCabecalhoModel.value = value ?? RequisicaoInternaCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Requisicao Interna', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens Requisicao', 
		),
	];

	List<Widget> tabPages() {
		return [
			RequisicaoInternaCabecalhoEditPage(),
			const RequisicaoInternaDetalheListPage(),
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
		for (var requisicaoInternaCabecalhoModel in _requisicaoInternaCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(requisicaoInternaCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(RequisicaoInternaCabecalhoModel requisicaoInternaCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(requisicaoInternaCabecalhoModel: requisicaoInternaCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ RequisicaoInternaCabecalhoModel? requisicaoInternaCabecalhoModel}) {
		return {
			"id": PlutoCell(value: requisicaoInternaCabecalhoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: requisicaoInternaCabecalhoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataRequisicao": PlutoCell(value: requisicaoInternaCabecalhoModel?.dataRequisicao ?? ''),
			"situacao": PlutoCell(value: requisicaoInternaCabecalhoModel?.situacao ?? ''),
			"idColaborador": PlutoCell(value: requisicaoInternaCabecalhoModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _requisicaoInternaCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			requisicaoInternaCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			requisicaoInternaCabecalhoModel = modelFromRow[0];
			_requisicaoInternaCabecalhoModelOld = requisicaoInternaCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Requisicao Interna]';
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
		await Get.find<RequisicaoInternaCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await requisicaoInternaCabecalhoRepository.getList(filter: filter).then( (data){ _requisicaoInternaCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Requisicao Interna',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens Requisicao
			Get.put<RequisicaoInternaDetalheController>(RequisicaoInternaDetalheController()); 
			final requisicaoInternaDetalheController = Get.find<RequisicaoInternaDetalheController>(); 
			requisicaoInternaDetalheController.requisicaoInternaDetalheModelList = requisicaoInternaCabecalhoModel.requisicaoInternaDetalheModelList!; 
			requisicaoInternaDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.requisicaoInternaCabecalhoTabPage)!.then((value) {
				if (requisicaoInternaCabecalhoModel.id == 0) {
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
		requisicaoInternaCabecalhoModel = RequisicaoInternaCabecalhoModel();
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
				if (await requisicaoInternaCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_requisicaoInternaCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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

	final requisicaoInternaCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final requisicaoInternaCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final requisicaoInternaCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = requisicaoInternaCabecalhoModel.id;
		plutoRow.cells['idColaborador']?.value = requisicaoInternaCabecalhoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = requisicaoInternaCabecalhoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataRequisicao']?.value = Util.formatDate(requisicaoInternaCabecalhoModel.dataRequisicao);
		plutoRow.cells['situacao']?.value = requisicaoInternaCabecalhoModel.situacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await requisicaoInternaCabecalhoRepository.save(requisicaoInternaCabecalhoModel: requisicaoInternaCabecalhoModel); 
				if (result != null) {
					requisicaoInternaCabecalhoModel = result;
					if (_isInserting) {
						_requisicaoInternaCabecalhoModelList.add(requisicaoInternaCabecalhoModel);
						_isInserting = false;
					} else {
            _requisicaoInternaCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _requisicaoInternaCabecalhoModelList.add(requisicaoInternaCabecalhoModel);
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
		Get.find<RequisicaoInternaDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_requisicaoInternaCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_requisicaoInternaCabecalhoModelList.add(_requisicaoInternaCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(requisicaoInternaCabecalhoModel.viewPessoaColaboradorModel?.nome); 
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
			requisicaoInternaCabecalhoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			requisicaoInternaCabecalhoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = requisicaoInternaCabecalhoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "requisicao_interna_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaColaboradorModelController.dispose();
		super.onClose();
	}
}