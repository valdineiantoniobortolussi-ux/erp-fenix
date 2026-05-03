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
import 'package:patrimonio/app/data/repository/patrim_tipo_aquisicao_bem_repository.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';
import 'package:patrimonio/app/mixin/controller_base_mixin.dart';

class PatrimTipoAquisicaoBemController extends GetxController with ControllerBaseMixin {
  final PatrimTipoAquisicaoBemRepository patrimTipoAquisicaoBemRepository;
  PatrimTipoAquisicaoBemController({required this.patrimTipoAquisicaoBemRepository});

  // general
  final _dbColumns = PatrimTipoAquisicaoBemModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PatrimTipoAquisicaoBemModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = patrimTipoAquisicaoBemGridColumns();
  
  var _patrimTipoAquisicaoBemModelList = <PatrimTipoAquisicaoBemModel>[];

  final _patrimTipoAquisicaoBemModel = PatrimTipoAquisicaoBemModel().obs;
  PatrimTipoAquisicaoBemModel get patrimTipoAquisicaoBemModel => _patrimTipoAquisicaoBemModel.value;
  set patrimTipoAquisicaoBemModel(value) => _patrimTipoAquisicaoBemModel.value = value ?? PatrimTipoAquisicaoBemModel();

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
    for (var patrimTipoAquisicaoBemModel in _patrimTipoAquisicaoBemModelList) {
      plutoRowList.add(_getPlutoRow(patrimTipoAquisicaoBemModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PatrimTipoAquisicaoBemModel patrimTipoAquisicaoBemModel) {
    return PlutoRow(
      cells: _getPlutoCells(patrimTipoAquisicaoBemModel: patrimTipoAquisicaoBemModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PatrimTipoAquisicaoBemModel? patrimTipoAquisicaoBemModel}) {
    return {
			"id": PlutoCell(value: patrimTipoAquisicaoBemModel?.id ?? 0),
			"tipo": PlutoCell(value: patrimTipoAquisicaoBemModel?.tipo ?? ''),
			"nome": PlutoCell(value: patrimTipoAquisicaoBemModel?.nome ?? ''),
			"descricao": PlutoCell(value: patrimTipoAquisicaoBemModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _patrimTipoAquisicaoBemModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      patrimTipoAquisicaoBemModel.plutoRowToObject(plutoRow);
    } else {
      patrimTipoAquisicaoBemModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Aquisição Bem]';
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
    await Get.find<PatrimTipoAquisicaoBemController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await patrimTipoAquisicaoBemRepository.getList(filter: filter).then( (data){ _patrimTipoAquisicaoBemModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Aquisição Bem',
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
      Get.toNamed(Routes.patrimTipoAquisicaoBemEditPage)!.then((value) {
        if (patrimTipoAquisicaoBemModel.id == 0) {
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
    patrimTipoAquisicaoBemModel = PatrimTipoAquisicaoBemModel();
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
        if (await patrimTipoAquisicaoBemRepository.delete(id: currentRow.cells['id']!.value)) {
          _patrimTipoAquisicaoBemModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = patrimTipoAquisicaoBemModel.id;
		plutoRow.cells['tipo']?.value = patrimTipoAquisicaoBemModel.tipo;
		plutoRow.cells['nome']?.value = patrimTipoAquisicaoBemModel.nome;
		plutoRow.cells['descricao']?.value = patrimTipoAquisicaoBemModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await patrimTipoAquisicaoBemRepository.save(patrimTipoAquisicaoBemModel: patrimTipoAquisicaoBemModel); 
        if (result != null) {
          patrimTipoAquisicaoBemModel = result;
          if (_isInserting) {
            _patrimTipoAquisicaoBemModelList.add(result);
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
		functionName = "patrim_tipo_aquisicao_bem";
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