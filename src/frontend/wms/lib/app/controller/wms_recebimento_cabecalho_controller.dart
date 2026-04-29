import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/controller/controller_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/page/grid_columns/grid_columns_imports.dart';
import 'package:wms/app/page/page_imports.dart';

import 'package:wms/app/routes/app_routes.dart';
import 'package:wms/app/data/repository/wms_recebimento_cabecalho_repository.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';
import 'package:wms/app/mixin/controller_base_mixin.dart';

class WmsRecebimentoCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final WmsRecebimentoCabecalhoRepository wmsRecebimentoCabecalhoRepository;
	WmsRecebimentoCabecalhoController({required this.wmsRecebimentoCabecalhoRepository});

	// general
	final _dbColumns = WmsRecebimentoCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = WmsRecebimentoCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = wmsRecebimentoCabecalhoGridColumns();
	
	var _wmsRecebimentoCabecalhoModelList = <WmsRecebimentoCabecalhoModel>[];

	var _wmsRecebimentoCabecalhoModelOld = WmsRecebimentoCabecalhoModel();

	final _wmsRecebimentoCabecalhoModel = WmsRecebimentoCabecalhoModel().obs;
	WmsRecebimentoCabecalhoModel get wmsRecebimentoCabecalhoModel => _wmsRecebimentoCabecalhoModel.value;
	set wmsRecebimentoCabecalhoModel(value) => _wmsRecebimentoCabecalhoModel.value = value ?? WmsRecebimentoCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Recebimento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Itens', 
		),
	];

	List<Widget> tabPages() {
		return [
			WmsRecebimentoCabecalhoEditPage(),
			const WmsRecebimentoDetalheListPage(),
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
		for (var wmsRecebimentoCabecalhoModel in _wmsRecebimentoCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(wmsRecebimentoCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(WmsRecebimentoCabecalhoModel wmsRecebimentoCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(wmsRecebimentoCabecalhoModel: wmsRecebimentoCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ WmsRecebimentoCabecalhoModel? wmsRecebimentoCabecalhoModel}) {
		return {
			"id": PlutoCell(value: wmsRecebimentoCabecalhoModel?.id ?? 0),
			"wmsAgendamento": PlutoCell(value: wmsRecebimentoCabecalhoModel?.wmsAgendamentoModel?.local_operacao ?? ''),
			"dataRecebimento": PlutoCell(value: wmsRecebimentoCabecalhoModel?.dataRecebimento ?? ''),
			"horaInicio": PlutoCell(value: wmsRecebimentoCabecalhoModel?.horaInicio ?? ''),
			"horaFim": PlutoCell(value: wmsRecebimentoCabecalhoModel?.horaFim ?? ''),
			"volumeRecebido": PlutoCell(value: wmsRecebimentoCabecalhoModel?.volumeRecebido ?? 0),
			"pesoRecebido": PlutoCell(value: wmsRecebimentoCabecalhoModel?.pesoRecebido ?? 0),
			"inconsistencia": PlutoCell(value: wmsRecebimentoCabecalhoModel?.inconsistencia ?? ''),
			"observacao": PlutoCell(value: wmsRecebimentoCabecalhoModel?.observacao ?? ''),
			"idWmsAgendamento": PlutoCell(value: wmsRecebimentoCabecalhoModel?.idWmsAgendamento ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _wmsRecebimentoCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			wmsRecebimentoCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			wmsRecebimentoCabecalhoModel = modelFromRow[0];
			_wmsRecebimentoCabecalhoModelOld = wmsRecebimentoCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Recebimento]';
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
		await Get.find<WmsRecebimentoCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await wmsRecebimentoCabecalhoRepository.getList(filter: filter).then( (data){ _wmsRecebimentoCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Recebimento',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			wmsAgendamentoModelController.text = currentRow.cells['wmsAgendamento']?.value ?? '';
			horaInicioController.text = currentRow.cells['horaInicio']?.value ?? '';
			horaFimController.text = currentRow.cells['horaFim']?.value ?? '';
			volumeRecebidoController.text = currentRow.cells['volumeRecebido']?.value?.toString() ?? '';
			pesoRecebidoController.text = currentRow.cells['pesoRecebido']?.value?.toStringAsFixed(2) ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Itens
			Get.put<WmsRecebimentoDetalheController>(WmsRecebimentoDetalheController()); 
			final wmsRecebimentoDetalheController = Get.find<WmsRecebimentoDetalheController>(); 
			wmsRecebimentoDetalheController.wmsRecebimentoDetalheModelList = wmsRecebimentoCabecalhoModel.wmsRecebimentoDetalheModelList!; 
			wmsRecebimentoDetalheController.userMadeChanges = false; 


			Get.toNamed(Routes.wmsRecebimentoCabecalhoTabPage)!.then((value) {
				if (wmsRecebimentoCabecalhoModel.id == 0) {
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
		wmsRecebimentoCabecalhoModel = WmsRecebimentoCabecalhoModel();
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
				if (await wmsRecebimentoCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_wmsRecebimentoCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final wmsAgendamentoModelController = TextEditingController();
	final horaInicioController = MaskedTextController(mask: '00:00:00',);
	final horaFimController = MaskedTextController(mask: '00:00:00',);
	final volumeRecebidoController = TextEditingController();
	final pesoRecebidoController = MoneyMaskedTextController();
	final observacaoController = TextEditingController();

	final wmsRecebimentoCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final wmsRecebimentoCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final wmsRecebimentoCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsRecebimentoCabecalhoModel.id;
		plutoRow.cells['idWmsAgendamento']?.value = wmsRecebimentoCabecalhoModel.idWmsAgendamento;
		plutoRow.cells['wmsAgendamento']?.value = wmsRecebimentoCabecalhoModel.wmsAgendamentoModel?.local_operacao;
		plutoRow.cells['dataRecebimento']?.value = Util.formatDate(wmsRecebimentoCabecalhoModel.dataRecebimento);
		plutoRow.cells['horaInicio']?.value = wmsRecebimentoCabecalhoModel.horaInicio;
		plutoRow.cells['horaFim']?.value = wmsRecebimentoCabecalhoModel.horaFim;
		plutoRow.cells['volumeRecebido']?.value = wmsRecebimentoCabecalhoModel.volumeRecebido;
		plutoRow.cells['pesoRecebido']?.value = wmsRecebimentoCabecalhoModel.pesoRecebido;
		plutoRow.cells['inconsistencia']?.value = wmsRecebimentoCabecalhoModel.inconsistencia;
		plutoRow.cells['observacao']?.value = wmsRecebimentoCabecalhoModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await wmsRecebimentoCabecalhoRepository.save(wmsRecebimentoCabecalhoModel: wmsRecebimentoCabecalhoModel); 
				if (result != null) {
					wmsRecebimentoCabecalhoModel = result;
					if (_isInserting) {
						_wmsRecebimentoCabecalhoModelList.add(wmsRecebimentoCabecalhoModel);
						_isInserting = false;
					} else {
            _wmsRecebimentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _wmsRecebimentoCabecalhoModelList.add(wmsRecebimentoCabecalhoModel);
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
		Get.find<WmsRecebimentoDetalheController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_wmsRecebimentoCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_wmsRecebimentoCabecalhoModelList.add(_wmsRecebimentoCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(wmsRecebimentoCabecalhoModel.wmsAgendamentoModel?.local_operacao); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Agendamento]'); 
			return false; 
		}
		return true;
	}

	Future callWmsAgendamentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Agendamento]'; 
		lookupController.route = '/wms-agendamento/'; 
		lookupController.gridColumns = wmsAgendamentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = WmsAgendamentoModel.aliasColumns; 
		lookupController.dbColumns = WmsAgendamentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			wmsRecebimentoCabecalhoModel.idWmsAgendamento = plutoRowResult.cells['id']!.value; 
			wmsRecebimentoCabecalhoModel.wmsAgendamentoModel!.plutoRowToObject(plutoRowResult); 
			wmsAgendamentoModelController.text = wmsRecebimentoCabecalhoModel.wmsAgendamentoModel?.local_operacao ?? ''; 
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
		functionName = "wms_recebimento_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		wmsAgendamentoModelController.dispose();
		horaInicioController.dispose();
		horaFimController.dispose();
		volumeRecebidoController.dispose();
		pesoRecebidoController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}