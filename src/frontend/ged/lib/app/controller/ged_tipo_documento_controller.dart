import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/controller/controller_imports.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:ged/app/page/grid_columns/grid_columns_imports.dart';

import 'package:ged/app/routes/app_routes.dart';
import 'package:ged/app/data/repository/ged_tipo_documento_repository.dart';
import 'package:ged/app/page/shared_page/shared_page_imports.dart';
import 'package:ged/app/page/shared_widget/message_dialog.dart';
import 'package:ged/app/mixin/controller_base_mixin.dart';

class GedTipoDocumentoController extends GetxController with ControllerBaseMixin {
  final GedTipoDocumentoRepository gedTipoDocumentoRepository;
  GedTipoDocumentoController({required this.gedTipoDocumentoRepository});

  // general
  final _dbColumns = GedTipoDocumentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = GedTipoDocumentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = gedTipoDocumentoGridColumns();
  
  var _gedTipoDocumentoModelList = <GedTipoDocumentoModel>[];

  final _gedTipoDocumentoModel = GedTipoDocumentoModel().obs;
  GedTipoDocumentoModel get gedTipoDocumentoModel => _gedTipoDocumentoModel.value;
  set gedTipoDocumentoModel(value) => _gedTipoDocumentoModel.value = value ?? GedTipoDocumentoModel();

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
    for (var gedTipoDocumentoModel in _gedTipoDocumentoModelList) {
      plutoRowList.add(_getPlutoRow(gedTipoDocumentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(GedTipoDocumentoModel gedTipoDocumentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(gedTipoDocumentoModel: gedTipoDocumentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ GedTipoDocumentoModel? gedTipoDocumentoModel}) {
    return {
			"id": PlutoCell(value: gedTipoDocumentoModel?.id ?? 0),
			"nome": PlutoCell(value: gedTipoDocumentoModel?.nome ?? ''),
			"tamanhoMaximo": PlutoCell(value: gedTipoDocumentoModel?.tamanhoMaximo ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _gedTipoDocumentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      gedTipoDocumentoModel.plutoRowToObject(plutoRow);
    } else {
      gedTipoDocumentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Documento]';
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
    await Get.find<GedTipoDocumentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await gedTipoDocumentoRepository.getList(filter: filter).then( (data){ _gedTipoDocumentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Documento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			tamanhoMaximoController.text = currentRow.cells['tamanhoMaximo']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.gedTipoDocumentoEditPage)!.then((value) {
        if (gedTipoDocumentoModel.id == 0) {
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
    gedTipoDocumentoModel = GedTipoDocumentoModel();
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
        if (await gedTipoDocumentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _gedTipoDocumentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();
	final tamanhoMaximoController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = gedTipoDocumentoModel.id;
		plutoRow.cells['nome']?.value = gedTipoDocumentoModel.nome;
		plutoRow.cells['tamanhoMaximo']?.value = gedTipoDocumentoModel.tamanhoMaximo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await gedTipoDocumentoRepository.save(gedTipoDocumentoModel: gedTipoDocumentoModel); 
        if (result != null) {
          gedTipoDocumentoModel = result;
          if (_isInserting) {
            _gedTipoDocumentoModelList.add(result);
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
		functionName = "ged_tipo_documento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		tamanhoMaximoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}