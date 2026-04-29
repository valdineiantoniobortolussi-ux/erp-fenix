import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/controller/controller_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:agenda/app/page/grid_columns/grid_columns_imports.dart';
import 'package:agenda/app/page/page_imports.dart';

import 'package:agenda/app/routes/app_routes.dart';
import 'package:agenda/app/data/repository/agenda_compromisso_repository.dart';
import 'package:agenda/app/page/shared_page/shared_page_imports.dart';
import 'package:agenda/app/page/shared_widget/message_dialog.dart';
import 'package:agenda/app/mixin/controller_base_mixin.dart';

class AgendaCompromissoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final AgendaCompromissoRepository agendaCompromissoRepository;
	AgendaCompromissoController({required this.agendaCompromissoRepository});

	// general
	final _dbColumns = AgendaCompromissoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = AgendaCompromissoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = agendaCompromissoGridColumns();
	
	var _agendaCompromissoModelList = <AgendaCompromissoModel>[];

	var _agendaCompromissoModelOld = AgendaCompromissoModel();

	final _agendaCompromissoModel = AgendaCompromissoModel().obs;
	AgendaCompromissoModel get agendaCompromissoModel => _agendaCompromissoModel.value;
	set agendaCompromissoModel(value) => _agendaCompromissoModel.value = value ?? AgendaCompromissoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Compromissos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Notificações', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Convidados', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Eventos', 
		),
	];

	List<Widget> tabPages() {
		return [
			AgendaCompromissoEditPage(),
			const AgendaNotificacaoListPage(),
			const AgendaCompromissoConvidadoListPage(),
			const ReuniaoSalaEventoListPage(),
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
		for (var agendaCompromissoModel in _agendaCompromissoModelList) {
			plutoRowList.add(_getPlutoRow(agendaCompromissoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(AgendaCompromissoModel agendaCompromissoModel) {
		return PlutoRow(
			cells: _getPlutoCells(agendaCompromissoModel: agendaCompromissoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ AgendaCompromissoModel? agendaCompromissoModel}) {
		return {
			"id": PlutoCell(value: agendaCompromissoModel?.id ?? 0),
			"agendaCategoriaCompromisso": PlutoCell(value: agendaCompromissoModel?.agendaCategoriaCompromissoModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: agendaCompromissoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataCompromisso": PlutoCell(value: agendaCompromissoModel?.dataCompromisso ?? ''),
			"hora": PlutoCell(value: agendaCompromissoModel?.hora ?? ''),
			"duracao": PlutoCell(value: agendaCompromissoModel?.duracao ?? 0),
			"tipo": PlutoCell(value: agendaCompromissoModel?.tipo ?? ''),
			"onde": PlutoCell(value: agendaCompromissoModel?.onde ?? ''),
			"descricao": PlutoCell(value: agendaCompromissoModel?.descricao ?? ''),
			"idAgendaCategoriaCompromisso": PlutoCell(value: agendaCompromissoModel?.idAgendaCategoriaCompromisso ?? 0),
			"idColaborador": PlutoCell(value: agendaCompromissoModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _agendaCompromissoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			agendaCompromissoModel.plutoRowToObject(plutoRow);
		} else {
			agendaCompromissoModel = modelFromRow[0];
			_agendaCompromissoModelOld = agendaCompromissoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Compromissos]';
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
		await Get.find<AgendaCompromissoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await agendaCompromissoRepository.getList(filter: filter).then( (data){ _agendaCompromissoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Compromissos',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			agendaCategoriaCompromissoModelController.text = currentRow.cells['agendaCategoriaCompromisso']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			horaController.text = currentRow.cells['hora']?.value ?? '';
			duracaoController.text = currentRow.cells['duracao']?.value?.toString() ?? '';
			ondeController.text = currentRow.cells['onde']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Notificações
			Get.put<AgendaNotificacaoController>(AgendaNotificacaoController()); 
			final agendaNotificacaoController = Get.find<AgendaNotificacaoController>(); 
			agendaNotificacaoController.agendaNotificacaoModelList = agendaCompromissoModel.agendaNotificacaoModelList!; 
			agendaNotificacaoController.userMadeChanges = false; 

			//Convidados
			Get.put<AgendaCompromissoConvidadoController>(AgendaCompromissoConvidadoController()); 
			final agendaCompromissoConvidadoController = Get.find<AgendaCompromissoConvidadoController>(); 
			agendaCompromissoConvidadoController.agendaCompromissoConvidadoModelList = agendaCompromissoModel.agendaCompromissoConvidadoModelList!; 
			agendaCompromissoConvidadoController.userMadeChanges = false; 

			//Eventos
			Get.put<ReuniaoSalaEventoController>(ReuniaoSalaEventoController()); 
			final reuniaoSalaEventoController = Get.find<ReuniaoSalaEventoController>(); 
			reuniaoSalaEventoController.reuniaoSalaEventoModelList = agendaCompromissoModel.reuniaoSalaEventoModelList!; 
			reuniaoSalaEventoController.userMadeChanges = false; 


			Get.toNamed(Routes.agendaCompromissoTabPage)!.then((value) {
				if (agendaCompromissoModel.id == 0) {
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
		agendaCompromissoModel = AgendaCompromissoModel();
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
				if (await agendaCompromissoRepository.delete(id: currentRow.cells['id']!.value)) {
					_agendaCompromissoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final agendaCategoriaCompromissoModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final horaController = TextEditingController();
	final duracaoController = TextEditingController();
	final ondeController = TextEditingController();
	final descricaoController = TextEditingController();

	final agendaCompromissoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final agendaCompromissoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final agendaCompromissoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = agendaCompromissoModel.id;
		plutoRow.cells['idAgendaCategoriaCompromisso']?.value = agendaCompromissoModel.idAgendaCategoriaCompromisso;
		plutoRow.cells['agendaCategoriaCompromisso']?.value = agendaCompromissoModel.agendaCategoriaCompromissoModel?.nome;
		plutoRow.cells['idColaborador']?.value = agendaCompromissoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = agendaCompromissoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataCompromisso']?.value = Util.formatDate(agendaCompromissoModel.dataCompromisso);
		plutoRow.cells['hora']?.value = agendaCompromissoModel.hora;
		plutoRow.cells['duracao']?.value = agendaCompromissoModel.duracao;
		plutoRow.cells['tipo']?.value = agendaCompromissoModel.tipo;
		plutoRow.cells['onde']?.value = agendaCompromissoModel.onde;
		plutoRow.cells['descricao']?.value = agendaCompromissoModel.descricao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await agendaCompromissoRepository.save(agendaCompromissoModel: agendaCompromissoModel); 
				if (result != null) {
					agendaCompromissoModel = result;
					if (_isInserting) {
						_agendaCompromissoModelList.add(agendaCompromissoModel);
						_isInserting = false;
					} else {
            _agendaCompromissoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _agendaCompromissoModelList.add(agendaCompromissoModel);
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
		Get.find<AgendaNotificacaoController>().userMadeChanges
		|| 
		Get.find<AgendaCompromissoConvidadoController>().userMadeChanges
		|| 
		Get.find<ReuniaoSalaEventoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_agendaCompromissoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_agendaCompromissoModelList.add(_agendaCompromissoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(agendaCompromissoModel.agendaCategoriaCompromissoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Categoria]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(agendaCompromissoModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
		return true;
	}

	Future callAgendaCategoriaCompromissoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Categoria]'; 
		lookupController.route = '/agenda-categoria-compromisso/'; 
		lookupController.gridColumns = agendaCategoriaCompromissoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = AgendaCategoriaCompromissoModel.aliasColumns; 
		lookupController.dbColumns = AgendaCategoriaCompromissoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			agendaCompromissoModel.idAgendaCategoriaCompromisso = plutoRowResult.cells['id']!.value; 
			agendaCompromissoModel.agendaCategoriaCompromissoModel!.plutoRowToObject(plutoRowResult); 
			agendaCategoriaCompromissoModelController.text = agendaCompromissoModel.agendaCategoriaCompromissoModel?.nome ?? ''; 
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
			agendaCompromissoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			agendaCompromissoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = agendaCompromissoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "agenda_compromisso";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		agendaCategoriaCompromissoModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		horaController.dispose();
		duracaoController.dispose();
		ondeController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}