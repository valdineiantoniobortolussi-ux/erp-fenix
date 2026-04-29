import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/fin_natureza_financeira_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinNaturezaFinanceiraController extends GetxController with ControllerBaseMixin {
  final FinNaturezaFinanceiraRepository finNaturezaFinanceiraRepository;
  FinNaturezaFinanceiraController({required this.finNaturezaFinanceiraRepository});

  // general
  final _dbColumns = FinNaturezaFinanceiraModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinNaturezaFinanceiraModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finNaturezaFinanceiraGridColumns();
  
  var _finNaturezaFinanceiraModelList = <FinNaturezaFinanceiraModel>[];

  final _finNaturezaFinanceiraModel = FinNaturezaFinanceiraModel().obs;
  FinNaturezaFinanceiraModel get finNaturezaFinanceiraModel => _finNaturezaFinanceiraModel.value;
  set finNaturezaFinanceiraModel(value) => _finNaturezaFinanceiraModel.value = value ?? FinNaturezaFinanceiraModel();

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
    for (var finNaturezaFinanceiraModel in _finNaturezaFinanceiraModelList) {
      plutoRowList.add(_getPlutoRow(finNaturezaFinanceiraModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinNaturezaFinanceiraModel finNaturezaFinanceiraModel) {
    return PlutoRow(
      cells: _getPlutoCells(finNaturezaFinanceiraModel: finNaturezaFinanceiraModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinNaturezaFinanceiraModel? finNaturezaFinanceiraModel}) {
    return {
			"id": PlutoCell(value: finNaturezaFinanceiraModel?.id ?? 0),
			"codigo": PlutoCell(value: finNaturezaFinanceiraModel?.codigo ?? ''),
			"tipo": PlutoCell(value: finNaturezaFinanceiraModel?.tipo ?? ''),
			"descricao": PlutoCell(value: finNaturezaFinanceiraModel?.descricao ?? ''),
			"aplicacao": PlutoCell(value: finNaturezaFinanceiraModel?.aplicacao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finNaturezaFinanceiraModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finNaturezaFinanceiraModel.plutoRowToObject(plutoRow);
    } else {
      finNaturezaFinanceiraModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Natureza Financeira]';
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
    await Get.find<FinNaturezaFinanceiraController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finNaturezaFinanceiraRepository.getList(filter: filter).then( (data){ _finNaturezaFinanceiraModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Natureza Financeira',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			aplicacaoController.text = currentRow.cells['aplicacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finNaturezaFinanceiraEditPage)!.then((value) {
        if (finNaturezaFinanceiraModel.id == 0) {
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
    finNaturezaFinanceiraModel = FinNaturezaFinanceiraModel();
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
        if (await finNaturezaFinanceiraRepository.delete(id: currentRow.cells['id']!.value)) {
          _finNaturezaFinanceiraModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();
	final aplicacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finNaturezaFinanceiraModel.id;
		plutoRow.cells['codigo']?.value = finNaturezaFinanceiraModel.codigo;
		plutoRow.cells['tipo']?.value = finNaturezaFinanceiraModel.tipo;
		plutoRow.cells['descricao']?.value = finNaturezaFinanceiraModel.descricao;
		plutoRow.cells['aplicacao']?.value = finNaturezaFinanceiraModel.aplicacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finNaturezaFinanceiraRepository.save(finNaturezaFinanceiraModel: finNaturezaFinanceiraModel); 
        if (result != null) {
          finNaturezaFinanceiraModel = result;
          if (_isInserting) {
            _finNaturezaFinanceiraModelList.add(result);
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
		functionName = "fin_natureza_financeira";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		descricaoController.dispose();
		aplicacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}