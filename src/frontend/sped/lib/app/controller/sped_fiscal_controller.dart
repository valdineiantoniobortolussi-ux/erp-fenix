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
import 'package:sped/app/data/repository/sped_fiscal_repository.dart';
import 'package:sped/app/page/shared_page/shared_page_imports.dart';
import 'package:sped/app/page/shared_widget/message_dialog.dart';
import 'package:sped/app/mixin/controller_base_mixin.dart';

class SpedFiscalController extends GetxController with ControllerBaseMixin {
  final SpedFiscalRepository spedFiscalRepository;
  SpedFiscalController({required this.spedFiscalRepository});

  // general
  final _dbColumns = SpedFiscalModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = SpedFiscalModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = spedFiscalGridColumns();
  
  var _spedFiscalModelList = <SpedFiscalModel>[];

  final _spedFiscalModel = SpedFiscalModel().obs;
  SpedFiscalModel get spedFiscalModel => _spedFiscalModel.value;
  set spedFiscalModel(value) => _spedFiscalModel.value = value ?? SpedFiscalModel();

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
    for (var spedFiscalModel in _spedFiscalModelList) {
      plutoRowList.add(_getPlutoRow(spedFiscalModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(SpedFiscalModel spedFiscalModel) {
    return PlutoRow(
      cells: _getPlutoCells(spedFiscalModel: spedFiscalModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ SpedFiscalModel? spedFiscalModel}) {
    return {
			"id": PlutoCell(value: spedFiscalModel?.id ?? 0),
			"dataEmissao": PlutoCell(value: spedFiscalModel?.dataEmissao ?? ''),
			"periodoInicial": PlutoCell(value: spedFiscalModel?.periodoInicial ?? ''),
			"periodoFinal": PlutoCell(value: spedFiscalModel?.periodoFinal ?? ''),
			"perfilApresentacao": PlutoCell(value: spedFiscalModel?.perfilApresentacao ?? ''),
			"finalidadeArquivo": PlutoCell(value: spedFiscalModel?.finalidadeArquivo ?? ''),
			"versaoLayout": PlutoCell(value: spedFiscalModel?.versaoLayout ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _spedFiscalModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      spedFiscalModel.plutoRowToObject(plutoRow);
    } else {
      spedFiscalModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Sped Fiscal]';
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
    await Get.find<SpedFiscalController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await spedFiscalRepository.getList(filter: filter).then( (data){ _spedFiscalModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Sped Fiscal',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			finalidadeArquivoController.text = currentRow.cells['finalidadeArquivo']?.value ?? '';
			versaoLayoutController.text = currentRow.cells['versaoLayout']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.spedFiscalEditPage)!.then((value) {
        if (spedFiscalModel.id == 0) {
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
    spedFiscalModel = SpedFiscalModel();
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
        if (await spedFiscalRepository.delete(id: currentRow.cells['id']!.value)) {
          _spedFiscalModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final finalidadeArquivoController = TextEditingController();
	final versaoLayoutController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = spedFiscalModel.id;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(spedFiscalModel.dataEmissao);
		plutoRow.cells['periodoInicial']?.value = Util.formatDate(spedFiscalModel.periodoInicial);
		plutoRow.cells['periodoFinal']?.value = Util.formatDate(spedFiscalModel.periodoFinal);
		plutoRow.cells['perfilApresentacao']?.value = spedFiscalModel.perfilApresentacao;
		plutoRow.cells['finalidadeArquivo']?.value = spedFiscalModel.finalidadeArquivo;
		plutoRow.cells['versaoLayout']?.value = spedFiscalModel.versaoLayout;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await spedFiscalRepository.save(spedFiscalModel: spedFiscalModel); 
        if (result != null) {
          spedFiscalModel = result;
          if (_isInserting) {
            _spedFiscalModelList.add(result);
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
		functionName = "sped_fiscal";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		finalidadeArquivoController.dispose();
		versaoLayoutController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}