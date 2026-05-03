import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/controller/controller_imports.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ordem_servico/app/page/page_imports.dart';

import 'package:ordem_servico/app/routes/app_routes.dart';
import 'package:ordem_servico/app/data/repository/os_abertura_repository.dart';
import 'package:ordem_servico/app/page/shared_page/shared_page_imports.dart';
import 'package:ordem_servico/app/page/shared_widget/message_dialog.dart';
import 'package:ordem_servico/app/mixin/controller_base_mixin.dart';

class OsAberturaController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final OsAberturaRepository osAberturaRepository;
	OsAberturaController({required this.osAberturaRepository});

	// general
	final _dbColumns = OsAberturaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = OsAberturaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = osAberturaGridColumns();
	
	var _osAberturaModelList = <OsAberturaModel>[];

	var _osAberturaModelOld = OsAberturaModel();

	final _osAberturaModel = OsAberturaModel().obs;
	OsAberturaModel get osAberturaModel => _osAberturaModel.value;
	set osAberturaModel(value) => _osAberturaModel.value = value ?? OsAberturaModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Abertura OS', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Equipamentos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Produto ou Serviço', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Evolução', 
		),
	];

	List<Widget> tabPages() {
		return [
			OsAberturaEditPage(),
			const OsAberturaEquipamentoListPage(),
			const OsProdutoServicoListPage(),
			const OsEvolucaoListPage(),
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
		for (var osAberturaModel in _osAberturaModelList) {
			plutoRowList.add(_getPlutoRow(osAberturaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(OsAberturaModel osAberturaModel) {
		return PlutoRow(
			cells: _getPlutoCells(osAberturaModel: osAberturaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ OsAberturaModel? osAberturaModel}) {
		return {
			"id": PlutoCell(value: osAberturaModel?.id ?? 0),
			"osStatus": PlutoCell(value: osAberturaModel?.osStatusModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: osAberturaModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"viewPessoaCliente": PlutoCell(value: osAberturaModel?.viewPessoaClienteModel?.nome ?? ''),
			"numero": PlutoCell(value: osAberturaModel?.numero ?? ''),
			"dataInicio": PlutoCell(value: osAberturaModel?.dataInicio ?? ''),
			"horaInicio": PlutoCell(value: osAberturaModel?.horaInicio ?? ''),
			"dataPrevisao": PlutoCell(value: osAberturaModel?.dataPrevisao ?? ''),
			"horaPrevisao": PlutoCell(value: osAberturaModel?.horaPrevisao ?? ''),
			"dataFim": PlutoCell(value: osAberturaModel?.dataFim ?? ''),
			"horaFim": PlutoCell(value: osAberturaModel?.horaFim ?? ''),
			"nomeContato": PlutoCell(value: osAberturaModel?.nomeContato ?? ''),
			"foneContato": PlutoCell(value: osAberturaModel?.foneContato ?? ''),
			"observacaoCliente": PlutoCell(value: osAberturaModel?.observacaoCliente ?? ''),
			"observacaoAbertura": PlutoCell(value: osAberturaModel?.observacaoAbertura ?? ''),
			"idOsStatus": PlutoCell(value: osAberturaModel?.idOsStatus ?? 0),
			"idColaborador": PlutoCell(value: osAberturaModel?.idColaborador ?? 0),
			"idCliente": PlutoCell(value: osAberturaModel?.idCliente ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _osAberturaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			osAberturaModel.plutoRowToObject(plutoRow);
		} else {
			osAberturaModel = modelFromRow[0];
			_osAberturaModelOld = osAberturaModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Abertura OS]';
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
		await Get.find<OsAberturaController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await osAberturaRepository.getList(filter: filter).then( (data){ _osAberturaModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Abertura OS',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			osStatusModelController.text = currentRow.cells['osStatus']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			horaInicioController.text = currentRow.cells['horaInicio']?.value ?? '';
			horaPrevisaoController.text = currentRow.cells['horaPrevisao']?.value ?? '';
			horaFimController.text = currentRow.cells['horaFim']?.value ?? '';
			nomeContatoController.text = currentRow.cells['nomeContato']?.value ?? '';
			foneContatoController.text = currentRow.cells['foneContato']?.value ?? '';
			observacaoClienteController.text = currentRow.cells['observacaoCliente']?.value ?? '';
			observacaoAberturaController.text = currentRow.cells['observacaoAbertura']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Equipamentos
			Get.put<OsAberturaEquipamentoController>(OsAberturaEquipamentoController()); 
			final osAberturaEquipamentoController = Get.find<OsAberturaEquipamentoController>(); 
			osAberturaEquipamentoController.osAberturaEquipamentoModelList = osAberturaModel.osAberturaEquipamentoModelList!; 
			osAberturaEquipamentoController.userMadeChanges = false; 

			//Produto ou Serviço
			Get.put<OsProdutoServicoController>(OsProdutoServicoController()); 
			final osProdutoServicoController = Get.find<OsProdutoServicoController>(); 
			osProdutoServicoController.osProdutoServicoModelList = osAberturaModel.osProdutoServicoModelList!; 
			osProdutoServicoController.userMadeChanges = false; 

			//Evolução
			Get.put<OsEvolucaoController>(OsEvolucaoController()); 
			final osEvolucaoController = Get.find<OsEvolucaoController>(); 
			osEvolucaoController.osEvolucaoModelList = osAberturaModel.osEvolucaoModelList!; 
			osEvolucaoController.userMadeChanges = false; 


			Get.toNamed(Routes.osAberturaTabPage)!.then((value) {
				if (osAberturaModel.id == 0) {
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
		osAberturaModel = OsAberturaModel();
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
				if (await osAberturaRepository.delete(id: currentRow.cells['id']!.value)) {
					_osAberturaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final osStatusModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final viewPessoaClienteModelController = TextEditingController();
	final numeroController = TextEditingController();
	final horaInicioController = TextEditingController();
	final horaPrevisaoController = MaskedTextController(mask: '00:00:00',);
	final horaFimController = MaskedTextController(mask: '00:00:00',);
	final nomeContatoController = TextEditingController();
	final foneContatoController = MaskedTextController(mask: '(00)00000-0000',);
	final observacaoClienteController = TextEditingController();
	final observacaoAberturaController = TextEditingController();

	final osAberturaTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final osAberturaEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final osAberturaEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = osAberturaModel.id;
		plutoRow.cells['idOsStatus']?.value = osAberturaModel.idOsStatus;
		plutoRow.cells['osStatus']?.value = osAberturaModel.osStatusModel?.nome;
		plutoRow.cells['idColaborador']?.value = osAberturaModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = osAberturaModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['idCliente']?.value = osAberturaModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = osAberturaModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['numero']?.value = osAberturaModel.numero;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(osAberturaModel.dataInicio);
		plutoRow.cells['horaInicio']?.value = osAberturaModel.horaInicio;
		plutoRow.cells['dataPrevisao']?.value = Util.formatDate(osAberturaModel.dataPrevisao);
		plutoRow.cells['horaPrevisao']?.value = osAberturaModel.horaPrevisao;
		plutoRow.cells['dataFim']?.value = Util.formatDate(osAberturaModel.dataFim);
		plutoRow.cells['horaFim']?.value = osAberturaModel.horaFim;
		plutoRow.cells['nomeContato']?.value = osAberturaModel.nomeContato;
		plutoRow.cells['foneContato']?.value = osAberturaModel.foneContato;
		plutoRow.cells['observacaoCliente']?.value = osAberturaModel.observacaoCliente;
		plutoRow.cells['observacaoAbertura']?.value = osAberturaModel.observacaoAbertura;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await osAberturaRepository.save(osAberturaModel: osAberturaModel); 
				if (result != null) {
					osAberturaModel = result;
					if (_isInserting) {
						_osAberturaModelList.add(osAberturaModel);
						_isInserting = false;
					} else {
            _osAberturaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _osAberturaModelList.add(osAberturaModel);
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
		Get.find<OsAberturaEquipamentoController>().userMadeChanges
		|| 
		Get.find<OsProdutoServicoController>().userMadeChanges
		|| 
		Get.find<OsEvolucaoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_osAberturaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_osAberturaModelList.add(_osAberturaModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(osAberturaModel.osStatusModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Status]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(osAberturaModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Colaborador]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(osAberturaModel.viewPessoaClienteModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Cliente]'); 
			return false; 
		}
		return true;
	}

	Future callOsStatusLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Status]'; 
		lookupController.route = '/os-status/'; 
		lookupController.gridColumns = osStatusGridColumns(isForLookup: true); 
		lookupController.aliasColumns = OsStatusModel.aliasColumns; 
		lookupController.dbColumns = OsStatusModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			osAberturaModel.idOsStatus = plutoRowResult.cells['id']!.value; 
			osAberturaModel.osStatusModel!.plutoRowToObject(plutoRowResult); 
			osStatusModelController.text = osAberturaModel.osStatusModel?.nome ?? ''; 
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
			osAberturaModel.idColaborador = plutoRowResult.cells['id']!.value; 
			osAberturaModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = osAberturaModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callViewPessoaClienteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Cliente]'; 
		lookupController.route = '/view-pessoa-cliente/'; 
		lookupController.gridColumns = viewPessoaClienteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaClienteModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaClienteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			osAberturaModel.idCliente = plutoRowResult.cells['id']!.value; 
			osAberturaModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = osAberturaModel.viewPessoaClienteModel?.nome ?? ''; 
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
		functionName = "os_abertura";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		osStatusModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		viewPessoaClienteModelController.dispose();
		numeroController.dispose();
		horaInicioController.dispose();
		horaPrevisaoController.dispose();
		horaFimController.dispose();
		nomeContatoController.dispose();
		foneContatoController.dispose();
		observacaoClienteController.dispose();
		observacaoAberturaController.dispose();
		super.onClose();
	}
}