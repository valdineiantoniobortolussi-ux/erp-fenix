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
import 'package:estoque/app/data/repository/estoque_marca_repository.dart';
import 'package:estoque/app/page/shared_page/shared_page_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';
import 'package:estoque/app/mixin/controller_base_mixin.dart';

class EstoqueMarcaController extends GetxController with ControllerBaseMixin {
  final EstoqueMarcaRepository estoqueMarcaRepository;
  EstoqueMarcaController({required this.estoqueMarcaRepository});

  // general
  final _dbColumns = EstoqueMarcaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EstoqueMarcaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = estoqueMarcaGridColumns();
  
  var _estoqueMarcaModelList = <EstoqueMarcaModel>[];

  final _estoqueMarcaModel = EstoqueMarcaModel().obs;
  EstoqueMarcaModel get estoqueMarcaModel => _estoqueMarcaModel.value;
  set estoqueMarcaModel(value) => _estoqueMarcaModel.value = value ?? EstoqueMarcaModel();

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
    for (var estoqueMarcaModel in _estoqueMarcaModelList) {
      plutoRowList.add(_getPlutoRow(estoqueMarcaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EstoqueMarcaModel estoqueMarcaModel) {
    return PlutoRow(
      cells: _getPlutoCells(estoqueMarcaModel: estoqueMarcaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EstoqueMarcaModel? estoqueMarcaModel}) {
    return {
			"id": PlutoCell(value: estoqueMarcaModel?.id ?? 0),
			"codigo": PlutoCell(value: estoqueMarcaModel?.codigo ?? ''),
			"nome": PlutoCell(value: estoqueMarcaModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _estoqueMarcaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      estoqueMarcaModel.plutoRowToObject(plutoRow);
    } else {
      estoqueMarcaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Marcas]';
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
    await Get.find<EstoqueMarcaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await estoqueMarcaRepository.getList(filter: filter).then( (data){ _estoqueMarcaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Marcas',
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
      Get.toNamed(Routes.estoqueMarcaEditPage)!.then((value) {
        if (estoqueMarcaModel.id == 0) {
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
    estoqueMarcaModel = EstoqueMarcaModel();
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
        if (await estoqueMarcaRepository.delete(id: currentRow.cells['id']!.value)) {
          _estoqueMarcaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = estoqueMarcaModel.id;
		plutoRow.cells['codigo']?.value = estoqueMarcaModel.codigo;
		plutoRow.cells['nome']?.value = estoqueMarcaModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await estoqueMarcaRepository.save(estoqueMarcaModel: estoqueMarcaModel); 
        if (result != null) {
          estoqueMarcaModel = result;
          if (_isInserting) {
            _estoqueMarcaModelList.add(result);
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
		functionName = "estoque_marca";
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