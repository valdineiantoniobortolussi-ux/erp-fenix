import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/feriados_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FeriadosController extends GetxController with ControllerBaseMixin {
  final FeriadosRepository feriadosRepository;
  FeriadosController({required this.feriadosRepository});

  // general
  final _dbColumns = FeriadosModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FeriadosModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = feriadosGridColumns();
  
  var _feriadosModelList = <FeriadosModel>[];

  final _feriadosModel = FeriadosModel().obs;
  FeriadosModel get feriadosModel => _feriadosModel.value;
  set feriadosModel(value) => _feriadosModel.value = value ?? FeriadosModel();

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
    for (var feriadosModel in _feriadosModelList) {
      plutoRowList.add(_getPlutoRow(feriadosModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FeriadosModel feriadosModel) {
    return PlutoRow(
      cells: _getPlutoCells(feriadosModel: feriadosModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FeriadosModel? feriadosModel}) {
    return {
			"id": PlutoCell(value: feriadosModel?.id ?? 0),
			"ano": PlutoCell(value: feriadosModel?.ano ?? ''),
			"nome": PlutoCell(value: feriadosModel?.nome ?? ''),
			"abrangencia": PlutoCell(value: feriadosModel?.abrangencia ?? ''),
			"uf": PlutoCell(value: feriadosModel?.uf ?? ''),
			"municipioIbge": PlutoCell(value: feriadosModel?.municipioIbge ?? 0),
			"tipo": PlutoCell(value: feriadosModel?.tipo ?? ''),
			"dataFeriado": PlutoCell(value: feriadosModel?.dataFeriado ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _feriadosModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      feriadosModel.plutoRowToObject(plutoRow);
    } else {
      feriadosModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Feriados]';
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
    await Get.find<FeriadosController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await feriadosRepository.getList(filter: filter).then( (data){ _feriadosModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Feriados',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			anoController.text = currentRow.cells['ano']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			municipioIbgeController.text = currentRow.cells['municipioIbge']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.feriadosEditPage)!.then((value) {
        if (feriadosModel.id == 0) {
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
    feriadosModel = FeriadosModel();
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
        if (await feriadosRepository.delete(id: currentRow.cells['id']!.value)) {
          _feriadosModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final anoController = TextEditingController();
	final nomeController = TextEditingController();
	final municipioIbgeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = feriadosModel.id;
		plutoRow.cells['ano']?.value = feriadosModel.ano;
		plutoRow.cells['nome']?.value = feriadosModel.nome;
		plutoRow.cells['abrangencia']?.value = feriadosModel.abrangencia;
		plutoRow.cells['uf']?.value = feriadosModel.uf;
		plutoRow.cells['municipioIbge']?.value = feriadosModel.municipioIbge;
		plutoRow.cells['tipo']?.value = feriadosModel.tipo;
		plutoRow.cells['dataFeriado']?.value = Util.formatDate(feriadosModel.dataFeriado);
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await feriadosRepository.save(feriadosModel: feriadosModel); 
        if (result != null) {
          feriadosModel = result;
          if (_isInserting) {
            _feriadosModelList.add(result);
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
		functionName = "feriados";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		anoController.dispose();
		nomeController.dispose();
		municipioIbgeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}