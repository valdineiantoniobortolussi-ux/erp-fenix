import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/controller/controller_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:compras/app/page/grid_columns/grid_columns_imports.dart';

import 'package:compras/app/routes/app_routes.dart';
import 'package:compras/app/data/repository/compra_tipo_requisicao_repository.dart';
import 'package:compras/app/page/shared_page/shared_page_imports.dart';
import 'package:compras/app/page/shared_widget/message_dialog.dart';
import 'package:compras/app/mixin/controller_base_mixin.dart';

class CompraTipoRequisicaoController extends GetxController with ControllerBaseMixin {
  final CompraTipoRequisicaoRepository compraTipoRequisicaoRepository;
  CompraTipoRequisicaoController({required this.compraTipoRequisicaoRepository});

  // general
  final _dbColumns = CompraTipoRequisicaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CompraTipoRequisicaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = compraTipoRequisicaoGridColumns();
  
  var _compraTipoRequisicaoModelList = <CompraTipoRequisicaoModel>[];

  final _compraTipoRequisicaoModel = CompraTipoRequisicaoModel().obs;
  CompraTipoRequisicaoModel get compraTipoRequisicaoModel => _compraTipoRequisicaoModel.value;
  set compraTipoRequisicaoModel(value) => _compraTipoRequisicaoModel.value = value ?? CompraTipoRequisicaoModel();

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
    for (var compraTipoRequisicaoModel in _compraTipoRequisicaoModelList) {
      plutoRowList.add(_getPlutoRow(compraTipoRequisicaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CompraTipoRequisicaoModel compraTipoRequisicaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(compraTipoRequisicaoModel: compraTipoRequisicaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CompraTipoRequisicaoModel? compraTipoRequisicaoModel}) {
    return {
			"id": PlutoCell(value: compraTipoRequisicaoModel?.id ?? 0),
			"codigo": PlutoCell(value: compraTipoRequisicaoModel?.codigo ?? ''),
			"nome": PlutoCell(value: compraTipoRequisicaoModel?.nome ?? ''),
			"descricao": PlutoCell(value: compraTipoRequisicaoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _compraTipoRequisicaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      compraTipoRequisicaoModel.plutoRowToObject(plutoRow);
    } else {
      compraTipoRequisicaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Requisição]';
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
    await Get.find<CompraTipoRequisicaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await compraTipoRequisicaoRepository.getList(filter: filter).then( (data){ _compraTipoRequisicaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Requisição',
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
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.compraTipoRequisicaoEditPage)!.then((value) {
        if (compraTipoRequisicaoModel.id == 0) {
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
    compraTipoRequisicaoModel = CompraTipoRequisicaoModel();
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
        if (await compraTipoRequisicaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _compraTipoRequisicaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = compraTipoRequisicaoModel.id;
		plutoRow.cells['codigo']?.value = compraTipoRequisicaoModel.codigo;
		plutoRow.cells['nome']?.value = compraTipoRequisicaoModel.nome;
		plutoRow.cells['descricao']?.value = compraTipoRequisicaoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await compraTipoRequisicaoRepository.save(compraTipoRequisicaoModel: compraTipoRequisicaoModel); 
        if (result != null) {
          compraTipoRequisicaoModel = result;
          if (_isInserting) {
            _compraTipoRequisicaoModelList.add(result);
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
		functionName = "compra_tipo_requisicao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}