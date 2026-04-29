import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/page/page_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/colaborador_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class ColaboradorController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ColaboradorRepository colaboradorRepository;
	ColaboradorController({required this.colaboradorRepository});

	// general
	final _dbColumns = ColaboradorModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ColaboradorModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = colaboradorGridColumns();
	
	var _colaboradorModelList = <ColaboradorModel>[];

	var _colaboradorModelOld = ColaboradorModel();

	final _colaboradorModel = ColaboradorModel().obs;
	ColaboradorModel get colaboradorModel => _colaboradorModel.value;
	set colaboradorModel(value) => _colaboradorModel.value = value ?? ColaboradorModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Colaborador', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Vendedor', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Relacionamentos', 
		),
	];

	List<Widget> tabPages() {
		return [
			ColaboradorEditPage(),
			VendedorEditPage(),
			const ColaboradorRelacionamentoListPage(),
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
		for (var colaboradorModel in _colaboradorModelList) {
			plutoRowList.add(_getPlutoRow(colaboradorModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ColaboradorModel colaboradorModel) {
		return PlutoRow(
			cells: _getPlutoCells(colaboradorModel: colaboradorModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ColaboradorModel? colaboradorModel}) {
		return {
			"id": PlutoCell(value: colaboradorModel?.id ?? 0),
			"pessoa": PlutoCell(value: colaboradorModel?.pessoaModel?.nome ?? ''),
			"cargo": PlutoCell(value: colaboradorModel?.cargoModel?.nome ?? ''),
			"setor": PlutoCell(value: colaboradorModel?.setorModel?.nome ?? ''),
			"colaboradorSituacao": PlutoCell(value: colaboradorModel?.colaboradorSituacaoModel?.nome ?? ''),
			"tipoAdmissao": PlutoCell(value: colaboradorModel?.tipoAdmissaoModel?.nome ?? ''),
			"colaboradorTipo": PlutoCell(value: colaboradorModel?.colaboradorTipoModel?.nome ?? ''),
			"sindicato": PlutoCell(value: colaboradorModel?.sindicatoModel?.nome ?? ''),
			"matricula": PlutoCell(value: colaboradorModel?.matricula ?? ''),
			"dataCadastro": PlutoCell(value: colaboradorModel?.dataCadastro ?? ''),
			"dataAdmissao": PlutoCell(value: colaboradorModel?.dataAdmissao ?? ''),
			"dataDemissao": PlutoCell(value: colaboradorModel?.dataDemissao ?? ''),
			"ctpsNumero": PlutoCell(value: colaboradorModel?.ctpsNumero ?? ''),
			"ctpsSerie": PlutoCell(value: colaboradorModel?.ctpsSerie ?? ''),
			"ctpsDataExpedicao": PlutoCell(value: colaboradorModel?.ctpsDataExpedicao ?? ''),
			"ctpsUf": PlutoCell(value: colaboradorModel?.ctpsUf ?? ''),
			"observacao": PlutoCell(value: colaboradorModel?.observacao ?? ''),
			"idPessoa": PlutoCell(value: colaboradorModel?.idPessoa ?? 0),
			"idCargo": PlutoCell(value: colaboradorModel?.idCargo ?? 0),
			"idSetor": PlutoCell(value: colaboradorModel?.idSetor ?? 0),
			"idColaboradorSituacao": PlutoCell(value: colaboradorModel?.idColaboradorSituacao ?? 0),
			"idTipoAdmissao": PlutoCell(value: colaboradorModel?.idTipoAdmissao ?? 0),
			"idColaboradorTipo": PlutoCell(value: colaboradorModel?.idColaboradorTipo ?? 0),
			"idSindicato": PlutoCell(value: colaboradorModel?.idSindicato ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _colaboradorModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			colaboradorModel.plutoRowToObject(plutoRow);
		} else {
			colaboradorModel = modelFromRow[0];
			_colaboradorModelOld = colaboradorModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Colaborador]';
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
		await Get.find<ColaboradorController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await colaboradorRepository.getList(filter: filter).then( (data){ _colaboradorModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Colaborador',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			pessoaModelController.text = currentRow.cells['pessoa']?.value ?? '';
			cargoModelController.text = currentRow.cells['cargo']?.value ?? '';
			setorModelController.text = currentRow.cells['setor']?.value ?? '';
			colaboradorSituacaoModelController.text = currentRow.cells['colaboradorSituacao']?.value ?? '';
			tipoAdmissaoModelController.text = currentRow.cells['tipoAdmissao']?.value ?? '';
			colaboradorTipoModelController.text = currentRow.cells['colaboradorTipo']?.value ?? '';
			sindicatoModelController.text = currentRow.cells['sindicato']?.value ?? '';
			matriculaController.text = currentRow.cells['matricula']?.value ?? '';
			ctpsNumeroController.text = currentRow.cells['ctpsNumero']?.value ?? '';
			ctpsSerieController.text = currentRow.cells['ctpsSerie']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Vendedor
			Get.put<VendedorController>(VendedorController()); 
			final vendedorController = Get.find<VendedorController>(); 
			vendedorController.vendedorModel = colaboradorModel.vendedorModel; 
			vendedorController.formWasChanged = false; 
			vendedorController.callEditPage(); 

			//Relacionamentos
			Get.put<ColaboradorRelacionamentoController>(ColaboradorRelacionamentoController()); 
			final colaboradorRelacionamentoController = Get.find<ColaboradorRelacionamentoController>(); 
			colaboradorRelacionamentoController.colaboradorRelacionamentoModelList = colaboradorModel.colaboradorRelacionamentoModelList!; 
			colaboradorRelacionamentoController.userMadeChanges = false; 


			Get.toNamed(Routes.colaboradorTabPage)!.then((value) {
				if (colaboradorModel.id == 0) {
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
		colaboradorModel = ColaboradorModel();
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
				if (await colaboradorRepository.delete(id: currentRow.cells['id']!.value)) {
					_colaboradorModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final pessoaModelController = TextEditingController();
	final cargoModelController = TextEditingController();
	final setorModelController = TextEditingController();
	final colaboradorSituacaoModelController = TextEditingController();
	final tipoAdmissaoModelController = TextEditingController();
	final colaboradorTipoModelController = TextEditingController();
	final sindicatoModelController = TextEditingController();
	final matriculaController = TextEditingController();
	final ctpsNumeroController = TextEditingController();
	final ctpsSerieController = TextEditingController();
	final observacaoController = TextEditingController();

	final colaboradorTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final colaboradorEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final colaboradorEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = colaboradorModel.id;
		plutoRow.cells['idPessoa']?.value = colaboradorModel.idPessoa;
		plutoRow.cells['pessoa']?.value = colaboradorModel.pessoaModel?.nome;
		plutoRow.cells['idCargo']?.value = colaboradorModel.idCargo;
		plutoRow.cells['cargo']?.value = colaboradorModel.cargoModel?.nome;
		plutoRow.cells['idSetor']?.value = colaboradorModel.idSetor;
		plutoRow.cells['setor']?.value = colaboradorModel.setorModel?.nome;
		plutoRow.cells['idColaboradorSituacao']?.value = colaboradorModel.idColaboradorSituacao;
		plutoRow.cells['colaboradorSituacao']?.value = colaboradorModel.colaboradorSituacaoModel?.nome;
		plutoRow.cells['idTipoAdmissao']?.value = colaboradorModel.idTipoAdmissao;
		plutoRow.cells['tipoAdmissao']?.value = colaboradorModel.tipoAdmissaoModel?.nome;
		plutoRow.cells['idColaboradorTipo']?.value = colaboradorModel.idColaboradorTipo;
		plutoRow.cells['colaboradorTipo']?.value = colaboradorModel.colaboradorTipoModel?.nome;
		plutoRow.cells['idSindicato']?.value = colaboradorModel.idSindicato;
		plutoRow.cells['sindicato']?.value = colaboradorModel.sindicatoModel?.nome;
		plutoRow.cells['matricula']?.value = colaboradorModel.matricula;
		plutoRow.cells['dataCadastro']?.value = Util.formatDate(colaboradorModel.dataCadastro);
		plutoRow.cells['dataAdmissao']?.value = Util.formatDate(colaboradorModel.dataAdmissao);
		plutoRow.cells['dataDemissao']?.value = Util.formatDate(colaboradorModel.dataDemissao);
		plutoRow.cells['ctpsNumero']?.value = colaboradorModel.ctpsNumero;
		plutoRow.cells['ctpsSerie']?.value = colaboradorModel.ctpsSerie;
		plutoRow.cells['ctpsDataExpedicao']?.value = Util.formatDate(colaboradorModel.ctpsDataExpedicao);
		plutoRow.cells['ctpsUf']?.value = colaboradorModel.ctpsUf;
		plutoRow.cells['observacao']?.value = colaboradorModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await colaboradorRepository.save(colaboradorModel: colaboradorModel); 
				if (result != null) {
					colaboradorModel = result;
					if (_isInserting) {
						_colaboradorModelList.add(colaboradorModel);
						_isInserting = false;
					} else {
            _colaboradorModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _colaboradorModelList.add(colaboradorModel);
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
		Get.find<VendedorController>().formWasChanged
		|| 
		Get.find<ColaboradorRelacionamentoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_colaboradorModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_colaboradorModelList.add(_colaboradorModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(colaboradorModel.pessoaModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Pessoa]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(colaboradorModel.sindicatoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Sindicato]'); 
			return false; 
		}
		final resultVendedor = Get.find<VendedorController>().validateForm(); 
		if (!resultVendedor) { 
			return false; 
		}
		return true;
	}

	Future callPessoaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Pessoa]'; 
		lookupController.route = '/pessoa/'; 
		lookupController.gridColumns = pessoaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PessoaModel.aliasColumns; 
		lookupController.dbColumns = PessoaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorModel.idPessoa = plutoRowResult.cells['id']!.value; 
			colaboradorModel.pessoaModel!.plutoRowToObject(plutoRowResult); 
			pessoaModelController.text = colaboradorModel.pessoaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callCargoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Cargo]'; 
		lookupController.route = '/cargo/'; 
		lookupController.gridColumns = cargoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CargoModel.aliasColumns; 
		lookupController.dbColumns = CargoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorModel.idCargo = plutoRowResult.cells['id']!.value; 
			colaboradorModel.cargoModel!.plutoRowToObject(plutoRowResult); 
			cargoModelController.text = colaboradorModel.cargoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callSetorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Setor]'; 
		lookupController.route = '/setor/'; 
		lookupController.gridColumns = setorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = SetorModel.aliasColumns; 
		lookupController.dbColumns = SetorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorModel.idSetor = plutoRowResult.cells['id']!.value; 
			colaboradorModel.setorModel!.plutoRowToObject(plutoRowResult); 
			setorModelController.text = colaboradorModel.setorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callColaboradorSituacaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Situação]'; 
		lookupController.route = '/colaborador-situacao/'; 
		lookupController.gridColumns = colaboradorSituacaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ColaboradorSituacaoModel.aliasColumns; 
		lookupController.dbColumns = ColaboradorSituacaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorModel.idColaboradorSituacao = plutoRowResult.cells['id']!.value; 
			colaboradorModel.colaboradorSituacaoModel!.plutoRowToObject(plutoRowResult); 
			colaboradorSituacaoModelController.text = colaboradorModel.colaboradorSituacaoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callTipoAdmissaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Admissao]'; 
		lookupController.route = '/tipo-admissao/'; 
		lookupController.gridColumns = tipoAdmissaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TipoAdmissaoModel.aliasColumns; 
		lookupController.dbColumns = TipoAdmissaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorModel.idTipoAdmissao = plutoRowResult.cells['id']!.value; 
			colaboradorModel.tipoAdmissaoModel!.plutoRowToObject(plutoRowResult); 
			tipoAdmissaoModelController.text = colaboradorModel.tipoAdmissaoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callColaboradorTipoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Colaborador]'; 
		lookupController.route = '/colaborador-tipo/'; 
		lookupController.gridColumns = colaboradorTipoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ColaboradorTipoModel.aliasColumns; 
		lookupController.dbColumns = ColaboradorTipoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorModel.idColaboradorTipo = plutoRowResult.cells['id']!.value; 
			colaboradorModel.colaboradorTipoModel!.plutoRowToObject(plutoRowResult); 
			colaboradorTipoModelController.text = colaboradorModel.colaboradorTipoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callSindicatoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Sindicato]'; 
		lookupController.route = '/sindicato/'; 
		lookupController.gridColumns = sindicatoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = SindicatoModel.aliasColumns; 
		lookupController.dbColumns = SindicatoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			colaboradorModel.idSindicato = plutoRowResult.cells['id']!.value; 
			colaboradorModel.sindicatoModel!.plutoRowToObject(plutoRowResult); 
			sindicatoModelController.text = colaboradorModel.sindicatoModel?.nome ?? ''; 
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
		functionName = "colaborador";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		pessoaModelController.dispose();
		cargoModelController.dispose();
		setorModelController.dispose();
		colaboradorSituacaoModelController.dispose();
		tipoAdmissaoModelController.dispose();
		colaboradorTipoModelController.dispose();
		sindicatoModelController.dispose();
		matriculaController.dispose();
		ctpsNumeroController.dispose();
		ctpsSerieController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}