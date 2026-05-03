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
import 'package:tributacao/app/data/repository/tribut_grupo_tributario_repository.dart';
import 'package:tributacao/app/page/shared_page/shared_page_imports.dart';
import 'package:tributacao/app/page/shared_widget/message_dialog.dart';

class TributGrupoTributarioController extends GetxController with ControllerBaseMixin {
  final TributGrupoTributarioRepository tributGrupoTributarioRepository;
  TributGrupoTributarioController({required this.tributGrupoTributarioRepository});

  // general
  final _dbColumns = TributGrupoTributarioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = TributGrupoTributarioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = tributGrupoTributarioGridColumns();
  
  var _tributGrupoTributarioModelList = <TributGrupoTributarioModel>[];

  final _tributGrupoTributarioModel = TributGrupoTributarioModel().obs;
  TributGrupoTributarioModel get tributGrupoTributarioModel => _tributGrupoTributarioModel.value;
  set tributGrupoTributarioModel(value) => _tributGrupoTributarioModel.value = value ?? TributGrupoTributarioModel();

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
    for (var tributGrupoTributarioModel in _tributGrupoTributarioModelList) {
      plutoRowList.add(_getPlutoRow(tributGrupoTributarioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(TributGrupoTributarioModel tributGrupoTributarioModel) {
    return PlutoRow(
      cells: _getPlutoCells(tributGrupoTributarioModel: tributGrupoTributarioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ TributGrupoTributarioModel? tributGrupoTributarioModel}) {
    return {
			"id": PlutoCell(value: tributGrupoTributarioModel?.id ?? 0),
			"descricao": PlutoCell(value: tributGrupoTributarioModel?.descricao ?? ''),
			"origemMercadoria": PlutoCell(value: tributGrupoTributarioModel?.origemMercadoria ?? ''),
			"observacao": PlutoCell(value: tributGrupoTributarioModel?.observacao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _tributGrupoTributarioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      tributGrupoTributarioModel.plutoRowToObject(plutoRow);
    } else {
      tributGrupoTributarioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tribut Grupo Tributario]';
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
    await Get.find<TributGrupoTributarioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await tributGrupoTributarioRepository.getList(filter: filter).then( (data){ _tributGrupoTributarioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tribut Grupo Tributario',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.tributGrupoTributarioEditPage)!.then((value) {
        if (tributGrupoTributarioModel.id == 0) {
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
    tributGrupoTributarioModel = TributGrupoTributarioModel();
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
        if (await tributGrupoTributarioRepository.delete(id: currentRow.cells['id']!.value)) {
          _tributGrupoTributarioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final observacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tributGrupoTributarioModel.id;
		plutoRow.cells['descricao']?.value = tributGrupoTributarioModel.descricao;
		plutoRow.cells['origemMercadoria']?.value = tributGrupoTributarioModel.origemMercadoria;
		plutoRow.cells['observacao']?.value = tributGrupoTributarioModel.observacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await tributGrupoTributarioRepository.save(tributGrupoTributarioModel: tributGrupoTributarioModel); 
        if (result != null) {
          tributGrupoTributarioModel = result;
          if (_isInserting) {
            _tributGrupoTributarioModelList.add(result);
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
    functionName = "TRIBUT_GRUPO_TRIBUTARIO";
    setPrivilege();    
    super.onInit();
  }

  @override
  void onClose() {
		descricaoController.dispose();
		observacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}