import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_ferias_coletivas_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaFeriasColetivasController extends GetxController with ControllerBaseMixin {
  final FolhaFeriasColetivasRepository folhaFeriasColetivasRepository;
  FolhaFeriasColetivasController({required this.folhaFeriasColetivasRepository});

  // general
  final _dbColumns = FolhaFeriasColetivasModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaFeriasColetivasModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaFeriasColetivasGridColumns();
  
  var _folhaFeriasColetivasModelList = <FolhaFeriasColetivasModel>[];

  final _folhaFeriasColetivasModel = FolhaFeriasColetivasModel().obs;
  FolhaFeriasColetivasModel get folhaFeriasColetivasModel => _folhaFeriasColetivasModel.value;
  set folhaFeriasColetivasModel(value) => _folhaFeriasColetivasModel.value = value ?? FolhaFeriasColetivasModel();

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
    for (var folhaFeriasColetivasModel in _folhaFeriasColetivasModelList) {
      plutoRowList.add(_getPlutoRow(folhaFeriasColetivasModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaFeriasColetivasModel folhaFeriasColetivasModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaFeriasColetivasModel: folhaFeriasColetivasModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaFeriasColetivasModel? folhaFeriasColetivasModel}) {
    return {
			"id": PlutoCell(value: folhaFeriasColetivasModel?.id ?? 0),
			"dataInicio": PlutoCell(value: folhaFeriasColetivasModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: folhaFeriasColetivasModel?.dataFim ?? ''),
			"diasGozo": PlutoCell(value: folhaFeriasColetivasModel?.diasGozo ?? 0),
			"abonoPecuniarioInicio": PlutoCell(value: folhaFeriasColetivasModel?.abonoPecuniarioInicio ?? ''),
			"abonoPecuniarioFim": PlutoCell(value: folhaFeriasColetivasModel?.abonoPecuniarioFim ?? ''),
			"diasAbono": PlutoCell(value: folhaFeriasColetivasModel?.diasAbono ?? 0),
			"dataPagamento": PlutoCell(value: folhaFeriasColetivasModel?.dataPagamento ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaFeriasColetivasModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaFeriasColetivasModel.plutoRowToObject(plutoRow);
    } else {
      folhaFeriasColetivasModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Férias Coletivas]';
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
    await Get.find<FolhaFeriasColetivasController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaFeriasColetivasRepository.getList(filter: filter).then( (data){ _folhaFeriasColetivasModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Férias Coletivas',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			diasGozoController.text = currentRow.cells['diasGozo']?.value?.toString() ?? '';
			diasAbonoController.text = currentRow.cells['diasAbono']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaFeriasColetivasEditPage)!.then((value) {
        if (folhaFeriasColetivasModel.id == 0) {
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
    folhaFeriasColetivasModel = FolhaFeriasColetivasModel();
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
        if (await folhaFeriasColetivasRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaFeriasColetivasModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final diasGozoController = TextEditingController();
	final diasAbonoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaFeriasColetivasModel.id;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(folhaFeriasColetivasModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(folhaFeriasColetivasModel.dataFim);
		plutoRow.cells['diasGozo']?.value = folhaFeriasColetivasModel.diasGozo;
		plutoRow.cells['abonoPecuniarioInicio']?.value = Util.formatDate(folhaFeriasColetivasModel.abonoPecuniarioInicio);
		plutoRow.cells['abonoPecuniarioFim']?.value = Util.formatDate(folhaFeriasColetivasModel.abonoPecuniarioFim);
		plutoRow.cells['diasAbono']?.value = folhaFeriasColetivasModel.diasAbono;
		plutoRow.cells['dataPagamento']?.value = Util.formatDate(folhaFeriasColetivasModel.dataPagamento);
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaFeriasColetivasRepository.save(folhaFeriasColetivasModel: folhaFeriasColetivasModel); 
        if (result != null) {
          folhaFeriasColetivasModel = result;
          if (_isInserting) {
            _folhaFeriasColetivasModelList.add(result);
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
		functionName = "folha_ferias_coletivas";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		diasGozoController.dispose();
		diasAbonoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}