import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/controller/controller_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:agenda/app/page/grid_columns/grid_columns_imports.dart';

import 'package:agenda/app/routes/app_routes.dart';
import 'package:agenda/app/data/repository/agenda_categoria_compromisso_repository.dart';
import 'package:agenda/app/page/shared_page/shared_page_imports.dart';
import 'package:agenda/app/page/shared_widget/message_dialog.dart';
import 'package:agenda/app/mixin/controller_base_mixin.dart';

class AgendaCategoriaCompromissoController extends GetxController with ControllerBaseMixin {
  final AgendaCategoriaCompromissoRepository agendaCategoriaCompromissoRepository;
  AgendaCategoriaCompromissoController({required this.agendaCategoriaCompromissoRepository});

  // general
  final _dbColumns = AgendaCategoriaCompromissoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = AgendaCategoriaCompromissoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = agendaCategoriaCompromissoGridColumns();
  
  var _agendaCategoriaCompromissoModelList = <AgendaCategoriaCompromissoModel>[];

  final _agendaCategoriaCompromissoModel = AgendaCategoriaCompromissoModel().obs;
  AgendaCategoriaCompromissoModel get agendaCategoriaCompromissoModel => _agendaCategoriaCompromissoModel.value;
  set agendaCategoriaCompromissoModel(value) => _agendaCategoriaCompromissoModel.value = value ?? AgendaCategoriaCompromissoModel();

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
    for (var agendaCategoriaCompromissoModel in _agendaCategoriaCompromissoModelList) {
      plutoRowList.add(_getPlutoRow(agendaCategoriaCompromissoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(AgendaCategoriaCompromissoModel agendaCategoriaCompromissoModel) {
    return PlutoRow(
      cells: _getPlutoCells(agendaCategoriaCompromissoModel: agendaCategoriaCompromissoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ AgendaCategoriaCompromissoModel? agendaCategoriaCompromissoModel}) {
    return {
			"id": PlutoCell(value: agendaCategoriaCompromissoModel?.id ?? 0),
			"nome": PlutoCell(value: agendaCategoriaCompromissoModel?.nome ?? ''),
			"cor": PlutoCell(value: agendaCategoriaCompromissoModel?.cor ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _agendaCategoriaCompromissoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      agendaCategoriaCompromissoModel.plutoRowToObject(plutoRow);
    } else {
      agendaCategoriaCompromissoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Categoria Compromisso]';
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
    await Get.find<AgendaCategoriaCompromissoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await agendaCategoriaCompromissoRepository.getList(filter: filter).then( (data){ _agendaCategoriaCompromissoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Categoria Compromisso',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			corController.text = currentRow.cells['cor']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.agendaCategoriaCompromissoEditPage)!.then((value) {
        if (agendaCategoriaCompromissoModel.id == 0) {
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
    agendaCategoriaCompromissoModel = AgendaCategoriaCompromissoModel();
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
        if (await agendaCategoriaCompromissoRepository.delete(id: currentRow.cells['id']!.value)) {
          _agendaCategoriaCompromissoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final corController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = agendaCategoriaCompromissoModel.id;
		plutoRow.cells['nome']?.value = agendaCategoriaCompromissoModel.nome;
		plutoRow.cells['cor']?.value = agendaCategoriaCompromissoModel.cor;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await agendaCategoriaCompromissoRepository.save(agendaCategoriaCompromissoModel: agendaCategoriaCompromissoModel); 
        if (result != null) {
          agendaCategoriaCompromissoModel = result;
          if (_isInserting) {
            _agendaCategoriaCompromissoModelList.add(result);
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
		functionName = "agenda_categoria_compromisso";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		corController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}