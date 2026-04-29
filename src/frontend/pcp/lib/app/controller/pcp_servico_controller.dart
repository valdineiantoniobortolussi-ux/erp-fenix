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
import 'package:pcp/app/data/repository/pcp_servico_repository.dart';
import 'package:pcp/app/page/shared_page/shared_page_imports.dart';
import 'package:pcp/app/page/shared_widget/message_dialog.dart';
import 'package:pcp/app/mixin/controller_base_mixin.dart';

class PcpServicoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final PcpServicoRepository pcpServicoRepository;
	PcpServicoController({required this.pcpServicoRepository});

	// general
	final _dbColumns = PcpServicoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PcpServicoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = pcpServicoGridColumns();
	
	var _pcpServicoModelList = <PcpServicoModel>[];

	var _pcpServicoModelOld = PcpServicoModel();

	final _pcpServicoModel = PcpServicoModel().obs;
	PcpServicoModel get pcpServicoModel => _pcpServicoModel.value;
	set pcpServicoModel(value) => _pcpServicoModel.value = value ?? PcpServicoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Serviços', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Colaboradores', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Equipamentos', 
		),
	];

	List<Widget> tabPages() {
		return [
			PcpServicoEditPage(),
			const PcpServicoColaboradorListPage(),
			const PcpServicoEquipamentoListPage(),
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
		for (var pcpServicoModel in _pcpServicoModelList) {
			plutoRowList.add(_getPlutoRow(pcpServicoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PcpServicoModel pcpServicoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pcpServicoModel: pcpServicoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PcpServicoModel? pcpServicoModel}) {
		return {
			"id": PlutoCell(value: pcpServicoModel?.id ?? 0),
			"pcpOpDetalhe": PlutoCell(value: pcpServicoModel?.pcpOpDetalheModel?.id ?? ''),
			"inicioRealizado": PlutoCell(value: pcpServicoModel?.inicioRealizado ?? ''),
			"terminoRealizado": PlutoCell(value: pcpServicoModel?.terminoRealizado ?? ''),
			"horasRealizado": PlutoCell(value: pcpServicoModel?.horasRealizado ?? 0),
			"minutosRealizado": PlutoCell(value: pcpServicoModel?.minutosRealizado ?? 0),
			"segundosRealizado": PlutoCell(value: pcpServicoModel?.segundosRealizado ?? 0),
			"custoRealizado": PlutoCell(value: pcpServicoModel?.custoRealizado ?? 0),
			"inicioPrevisto": PlutoCell(value: pcpServicoModel?.inicioPrevisto ?? ''),
			"terminoPrevisto": PlutoCell(value: pcpServicoModel?.terminoPrevisto ?? ''),
			"horasPrevisto": PlutoCell(value: pcpServicoModel?.horasPrevisto ?? 0),
			"minutosPrevisto": PlutoCell(value: pcpServicoModel?.minutosPrevisto ?? 0),
			"segundosPrevisto": PlutoCell(value: pcpServicoModel?.segundosPrevisto ?? 0),
			"custoPrevisto": PlutoCell(value: pcpServicoModel?.custoPrevisto ?? 0),
			"idPcpOpDetalhe": PlutoCell(value: pcpServicoModel?.idPcpOpDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _pcpServicoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			pcpServicoModel.plutoRowToObject(plutoRow);
		} else {
			pcpServicoModel = modelFromRow[0];
			_pcpServicoModelOld = pcpServicoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Serviços]';
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
		await Get.find<PcpServicoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await pcpServicoRepository.getList(filter: filter).then( (data){ _pcpServicoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Serviços',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			pcpOpDetalheModelController.text = currentRow.cells['pcpOpDetalhe']?.value ?? '';
			horasRealizadoController.text = currentRow.cells['horasRealizado']?.value?.toString() ?? '';
			minutosRealizadoController.text = currentRow.cells['minutosRealizado']?.value?.toString() ?? '';
			segundosRealizadoController.text = currentRow.cells['segundosRealizado']?.value?.toString() ?? '';
			custoRealizadoController.text = currentRow.cells['custoRealizado']?.value?.toStringAsFixed(2) ?? '';
			horasPrevistoController.text = currentRow.cells['horasPrevisto']?.value?.toString() ?? '';
			minutosPrevistoController.text = currentRow.cells['minutosPrevisto']?.value?.toString() ?? '';
			segundosPrevistoController.text = currentRow.cells['segundosPrevisto']?.value?.toString() ?? '';
			custoPrevistoController.text = currentRow.cells['custoPrevisto']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Colaboradores
			Get.put<PcpServicoColaboradorController>(PcpServicoColaboradorController()); 
			final pcpServicoColaboradorController = Get.find<PcpServicoColaboradorController>(); 
			pcpServicoColaboradorController.pcpServicoColaboradorModelList = pcpServicoModel.pcpServicoColaboradorModelList!; 
			pcpServicoColaboradorController.userMadeChanges = false; 

			//Equipamentos
			Get.put<PcpServicoEquipamentoController>(PcpServicoEquipamentoController()); 
			final pcpServicoEquipamentoController = Get.find<PcpServicoEquipamentoController>(); 
			pcpServicoEquipamentoController.pcpServicoEquipamentoModelList = pcpServicoModel.pcpServicoEquipamentoModelList!; 
			pcpServicoEquipamentoController.userMadeChanges = false; 


			Get.toNamed(Routes.pcpServicoTabPage)!.then((value) {
				if (pcpServicoModel.id == 0) {
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
		pcpServicoModel = PcpServicoModel();
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
				if (await pcpServicoRepository.delete(id: currentRow.cells['id']!.value)) {
					_pcpServicoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final pcpOpDetalheModelController = TextEditingController();
	final horasRealizadoController = TextEditingController();
	final minutosRealizadoController = TextEditingController();
	final segundosRealizadoController = TextEditingController();
	final custoRealizadoController = MoneyMaskedTextController();
	final horasPrevistoController = TextEditingController();
	final minutosPrevistoController = TextEditingController();
	final segundosPrevistoController = TextEditingController();
	final custoPrevistoController = MoneyMaskedTextController();

	final pcpServicoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final pcpServicoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final pcpServicoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pcpServicoModel.id;
		plutoRow.cells['idPcpOpDetalhe']?.value = pcpServicoModel.idPcpOpDetalhe;
		plutoRow.cells['pcpOpDetalhe']?.value = pcpServicoModel.pcpOpDetalheModel?.id;
		plutoRow.cells['inicioRealizado']?.value = Util.formatDate(pcpServicoModel.inicioRealizado);
		plutoRow.cells['terminoRealizado']?.value = Util.formatDate(pcpServicoModel.terminoRealizado);
		plutoRow.cells['horasRealizado']?.value = pcpServicoModel.horasRealizado;
		plutoRow.cells['minutosRealizado']?.value = pcpServicoModel.minutosRealizado;
		plutoRow.cells['segundosRealizado']?.value = pcpServicoModel.segundosRealizado;
		plutoRow.cells['custoRealizado']?.value = pcpServicoModel.custoRealizado;
		plutoRow.cells['inicioPrevisto']?.value = Util.formatDate(pcpServicoModel.inicioPrevisto);
		plutoRow.cells['terminoPrevisto']?.value = Util.formatDate(pcpServicoModel.terminoPrevisto);
		plutoRow.cells['horasPrevisto']?.value = pcpServicoModel.horasPrevisto;
		plutoRow.cells['minutosPrevisto']?.value = pcpServicoModel.minutosPrevisto;
		plutoRow.cells['segundosPrevisto']?.value = pcpServicoModel.segundosPrevisto;
		plutoRow.cells['custoPrevisto']?.value = pcpServicoModel.custoPrevisto;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await pcpServicoRepository.save(pcpServicoModel: pcpServicoModel); 
				if (result != null) {
					pcpServicoModel = result;
					if (_isInserting) {
						_pcpServicoModelList.add(pcpServicoModel);
						_isInserting = false;
					} else {
            _pcpServicoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _pcpServicoModelList.add(pcpServicoModel);
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
		Get.find<PcpServicoColaboradorController>().userMadeChanges
		|| 
		Get.find<PcpServicoEquipamentoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_pcpServicoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_pcpServicoModelList.add(_pcpServicoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(pcpServicoModel.pcpOpDetalheModel?.id); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Item da OP]'); 
			return false; 
		}
		return true;
	}

	Future callPcpOpDetalheLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Item da OP]'; 
		lookupController.route = '/pcp-op-detalhe/'; 
		lookupController.gridColumns = pcpOpDetalheGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PcpOpDetalheModel.aliasColumns; 
		lookupController.dbColumns = PcpOpDetalheModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pcpServicoModel.idPcpOpDetalhe = plutoRowResult.cells['id']!.value; 
			pcpServicoModel.pcpOpDetalheModel!.plutoRowToObject(plutoRowResult); 
			pcpOpDetalheModelController.text = pcpServicoModel.pcpOpDetalheModel?.id?.toString() ?? ''; 
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
		functionName = "pcp_servico";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		pcpOpDetalheModelController.dispose();
		horasRealizadoController.dispose();
		minutosRealizadoController.dispose();
		segundosRealizadoController.dispose();
		custoRealizadoController.dispose();
		horasPrevistoController.dispose();
		minutosPrevistoController.dispose();
		segundosPrevistoController.dispose();
		custoPrevistoController.dispose();
		super.onClose();
	}
}