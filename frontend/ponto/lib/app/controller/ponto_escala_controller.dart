import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/controller/controller_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ponto/app/page/page_imports.dart';

import 'package:ponto/app/routes/app_routes.dart';
import 'package:ponto/app/data/repository/ponto_escala_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoEscalaController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final PontoEscalaRepository pontoEscalaRepository;
	PontoEscalaController({required this.pontoEscalaRepository});

	// general
	final _dbColumns = PontoEscalaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PontoEscalaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = pontoEscalaGridColumns();
	
	var _pontoEscalaModelList = <PontoEscalaModel>[];

	var _pontoEscalaModelOld = PontoEscalaModel();

	final _pontoEscalaModel = PontoEscalaModel().obs;
	PontoEscalaModel get pontoEscalaModel => _pontoEscalaModel.value;
	set pontoEscalaModel(value) => _pontoEscalaModel.value = value ?? PontoEscalaModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Escalas', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Turmas', 
		),
	];

	List<Widget> tabPages() {
		return [
			PontoEscalaEditPage(),
			const PontoTurmaListPage(),
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
		for (var pontoEscalaModel in _pontoEscalaModelList) {
			plutoRowList.add(_getPlutoRow(pontoEscalaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PontoEscalaModel pontoEscalaModel) {
		return PlutoRow(
			cells: _getPlutoCells(pontoEscalaModel: pontoEscalaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PontoEscalaModel? pontoEscalaModel}) {
		return {
			"id": PlutoCell(value: pontoEscalaModel?.id ?? 0),
			"nome": PlutoCell(value: pontoEscalaModel?.nome ?? ''),
			"descontoHoraDia": PlutoCell(value: pontoEscalaModel?.descontoHoraDia ?? ''),
			"descontoDsr": PlutoCell(value: pontoEscalaModel?.descontoDsr ?? ''),
			"codigoHorarioDomingo": PlutoCell(value: pontoEscalaModel?.codigoHorarioDomingo ?? ''),
			"codigoHorarioSegunda": PlutoCell(value: pontoEscalaModel?.codigoHorarioSegunda ?? ''),
			"codigoHorarioTerca": PlutoCell(value: pontoEscalaModel?.codigoHorarioTerca ?? ''),
			"codigoHorarioQuarta": PlutoCell(value: pontoEscalaModel?.codigoHorarioQuarta ?? ''),
			"codigoHorarioQuinta": PlutoCell(value: pontoEscalaModel?.codigoHorarioQuinta ?? ''),
			"codigoHorarioSexta": PlutoCell(value: pontoEscalaModel?.codigoHorarioSexta ?? ''),
			"codigoHorarioSabado": PlutoCell(value: pontoEscalaModel?.codigoHorarioSabado ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _pontoEscalaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			pontoEscalaModel.plutoRowToObject(plutoRow);
		} else {
			pontoEscalaModel = modelFromRow[0];
			_pontoEscalaModelOld = pontoEscalaModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Escalas]';
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
		await Get.find<PontoEscalaController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await pontoEscalaRepository.getList(filter: filter).then( (data){ _pontoEscalaModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Escalas',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descontoHoraDiaController.text = currentRow.cells['descontoHoraDia']?.value ?? '';
			descontoDsrController.text = currentRow.cells['descontoDsr']?.value ?? '';
			codigoHorarioDomingoController.text = currentRow.cells['codigoHorarioDomingo']?.value ?? '';
			codigoHorarioSegundaController.text = currentRow.cells['codigoHorarioSegunda']?.value ?? '';
			codigoHorarioTercaController.text = currentRow.cells['codigoHorarioTerca']?.value ?? '';
			codigoHorarioQuartaController.text = currentRow.cells['codigoHorarioQuarta']?.value ?? '';
			codigoHorarioQuintaController.text = currentRow.cells['codigoHorarioQuinta']?.value ?? '';
			codigoHorarioSextaController.text = currentRow.cells['codigoHorarioSexta']?.value ?? '';
			codigoHorarioSabadoController.text = currentRow.cells['codigoHorarioSabado']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Turmas
			Get.put<PontoTurmaController>(PontoTurmaController()); 
			final pontoTurmaController = Get.find<PontoTurmaController>(); 
			pontoTurmaController.pontoTurmaModelList = pontoEscalaModel.pontoTurmaModelList!; 
			pontoTurmaController.userMadeChanges = false; 


			Get.toNamed(Routes.pontoEscalaTabPage)!.then((value) {
				if (pontoEscalaModel.id == 0) {
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
		pontoEscalaModel = PontoEscalaModel();
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
				if (await pontoEscalaRepository.delete(id: currentRow.cells['id']!.value)) {
					_pontoEscalaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descontoHoraDiaController = MaskedTextController(mask: '00:00:00',);
	final descontoDsrController = MaskedTextController(mask: '00:00:00',);
	final codigoHorarioDomingoController = TextEditingController();
	final codigoHorarioSegundaController = TextEditingController();
	final codigoHorarioTercaController = TextEditingController();
	final codigoHorarioQuartaController = TextEditingController();
	final codigoHorarioQuintaController = TextEditingController();
	final codigoHorarioSextaController = TextEditingController();
	final codigoHorarioSabadoController = TextEditingController();

	final pontoEscalaTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final pontoEscalaEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final pontoEscalaEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoEscalaModel.id;
		plutoRow.cells['nome']?.value = pontoEscalaModel.nome;
		plutoRow.cells['descontoHoraDia']?.value = pontoEscalaModel.descontoHoraDia;
		plutoRow.cells['descontoDsr']?.value = pontoEscalaModel.descontoDsr;
		plutoRow.cells['codigoHorarioDomingo']?.value = pontoEscalaModel.codigoHorarioDomingo;
		plutoRow.cells['codigoHorarioSegunda']?.value = pontoEscalaModel.codigoHorarioSegunda;
		plutoRow.cells['codigoHorarioTerca']?.value = pontoEscalaModel.codigoHorarioTerca;
		plutoRow.cells['codigoHorarioQuarta']?.value = pontoEscalaModel.codigoHorarioQuarta;
		plutoRow.cells['codigoHorarioQuinta']?.value = pontoEscalaModel.codigoHorarioQuinta;
		plutoRow.cells['codigoHorarioSexta']?.value = pontoEscalaModel.codigoHorarioSexta;
		plutoRow.cells['codigoHorarioSabado']?.value = pontoEscalaModel.codigoHorarioSabado;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await pontoEscalaRepository.save(pontoEscalaModel: pontoEscalaModel); 
				if (result != null) {
					pontoEscalaModel = result;
					if (_isInserting) {
						_pontoEscalaModelList.add(pontoEscalaModel);
						_isInserting = false;
					} else {
            _pontoEscalaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _pontoEscalaModelList.add(pontoEscalaModel);
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
		Get.find<PontoTurmaController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_pontoEscalaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_pontoEscalaModelList.add(_pontoEscalaModelOld);
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
		functionName = "ponto_escala";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		nomeController.dispose();
		descontoHoraDiaController.dispose();
		descontoDsrController.dispose();
		codigoHorarioDomingoController.dispose();
		codigoHorarioSegundaController.dispose();
		codigoHorarioTercaController.dispose();
		codigoHorarioQuartaController.dispose();
		codigoHorarioQuintaController.dispose();
		codigoHorarioSextaController.dispose();
		codigoHorarioSabadoController.dispose();
		super.onClose();
	}
}