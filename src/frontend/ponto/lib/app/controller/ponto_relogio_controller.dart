import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/controller/controller_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/page/grid_columns/grid_columns_imports.dart';

import 'package:ponto/app/routes/app_routes.dart';
import 'package:ponto/app/data/repository/ponto_relogio_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoRelogioController extends GetxController with ControllerBaseMixin {
  final PontoRelogioRepository pontoRelogioRepository;
  PontoRelogioController({required this.pontoRelogioRepository});

  // general
  final _dbColumns = PontoRelogioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PontoRelogioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = pontoRelogioGridColumns();
  
  var _pontoRelogioModelList = <PontoRelogioModel>[];

  final _pontoRelogioModel = PontoRelogioModel().obs;
  PontoRelogioModel get pontoRelogioModel => _pontoRelogioModel.value;
  set pontoRelogioModel(value) => _pontoRelogioModel.value = value ?? PontoRelogioModel();

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
    for (var pontoRelogioModel in _pontoRelogioModelList) {
      plutoRowList.add(_getPlutoRow(pontoRelogioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PontoRelogioModel pontoRelogioModel) {
    return PlutoRow(
      cells: _getPlutoCells(pontoRelogioModel: pontoRelogioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PontoRelogioModel? pontoRelogioModel}) {
    return {
			"id": PlutoCell(value: pontoRelogioModel?.id ?? 0),
			"localizacao": PlutoCell(value: pontoRelogioModel?.localizacao ?? ''),
			"marca": PlutoCell(value: pontoRelogioModel?.marca ?? ''),
			"fabricante": PlutoCell(value: pontoRelogioModel?.fabricante ?? ''),
			"numeroSerie": PlutoCell(value: pontoRelogioModel?.numeroSerie ?? ''),
			"utilizacao": PlutoCell(value: pontoRelogioModel?.utilizacao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _pontoRelogioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      pontoRelogioModel.plutoRowToObject(plutoRow);
    } else {
      pontoRelogioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Relógio de Ponto]';
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
    await Get.find<PontoRelogioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await pontoRelogioRepository.getList(filter: filter).then( (data){ _pontoRelogioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Relógio de Ponto',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			localizacaoController.text = currentRow.cells['localizacao']?.value ?? '';
			marcaController.text = currentRow.cells['marca']?.value ?? '';
			fabricanteController.text = currentRow.cells['fabricante']?.value ?? '';
			numeroSerieController.text = currentRow.cells['numeroSerie']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.pontoRelogioEditPage)!.then((value) {
        if (pontoRelogioModel.id == 0) {
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
    pontoRelogioModel = PontoRelogioModel();
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
        if (await pontoRelogioRepository.delete(id: currentRow.cells['id']!.value)) {
          _pontoRelogioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final localizacaoController = TextEditingController();
	final marcaController = TextEditingController();
	final fabricanteController = TextEditingController();
	final numeroSerieController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoRelogioModel.id;
		plutoRow.cells['localizacao']?.value = pontoRelogioModel.localizacao;
		plutoRow.cells['marca']?.value = pontoRelogioModel.marca;
		plutoRow.cells['fabricante']?.value = pontoRelogioModel.fabricante;
		plutoRow.cells['numeroSerie']?.value = pontoRelogioModel.numeroSerie;
		plutoRow.cells['utilizacao']?.value = pontoRelogioModel.utilizacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await pontoRelogioRepository.save(pontoRelogioModel: pontoRelogioModel); 
        if (result != null) {
          pontoRelogioModel = result;
          if (_isInserting) {
            _pontoRelogioModelList.add(result);
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
		functionName = "ponto_relogio";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		localizacaoController.dispose();
		marcaController.dispose();
		fabricanteController.dispose();
		numeroSerieController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}