import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/controller/controller_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/page/grid_columns/grid_columns_imports.dart';

import 'package:estoque/app/routes/app_routes.dart';
import 'package:estoque/app/data/repository/estoque_sabor_repository.dart';
import 'package:estoque/app/page/shared_page/shared_page_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';
import 'package:estoque/app/mixin/controller_base_mixin.dart';

class EstoqueSaborController extends GetxController with ControllerBaseMixin {
  final EstoqueSaborRepository estoqueSaborRepository;
  EstoqueSaborController({required this.estoqueSaborRepository});

  // general
  final _dbColumns = EstoqueSaborModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EstoqueSaborModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = estoqueSaborGridColumns();
  
  var _estoqueSaborModelList = <EstoqueSaborModel>[];

  final _estoqueSaborModel = EstoqueSaborModel().obs;
  EstoqueSaborModel get estoqueSaborModel => _estoqueSaborModel.value;
  set estoqueSaborModel(value) => _estoqueSaborModel.value = value ?? EstoqueSaborModel();

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
    for (var estoqueSaborModel in _estoqueSaborModelList) {
      plutoRowList.add(_getPlutoRow(estoqueSaborModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EstoqueSaborModel estoqueSaborModel) {
    return PlutoRow(
      cells: _getPlutoCells(estoqueSaborModel: estoqueSaborModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EstoqueSaborModel? estoqueSaborModel}) {
    return {
			"id": PlutoCell(value: estoqueSaborModel?.id ?? 0),
			"codigo": PlutoCell(value: estoqueSaborModel?.codigo ?? ''),
			"nome": PlutoCell(value: estoqueSaborModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _estoqueSaborModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      estoqueSaborModel.plutoRowToObject(plutoRow);
    } else {
      estoqueSaborModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Sabores]';
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
    await Get.find<EstoqueSaborController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await estoqueSaborRepository.getList(filter: filter).then( (data){ _estoqueSaborModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Sabores',
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
      Get.toNamed(Routes.estoqueSaborEditPage)!.then((value) {
        if (estoqueSaborModel.id == 0) {
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
    estoqueSaborModel = EstoqueSaborModel();
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
        if (await estoqueSaborRepository.delete(id: currentRow.cells['id']!.value)) {
          _estoqueSaborModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = estoqueSaborModel.id;
		plutoRow.cells['codigo']?.value = estoqueSaborModel.codigo;
		plutoRow.cells['nome']?.value = estoqueSaborModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await estoqueSaborRepository.save(estoqueSaborModel: estoqueSaborModel); 
        if (result != null) {
          estoqueSaborModel = result;
          if (_isInserting) {
            _estoqueSaborModelList.add(result);
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
		functionName = "estoque_sabor";
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