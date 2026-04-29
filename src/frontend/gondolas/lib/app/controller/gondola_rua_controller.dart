import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/controller/controller_imports.dart';
import 'package:gondolas/app/data/model/model_imports.dart';
import 'package:gondolas/app/page/grid_columns/grid_columns_imports.dart';

import 'package:gondolas/app/routes/app_routes.dart';
import 'package:gondolas/app/data/repository/gondola_rua_repository.dart';
import 'package:gondolas/app/page/shared_page/shared_page_imports.dart';
import 'package:gondolas/app/page/shared_widget/message_dialog.dart';
import 'package:gondolas/app/mixin/controller_base_mixin.dart';

class GondolaRuaController extends GetxController with ControllerBaseMixin {
  final GondolaRuaRepository gondolaRuaRepository;
  GondolaRuaController({required this.gondolaRuaRepository});

  // general
  final _dbColumns = GondolaRuaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = GondolaRuaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = gondolaRuaGridColumns();
  
  var _gondolaRuaModelList = <GondolaRuaModel>[];

  final _gondolaRuaModel = GondolaRuaModel().obs;
  GondolaRuaModel get gondolaRuaModel => _gondolaRuaModel.value;
  set gondolaRuaModel(value) => _gondolaRuaModel.value = value ?? GondolaRuaModel();

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
    for (var gondolaRuaModel in _gondolaRuaModelList) {
      plutoRowList.add(_getPlutoRow(gondolaRuaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(GondolaRuaModel gondolaRuaModel) {
    return PlutoRow(
      cells: _getPlutoCells(gondolaRuaModel: gondolaRuaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ GondolaRuaModel? gondolaRuaModel}) {
    return {
			"id": PlutoCell(value: gondolaRuaModel?.id ?? 0),
			"codigo": PlutoCell(value: gondolaRuaModel?.codigo ?? ''),
			"quantidadeEstante": PlutoCell(value: gondolaRuaModel?.quantidadeEstante ?? 0),
			"nome": PlutoCell(value: gondolaRuaModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _gondolaRuaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      gondolaRuaModel.plutoRowToObject(plutoRow);
    } else {
      gondolaRuaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Rua]';
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
    await Get.find<GondolaRuaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await gondolaRuaRepository.getList(filter: filter).then( (data){ _gondolaRuaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Rua',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			quantidadeEstanteController.text = currentRow.cells['quantidadeEstante']?.value?.toString() ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.gondolaRuaEditPage)!.then((value) {
        if (gondolaRuaModel.id == 0) {
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
    gondolaRuaModel = GondolaRuaModel();
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
        if (await gondolaRuaRepository.delete(id: currentRow.cells['id']!.value)) {
          _gondolaRuaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final quantidadeEstanteController = TextEditingController();
	final nomeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = gondolaRuaModel.id;
		plutoRow.cells['codigo']?.value = gondolaRuaModel.codigo;
		plutoRow.cells['quantidadeEstante']?.value = gondolaRuaModel.quantidadeEstante;
		plutoRow.cells['nome']?.value = gondolaRuaModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await gondolaRuaRepository.save(gondolaRuaModel: gondolaRuaModel); 
        if (result != null) {
          gondolaRuaModel = result;
          if (_isInserting) {
            _gondolaRuaModelList.add(result);
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
		functionName = "gondola_rua";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		quantidadeEstanteController.dispose();
		nomeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}