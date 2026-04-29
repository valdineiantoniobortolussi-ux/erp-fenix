import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/fin_documento_origem_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinDocumentoOrigemController extends GetxController with ControllerBaseMixin {
  final FinDocumentoOrigemRepository finDocumentoOrigemRepository;
  FinDocumentoOrigemController({required this.finDocumentoOrigemRepository});

  // general
  final _dbColumns = FinDocumentoOrigemModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinDocumentoOrigemModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finDocumentoOrigemGridColumns();
  
  var _finDocumentoOrigemModelList = <FinDocumentoOrigemModel>[];

  final _finDocumentoOrigemModel = FinDocumentoOrigemModel().obs;
  FinDocumentoOrigemModel get finDocumentoOrigemModel => _finDocumentoOrigemModel.value;
  set finDocumentoOrigemModel(value) => _finDocumentoOrigemModel.value = value ?? FinDocumentoOrigemModel();

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
    for (var finDocumentoOrigemModel in _finDocumentoOrigemModelList) {
      plutoRowList.add(_getPlutoRow(finDocumentoOrigemModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinDocumentoOrigemModel finDocumentoOrigemModel) {
    return PlutoRow(
      cells: _getPlutoCells(finDocumentoOrigemModel: finDocumentoOrigemModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinDocumentoOrigemModel? finDocumentoOrigemModel}) {
    return {
			"id": PlutoCell(value: finDocumentoOrigemModel?.id ?? 0),
			"codigo": PlutoCell(value: finDocumentoOrigemModel?.codigo ?? ''),
			"sigla": PlutoCell(value: finDocumentoOrigemModel?.sigla ?? ''),
			"descricao": PlutoCell(value: finDocumentoOrigemModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finDocumentoOrigemModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finDocumentoOrigemModel.plutoRowToObject(plutoRow);
    } else {
      finDocumentoOrigemModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Documento Origem]';
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
    await Get.find<FinDocumentoOrigemController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finDocumentoOrigemRepository.getList(filter: filter).then( (data){ _finDocumentoOrigemModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Documento Origem',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			siglaController.text = currentRow.cells['sigla']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finDocumentoOrigemEditPage)!.then((value) {
        if (finDocumentoOrigemModel.id == 0) {
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
    finDocumentoOrigemModel = FinDocumentoOrigemModel();
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
        if (await finDocumentoOrigemRepository.delete(id: currentRow.cells['id']!.value)) {
          _finDocumentoOrigemModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoController = TextEditingController();
	final siglaController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finDocumentoOrigemModel.id;
		plutoRow.cells['codigo']?.value = finDocumentoOrigemModel.codigo;
		plutoRow.cells['sigla']?.value = finDocumentoOrigemModel.sigla;
		plutoRow.cells['descricao']?.value = finDocumentoOrigemModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finDocumentoOrigemRepository.save(finDocumentoOrigemModel: finDocumentoOrigemModel); 
        if (result != null) {
          finDocumentoOrigemModel = result;
          if (_isInserting) {
            _finDocumentoOrigemModelList.add(result);
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
		functionName = "fin_documento_origem";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		siglaController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}