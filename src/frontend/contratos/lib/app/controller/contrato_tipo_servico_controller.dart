import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/controller/controller_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:contratos/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contratos/app/routes/app_routes.dart';
import 'package:contratos/app/data/repository/contrato_tipo_servico_repository.dart';
import 'package:contratos/app/page/shared_page/shared_page_imports.dart';
import 'package:contratos/app/page/shared_widget/message_dialog.dart';
import 'package:contratos/app/mixin/controller_base_mixin.dart';

class ContratoTipoServicoController extends GetxController with ControllerBaseMixin {
  final ContratoTipoServicoRepository contratoTipoServicoRepository;
  ContratoTipoServicoController({required this.contratoTipoServicoRepository});

  // general
  final _dbColumns = ContratoTipoServicoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContratoTipoServicoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contratoTipoServicoGridColumns();
  
  var _contratoTipoServicoModelList = <ContratoTipoServicoModel>[];

  final _contratoTipoServicoModel = ContratoTipoServicoModel().obs;
  ContratoTipoServicoModel get contratoTipoServicoModel => _contratoTipoServicoModel.value;
  set contratoTipoServicoModel(value) => _contratoTipoServicoModel.value = value ?? ContratoTipoServicoModel();

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
    for (var contratoTipoServicoModel in _contratoTipoServicoModelList) {
      plutoRowList.add(_getPlutoRow(contratoTipoServicoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContratoTipoServicoModel contratoTipoServicoModel) {
    return PlutoRow(
      cells: _getPlutoCells(contratoTipoServicoModel: contratoTipoServicoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContratoTipoServicoModel? contratoTipoServicoModel}) {
    return {
			"id": PlutoCell(value: contratoTipoServicoModel?.id ?? 0),
			"nome": PlutoCell(value: contratoTipoServicoModel?.nome ?? ''),
			"descricao": PlutoCell(value: contratoTipoServicoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contratoTipoServicoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contratoTipoServicoModel.plutoRowToObject(plutoRow);
    } else {
      contratoTipoServicoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo de Serviço]';
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
    await Get.find<ContratoTipoServicoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contratoTipoServicoRepository.getList(filter: filter).then( (data){ _contratoTipoServicoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo de Serviço',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contratoTipoServicoEditPage)!.then((value) {
        if (contratoTipoServicoModel.id == 0) {
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
    contratoTipoServicoModel = ContratoTipoServicoModel();
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
        if (await contratoTipoServicoRepository.delete(id: currentRow.cells['id']!.value)) {
          _contratoTipoServicoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contratoTipoServicoModel.id;
		plutoRow.cells['nome']?.value = contratoTipoServicoModel.nome;
		plutoRow.cells['descricao']?.value = contratoTipoServicoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contratoTipoServicoRepository.save(contratoTipoServicoModel: contratoTipoServicoModel); 
        if (result != null) {
          contratoTipoServicoModel = result;
          if (_isInserting) {
            _contratoTipoServicoModelList.add(result);
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
		functionName = "contrato_tipo_servico";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}