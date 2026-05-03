import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/controller/controller_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:nfe/app/routes/app_routes.dart';
import 'package:nfe/app/data/repository/nfe_importacao_detalhe_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeImportacaoDetalheController extends GetxController with ControllerBaseMixin {
  final NfeImportacaoDetalheRepository nfeImportacaoDetalheRepository;
  NfeImportacaoDetalheController({required this.nfeImportacaoDetalheRepository});

  // general
  final _dbColumns = NfeImportacaoDetalheModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeImportacaoDetalheModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeImportacaoDetalheGridColumns();
  
  var _nfeImportacaoDetalheModelList = <NfeImportacaoDetalheModel>[];

  final _nfeImportacaoDetalheModel = NfeImportacaoDetalheModel().obs;
  NfeImportacaoDetalheModel get nfeImportacaoDetalheModel => _nfeImportacaoDetalheModel.value;
  set nfeImportacaoDetalheModel(value) => _nfeImportacaoDetalheModel.value = value ?? NfeImportacaoDetalheModel();

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
    for (var nfeImportacaoDetalheModel in _nfeImportacaoDetalheModelList) {
      plutoRowList.add(_getPlutoRow(nfeImportacaoDetalheModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeImportacaoDetalheModel nfeImportacaoDetalheModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeImportacaoDetalheModel: nfeImportacaoDetalheModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeImportacaoDetalheModel? nfeImportacaoDetalheModel}) {
    return {
			"id": PlutoCell(value: nfeImportacaoDetalheModel?.id ?? 0),
			"nfeDeclaracaoImportacao": PlutoCell(value: nfeImportacaoDetalheModel?.nfeDeclaracaoImportacaoModel?.numeroDocumento ?? ''),
			"numeroAdicao": PlutoCell(value: nfeImportacaoDetalheModel?.numeroAdicao ?? 0),
			"numeroSequencial": PlutoCell(value: nfeImportacaoDetalheModel?.numeroSequencial ?? 0),
			"codigoFabricanteEstrangeiro": PlutoCell(value: nfeImportacaoDetalheModel?.codigoFabricanteEstrangeiro ?? ''),
			"valorDesconto": PlutoCell(value: nfeImportacaoDetalheModel?.valorDesconto ?? 0),
			"drawback": PlutoCell(value: nfeImportacaoDetalheModel?.drawback ?? 0),
			"idNfeDeclaracaoImportacao": PlutoCell(value: nfeImportacaoDetalheModel?.idNfeDeclaracaoImportacao ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeImportacaoDetalheModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeImportacaoDetalheModel.plutoRowToObject(plutoRow);
    } else {
      nfeImportacaoDetalheModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Importação Detalhe]';
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
    await Get.find<NfeImportacaoDetalheController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeImportacaoDetalheRepository.getList(filter: filter).then( (data){ _nfeImportacaoDetalheModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Importação Detalhe',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeDeclaracaoImportacaoModelController.text = currentRow.cells['nfeDeclaracaoImportacao']?.value ?? '';
			numeroAdicaoController.text = currentRow.cells['numeroAdicao']?.value?.toString() ?? '';
			numeroSequencialController.text = currentRow.cells['numeroSequencial']?.value?.toString() ?? '';
			codigoFabricanteEstrangeiroController.text = currentRow.cells['codigoFabricanteEstrangeiro']?.value ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			drawbackController.text = currentRow.cells['drawback']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeImportacaoDetalheEditPage)!.then((value) {
        if (nfeImportacaoDetalheModel.id == 0) {
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
    nfeImportacaoDetalheModel = NfeImportacaoDetalheModel();
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
        if (await nfeImportacaoDetalheRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeImportacaoDetalheModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeDeclaracaoImportacaoModelController = TextEditingController();
	final numeroAdicaoController = TextEditingController();
	final numeroSequencialController = TextEditingController();
	final codigoFabricanteEstrangeiroController = TextEditingController();
	final valorDescontoController = MoneyMaskedTextController();
	final drawbackController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeImportacaoDetalheModel.id;
		plutoRow.cells['idNfeDeclaracaoImportacao']?.value = nfeImportacaoDetalheModel.idNfeDeclaracaoImportacao;
		plutoRow.cells['nfeDeclaracaoImportacao']?.value = nfeImportacaoDetalheModel.nfeDeclaracaoImportacaoModel?.numeroDocumento;
		plutoRow.cells['numeroAdicao']?.value = nfeImportacaoDetalheModel.numeroAdicao;
		plutoRow.cells['numeroSequencial']?.value = nfeImportacaoDetalheModel.numeroSequencial;
		plutoRow.cells['codigoFabricanteEstrangeiro']?.value = nfeImportacaoDetalheModel.codigoFabricanteEstrangeiro;
		plutoRow.cells['valorDesconto']?.value = nfeImportacaoDetalheModel.valorDesconto;
		plutoRow.cells['drawback']?.value = nfeImportacaoDetalheModel.drawback;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeImportacaoDetalheRepository.save(nfeImportacaoDetalheModel: nfeImportacaoDetalheModel); 
        if (result != null) {
          nfeImportacaoDetalheModel = result;
          if (_isInserting) {
            _nfeImportacaoDetalheModelList.add(result);
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

	Future callNfeDeclaracaoImportacaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Nfe Declaracao Importacao]'; 
		lookupController.route = '/nfe-declaracao-importacao/'; 
		lookupController.gridColumns = nfeDeclaracaoImportacaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeDeclaracaoImportacaoModel.aliasColumns; 
		lookupController.dbColumns = NfeDeclaracaoImportacaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeImportacaoDetalheModel.idNfeDeclaracaoImportacao = plutoRowResult.cells['id']!.value; 
			nfeImportacaoDetalheModel.nfeDeclaracaoImportacaoModel!.plutoRowToObject(plutoRowResult); 
			nfeDeclaracaoImportacaoModelController.text = nfeImportacaoDetalheModel.nfeDeclaracaoImportacaoModel?.numeroDocumento ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nfe_importacao_detalhe";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeDeclaracaoImportacaoModelController.dispose();
		numeroAdicaoController.dispose();
		numeroSequencialController.dispose();
		codigoFabricanteEstrangeiroController.dispose();
		valorDescontoController.dispose();
		drawbackController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}