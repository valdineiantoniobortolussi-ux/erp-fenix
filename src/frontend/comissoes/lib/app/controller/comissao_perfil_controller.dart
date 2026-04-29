import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:comissoes/app/infra/infra_imports.dart';
import 'package:comissoes/app/controller/controller_imports.dart';
import 'package:comissoes/app/data/model/model_imports.dart';
import 'package:comissoes/app/page/grid_columns/grid_columns_imports.dart';

import 'package:comissoes/app/routes/app_routes.dart';
import 'package:comissoes/app/data/repository/comissao_perfil_repository.dart';
import 'package:comissoes/app/page/shared_page/shared_page_imports.dart';
import 'package:comissoes/app/page/shared_widget/message_dialog.dart';
import 'package:comissoes/app/mixin/controller_base_mixin.dart';

class ComissaoPerfilController extends GetxController with ControllerBaseMixin {
  final ComissaoPerfilRepository comissaoPerfilRepository;
  ComissaoPerfilController({required this.comissaoPerfilRepository});

  // general
  final _dbColumns = ComissaoPerfilModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ComissaoPerfilModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = comissaoPerfilGridColumns();
  
  var _comissaoPerfilModelList = <ComissaoPerfilModel>[];

  final _comissaoPerfilModel = ComissaoPerfilModel().obs;
  ComissaoPerfilModel get comissaoPerfilModel => _comissaoPerfilModel.value;
  set comissaoPerfilModel(value) => _comissaoPerfilModel.value = value ?? ComissaoPerfilModel();

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
    for (var comissaoPerfilModel in _comissaoPerfilModelList) {
      plutoRowList.add(_getPlutoRow(comissaoPerfilModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ComissaoPerfilModel comissaoPerfilModel) {
    return PlutoRow(
      cells: _getPlutoCells(comissaoPerfilModel: comissaoPerfilModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ComissaoPerfilModel? comissaoPerfilModel}) {
    return {
			"id": PlutoCell(value: comissaoPerfilModel?.id ?? 0),
			"codigo": PlutoCell(value: comissaoPerfilModel?.codigo ?? ''),
			"nome": PlutoCell(value: comissaoPerfilModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _comissaoPerfilModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      comissaoPerfilModel.plutoRowToObject(plutoRow);
    } else {
      comissaoPerfilModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Perfis]';
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
    await Get.find<ComissaoPerfilController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await comissaoPerfilRepository.getList(filter: filter).then( (data){ _comissaoPerfilModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Perfis',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.comissaoPerfilEditPage)!.then((value) {
        if (comissaoPerfilModel.id == 0) {
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
    comissaoPerfilModel = ComissaoPerfilModel();
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
        if (await comissaoPerfilRepository.delete(id: currentRow.cells['id']!.value)) {
          _comissaoPerfilModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = comissaoPerfilModel.id;
		plutoRow.cells['codigo']?.value = comissaoPerfilModel.codigo;
		plutoRow.cells['nome']?.value = comissaoPerfilModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await comissaoPerfilRepository.save(comissaoPerfilModel: comissaoPerfilModel); 
        if (result != null) {
          comissaoPerfilModel = result;
          if (_isInserting) {
            _comissaoPerfilModelList.add(result);
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
		functionName = "comissao_perfil";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}