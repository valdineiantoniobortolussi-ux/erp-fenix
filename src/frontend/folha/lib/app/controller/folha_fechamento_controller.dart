import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_fechamento_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaFechamentoController extends GetxController with ControllerBaseMixin {
  final FolhaFechamentoRepository folhaFechamentoRepository;
  FolhaFechamentoController({required this.folhaFechamentoRepository});

  // general
  final _dbColumns = FolhaFechamentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaFechamentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaFechamentoGridColumns();
  
  var _folhaFechamentoModelList = <FolhaFechamentoModel>[];

  final _folhaFechamentoModel = FolhaFechamentoModel().obs;
  FolhaFechamentoModel get folhaFechamentoModel => _folhaFechamentoModel.value;
  set folhaFechamentoModel(value) => _folhaFechamentoModel.value = value ?? FolhaFechamentoModel();

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
    for (var folhaFechamentoModel in _folhaFechamentoModelList) {
      plutoRowList.add(_getPlutoRow(folhaFechamentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaFechamentoModel folhaFechamentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaFechamentoModel: folhaFechamentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaFechamentoModel? folhaFechamentoModel}) {
    return {
			"id": PlutoCell(value: folhaFechamentoModel?.id ?? 0),
			"fechamentoAtual": PlutoCell(value: folhaFechamentoModel?.fechamentoAtual ?? ''),
			"proximoFechamento": PlutoCell(value: folhaFechamentoModel?.proximoFechamento ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaFechamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaFechamentoModel.plutoRowToObject(plutoRow);
    } else {
      folhaFechamentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Fechamento da Folha]';
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
    await Get.find<FolhaFechamentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaFechamentoRepository.getList(filter: filter).then( (data){ _folhaFechamentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Fechamento da Folha',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			fechamentoAtualController.text = currentRow.cells['fechamentoAtual']?.value ?? '';
			proximoFechamentoController.text = currentRow.cells['proximoFechamento']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaFechamentoEditPage)!.then((value) {
        if (folhaFechamentoModel.id == 0) {
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
    folhaFechamentoModel = FolhaFechamentoModel();
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
        if (await folhaFechamentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaFechamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final fechamentoAtualController = MaskedTextController(mask: '00/0000',);
	final proximoFechamentoController = MaskedTextController(mask: '00/0000',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaFechamentoModel.id;
		plutoRow.cells['fechamentoAtual']?.value = folhaFechamentoModel.fechamentoAtual;
		plutoRow.cells['proximoFechamento']?.value = folhaFechamentoModel.proximoFechamento;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaFechamentoRepository.save(folhaFechamentoModel: folhaFechamentoModel); 
        if (result != null) {
          folhaFechamentoModel = result;
          if (_isInserting) {
            _folhaFechamentoModelList.add(result);
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
		functionName = "folha_fechamento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		fechamentoAtualController.dispose();
		proximoFechamentoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}