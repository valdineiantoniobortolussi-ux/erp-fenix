import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/controller/controller_imports.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/page/grid_columns/grid_columns_imports.dart';
import 'package:tributacao/app/mixin/controller_base_mixin.dart';

import 'package:tributacao/app/routes/app_routes.dart';
import 'package:tributacao/app/data/repository/tribut_operacao_fiscal_repository.dart';
import 'package:tributacao/app/page/shared_page/shared_page_imports.dart';
import 'package:tributacao/app/page/shared_widget/message_dialog.dart';

class TributOperacaoFiscalController extends GetxController with ControllerBaseMixin {
  final TributOperacaoFiscalRepository tributOperacaoFiscalRepository;
  TributOperacaoFiscalController({required this.tributOperacaoFiscalRepository});

  // general
  final _dbColumns = TributOperacaoFiscalModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = TributOperacaoFiscalModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = tributOperacaoFiscalGridColumns();
  
  var _tributOperacaoFiscalModelList = <TributOperacaoFiscalModel>[];

  final _tributOperacaoFiscalModel = TributOperacaoFiscalModel().obs;
  TributOperacaoFiscalModel get tributOperacaoFiscalModel => _tributOperacaoFiscalModel.value;
  set tributOperacaoFiscalModel(value) => _tributOperacaoFiscalModel.value = value ?? TributOperacaoFiscalModel();

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
    for (var tributOperacaoFiscalModel in _tributOperacaoFiscalModelList) {
      plutoRowList.add(_getPlutoRow(tributOperacaoFiscalModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(TributOperacaoFiscalModel tributOperacaoFiscalModel) {
    return PlutoRow(
      cells: _getPlutoCells(tributOperacaoFiscalModel: tributOperacaoFiscalModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ TributOperacaoFiscalModel? tributOperacaoFiscalModel}) {
    return {
			"id": PlutoCell(value: tributOperacaoFiscalModel?.id ?? 0),
			"cfop": PlutoCell(value: tributOperacaoFiscalModel?.cfop ?? 0),
			"descricao": PlutoCell(value: tributOperacaoFiscalModel?.descricao ?? ''),
			"descricaoNaNf": PlutoCell(value: tributOperacaoFiscalModel?.descricaoNaNf ?? ''),
			"observacao": PlutoCell(value: tributOperacaoFiscalModel?.observacao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _tributOperacaoFiscalModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      tributOperacaoFiscalModel.plutoRowToObject(plutoRow);
    } else {
      tributOperacaoFiscalModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tribut Operacao Fiscal]';
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
    await Get.find<TributOperacaoFiscalController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await tributOperacaoFiscalRepository.getList(filter: filter).then( (data){ _tributOperacaoFiscalModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tribut Operacao Fiscal',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cfopController.text = currentRow.cells['cfop']?.value?.toString() ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			descricaoNaNfController.text = currentRow.cells['descricaoNaNf']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.tributOperacaoFiscalEditPage)!.then((value) {
        if (tributOperacaoFiscalModel.id == 0) {
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
    tributOperacaoFiscalModel = TributOperacaoFiscalModel();
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
        if (await tributOperacaoFiscalRepository.delete(id: currentRow.cells['id']!.value)) {
          _tributOperacaoFiscalModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cfopController = TextEditingController();
	final descricaoController = TextEditingController();
	final descricaoNaNfController = TextEditingController();
	final observacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tributOperacaoFiscalModel.id;
		plutoRow.cells['cfop']?.value = tributOperacaoFiscalModel.cfop;
		plutoRow.cells['descricao']?.value = tributOperacaoFiscalModel.descricao;
		plutoRow.cells['descricaoNaNf']?.value = tributOperacaoFiscalModel.descricaoNaNf;
		plutoRow.cells['observacao']?.value = tributOperacaoFiscalModel.observacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await tributOperacaoFiscalRepository.save(tributOperacaoFiscalModel: tributOperacaoFiscalModel); 
        if (result != null) {
          tributOperacaoFiscalModel = result;
          if (_isInserting) {
            _tributOperacaoFiscalModelList.add(result);
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
    functionName = "TRIBUT_OPERACAO_FISCAL";
    setPrivilege();    
    super.onInit();
  }

  @override
  void onClose() {
		cfopController.dispose();
		descricaoController.dispose();
		descricaoNaNfController.dispose();
		observacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}