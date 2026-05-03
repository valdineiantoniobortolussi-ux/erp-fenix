import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';

import 'package:patrimonio/app/routes/app_routes.dart';
import 'package:patrimonio/app/data/repository/patrim_taxa_depreciacao_repository.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';
import 'package:patrimonio/app/mixin/controller_base_mixin.dart';

class PatrimTaxaDepreciacaoController extends GetxController with ControllerBaseMixin {
  final PatrimTaxaDepreciacaoRepository patrimTaxaDepreciacaoRepository;
  PatrimTaxaDepreciacaoController({required this.patrimTaxaDepreciacaoRepository});

  // general
  final _dbColumns = PatrimTaxaDepreciacaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PatrimTaxaDepreciacaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = patrimTaxaDepreciacaoGridColumns();
  
  var _patrimTaxaDepreciacaoModelList = <PatrimTaxaDepreciacaoModel>[];

  final _patrimTaxaDepreciacaoModel = PatrimTaxaDepreciacaoModel().obs;
  PatrimTaxaDepreciacaoModel get patrimTaxaDepreciacaoModel => _patrimTaxaDepreciacaoModel.value;
  set patrimTaxaDepreciacaoModel(value) => _patrimTaxaDepreciacaoModel.value = value ?? PatrimTaxaDepreciacaoModel();

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
    for (var patrimTaxaDepreciacaoModel in _patrimTaxaDepreciacaoModelList) {
      plutoRowList.add(_getPlutoRow(patrimTaxaDepreciacaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PatrimTaxaDepreciacaoModel patrimTaxaDepreciacaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(patrimTaxaDepreciacaoModel: patrimTaxaDepreciacaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PatrimTaxaDepreciacaoModel? patrimTaxaDepreciacaoModel}) {
    return {
			"id": PlutoCell(value: patrimTaxaDepreciacaoModel?.id ?? 0),
			"ncm": PlutoCell(value: patrimTaxaDepreciacaoModel?.ncm ?? ''),
			"bem": PlutoCell(value: patrimTaxaDepreciacaoModel?.bem ?? ''),
			"vida": PlutoCell(value: patrimTaxaDepreciacaoModel?.vida ?? 0),
			"taxa": PlutoCell(value: patrimTaxaDepreciacaoModel?.taxa ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _patrimTaxaDepreciacaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      patrimTaxaDepreciacaoModel.plutoRowToObject(plutoRow);
    } else {
      patrimTaxaDepreciacaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Taxas de Depreciação]';
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
    await Get.find<PatrimTaxaDepreciacaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await patrimTaxaDepreciacaoRepository.getList(filter: filter).then( (data){ _patrimTaxaDepreciacaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Taxas de Depreciação',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			ncmController.text = currentRow.cells['ncm']?.value ?? '';
			bemController.text = currentRow.cells['bem']?.value ?? '';
			vidaController.text = currentRow.cells['vida']?.value?.toStringAsFixed(2) ?? '';
			taxaController.text = currentRow.cells['taxa']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.patrimTaxaDepreciacaoEditPage)!.then((value) {
        if (patrimTaxaDepreciacaoModel.id == 0) {
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
    patrimTaxaDepreciacaoModel = PatrimTaxaDepreciacaoModel();
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
        if (await patrimTaxaDepreciacaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _patrimTaxaDepreciacaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final ncmController = TextEditingController();
	final bemController = TextEditingController();
	final vidaController = MoneyMaskedTextController();
	final taxaController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimTaxaDepreciacaoModel.id;
		plutoRow.cells['ncm']?.value = patrimTaxaDepreciacaoModel.ncm;
		plutoRow.cells['bem']?.value = patrimTaxaDepreciacaoModel.bem;
		plutoRow.cells['vida']?.value = patrimTaxaDepreciacaoModel.vida;
		plutoRow.cells['taxa']?.value = patrimTaxaDepreciacaoModel.taxa;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await patrimTaxaDepreciacaoRepository.save(patrimTaxaDepreciacaoModel: patrimTaxaDepreciacaoModel); 
        if (result != null) {
          patrimTaxaDepreciacaoModel = result;
          if (_isInserting) {
            _patrimTaxaDepreciacaoModelList.add(result);
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
		functionName = "patrim_taxa_depreciacao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		ncmController.dispose();
		bemController.dispose();
		vidaController.dispose();
		taxaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}