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
import 'package:nfe/app/data/repository/nfe_cana_deducoes_safra_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeCanaDeducoesSafraController extends GetxController with ControllerBaseMixin {
  final NfeCanaDeducoesSafraRepository nfeCanaDeducoesSafraRepository;
  NfeCanaDeducoesSafraController({required this.nfeCanaDeducoesSafraRepository});

  // general
  final _dbColumns = NfeCanaDeducoesSafraModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeCanaDeducoesSafraModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeCanaDeducoesSafraGridColumns();
  
  var _nfeCanaDeducoesSafraModelList = <NfeCanaDeducoesSafraModel>[];

  final _nfeCanaDeducoesSafraModel = NfeCanaDeducoesSafraModel().obs;
  NfeCanaDeducoesSafraModel get nfeCanaDeducoesSafraModel => _nfeCanaDeducoesSafraModel.value;
  set nfeCanaDeducoesSafraModel(value) => _nfeCanaDeducoesSafraModel.value = value ?? NfeCanaDeducoesSafraModel();

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
    for (var nfeCanaDeducoesSafraModel in _nfeCanaDeducoesSafraModelList) {
      plutoRowList.add(_getPlutoRow(nfeCanaDeducoesSafraModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeCanaDeducoesSafraModel nfeCanaDeducoesSafraModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeCanaDeducoesSafraModel: nfeCanaDeducoesSafraModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeCanaDeducoesSafraModel? nfeCanaDeducoesSafraModel}) {
    return {
			"id": PlutoCell(value: nfeCanaDeducoesSafraModel?.id ?? 0),
			"nfeCana": PlutoCell(value: nfeCanaDeducoesSafraModel?.nfeCanaModel?.safra ?? ''),
			"decricao": PlutoCell(value: nfeCanaDeducoesSafraModel?.decricao ?? ''),
			"valorDeducao": PlutoCell(value: nfeCanaDeducoesSafraModel?.valorDeducao ?? 0),
			"valorFornecimento": PlutoCell(value: nfeCanaDeducoesSafraModel?.valorFornecimento ?? 0),
			"valorTotalDeducao": PlutoCell(value: nfeCanaDeducoesSafraModel?.valorTotalDeducao ?? 0),
			"valorLiquidoFornecimento": PlutoCell(value: nfeCanaDeducoesSafraModel?.valorLiquidoFornecimento ?? 0),
			"idNfeCana": PlutoCell(value: nfeCanaDeducoesSafraModel?.idNfeCana ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeCanaDeducoesSafraModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeCanaDeducoesSafraModel.plutoRowToObject(plutoRow);
    } else {
      nfeCanaDeducoesSafraModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Nfe Cana Deducoes Safra]';
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
    await Get.find<NfeCanaDeducoesSafraController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeCanaDeducoesSafraRepository.getList(filter: filter).then( (data){ _nfeCanaDeducoesSafraModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Nfe Cana Deducoes Safra',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeCanaModelController.text = currentRow.cells['nfeCana']?.value ?? '';
			decricaoController.text = currentRow.cells['decricao']?.value ?? '';
			valorDeducaoController.text = currentRow.cells['valorDeducao']?.value?.toStringAsFixed(2) ?? '';
			valorFornecimentoController.text = currentRow.cells['valorFornecimento']?.value?.toStringAsFixed(2) ?? '';
			valorTotalDeducaoController.text = currentRow.cells['valorTotalDeducao']?.value?.toStringAsFixed(2) ?? '';
			valorLiquidoFornecimentoController.text = currentRow.cells['valorLiquidoFornecimento']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeCanaDeducoesSafraEditPage)!.then((value) {
        if (nfeCanaDeducoesSafraModel.id == 0) {
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
    nfeCanaDeducoesSafraModel = NfeCanaDeducoesSafraModel();
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
        if (await nfeCanaDeducoesSafraRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeCanaDeducoesSafraModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final decricaoController = TextEditingController();
	final valorDeducaoController = MoneyMaskedTextController();
	final valorFornecimentoController = MoneyMaskedTextController();
	final valorTotalDeducaoController = MoneyMaskedTextController();
	final valorLiquidoFornecimentoController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeCanaDeducoesSafraModel.id;
		plutoRow.cells['idNfeCana']?.value = nfeCanaDeducoesSafraModel.idNfeCana;
		plutoRow.cells['nfeCana']?.value = nfeCanaDeducoesSafraModel.nfeCanaModel?.safra;
		plutoRow.cells['decricao']?.value = nfeCanaDeducoesSafraModel.decricao;
		plutoRow.cells['valorDeducao']?.value = nfeCanaDeducoesSafraModel.valorDeducao;
		plutoRow.cells['valorFornecimento']?.value = nfeCanaDeducoesSafraModel.valorFornecimento;
		plutoRow.cells['valorTotalDeducao']?.value = nfeCanaDeducoesSafraModel.valorTotalDeducao;
		plutoRow.cells['valorLiquidoFornecimento']?.value = nfeCanaDeducoesSafraModel.valorLiquidoFornecimento;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeCanaDeducoesSafraRepository.save(nfeCanaDeducoesSafraModel: nfeCanaDeducoesSafraModel); 
        if (result != null) {
          nfeCanaDeducoesSafraModel = result;
          if (_isInserting) {
            _nfeCanaDeducoesSafraModelList.add(result);
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
			nfeCanaDeducoesSafraModel.idNfeCana = plutoRowResult.cells['id']!.value; 
			nfeCanaDeducoesSafraModel.nfeCanaModel!.plutoRowToObject(plutoRowResult); 
			nfeCanaModelController.text = nfeCanaDeducoesSafraModel.nfeCanaModel?.safra ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nfe_cana_deducoes_safra";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeCanaModelController.dispose();
		decricaoController.dispose();
		valorDeducaoController.dispose();
		valorFornecimentoController.dispose();
		valorTotalDeducaoController.dispose();
		valorLiquidoFornecimentoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}