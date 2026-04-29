import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';

import 'package:patrimonio/app/routes/app_routes.dart';
import 'package:patrimonio/app/data/repository/patrim_estado_conservacao_repository.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';
import 'package:patrimonio/app/mixin/controller_base_mixin.dart';

class PatrimEstadoConservacaoController extends GetxController with ControllerBaseMixin {
  final PatrimEstadoConservacaoRepository patrimEstadoConservacaoRepository;
  PatrimEstadoConservacaoController({required this.patrimEstadoConservacaoRepository});

  // general
  final _dbColumns = PatrimEstadoConservacaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PatrimEstadoConservacaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = patrimEstadoConservacaoGridColumns();
  
  var _patrimEstadoConservacaoModelList = <PatrimEstadoConservacaoModel>[];

  final _patrimEstadoConservacaoModel = PatrimEstadoConservacaoModel().obs;
  PatrimEstadoConservacaoModel get patrimEstadoConservacaoModel => _patrimEstadoConservacaoModel.value;
  set patrimEstadoConservacaoModel(value) => _patrimEstadoConservacaoModel.value = value ?? PatrimEstadoConservacaoModel();

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
    for (var patrimEstadoConservacaoModel in _patrimEstadoConservacaoModelList) {
      plutoRowList.add(_getPlutoRow(patrimEstadoConservacaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PatrimEstadoConservacaoModel patrimEstadoConservacaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(patrimEstadoConservacaoModel: patrimEstadoConservacaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PatrimEstadoConservacaoModel? patrimEstadoConservacaoModel}) {
    return {
			"id": PlutoCell(value: patrimEstadoConservacaoModel?.id ?? 0),
			"codigo": PlutoCell(value: patrimEstadoConservacaoModel?.codigo ?? ''),
			"nome": PlutoCell(value: patrimEstadoConservacaoModel?.nome ?? ''),
			"descricao": PlutoCell(value: patrimEstadoConservacaoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _patrimEstadoConservacaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      patrimEstadoConservacaoModel.plutoRowToObject(plutoRow);
    } else {
      patrimEstadoConservacaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Estado de Conservação]';
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
    await Get.find<PatrimEstadoConservacaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await patrimEstadoConservacaoRepository.getList(filter: filter).then( (data){ _patrimEstadoConservacaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Estado de Conservação',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.patrimEstadoConservacaoEditPage)!.then((value) {
        if (patrimEstadoConservacaoModel.id == 0) {
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
    patrimEstadoConservacaoModel = PatrimEstadoConservacaoModel();
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
        if (await patrimEstadoConservacaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _patrimEstadoConservacaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimEstadoConservacaoModel.id;
		plutoRow.cells['codigo']?.value = patrimEstadoConservacaoModel.codigo;
		plutoRow.cells['nome']?.value = patrimEstadoConservacaoModel.nome;
		plutoRow.cells['descricao']?.value = patrimEstadoConservacaoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await patrimEstadoConservacaoRepository.save(patrimEstadoConservacaoModel: patrimEstadoConservacaoModel); 
        if (result != null) {
          patrimEstadoConservacaoModel = result;
          if (_isInserting) {
            _patrimEstadoConservacaoModelList.add(result);
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
		functionName = "patrim_estado_conservacao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}