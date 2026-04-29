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
import 'package:contabil/app/data/repository/contabil_lancamento_padrao_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilLancamentoPadraoController extends GetxController with ControllerBaseMixin {
  final ContabilLancamentoPadraoRepository contabilLancamentoPadraoRepository;
  ContabilLancamentoPadraoController({required this.contabilLancamentoPadraoRepository});

  // general
  final _dbColumns = ContabilLancamentoPadraoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilLancamentoPadraoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilLancamentoPadraoGridColumns();
  
  var _contabilLancamentoPadraoModelList = <ContabilLancamentoPadraoModel>[];

  final _contabilLancamentoPadraoModel = ContabilLancamentoPadraoModel().obs;
  ContabilLancamentoPadraoModel get contabilLancamentoPadraoModel => _contabilLancamentoPadraoModel.value;
  set contabilLancamentoPadraoModel(value) => _contabilLancamentoPadraoModel.value = value ?? ContabilLancamentoPadraoModel();

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
    for (var contabilLancamentoPadraoModel in _contabilLancamentoPadraoModelList) {
      plutoRowList.add(_getPlutoRow(contabilLancamentoPadraoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilLancamentoPadraoModel contabilLancamentoPadraoModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilLancamentoPadraoModel: contabilLancamentoPadraoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilLancamentoPadraoModel? contabilLancamentoPadraoModel}) {
    return {
			"id": PlutoCell(value: contabilLancamentoPadraoModel?.id ?? 0),
			"descricao": PlutoCell(value: contabilLancamentoPadraoModel?.descricao ?? ''),
			"historico": PlutoCell(value: contabilLancamentoPadraoModel?.historico ?? ''),
			"idContaDebito": PlutoCell(value: contabilLancamentoPadraoModel?.idContaDebito ?? 0),
			"idContaCredito": PlutoCell(value: contabilLancamentoPadraoModel?.idContaCredito ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilLancamentoPadraoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilLancamentoPadraoModel.plutoRowToObject(plutoRow);
    } else {
      contabilLancamentoPadraoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Lancamento Padrão]';
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
    await Get.find<ContabilLancamentoPadraoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilLancamentoPadraoRepository.getList(filter: filter).then( (data){ _contabilLancamentoPadraoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Lancamento Padrão',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			historicoController.text = currentRow.cells['historico']?.value ?? '';
			idContaDebitoController.text = currentRow.cells['idContaDebito']?.value?.toString() ?? '';
			idContaCreditoController.text = currentRow.cells['idContaCredito']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilLancamentoPadraoEditPage)!.then((value) {
        if (contabilLancamentoPadraoModel.id == 0) {
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
    contabilLancamentoPadraoModel = ContabilLancamentoPadraoModel();
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
        if (await contabilLancamentoPadraoRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilLancamentoPadraoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();
	final historicoController = TextEditingController();
	final idContaDebitoController = TextEditingController();
	final idContaCreditoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilLancamentoPadraoModel.id;
		plutoRow.cells['descricao']?.value = contabilLancamentoPadraoModel.descricao;
		plutoRow.cells['historico']?.value = contabilLancamentoPadraoModel.historico;
		plutoRow.cells['idContaDebito']?.value = contabilLancamentoPadraoModel.idContaDebito;
		plutoRow.cells['idContaCredito']?.value = contabilLancamentoPadraoModel.idContaCredito;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilLancamentoPadraoRepository.save(contabilLancamentoPadraoModel: contabilLancamentoPadraoModel); 
        if (result != null) {
          contabilLancamentoPadraoModel = result;
          if (_isInserting) {
            _contabilLancamentoPadraoModelList.add(result);
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


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "contabil_lancamento_padrao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		descricaoController.dispose();
		historicoController.dispose();
		idContaDebitoController.dispose();
		idContaCreditoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}