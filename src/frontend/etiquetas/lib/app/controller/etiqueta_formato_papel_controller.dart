import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/controller/controller_imports.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';
import 'package:etiquetas/app/page/grid_columns/grid_columns_imports.dart';

import 'package:etiquetas/app/routes/app_routes.dart';
import 'package:etiquetas/app/data/repository/etiqueta_formato_papel_repository.dart';
import 'package:etiquetas/app/page/shared_page/shared_page_imports.dart';
import 'package:etiquetas/app/page/shared_widget/message_dialog.dart';
import 'package:etiquetas/app/mixin/controller_base_mixin.dart';

class EtiquetaFormatoPapelController extends GetxController with ControllerBaseMixin {
  final EtiquetaFormatoPapelRepository etiquetaFormatoPapelRepository;
  EtiquetaFormatoPapelController({required this.etiquetaFormatoPapelRepository});

  // general
  final _dbColumns = EtiquetaFormatoPapelModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EtiquetaFormatoPapelModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = etiquetaFormatoPapelGridColumns();
  
  var _etiquetaFormatoPapelModelList = <EtiquetaFormatoPapelModel>[];

  final _etiquetaFormatoPapelModel = EtiquetaFormatoPapelModel().obs;
  EtiquetaFormatoPapelModel get etiquetaFormatoPapelModel => _etiquetaFormatoPapelModel.value;
  set etiquetaFormatoPapelModel(value) => _etiquetaFormatoPapelModel.value = value ?? EtiquetaFormatoPapelModel();

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
    for (var etiquetaFormatoPapelModel in _etiquetaFormatoPapelModelList) {
      plutoRowList.add(_getPlutoRow(etiquetaFormatoPapelModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EtiquetaFormatoPapelModel etiquetaFormatoPapelModel) {
    return PlutoRow(
      cells: _getPlutoCells(etiquetaFormatoPapelModel: etiquetaFormatoPapelModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EtiquetaFormatoPapelModel? etiquetaFormatoPapelModel}) {
    return {
			"id": PlutoCell(value: etiquetaFormatoPapelModel?.id ?? 0),
			"nome": PlutoCell(value: etiquetaFormatoPapelModel?.nome ?? ''),
			"altura": PlutoCell(value: etiquetaFormatoPapelModel?.altura ?? 0),
			"largura": PlutoCell(value: etiquetaFormatoPapelModel?.largura ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _etiquetaFormatoPapelModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      etiquetaFormatoPapelModel.plutoRowToObject(plutoRow);
    } else {
      etiquetaFormatoPapelModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Formato do Papel]';
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
    await Get.find<EtiquetaFormatoPapelController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await etiquetaFormatoPapelRepository.getList(filter: filter).then( (data){ _etiquetaFormatoPapelModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Formato do Papel',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			alturaController.text = currentRow.cells['altura']?.value?.toString() ?? '';
			larguraController.text = currentRow.cells['largura']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.etiquetaFormatoPapelEditPage)!.then((value) {
        if (etiquetaFormatoPapelModel.id == 0) {
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
    etiquetaFormatoPapelModel = EtiquetaFormatoPapelModel();
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
        if (await etiquetaFormatoPapelRepository.delete(id: currentRow.cells['id']!.value)) {
          _etiquetaFormatoPapelModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final alturaController = TextEditingController();
	final larguraController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = etiquetaFormatoPapelModel.id;
		plutoRow.cells['nome']?.value = etiquetaFormatoPapelModel.nome;
		plutoRow.cells['altura']?.value = etiquetaFormatoPapelModel.altura;
		plutoRow.cells['largura']?.value = etiquetaFormatoPapelModel.largura;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await etiquetaFormatoPapelRepository.save(etiquetaFormatoPapelModel: etiquetaFormatoPapelModel); 
        if (result != null) {
          etiquetaFormatoPapelModel = result;
          if (_isInserting) {
            _etiquetaFormatoPapelModelList.add(result);
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
		functionName = "etiqueta_formato_papel";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		alturaController.dispose();
		larguraController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}