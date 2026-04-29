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
import 'package:nfe/app/data/repository/nfe_duplicata_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeDuplicataController extends GetxController with ControllerBaseMixin {
  final NfeDuplicataRepository nfeDuplicataRepository;
  NfeDuplicataController({required this.nfeDuplicataRepository});

  // general
  final _dbColumns = NfeDuplicataModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeDuplicataModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeDuplicataGridColumns();
  
  var _nfeDuplicataModelList = <NfeDuplicataModel>[];

  final _nfeDuplicataModel = NfeDuplicataModel().obs;
  NfeDuplicataModel get nfeDuplicataModel => _nfeDuplicataModel.value;
  set nfeDuplicataModel(value) => _nfeDuplicataModel.value = value ?? NfeDuplicataModel();

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
    for (var nfeDuplicataModel in _nfeDuplicataModelList) {
      plutoRowList.add(_getPlutoRow(nfeDuplicataModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeDuplicataModel nfeDuplicataModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeDuplicataModel: nfeDuplicataModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeDuplicataModel? nfeDuplicataModel}) {
    return {
			"id": PlutoCell(value: nfeDuplicataModel?.id ?? 0),
			"nfeFatura": PlutoCell(value: nfeDuplicataModel?.nfeFaturaModel?.numero ?? ''),
			"numero": PlutoCell(value: nfeDuplicataModel?.numero ?? ''),
			"dataVencimento": PlutoCell(value: nfeDuplicataModel?.dataVencimento ?? ''),
			"valor": PlutoCell(value: nfeDuplicataModel?.valor ?? 0),
			"idNfeFatura": PlutoCell(value: nfeDuplicataModel?.idNfeFatura ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeDuplicataModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeDuplicataModel.plutoRowToObject(plutoRow);
    } else {
      nfeDuplicataModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Duplicata]';
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
    await Get.find<NfeDuplicataController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeDuplicataRepository.getList(filter: filter).then( (data){ _nfeDuplicataModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Duplicata',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeFaturaModelController.text = currentRow.cells['nfeFatura']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeDuplicataEditPage)!.then((value) {
        if (nfeDuplicataModel.id == 0) {
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
    nfeDuplicataModel = NfeDuplicataModel();
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
        if (await nfeDuplicataRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeDuplicataModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeFaturaModelController = TextEditingController();
	final numeroController = TextEditingController();
	final valorController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDuplicataModel.id;
		plutoRow.cells['idNfeFatura']?.value = nfeDuplicataModel.idNfeFatura;
		plutoRow.cells['nfeFatura']?.value = nfeDuplicataModel.nfeFaturaModel?.numero;
		plutoRow.cells['numero']?.value = nfeDuplicataModel.numero;
		plutoRow.cells['dataVencimento']?.value = Util.formatDate(nfeDuplicataModel.dataVencimento);
		plutoRow.cells['valor']?.value = nfeDuplicataModel.valor;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeDuplicataRepository.save(nfeDuplicataModel: nfeDuplicataModel); 
        if (result != null) {
          nfeDuplicataModel = result;
          if (_isInserting) {
            _nfeDuplicataModelList.add(result);
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

	Future callNfeFaturaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Nfe Fatura]'; 
		lookupController.route = '/nfe-fatura/'; 
		lookupController.gridColumns = nfeFaturaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeFaturaModel.aliasColumns; 
		lookupController.dbColumns = NfeFaturaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeDuplicataModel.idNfeFatura = plutoRowResult.cells['id']!.value; 
			nfeDuplicataModel.nfeFaturaModel!.plutoRowToObject(plutoRowResult); 
			nfeFaturaModelController.text = nfeDuplicataModel.nfeFaturaModel?.numero ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nfe_duplicata";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeFaturaModelController.dispose();
		numeroController.dispose();
		valorController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}