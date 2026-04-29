import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/controller/controller_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:contratos/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contratos/app/routes/app_routes.dart';
import 'package:contratos/app/data/repository/contrato_solicitacao_servico_repository.dart';
import 'package:contratos/app/page/shared_page/shared_page_imports.dart';
import 'package:contratos/app/page/shared_widget/message_dialog.dart';
import 'package:contratos/app/mixin/controller_base_mixin.dart';

class ContratoSolicitacaoServicoController extends GetxController with ControllerBaseMixin {
  final ContratoSolicitacaoServicoRepository contratoSolicitacaoServicoRepository;
  ContratoSolicitacaoServicoController({required this.contratoSolicitacaoServicoRepository});

  // general
  final _dbColumns = ContratoSolicitacaoServicoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContratoSolicitacaoServicoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contratoSolicitacaoServicoGridColumns();
  
  var _contratoSolicitacaoServicoModelList = <ContratoSolicitacaoServicoModel>[];

  final _contratoSolicitacaoServicoModel = ContratoSolicitacaoServicoModel().obs;
  ContratoSolicitacaoServicoModel get contratoSolicitacaoServicoModel => _contratoSolicitacaoServicoModel.value;
  set contratoSolicitacaoServicoModel(value) => _contratoSolicitacaoServicoModel.value = value ?? ContratoSolicitacaoServicoModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter(); 

  var _isInserting = false;

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
    for (var contratoSolicitacaoServicoModel in _contratoSolicitacaoServicoModelList) {
      plutoRowList.add(_getPlutoRow(contratoSolicitacaoServicoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContratoSolicitacaoServicoModel contratoSolicitacaoServicoModel) {
    return PlutoRow(
      cells: _getPlutoCells(contratoSolicitacaoServicoModel: contratoSolicitacaoServicoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContratoSolicitacaoServicoModel? contratoSolicitacaoServicoModel}) {
    return {
			"id": PlutoCell(value: contratoSolicitacaoServicoModel?.id ?? 0),
			"contratoTipoServico": PlutoCell(value: contratoSolicitacaoServicoModel?.contratoTipoServicoModel?.nome ?? ''),
			"setor": PlutoCell(value: contratoSolicitacaoServicoModel?.setorModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: contratoSolicitacaoServicoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"viewPessoaCliente": PlutoCell(value: contratoSolicitacaoServicoModel?.viewPessoaClienteModel?.nome ?? ''),
			"viewPessoaFornecedor": PlutoCell(value: contratoSolicitacaoServicoModel?.viewPessoaFornecedorModel?.nome ?? ''),
			"dataSolicitacao": PlutoCell(value: contratoSolicitacaoServicoModel?.dataSolicitacao ?? ''),
			"dataDesejadaInicio": PlutoCell(value: contratoSolicitacaoServicoModel?.dataDesejadaInicio ?? ''),
			"urgente": PlutoCell(value: contratoSolicitacaoServicoModel?.urgente ?? ''),
			"statusSolicitacao": PlutoCell(value: contratoSolicitacaoServicoModel?.statusSolicitacao ?? ''),
			"descricao": PlutoCell(value: contratoSolicitacaoServicoModel?.descricao ?? ''),
			"idContratoTipoServico": PlutoCell(value: contratoSolicitacaoServicoModel?.idContratoTipoServico ?? 0),
			"idSetor": PlutoCell(value: contratoSolicitacaoServicoModel?.idSetor ?? 0),
			"idColaborador": PlutoCell(value: contratoSolicitacaoServicoModel?.idColaborador ?? 0),
			"idCliente": PlutoCell(value: contratoSolicitacaoServicoModel?.idCliente ?? 0),
			"idFornecedor": PlutoCell(value: contratoSolicitacaoServicoModel?.idFornecedor ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contratoSolicitacaoServicoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contratoSolicitacaoServicoModel.plutoRowToObject(plutoRow);
    } else {
      contratoSolicitacaoServicoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Solicitação de Serviço]';
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
    await Get.find<ContratoSolicitacaoServicoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contratoSolicitacaoServicoRepository.getList(filter: filter).then( (data){ _contratoSolicitacaoServicoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Solicitação de Serviço',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			contratoTipoServicoModelController.text = currentRow.cells['contratoTipoServico']?.value ?? '';
			setorModelController.text = currentRow.cells['setor']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			viewPessoaFornecedorModelController.text = currentRow.cells['viewPessoaFornecedor']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contratoSolicitacaoServicoEditPage)!.then((value) {
        if (contratoSolicitacaoServicoModel.id == 0) {
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
    contratoSolicitacaoServicoModel = ContratoSolicitacaoServicoModel();
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
        if (await contratoSolicitacaoServicoRepository.delete(id: currentRow.cells['id']!.value)) {
          _contratoSolicitacaoServicoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
  final scrollController = ScrollController();
	final contratoTipoServicoModelController = TextEditingController();
	final setorModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final viewPessoaClienteModelController = TextEditingController();
	final viewPessoaFornecedorModelController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contratoSolicitacaoServicoModel.id;
		plutoRow.cells['idContratoTipoServico']?.value = contratoSolicitacaoServicoModel.idContratoTipoServico;
		plutoRow.cells['contratoTipoServico']?.value = contratoSolicitacaoServicoModel.contratoTipoServicoModel?.nome;
		plutoRow.cells['idSetor']?.value = contratoSolicitacaoServicoModel.idSetor;
		plutoRow.cells['setor']?.value = contratoSolicitacaoServicoModel.setorModel?.nome;
		plutoRow.cells['idColaborador']?.value = contratoSolicitacaoServicoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = contratoSolicitacaoServicoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['idCliente']?.value = contratoSolicitacaoServicoModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = contratoSolicitacaoServicoModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['idFornecedor']?.value = contratoSolicitacaoServicoModel.idFornecedor;
		plutoRow.cells['viewPessoaFornecedor']?.value = contratoSolicitacaoServicoModel.viewPessoaFornecedorModel?.nome;
		plutoRow.cells['dataSolicitacao']?.value = Util.formatDate(contratoSolicitacaoServicoModel.dataSolicitacao);
		plutoRow.cells['dataDesejadaInicio']?.value = Util.formatDate(contratoSolicitacaoServicoModel.dataDesejadaInicio);
		plutoRow.cells['urgente']?.value = contratoSolicitacaoServicoModel.urgente;
		plutoRow.cells['statusSolicitacao']?.value = contratoSolicitacaoServicoModel.statusSolicitacao;
		plutoRow.cells['descricao']?.value = contratoSolicitacaoServicoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contratoSolicitacaoServicoRepository.save(contratoSolicitacaoServicoModel: contratoSolicitacaoServicoModel); 
        if (result != null) {
          contratoSolicitacaoServicoModel = result;
          if (_isInserting) {
            _contratoSolicitacaoServicoModelList.add(result);
            _isInserting = false;
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
    if (formWasChanged) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      Get.back();
    }
  }  

	Future callContratoTipoServicoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Servico]'; 
		lookupController.route = '/contrato-tipo-servico/'; 
		lookupController.gridColumns = contratoTipoServicoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContratoTipoServicoModel.aliasColumns; 
		lookupController.dbColumns = ContratoTipoServicoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contratoSolicitacaoServicoModel.idContratoTipoServico = plutoRowResult.cells['id']!.value; 
			contratoSolicitacaoServicoModel.contratoTipoServicoModel!.plutoRowToObject(plutoRowResult); 
			contratoTipoServicoModelController.text = contratoSolicitacaoServicoModel.contratoTipoServicoModel?.nome ?? ''; 
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
			contratoSolicitacaoServicoModel.idSetor = plutoRowResult.cells['id']!.value; 
			contratoSolicitacaoServicoModel.setorModel!.plutoRowToObject(plutoRowResult); 
			setorModelController.text = contratoSolicitacaoServicoModel.setorModel?.nome ?? ''; 
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
			contratoSolicitacaoServicoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			contratoSolicitacaoServicoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = contratoSolicitacaoServicoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
			contratoSolicitacaoServicoModel.idCliente = plutoRowResult.cells['id']!.value; 
			contratoSolicitacaoServicoModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = contratoSolicitacaoServicoModel.viewPessoaClienteModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callViewPessoaFornecedorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Fornecedor]'; 
		lookupController.route = '/view-pessoa-fornecedor/'; 
		lookupController.gridColumns = viewPessoaFornecedorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaFornecedorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaFornecedorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contratoSolicitacaoServicoModel.idFornecedor = plutoRowResult.cells['id']!.value; 
			contratoSolicitacaoServicoModel.viewPessoaFornecedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaFornecedorModelController.text = contratoSolicitacaoServicoModel.viewPessoaFornecedorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "contrato_solicitacao_servico";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		contratoTipoServicoModelController.dispose();
		setorModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		viewPessoaClienteModelController.dispose();
		viewPessoaFornecedorModelController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}