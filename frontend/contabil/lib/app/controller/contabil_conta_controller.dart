import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_conta_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilContaController extends GetxController with ControllerBaseMixin {
  final ContabilContaRepository contabilContaRepository;
  ContabilContaController({required this.contabilContaRepository});

  // general
  final _dbColumns = ContabilContaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilContaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilContaGridColumns();
  
  var _contabilContaModelList = <ContabilContaModel>[];

  final _contabilContaModel = ContabilContaModel().obs;
  ContabilContaModel get contabilContaModel => _contabilContaModel.value;
  set contabilContaModel(value) => _contabilContaModel.value = value ?? ContabilContaModel();

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
    for (var contabilContaModel in _contabilContaModelList) {
      plutoRowList.add(_getPlutoRow(contabilContaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilContaModel contabilContaModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilContaModel: contabilContaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilContaModel? contabilContaModel}) {
    return {
			"id": PlutoCell(value: contabilContaModel?.id ?? 0),
			"planoConta": PlutoCell(value: contabilContaModel?.planoContaModel?.nome ?? ''),
			"planoContaRefSped": PlutoCell(value: contabilContaModel?.planoContaRefSpedModel?.codCtaRef ?? ''),
			"idContabilConta": PlutoCell(value: contabilContaModel?.idContabilConta ?? 0),
			"classificacao": PlutoCell(value: contabilContaModel?.classificacao ?? ''),
			"tipo": PlutoCell(value: contabilContaModel?.tipo ?? ''),
			"descricao": PlutoCell(value: contabilContaModel?.descricao ?? ''),
			"dataInclusao": PlutoCell(value: contabilContaModel?.dataInclusao ?? ''),
			"situacao": PlutoCell(value: contabilContaModel?.situacao ?? ''),
			"natureza": PlutoCell(value: contabilContaModel?.natureza ?? ''),
			"patrimonioResultado": PlutoCell(value: contabilContaModel?.patrimonioResultado ?? ''),
			"livroCaixa": PlutoCell(value: contabilContaModel?.livroCaixa ?? ''),
			"dfc": PlutoCell(value: contabilContaModel?.dfc ?? ''),
			"codigoEfd": PlutoCell(value: contabilContaModel?.codigoEfd ?? ''),
			"ordem": PlutoCell(value: contabilContaModel?.ordem ?? ''),
			"codigoReduzido": PlutoCell(value: contabilContaModel?.codigoReduzido ?? ''),
			"idPlanoConta": PlutoCell(value: contabilContaModel?.idPlanoConta ?? 0),
			"idPlanoContaRefSped": PlutoCell(value: contabilContaModel?.idPlanoContaRefSped ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilContaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilContaModel.plutoRowToObject(plutoRow);
    } else {
      contabilContaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Conta Contábil]';
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
    await Get.find<ContabilContaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilContaRepository.getList(filter: filter).then( (data){ _contabilContaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Conta Contábil',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			planoContaModelController.text = currentRow.cells['planoConta']?.value ?? '';
			planoContaRefSpedModelController.text = currentRow.cells['planoContaRefSped']?.value ?? '';
			idContabilContaController.text = currentRow.cells['idContabilConta']?.value?.toString() ?? '';
			classificacaoController.text = currentRow.cells['classificacao']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			codigoEfdController.text = currentRow.cells['codigoEfd']?.value ?? '';
			ordemController.text = currentRow.cells['ordem']?.value ?? '';
			codigoReduzidoController.text = currentRow.cells['codigoReduzido']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilContaEditPage)!.then((value) {
        if (contabilContaModel.id == 0) {
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
    contabilContaModel = ContabilContaModel();
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
        if (await contabilContaRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilContaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final planoContaModelController = TextEditingController();
	final planoContaRefSpedModelController = TextEditingController();
	final idContabilContaController = TextEditingController();
	final classificacaoController = TextEditingController();
	final descricaoController = TextEditingController();
	final codigoEfdController = TextEditingController();
	final ordemController = TextEditingController();
	final codigoReduzidoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilContaModel.id;
		plutoRow.cells['idPlanoConta']?.value = contabilContaModel.idPlanoConta;
		plutoRow.cells['planoConta']?.value = contabilContaModel.planoContaModel?.nome;
		plutoRow.cells['idPlanoContaRefSped']?.value = contabilContaModel.idPlanoContaRefSped;
		plutoRow.cells['planoContaRefSped']?.value = contabilContaModel.planoContaRefSpedModel?.codCtaRef;
		plutoRow.cells['idContabilConta']?.value = contabilContaModel.idContabilConta;
		plutoRow.cells['classificacao']?.value = contabilContaModel.classificacao;
		plutoRow.cells['tipo']?.value = contabilContaModel.tipo;
		plutoRow.cells['descricao']?.value = contabilContaModel.descricao;
		plutoRow.cells['dataInclusao']?.value = Util.formatDate(contabilContaModel.dataInclusao);
		plutoRow.cells['situacao']?.value = contabilContaModel.situacao;
		plutoRow.cells['natureza']?.value = contabilContaModel.natureza;
		plutoRow.cells['patrimonioResultado']?.value = contabilContaModel.patrimonioResultado;
		plutoRow.cells['livroCaixa']?.value = contabilContaModel.livroCaixa;
		plutoRow.cells['dfc']?.value = contabilContaModel.dfc;
		plutoRow.cells['codigoEfd']?.value = contabilContaModel.codigoEfd;
		plutoRow.cells['ordem']?.value = contabilContaModel.ordem;
		plutoRow.cells['codigoReduzido']?.value = contabilContaModel.codigoReduzido;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilContaRepository.save(contabilContaModel: contabilContaModel); 
        if (result != null) {
          contabilContaModel = result;
          if (_isInserting) {
            _contabilContaModelList.add(result);
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

	Future callPlanoContaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Plano Conta]'; 
		lookupController.route = '/plano-conta/'; 
		lookupController.gridColumns = planoContaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PlanoContaModel.aliasColumns; 
		lookupController.dbColumns = PlanoContaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilContaModel.idPlanoConta = plutoRowResult.cells['id']!.value; 
			contabilContaModel.planoContaModel!.plutoRowToObject(plutoRowResult); 
			planoContaModelController.text = contabilContaModel.planoContaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callPlanoContaRefSpedLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Conta SPED]'; 
		lookupController.route = '/plano-conta-ref-sped/'; 
		lookupController.gridColumns = planoContaRefSpedGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PlanoContaRefSpedModel.aliasColumns; 
		lookupController.dbColumns = PlanoContaRefSpedModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilContaModel.idPlanoContaRefSped = plutoRowResult.cells['id']!.value; 
			contabilContaModel.planoContaRefSpedModel!.plutoRowToObject(plutoRowResult); 
			planoContaRefSpedModelController.text = contabilContaModel.planoContaRefSpedModel?.codCtaRef ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "contabil_conta";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		planoContaModelController.dispose();
		planoContaRefSpedModelController.dispose();
		idContabilContaController.dispose();
		classificacaoController.dispose();
		descricaoController.dispose();
		codigoEfdController.dispose();
		ordemController.dispose();
		codigoReduzidoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}
