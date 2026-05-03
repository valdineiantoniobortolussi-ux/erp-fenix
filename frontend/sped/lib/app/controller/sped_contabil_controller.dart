import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/controller/controller_imports.dart';
import 'package:sped/app/data/model/model_imports.dart';
import 'package:sped/app/page/grid_columns/grid_columns_imports.dart';

import 'package:sped/app/routes/app_routes.dart';
import 'package:sped/app/data/repository/sped_contabil_repository.dart';
import 'package:sped/app/page/shared_page/shared_page_imports.dart';
import 'package:sped/app/page/shared_widget/message_dialog.dart';
import 'package:sped/app/mixin/controller_base_mixin.dart';

class SpedContabilController extends GetxController with ControllerBaseMixin {
  final SpedContabilRepository spedContabilRepository;
  SpedContabilController({required this.spedContabilRepository});

  // general
  final _dbColumns = SpedContabilModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = SpedContabilModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = spedContabilGridColumns();
  
  var _spedContabilModelList = <SpedContabilModel>[];

  final _spedContabilModel = SpedContabilModel().obs;
  SpedContabilModel get spedContabilModel => _spedContabilModel.value;
  set spedContabilModel(value) => _spedContabilModel.value = value ?? SpedContabilModel();

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
    for (var spedContabilModel in _spedContabilModelList) {
      plutoRowList.add(_getPlutoRow(spedContabilModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(SpedContabilModel spedContabilModel) {
    return PlutoRow(
      cells: _getPlutoCells(spedContabilModel: spedContabilModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ SpedContabilModel? spedContabilModel}) {
    return {
			"id": PlutoCell(value: spedContabilModel?.id ?? 0),
			"dataEmissao": PlutoCell(value: spedContabilModel?.dataEmissao ?? ''),
			"periodoInicial": PlutoCell(value: spedContabilModel?.periodoInicial ?? ''),
			"periodoFinal": PlutoCell(value: spedContabilModel?.periodoFinal ?? ''),
			"formaEscrituracao": PlutoCell(value: spedContabilModel?.formaEscrituracao ?? ''),
			"versaoLayout": PlutoCell(value: spedContabilModel?.versaoLayout ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _spedContabilModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      spedContabilModel.plutoRowToObject(plutoRow);
    } else {
      spedContabilModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Sped Contábil]';
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
    await Get.find<SpedContabilController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await spedContabilRepository.getList(filter: filter).then( (data){ _spedContabilModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Sped Contábil',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			versaoLayoutController.text = currentRow.cells['versaoLayout']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.spedContabilEditPage)!.then((value) {
        if (spedContabilModel.id == 0) {
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
    spedContabilModel = SpedContabilModel();
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
        if (await spedContabilRepository.delete(id: currentRow.cells['id']!.value)) {
          _spedContabilModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final versaoLayoutController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = spedContabilModel.id;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(spedContabilModel.dataEmissao);
		plutoRow.cells['periodoInicial']?.value = Util.formatDate(spedContabilModel.periodoInicial);
		plutoRow.cells['periodoFinal']?.value = Util.formatDate(spedContabilModel.periodoFinal);
		plutoRow.cells['formaEscrituracao']?.value = spedContabilModel.formaEscrituracao;
		plutoRow.cells['versaoLayout']?.value = spedContabilModel.versaoLayout;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await spedContabilRepository.save(spedContabilModel: spedContabilModel); 
        if (result != null) {
          spedContabilModel = result;
          if (_isInserting) {
            _spedContabilModelList.add(result);
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
		functionName = "sped_contabil";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		versaoLayoutController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}