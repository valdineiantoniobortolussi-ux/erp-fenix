import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/controller/controller_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:nfe/app/routes/app_routes.dart';
import 'package:nfe/app/data/repository/nfe_numero_inutilizado_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeNumeroInutilizadoController extends GetxController with ControllerBaseMixin {
  final NfeNumeroInutilizadoRepository nfeNumeroInutilizadoRepository;
  NfeNumeroInutilizadoController({required this.nfeNumeroInutilizadoRepository});

  // general
  final _dbColumns = NfeNumeroInutilizadoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeNumeroInutilizadoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeNumeroInutilizadoGridColumns();
  
  var _nfeNumeroInutilizadoModelList = <NfeNumeroInutilizadoModel>[];

  final _nfeNumeroInutilizadoModel = NfeNumeroInutilizadoModel().obs;
  NfeNumeroInutilizadoModel get nfeNumeroInutilizadoModel => _nfeNumeroInutilizadoModel.value;
  set nfeNumeroInutilizadoModel(value) => _nfeNumeroInutilizadoModel.value = value ?? NfeNumeroInutilizadoModel();

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
    for (var nfeNumeroInutilizadoModel in _nfeNumeroInutilizadoModelList) {
      plutoRowList.add(_getPlutoRow(nfeNumeroInutilizadoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeNumeroInutilizadoModel nfeNumeroInutilizadoModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeNumeroInutilizadoModel: nfeNumeroInutilizadoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeNumeroInutilizadoModel? nfeNumeroInutilizadoModel}) {
    return {
			"id": PlutoCell(value: nfeNumeroInutilizadoModel?.id ?? 0),
			"serie": PlutoCell(value: nfeNumeroInutilizadoModel?.serie ?? ''),
			"numero": PlutoCell(value: nfeNumeroInutilizadoModel?.numero ?? 0),
			"dataInutilizacao": PlutoCell(value: nfeNumeroInutilizadoModel?.dataInutilizacao ?? ''),
			"observacao": PlutoCell(value: nfeNumeroInutilizadoModel?.observacao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeNumeroInutilizadoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeNumeroInutilizadoModel.plutoRowToObject(plutoRow);
    } else {
      nfeNumeroInutilizadoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Números Inutilizados]';
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
    await Get.find<NfeNumeroInutilizadoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeNumeroInutilizadoRepository.getList(filter: filter).then( (data){ _nfeNumeroInutilizadoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Números Inutilizados',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			serieController.text = currentRow.cells['serie']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeNumeroInutilizadoEditPage)!.then((value) {
        if (nfeNumeroInutilizadoModel.id == 0) {
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
    nfeNumeroInutilizadoModel = NfeNumeroInutilizadoModel();
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
        if (await nfeNumeroInutilizadoRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeNumeroInutilizadoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final serieController = TextEditingController();
	final numeroController = TextEditingController();
	final observacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeNumeroInutilizadoModel.id;
		plutoRow.cells['serie']?.value = nfeNumeroInutilizadoModel.serie;
		plutoRow.cells['numero']?.value = nfeNumeroInutilizadoModel.numero;
		plutoRow.cells['dataInutilizacao']?.value = Util.formatDate(nfeNumeroInutilizadoModel.dataInutilizacao);
		plutoRow.cells['observacao']?.value = nfeNumeroInutilizadoModel.observacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeNumeroInutilizadoRepository.save(nfeNumeroInutilizadoModel: nfeNumeroInutilizadoModel); 
        if (result != null) {
          nfeNumeroInutilizadoModel = result;
          if (_isInserting) {
            _nfeNumeroInutilizadoModelList.add(result);
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
		functionName = "nfe_numero_inutilizado";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		serieController.dispose();
		numeroController.dispose();
		observacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}