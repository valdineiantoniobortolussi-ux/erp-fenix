import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/plano_centro_resultado_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class PlanoCentroResultadoController extends GetxController with ControllerBaseMixin {
  final PlanoCentroResultadoRepository planoCentroResultadoRepository;
  PlanoCentroResultadoController({required this.planoCentroResultadoRepository});

  // general
  final _dbColumns = PlanoCentroResultadoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PlanoCentroResultadoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = planoCentroResultadoGridColumns();
  
  var _planoCentroResultadoModelList = <PlanoCentroResultadoModel>[];

  final _planoCentroResultadoModel = PlanoCentroResultadoModel().obs;
  PlanoCentroResultadoModel get planoCentroResultadoModel => _planoCentroResultadoModel.value;
  set planoCentroResultadoModel(value) => _planoCentroResultadoModel.value = value ?? PlanoCentroResultadoModel();

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
    for (var planoCentroResultadoModel in _planoCentroResultadoModelList) {
      plutoRowList.add(_getPlutoRow(planoCentroResultadoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PlanoCentroResultadoModel planoCentroResultadoModel) {
    return PlutoRow(
      cells: _getPlutoCells(planoCentroResultadoModel: planoCentroResultadoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PlanoCentroResultadoModel? planoCentroResultadoModel}) {
    return {
			"id": PlutoCell(value: planoCentroResultadoModel?.id ?? 0),
			"nome": PlutoCell(value: planoCentroResultadoModel?.nome ?? ''),
			"mascara": PlutoCell(value: planoCentroResultadoModel?.mascara ?? ''),
			"niveis": PlutoCell(value: planoCentroResultadoModel?.niveis ?? 0),
			"dataInclusao": PlutoCell(value: planoCentroResultadoModel?.dataInclusao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _planoCentroResultadoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      planoCentroResultadoModel.plutoRowToObject(plutoRow);
    } else {
      planoCentroResultadoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Plano Centro Resultado]';
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
    await Get.find<PlanoCentroResultadoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await planoCentroResultadoRepository.getList(filter: filter).then( (data){ _planoCentroResultadoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Plano Centro Resultado',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			mascaraController.text = currentRow.cells['mascara']?.value ?? '';
			niveisController.text = currentRow.cells['niveis']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.planoCentroResultadoEditPage)!.then((value) {
        if (planoCentroResultadoModel.id == 0) {
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
    planoCentroResultadoModel = PlanoCentroResultadoModel();
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
        if (await planoCentroResultadoRepository.delete(id: currentRow.cells['id']!.value)) {
          _planoCentroResultadoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final mascaraController = TextEditingController();
	final niveisController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = planoCentroResultadoModel.id;
		plutoRow.cells['nome']?.value = planoCentroResultadoModel.nome;
		plutoRow.cells['mascara']?.value = planoCentroResultadoModel.mascara;
		plutoRow.cells['niveis']?.value = planoCentroResultadoModel.niveis;
		plutoRow.cells['dataInclusao']?.value = Util.formatDate(planoCentroResultadoModel.dataInclusao);
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await planoCentroResultadoRepository.save(planoCentroResultadoModel: planoCentroResultadoModel); 
        if (result != null) {
          planoCentroResultadoModel = result;
          if (_isInserting) {
            _planoCentroResultadoModelList.add(result);
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
		functionName = "plano_centro_resultado";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		mascaraController.dispose();
		niveisController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}