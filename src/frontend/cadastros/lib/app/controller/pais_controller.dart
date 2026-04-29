import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/pais_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class PaisController extends GetxController with ControllerBaseMixin {
  final PaisRepository paisRepository;
  PaisController({required this.paisRepository});

  // general
  final _dbColumns = PaisModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PaisModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = paisGridColumns();
  
  var _paisModelList = <PaisModel>[];

  final _paisModel = PaisModel().obs;
  PaisModel get paisModel => _paisModel.value;
  set paisModel(value) => _paisModel.value = value ?? PaisModel();

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
    for (var paisModel in _paisModelList) {
      plutoRowList.add(_getPlutoRow(paisModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PaisModel paisModel) {
    return PlutoRow(
      cells: _getPlutoCells(paisModel: paisModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PaisModel? paisModel}) {
    return {
			"id": PlutoCell(value: paisModel?.id ?? 0),
			"nomePtbr": PlutoCell(value: paisModel?.nomePtbr ?? ''),
			"nomeEn": PlutoCell(value: paisModel?.nomeEn ?? ''),
			"codigo": PlutoCell(value: paisModel?.codigo ?? 0),
			"sigla2": PlutoCell(value: paisModel?.sigla2 ?? ''),
			"sigla3": PlutoCell(value: paisModel?.sigla3 ?? ''),
			"codigoBacen": PlutoCell(value: paisModel?.codigoBacen ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _paisModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      paisModel.plutoRowToObject(plutoRow);
    } else {
      paisModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [País]';
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
    await Get.find<PaisController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await paisRepository.getList(filter: filter).then( (data){ _paisModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'País',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomePtbrController.text = currentRow.cells['nomePtbr']?.value ?? '';
			nomeEnController.text = currentRow.cells['nomeEn']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value?.toString() ?? '';
			sigla2Controller.text = currentRow.cells['sigla2']?.value ?? '';
			sigla3Controller.text = currentRow.cells['sigla3']?.value ?? '';
			codigoBacenController.text = currentRow.cells['codigoBacen']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.paisEditPage)!.then((value) {
        if (paisModel.id == 0) {
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
    paisModel = PaisModel();
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
        if (await paisRepository.delete(id: currentRow.cells['id']!.value)) {
          _paisModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomePtbrController = TextEditingController();
	final nomeEnController = TextEditingController();
	final codigoController = TextEditingController();
	final sigla2Controller = TextEditingController();
	final sigla3Controller = TextEditingController();
	final codigoBacenController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = paisModel.id;
		plutoRow.cells['nomePtbr']?.value = paisModel.nomePtbr;
		plutoRow.cells['nomeEn']?.value = paisModel.nomeEn;
		plutoRow.cells['codigo']?.value = paisModel.codigo;
		plutoRow.cells['sigla2']?.value = paisModel.sigla2;
		plutoRow.cells['sigla3']?.value = paisModel.sigla3;
		plutoRow.cells['codigoBacen']?.value = paisModel.codigoBacen;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await paisRepository.save(paisModel: paisModel); 
        if (result != null) {
          paisModel = result;
          if (_isInserting) {
            _paisModelList.add(result);
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
		functionName = "pais";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomePtbrController.dispose();
		nomeEnController.dispose();
		codigoController.dispose();
		sigla2Controller.dispose();
		sigla3Controller.dispose();
		codigoBacenController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}