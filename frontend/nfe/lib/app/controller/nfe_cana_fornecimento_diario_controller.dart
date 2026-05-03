import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/controller/controller_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:nfe/app/routes/app_routes.dart';
import 'package:nfe/app/data/repository/nfe_cana_fornecimento_diario_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeCanaFornecimentoDiarioController extends GetxController with ControllerBaseMixin {
  final NfeCanaFornecimentoDiarioRepository nfeCanaFornecimentoDiarioRepository;
  NfeCanaFornecimentoDiarioController({required this.nfeCanaFornecimentoDiarioRepository});

  // general
  final _dbColumns = NfeCanaFornecimentoDiarioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeCanaFornecimentoDiarioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeCanaFornecimentoDiarioGridColumns();
  
  var _nfeCanaFornecimentoDiarioModelList = <NfeCanaFornecimentoDiarioModel>[];

  final _nfeCanaFornecimentoDiarioModel = NfeCanaFornecimentoDiarioModel().obs;
  NfeCanaFornecimentoDiarioModel get nfeCanaFornecimentoDiarioModel => _nfeCanaFornecimentoDiarioModel.value;
  set nfeCanaFornecimentoDiarioModel(value) => _nfeCanaFornecimentoDiarioModel.value = value ?? NfeCanaFornecimentoDiarioModel();

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
    for (var nfeCanaFornecimentoDiarioModel in _nfeCanaFornecimentoDiarioModelList) {
      plutoRowList.add(_getPlutoRow(nfeCanaFornecimentoDiarioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeCanaFornecimentoDiarioModel nfeCanaFornecimentoDiarioModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeCanaFornecimentoDiarioModel: nfeCanaFornecimentoDiarioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeCanaFornecimentoDiarioModel? nfeCanaFornecimentoDiarioModel}) {
    return {
			"id": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.id ?? 0),
			"nfeCana": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.nfeCanaModel?.safra ?? ''),
			"dia": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.dia ?? ''),
			"quantidade": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.quantidade ?? 0),
			"quantidadeTotalMes": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.quantidadeTotalMes ?? 0),
			"quantidadeTotalAnterior": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.quantidadeTotalAnterior ?? 0),
			"quantidadeTotalGeral": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.quantidadeTotalGeral ?? 0),
			"idNfeCana": PlutoCell(value: nfeCanaFornecimentoDiarioModel?.idNfeCana ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeCanaFornecimentoDiarioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeCanaFornecimentoDiarioModel.plutoRowToObject(plutoRow);
    } else {
      nfeCanaFornecimentoDiarioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Nfe Cana Fornecimento Diario]';
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
    await Get.find<NfeCanaFornecimentoDiarioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeCanaFornecimentoDiarioRepository.getList(filter: filter).then( (data){ _nfeCanaFornecimentoDiarioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Nfe Cana Fornecimento Diario',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeCanaModelController.text = currentRow.cells['nfeCana']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toStringAsFixed(2) ?? '';
			quantidadeTotalMesController.text = currentRow.cells['quantidadeTotalMes']?.value?.toStringAsFixed(2) ?? '';
			quantidadeTotalAnteriorController.text = currentRow.cells['quantidadeTotalAnterior']?.value?.toStringAsFixed(2) ?? '';
			quantidadeTotalGeralController.text = currentRow.cells['quantidadeTotalGeral']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeCanaFornecimentoDiarioEditPage)!.then((value) {
        if (nfeCanaFornecimentoDiarioModel.id == 0) {
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
    nfeCanaFornecimentoDiarioModel = NfeCanaFornecimentoDiarioModel();
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
        if (await nfeCanaFornecimentoDiarioRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeCanaFornecimentoDiarioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeCanaModelController = TextEditingController();
	final quantidadeController = MoneyMaskedTextController();
	final quantidadeTotalMesController = MoneyMaskedTextController();
	final quantidadeTotalAnteriorController = MoneyMaskedTextController();
	final quantidadeTotalGeralController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeCanaFornecimentoDiarioModel.id;
		plutoRow.cells['idNfeCana']?.value = nfeCanaFornecimentoDiarioModel.idNfeCana;
		plutoRow.cells['nfeCana']?.value = nfeCanaFornecimentoDiarioModel.nfeCanaModel?.safra;
		plutoRow.cells['dia']?.value = nfeCanaFornecimentoDiarioModel.dia;
		plutoRow.cells['quantidade']?.value = nfeCanaFornecimentoDiarioModel.quantidade;
		plutoRow.cells['quantidadeTotalMes']?.value = nfeCanaFornecimentoDiarioModel.quantidadeTotalMes;
		plutoRow.cells['quantidadeTotalAnterior']?.value = nfeCanaFornecimentoDiarioModel.quantidadeTotalAnterior;
		plutoRow.cells['quantidadeTotalGeral']?.value = nfeCanaFornecimentoDiarioModel.quantidadeTotalGeral;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeCanaFornecimentoDiarioRepository.save(nfeCanaFornecimentoDiarioModel: nfeCanaFornecimentoDiarioModel); 
        if (result != null) {
          nfeCanaFornecimentoDiarioModel = result;
          if (_isInserting) {
            _nfeCanaFornecimentoDiarioModelList.add(result);
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

	Future callNfeCanaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Nfe Cana]'; 
		lookupController.route = '/nfe-cana/'; 
		lookupController.gridColumns = nfeCanaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeCanaModel.aliasColumns; 
		lookupController.dbColumns = NfeCanaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeCanaFornecimentoDiarioModel.idNfeCana = plutoRowResult.cells['id']!.value; 
			nfeCanaFornecimentoDiarioModel.nfeCanaModel!.plutoRowToObject(plutoRowResult); 
			nfeCanaModelController.text = nfeCanaFornecimentoDiarioModel.nfeCanaModel?.safra ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nfe_cana_fornecimento_diario";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeCanaModelController.dispose();
		quantidadeController.dispose();
		quantidadeTotalMesController.dispose();
		quantidadeTotalAnteriorController.dispose();
		quantidadeTotalGeralController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}