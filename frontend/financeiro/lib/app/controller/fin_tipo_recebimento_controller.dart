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
import 'package:financeiro/app/data/repository/fin_tipo_recebimento_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinTipoRecebimentoController extends GetxController with ControllerBaseMixin {
  final FinTipoRecebimentoRepository finTipoRecebimentoRepository;
  FinTipoRecebimentoController({required this.finTipoRecebimentoRepository});

  // general
  final _dbColumns = FinTipoRecebimentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinTipoRecebimentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finTipoRecebimentoGridColumns();
  
  var _finTipoRecebimentoModelList = <FinTipoRecebimentoModel>[];

  final _finTipoRecebimentoModel = FinTipoRecebimentoModel().obs;
  FinTipoRecebimentoModel get finTipoRecebimentoModel => _finTipoRecebimentoModel.value;
  set finTipoRecebimentoModel(value) => _finTipoRecebimentoModel.value = value ?? FinTipoRecebimentoModel();

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
    for (var finTipoRecebimentoModel in _finTipoRecebimentoModelList) {
      plutoRowList.add(_getPlutoRow(finTipoRecebimentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinTipoRecebimentoModel finTipoRecebimentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(finTipoRecebimentoModel: finTipoRecebimentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinTipoRecebimentoModel? finTipoRecebimentoModel}) {
    return {
			"id": PlutoCell(value: finTipoRecebimentoModel?.id ?? 0),
			"codigo": PlutoCell(value: finTipoRecebimentoModel?.codigo ?? ''),
			"descricao": PlutoCell(value: finTipoRecebimentoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finTipoRecebimentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finTipoRecebimentoModel.plutoRowToObject(plutoRow);
    } else {
      finTipoRecebimentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Recebimento]';
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
    await Get.find<FinTipoRecebimentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finTipoRecebimentoRepository.getList(filter: filter).then( (data){ _finTipoRecebimentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Recebimento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finTipoRecebimentoEditPage)!.then((value) {
        if (finTipoRecebimentoModel.id == 0) {
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
    finTipoRecebimentoModel = FinTipoRecebimentoModel();
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
        if (await finTipoRecebimentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _finTipoRecebimentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finTipoRecebimentoModel.id;
		plutoRow.cells['codigo']?.value = finTipoRecebimentoModel.codigo;
		plutoRow.cells['descricao']?.value = finTipoRecebimentoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finTipoRecebimentoRepository.save(finTipoRecebimentoModel: finTipoRecebimentoModel); 
        if (result != null) {
          finTipoRecebimentoModel = result;
          if (_isInserting) {
            _finTipoRecebimentoModelList.add(result);
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
		functionName = "fin_tipo_recebimento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}