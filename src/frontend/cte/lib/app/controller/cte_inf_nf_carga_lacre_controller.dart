import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/controller/controller_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cte/app/routes/app_routes.dart';
import 'package:cte/app/data/repository/cte_inf_nf_carga_lacre_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteInfNfCargaLacreController extends GetxController with ControllerBaseMixin {
  final CteInfNfCargaLacreRepository cteInfNfCargaLacreRepository;
  CteInfNfCargaLacreController({required this.cteInfNfCargaLacreRepository});

  // general
  final _dbColumns = CteInfNfCargaLacreModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteInfNfCargaLacreModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteInfNfCargaLacreGridColumns();
  
  var _cteInfNfCargaLacreModelList = <CteInfNfCargaLacreModel>[];

  final _cteInfNfCargaLacreModel = CteInfNfCargaLacreModel().obs;
  CteInfNfCargaLacreModel get cteInfNfCargaLacreModel => _cteInfNfCargaLacreModel.value;
  set cteInfNfCargaLacreModel(value) => _cteInfNfCargaLacreModel.value = value ?? CteInfNfCargaLacreModel();

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
    for (var cteInfNfCargaLacreModel in _cteInfNfCargaLacreModelList) {
      plutoRowList.add(_getPlutoRow(cteInfNfCargaLacreModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteInfNfCargaLacreModel cteInfNfCargaLacreModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteInfNfCargaLacreModel: cteInfNfCargaLacreModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteInfNfCargaLacreModel? cteInfNfCargaLacreModel}) {
    return {
			"id": PlutoCell(value: cteInfNfCargaLacreModel?.id ?? 0),
			"cteInformacaoNfCarga": PlutoCell(value: cteInfNfCargaLacreModel?.cteInformacaoNfCargaModel?.tipoUnidadeCarga ?? ''),
			"numero": PlutoCell(value: cteInfNfCargaLacreModel?.numero ?? ''),
			"quantidadeRateada": PlutoCell(value: cteInfNfCargaLacreModel?.quantidadeRateada ?? 0),
			"idCteInformacaoNfCarga": PlutoCell(value: cteInfNfCargaLacreModel?.idCteInformacaoNfCarga ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteInfNfCargaLacreModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteInfNfCargaLacreModel.plutoRowToObject(plutoRow);
    } else {
      cteInfNfCargaLacreModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Inf Nf Carga Lacre]';
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
    await Get.find<CteInfNfCargaLacreController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteInfNfCargaLacreRepository.getList(filter: filter).then( (data){ _cteInfNfCargaLacreModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Inf Nf Carga Lacre',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteInformacaoNfCargaModelController.text = currentRow.cells['cteInformacaoNfCarga']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			quantidadeRateadaController.text = currentRow.cells['quantidadeRateada']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteInfNfCargaLacreEditPage)!.then((value) {
        if (cteInfNfCargaLacreModel.id == 0) {
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
    cteInfNfCargaLacreModel = CteInfNfCargaLacreModel();
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
        if (await cteInfNfCargaLacreRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteInfNfCargaLacreModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteInformacaoNfCargaModelController = TextEditingController();
	final numeroController = TextEditingController();
	final quantidadeRateadaController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteInfNfCargaLacreModel.id;
		plutoRow.cells['idCteInformacaoNfCarga']?.value = cteInfNfCargaLacreModel.idCteInformacaoNfCarga;
		plutoRow.cells['cteInformacaoNfCarga']?.value = cteInfNfCargaLacreModel.cteInformacaoNfCargaModel?.tipoUnidadeCarga;
		plutoRow.cells['numero']?.value = cteInfNfCargaLacreModel.numero;
		plutoRow.cells['quantidadeRateada']?.value = cteInfNfCargaLacreModel.quantidadeRateada;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteInfNfCargaLacreRepository.save(cteInfNfCargaLacreModel: cteInfNfCargaLacreModel); 
        if (result != null) {
          cteInfNfCargaLacreModel = result;
          if (_isInserting) {
            _cteInfNfCargaLacreModelList.add(result);
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

	Future callCteInformacaoNfCargaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Informacao Nf Carga]'; 
		lookupController.route = '/cte-informacao-nf-carga/'; 
		lookupController.gridColumns = cteInformacaoNfCargaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteInformacaoNfCargaModel.aliasColumns; 
		lookupController.dbColumns = CteInformacaoNfCargaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteInfNfCargaLacreModel.idCteInformacaoNfCarga = plutoRowResult.cells['id']!.value; 
			cteInfNfCargaLacreModel.cteInformacaoNfCargaModel!.plutoRowToObject(plutoRowResult); 
			cteInformacaoNfCargaModelController.text = cteInfNfCargaLacreModel.cteInformacaoNfCargaModel?.tipoUnidadeCarga ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_inf_nf_carga_lacre";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteInformacaoNfCargaModelController.dispose();
		numeroController.dispose();
		quantidadeRateadaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}