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
import 'package:contabil/app/data/repository/plano_conta_ref_sped_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class PlanoContaRefSpedController extends GetxController with ControllerBaseMixin {
  final PlanoContaRefSpedRepository planoContaRefSpedRepository;
  PlanoContaRefSpedController({required this.planoContaRefSpedRepository});

  // general
  final _dbColumns = PlanoContaRefSpedModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PlanoContaRefSpedModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = planoContaRefSpedGridColumns();
  
  var _planoContaRefSpedModelList = <PlanoContaRefSpedModel>[];

  final _planoContaRefSpedModel = PlanoContaRefSpedModel().obs;
  PlanoContaRefSpedModel get planoContaRefSpedModel => _planoContaRefSpedModel.value;
  set planoContaRefSpedModel(value) => _planoContaRefSpedModel.value = value ?? PlanoContaRefSpedModel();

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
    for (var planoContaRefSpedModel in _planoContaRefSpedModelList) {
      plutoRowList.add(_getPlutoRow(planoContaRefSpedModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PlanoContaRefSpedModel planoContaRefSpedModel) {
    return PlutoRow(
      cells: _getPlutoCells(planoContaRefSpedModel: planoContaRefSpedModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PlanoContaRefSpedModel? planoContaRefSpedModel}) {
    return {
			"id": PlutoCell(value: planoContaRefSpedModel?.id ?? 0),
			"codCtaRef": PlutoCell(value: planoContaRefSpedModel?.codCtaRef ?? ''),
			"inicioValidade": PlutoCell(value: planoContaRefSpedModel?.inicioValidade ?? ''),
			"fimValidade": PlutoCell(value: planoContaRefSpedModel?.fimValidade ?? ''),
			"tipo": PlutoCell(value: planoContaRefSpedModel?.tipo ?? ''),
			"descricao": PlutoCell(value: planoContaRefSpedModel?.descricao ?? ''),
			"orientacoes": PlutoCell(value: planoContaRefSpedModel?.orientacoes ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _planoContaRefSpedModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      planoContaRefSpedModel.plutoRowToObject(plutoRow);
    } else {
      planoContaRefSpedModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Planos de Contas Sped]';
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
    await Get.find<PlanoContaRefSpedController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await planoContaRefSpedRepository.getList(filter: filter).then( (data){ _planoContaRefSpedModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Planos de Contas Sped',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codCtaRefController.text = currentRow.cells['codCtaRef']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			orientacoesController.text = currentRow.cells['orientacoes']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.planoContaRefSpedEditPage)!.then((value) {
        if (planoContaRefSpedModel.id == 0) {
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
    planoContaRefSpedModel = PlanoContaRefSpedModel();
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
        if (await planoContaRefSpedRepository.delete(id: currentRow.cells['id']!.value)) {
          _planoContaRefSpedModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codCtaRefController = TextEditingController();
	final descricaoController = TextEditingController();
	final orientacoesController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = planoContaRefSpedModel.id;
		plutoRow.cells['codCtaRef']?.value = planoContaRefSpedModel.codCtaRef;
		plutoRow.cells['inicioValidade']?.value = Util.formatDate(planoContaRefSpedModel.inicioValidade);
		plutoRow.cells['fimValidade']?.value = Util.formatDate(planoContaRefSpedModel.fimValidade);
		plutoRow.cells['tipo']?.value = planoContaRefSpedModel.tipo;
		plutoRow.cells['descricao']?.value = planoContaRefSpedModel.descricao;
		plutoRow.cells['orientacoes']?.value = planoContaRefSpedModel.orientacoes;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await planoContaRefSpedRepository.save(planoContaRefSpedModel: planoContaRefSpedModel); 
        if (result != null) {
          planoContaRefSpedModel = result;
          if (_isInserting) {
            _planoContaRefSpedModelList.add(result);
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
		functionName = "plano_conta_ref_sped";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codCtaRefController.dispose();
		descricaoController.dispose();
		orientacoesController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}