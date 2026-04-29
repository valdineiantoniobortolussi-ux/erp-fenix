import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/controller/controller_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/page/grid_columns/grid_columns_imports.dart';

import 'package:frotas/app/routes/app_routes.dart';
import 'package:frotas/app/data/repository/frota_combustivel_tipo_repository.dart';
import 'package:frotas/app/page/shared_page/shared_page_imports.dart';
import 'package:frotas/app/page/shared_widget/message_dialog.dart';
import 'package:frotas/app/mixin/controller_base_mixin.dart';

class FrotaCombustivelTipoController extends GetxController with ControllerBaseMixin {
  final FrotaCombustivelTipoRepository frotaCombustivelTipoRepository;
  FrotaCombustivelTipoController({required this.frotaCombustivelTipoRepository});

  // general
  final _dbColumns = FrotaCombustivelTipoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FrotaCombustivelTipoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = frotaCombustivelTipoGridColumns();
  
  var _frotaCombustivelTipoModelList = <FrotaCombustivelTipoModel>[];

  final _frotaCombustivelTipoModel = FrotaCombustivelTipoModel().obs;
  FrotaCombustivelTipoModel get frotaCombustivelTipoModel => _frotaCombustivelTipoModel.value;
  set frotaCombustivelTipoModel(value) => _frotaCombustivelTipoModel.value = value ?? FrotaCombustivelTipoModel();

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
    for (var frotaCombustivelTipoModel in _frotaCombustivelTipoModelList) {
      plutoRowList.add(_getPlutoRow(frotaCombustivelTipoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FrotaCombustivelTipoModel frotaCombustivelTipoModel) {
    return PlutoRow(
      cells: _getPlutoCells(frotaCombustivelTipoModel: frotaCombustivelTipoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FrotaCombustivelTipoModel? frotaCombustivelTipoModel}) {
    return {
			"id": PlutoCell(value: frotaCombustivelTipoModel?.id ?? 0),
			"codigo": PlutoCell(value: frotaCombustivelTipoModel?.codigo ?? ''),
			"nome": PlutoCell(value: frotaCombustivelTipoModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _frotaCombustivelTipoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      frotaCombustivelTipoModel.plutoRowToObject(plutoRow);
    } else {
      frotaCombustivelTipoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Combustível]';
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
    await Get.find<FrotaCombustivelTipoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await frotaCombustivelTipoRepository.getList(filter: filter).then( (data){ _frotaCombustivelTipoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Combustível',
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
      Get.toNamed(Routes.frotaCombustivelTipoEditPage)!.then((value) {
        if (frotaCombustivelTipoModel.id == 0) {
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
    frotaCombustivelTipoModel = FrotaCombustivelTipoModel();
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
        if (await frotaCombustivelTipoRepository.delete(id: currentRow.cells['id']!.value)) {
          _frotaCombustivelTipoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = frotaCombustivelTipoModel.id;
		plutoRow.cells['codigo']?.value = frotaCombustivelTipoModel.codigo;
		plutoRow.cells['nome']?.value = frotaCombustivelTipoModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await frotaCombustivelTipoRepository.save(frotaCombustivelTipoModel: frotaCombustivelTipoModel); 
        if (result != null) {
          frotaCombustivelTipoModel = result;
          if (_isInserting) {
            _frotaCombustivelTipoModelList.add(result);
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
		functionName = "frota_combustivel_tipo";
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