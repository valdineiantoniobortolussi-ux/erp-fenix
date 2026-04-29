import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/controller/controller_imports.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:pcp/app/page/grid_columns/grid_columns_imports.dart';
import 'package:pcp/app/page/page_imports.dart';

import 'package:pcp/app/routes/app_routes.dart';
import 'package:pcp/app/data/repository/pcp_op_cabecalho_repository.dart';
import 'package:pcp/app/page/shared_page/shared_page_imports.dart';
import 'package:pcp/app/page/shared_widget/message_dialog.dart';
import 'package:pcp/app/mixin/controller_base_mixin.dart';

class PcpOpCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final PcpOpCabecalhoRepository pcpOpCabecalhoRepository;
	PcpOpCabecalhoController({required this.pcpOpCabecalhoRepository});

	// general
	final _dbColumns = PcpOpCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PcpOpCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = pcpOpCabecalhoGridColumns();
	
	var _pcpOpCabecalhoModelList = <PcpOpCabecalhoModel>[];

	var _pcpOpCabecalhoModelOld = PcpOpCabecalhoModel();

	final _pcpOpCabecalhoModel = PcpOpCabecalhoModel().obs;
	PcpOpCabecalhoModel get pcpOpCabecalhoModel => _pcpOpCabecalhoModel.value;
	set pcpOpCabecalhoModel(value) => _pcpOpCabecalhoModel.value = value ?? PcpOpCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Ordem de Produção', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Instruções', 
		),
	];

	List<Widget> tabPages() {
		return [
			PcpOpCabecalhoEditPage(),
			const PcpOpDetalheListPage(),
			const PcpInstrucaoOpListPage(),
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
		for (var pcpOpCabecalhoModel in _pcpOpCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(pcpOpCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PcpOpCabecalhoModel pcpOpCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pcpOpCabecalhoModel: pcpOpCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PcpOpCabecalhoModel? pcpOpCabecalhoModel}) {
		return {
			"id": PlutoCell(value: pcpOpCabecalhoModel?.id ?? 0),
			"dataInicio": PlutoCell(value: pcpOpCabecalhoModel?.dataInicio ?? ''),
			"dataPrevisaoEntrega": PlutoCell(value: pcpOpCabecalhoModel?.dataPrevisaoEntrega ?? ''),
			"dataTermino": PlutoCell(value: pcpOpCabecalhoModel?.dataTermino ?? ''),
			"custoTotalPrevisto": PlutoCell(value: pcpOpCabecalhoModel?.custoTotalPrevisto ?? 0),
			"custoTotalRealizado": PlutoCell(value: pcpOpCabecalhoModel?.custoTotalRealizado ?? 0),
			"porcentoVenda": PlutoCell(value: pcpOpCabecalhoModel?.porcentoVenda ?? 0),
			"porcentoEstoque": PlutoCell(value: pcpOpCabecalhoModel?.porcentoEstoque ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _pcpOpCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			pcpOpCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			pcpOpCabecalhoModel = modelFromRow[0];
			_pcpOpCabecalhoModelOld = pcpOpCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Ordem de Produção]';
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
		await Get.find<PcpOpCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await pcpOpCabecalhoRepository.getList(filter: filter).then( (data){ _pcpOpCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Ordem de Produção',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			custoTotalPrevistoController.text = currentRow.cells['custoTotalPrevisto']?.value?.toStringAsFixed(2) ?? '';
			custoTotalRealizadoController.text = currentRow.cells['custoTotalRealizado']?.value?.toStringAsFixed(2) ?? '';
			porcentoVendaController.text = currentRow.cells['porcentoVenda']?.value?.toStringAsFixed(2) ?? '';
			porcentoEstoqueController.text = currentRow.cells['porcentoEstoque']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens
			Get.put<PcpOpDetalheController>(PcpOpDetalheController()); 
			final pcpOpDetalheController = Get.find<PcpOpDetalheController>(); 
			pcpOpDetalheController.pcpOpDetalheModelList = pcpOpCabecalhoModel.pcpOpDetalheModelList!; 
			pcpOpDetalheController.userMadeChanges = false; 

			//Instruções
			Get.put<PcpInstrucaoOpController>(PcpInstrucaoOpController()); 
			final pcpInstrucaoOpController = Get.find<PcpInstrucaoOpController>(); 
			pcpInstrucaoOpController.pcpInstrucaoOpModelList = pcpOpCabecalhoModel.pcpInstrucaoOpModelList!; 
			pcpInstrucaoOpController.userMadeChanges = false; 


			Get.toNamed(Routes.pcpOpCabecalhoTabPage)!.then((value) {
				if (pcpOpCabecalhoModel.id == 0) {
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
		pcpOpCabecalhoModel = PcpOpCabecalhoModel();
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
				if (await pcpOpCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_pcpOpCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final custoTotalPrevistoController = MoneyMaskedTextController();
	final custoTotalRealizadoController = MoneyMaskedTextController();
	final porcentoVendaController = MoneyMaskedTextController();
	final porcentoEstoqueController = MoneyMaskedTextController();

	final pcpOpCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final pcpOpCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final pcpOpCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pcpOpCabecalhoModel.id;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(pcpOpCabecalhoModel.dataInicio);
		plutoRow.cells['dataPrevisaoEntrega']?.value = Util.formatDate(pcpOpCabecalhoModel.dataPrevisaoEntrega);
		plutoRow.cells['dataTermino']?.value = Util.formatDate(pcpOpCabecalhoModel.dataTermino);
		plutoRow.cells['custoTotalPrevisto']?.value = pcpOpCabecalhoModel.custoTotalPrevisto;
		plutoRow.cells['custoTotalRealizado']?.value = pcpOpCabecalhoModel.custoTotalRealizado;
		plutoRow.cells['porcentoVenda']?.value = pcpOpCabecalhoModel.porcentoVenda;
		plutoRow.cells['porcentoEstoque']?.value = pcpOpCabecalhoModel.porcentoEstoque;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await pcpOpCabecalhoRepository.save(pcpOpCabecalhoModel: pcpOpCabecalhoModel); 
				if (result != null) {
					pcpOpCabecalhoModel = result;
					if (_isInserting) {
						_pcpOpCabecalhoModelList.add(pcpOpCabecalhoModel);
						_isInserting = false;
					} else {
            _pcpOpCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _pcpOpCabecalhoModelList.add(pcpOpCabecalhoModel);
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
		Get.find<PcpOpDetalheController>().userMadeChanges
		|| 
		Get.find<PcpInstrucaoOpController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_pcpOpCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_pcpOpCabecalhoModelList.add(_pcpOpCabecalhoModelOld);
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
		functionName = "pcp_op_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		custoTotalPrevistoController.dispose();
		custoTotalRealizadoController.dispose();
		porcentoVendaController.dispose();
		porcentoEstoqueController.dispose();
		super.onClose();
	}
}