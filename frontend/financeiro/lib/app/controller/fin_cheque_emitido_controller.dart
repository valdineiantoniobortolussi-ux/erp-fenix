import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/fin_cheque_emitido_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinChequeEmitidoController extends GetxController with ControllerBaseMixin {
  final FinChequeEmitidoRepository finChequeEmitidoRepository;
  FinChequeEmitidoController({required this.finChequeEmitidoRepository});

  // general
  final _dbColumns = FinChequeEmitidoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinChequeEmitidoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finChequeEmitidoGridColumns();
  
  var _finChequeEmitidoModelList = <FinChequeEmitidoModel>[];

  final _finChequeEmitidoModel = FinChequeEmitidoModel().obs;
  FinChequeEmitidoModel get finChequeEmitidoModel => _finChequeEmitidoModel.value;
  set finChequeEmitidoModel(value) => _finChequeEmitidoModel.value = value ?? FinChequeEmitidoModel();

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
    for (var finChequeEmitidoModel in _finChequeEmitidoModelList) {
      plutoRowList.add(_getPlutoRow(finChequeEmitidoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinChequeEmitidoModel finChequeEmitidoModel) {
    return PlutoRow(
      cells: _getPlutoCells(finChequeEmitidoModel: finChequeEmitidoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinChequeEmitidoModel? finChequeEmitidoModel}) {
    return {
			"id": PlutoCell(value: finChequeEmitidoModel?.id ?? 0),
			"cheque": PlutoCell(value: finChequeEmitidoModel?.chequeModel?.numero ?? ''),
			"dataEmissao": PlutoCell(value: finChequeEmitidoModel?.dataEmissao ?? ''),
			"bomPara": PlutoCell(value: finChequeEmitidoModel?.bomPara ?? ''),
			"dataCompensacao": PlutoCell(value: finChequeEmitidoModel?.dataCompensacao ?? ''),
			"valor": PlutoCell(value: finChequeEmitidoModel?.valor ?? 0),
			"nominalA": PlutoCell(value: finChequeEmitidoModel?.nominalA ?? ''),
			"idCheque": PlutoCell(value: finChequeEmitidoModel?.idCheque ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finChequeEmitidoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finChequeEmitidoModel.plutoRowToObject(plutoRow);
    } else {
      finChequeEmitidoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cheque Emitido]';
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
    await Get.find<FinChequeEmitidoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finChequeEmitidoRepository.getList(filter: filter).then( (data){ _finChequeEmitidoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cheque Emitido',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			chequeModelController.text = currentRow.cells['cheque']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			nominalAController.text = currentRow.cells['nominalA']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finChequeEmitidoEditPage)!.then((value) {
        if (finChequeEmitidoModel.id == 0) {
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
    finChequeEmitidoModel = FinChequeEmitidoModel();
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
        if (await finChequeEmitidoRepository.delete(id: currentRow.cells['id']!.value)) {
          _finChequeEmitidoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final chequeModelController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final nominalAController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finChequeEmitidoModel.id;
		plutoRow.cells['idCheque']?.value = finChequeEmitidoModel.idCheque;
		plutoRow.cells['cheque']?.value = finChequeEmitidoModel.chequeModel?.numero;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(finChequeEmitidoModel.dataEmissao);
		plutoRow.cells['bomPara']?.value = Util.formatDate(finChequeEmitidoModel.bomPara);
		plutoRow.cells['dataCompensacao']?.value = Util.formatDate(finChequeEmitidoModel.dataCompensacao);
		plutoRow.cells['valor']?.value = finChequeEmitidoModel.valor;
		plutoRow.cells['nominalA']?.value = finChequeEmitidoModel.nominalA;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finChequeEmitidoRepository.save(finChequeEmitidoModel: finChequeEmitidoModel); 
        if (result != null) {
          finChequeEmitidoModel = result;
          if (_isInserting) {
            _finChequeEmitidoModelList.add(result);
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

	Future callChequeLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Número Cheque]'; 
		lookupController.route = '/cheque/'; 
		lookupController.gridColumns = chequeGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ChequeModel.aliasColumns; 
		lookupController.dbColumns = ChequeModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finChequeEmitidoModel.idCheque = plutoRowResult.cells['id']!.value; 
			finChequeEmitidoModel.chequeModel!.plutoRowToObject(plutoRowResult); 
			chequeModelController.text = finChequeEmitidoModel.chequeModel?.numero?.toString() ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "fin_cheque_emitido";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		chequeModelController.dispose();
		valorController.dispose();
		nominalAController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}