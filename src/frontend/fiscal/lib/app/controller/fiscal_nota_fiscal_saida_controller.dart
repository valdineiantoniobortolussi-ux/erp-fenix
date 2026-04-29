import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/controller/controller_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';

import 'package:fiscal/app/routes/app_routes.dart';
import 'package:fiscal/app/data/repository/fiscal_nota_fiscal_saida_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalNotaFiscalSaidaController extends GetxController with ControllerBaseMixin {
  final FiscalNotaFiscalSaidaRepository fiscalNotaFiscalSaidaRepository;
  FiscalNotaFiscalSaidaController({required this.fiscalNotaFiscalSaidaRepository});

  // general
  final _dbColumns = FiscalNotaFiscalSaidaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FiscalNotaFiscalSaidaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = fiscalNotaFiscalSaidaGridColumns();
  
  var _fiscalNotaFiscalSaidaModelList = <FiscalNotaFiscalSaidaModel>[];

  final _fiscalNotaFiscalSaidaModel = FiscalNotaFiscalSaidaModel().obs;
  FiscalNotaFiscalSaidaModel get fiscalNotaFiscalSaidaModel => _fiscalNotaFiscalSaidaModel.value;
  set fiscalNotaFiscalSaidaModel(value) => _fiscalNotaFiscalSaidaModel.value = value ?? FiscalNotaFiscalSaidaModel();

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
    for (var fiscalNotaFiscalSaidaModel in _fiscalNotaFiscalSaidaModelList) {
      plutoRowList.add(_getPlutoRow(fiscalNotaFiscalSaidaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FiscalNotaFiscalSaidaModel fiscalNotaFiscalSaidaModel) {
    return PlutoRow(
      cells: _getPlutoCells(fiscalNotaFiscalSaidaModel: fiscalNotaFiscalSaidaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FiscalNotaFiscalSaidaModel? fiscalNotaFiscalSaidaModel}) {
    return {
			"id": PlutoCell(value: fiscalNotaFiscalSaidaModel?.id ?? 0),
			"nfeCabecalho": PlutoCell(value: fiscalNotaFiscalSaidaModel?.nfeCabecalhoModel?.chave_acesso ?? ''),
			"competencia": PlutoCell(value: fiscalNotaFiscalSaidaModel?.competencia ?? ''),
			"idNfeCabecalho": PlutoCell(value: fiscalNotaFiscalSaidaModel?.idNfeCabecalho ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _fiscalNotaFiscalSaidaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      fiscalNotaFiscalSaidaModel.plutoRowToObject(plutoRow);
    } else {
      fiscalNotaFiscalSaidaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Registro de Saídas]';
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
    await Get.find<FiscalNotaFiscalSaidaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await fiscalNotaFiscalSaidaRepository.getList(filter: filter).then( (data){ _fiscalNotaFiscalSaidaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Registro de Saídas',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeCabecalhoModelController.text = currentRow.cells['nfeCabecalho']?.value ?? '';
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.fiscalNotaFiscalSaidaEditPage)!.then((value) {
        if (fiscalNotaFiscalSaidaModel.id == 0) {
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
    fiscalNotaFiscalSaidaModel = FiscalNotaFiscalSaidaModel();
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
        if (await fiscalNotaFiscalSaidaRepository.delete(id: currentRow.cells['id']!.value)) {
          _fiscalNotaFiscalSaidaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeCabecalhoModelController = TextEditingController();
	final competenciaController = MaskedTextController(mask: '00/0000',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalNotaFiscalSaidaModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = fiscalNotaFiscalSaidaModel.idNfeCabecalho;
		plutoRow.cells['nfeCabecalho']?.value = fiscalNotaFiscalSaidaModel.nfeCabecalhoModel?.chave_acesso;
		plutoRow.cells['competencia']?.value = fiscalNotaFiscalSaidaModel.competencia;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await fiscalNotaFiscalSaidaRepository.save(fiscalNotaFiscalSaidaModel: fiscalNotaFiscalSaidaModel); 
        if (result != null) {
          fiscalNotaFiscalSaidaModel = result;
          if (_isInserting) {
            _fiscalNotaFiscalSaidaModelList.add(result);
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

	Future callNfeCabecalhoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [NF-e Cabecalho]'; 
		lookupController.route = '/nfe-cabecalho/'; 
		lookupController.gridColumns = nfeCabecalhoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeCabecalhoModel.aliasColumns; 
		lookupController.dbColumns = NfeCabecalhoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			fiscalNotaFiscalSaidaModel.idNfeCabecalho = plutoRowResult.cells['id']!.value; 
			fiscalNotaFiscalSaidaModel.nfeCabecalhoModel!.plutoRowToObject(plutoRowResult); 
			nfeCabecalhoModelController.text = fiscalNotaFiscalSaidaModel.nfeCabecalhoModel?.chave_acesso ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "fiscal_nota_fiscal_saida";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeCabecalhoModelController.dispose();
		competenciaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}