import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/controller/controller_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/page/grid_columns/grid_columns_imports.dart';

import 'package:vendas/app/routes/app_routes.dart';
import 'package:vendas/app/data/repository/nota_fiscal_tipo_repository.dart';
import 'package:vendas/app/page/shared_page/shared_page_imports.dart';
import 'package:vendas/app/page/shared_widget/message_dialog.dart';
import 'package:vendas/app/mixin/controller_base_mixin.dart';

class NotaFiscalTipoController extends GetxController with ControllerBaseMixin {
  final NotaFiscalTipoRepository notaFiscalTipoRepository;
  NotaFiscalTipoController({required this.notaFiscalTipoRepository});

  // general
  final _dbColumns = NotaFiscalTipoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NotaFiscalTipoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = notaFiscalTipoGridColumns();
  
  var _notaFiscalTipoModelList = <NotaFiscalTipoModel>[];

  final _notaFiscalTipoModel = NotaFiscalTipoModel().obs;
  NotaFiscalTipoModel get notaFiscalTipoModel => _notaFiscalTipoModel.value;
  set notaFiscalTipoModel(value) => _notaFiscalTipoModel.value = value ?? NotaFiscalTipoModel();

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
    for (var notaFiscalTipoModel in _notaFiscalTipoModelList) {
      plutoRowList.add(_getPlutoRow(notaFiscalTipoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NotaFiscalTipoModel notaFiscalTipoModel) {
    return PlutoRow(
      cells: _getPlutoCells(notaFiscalTipoModel: notaFiscalTipoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NotaFiscalTipoModel? notaFiscalTipoModel}) {
    return {
			"id": PlutoCell(value: notaFiscalTipoModel?.id ?? 0),
			"notaFiscalModelo": PlutoCell(value: notaFiscalTipoModel?.notaFiscalModeloModel?.modelo ?? ''),
			"nome": PlutoCell(value: notaFiscalTipoModel?.nome ?? ''),
			"descricao": PlutoCell(value: notaFiscalTipoModel?.descricao ?? ''),
			"serie": PlutoCell(value: notaFiscalTipoModel?.serie ?? ''),
			"serieScan": PlutoCell(value: notaFiscalTipoModel?.serieScan ?? ''),
			"ultimoNumero": PlutoCell(value: notaFiscalTipoModel?.ultimoNumero ?? 0),
			"idNotaFiscalModelo": PlutoCell(value: notaFiscalTipoModel?.idNotaFiscalModelo ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _notaFiscalTipoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      notaFiscalTipoModel.plutoRowToObject(plutoRow);
    } else {
      notaFiscalTipoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo de Nota Fiscal]';
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
    await Get.find<NotaFiscalTipoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await notaFiscalTipoRepository.getList(filter: filter).then( (data){ _notaFiscalTipoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo de Nota Fiscal',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			notaFiscalModeloModelController.text = currentRow.cells['notaFiscalModelo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			serieController.text = currentRow.cells['serie']?.value ?? '';
			serieScanController.text = currentRow.cells['serieScan']?.value ?? '';
			ultimoNumeroController.text = currentRow.cells['ultimoNumero']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.notaFiscalTipoEditPage)!.then((value) {
        if (notaFiscalTipoModel.id == 0) {
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
    notaFiscalTipoModel = NotaFiscalTipoModel();
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
        if (await notaFiscalTipoRepository.delete(id: currentRow.cells['id']!.value)) {
          _notaFiscalTipoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final notaFiscalModeloModelController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final serieController = TextEditingController();
	final serieScanController = TextEditingController();
	final ultimoNumeroController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = notaFiscalTipoModel.id;
		plutoRow.cells['idNotaFiscalModelo']?.value = notaFiscalTipoModel.idNotaFiscalModelo;
		plutoRow.cells['notaFiscalModelo']?.value = notaFiscalTipoModel.notaFiscalModeloModel?.modelo;
		plutoRow.cells['nome']?.value = notaFiscalTipoModel.nome;
		plutoRow.cells['descricao']?.value = notaFiscalTipoModel.descricao;
		plutoRow.cells['serie']?.value = notaFiscalTipoModel.serie;
		plutoRow.cells['serieScan']?.value = notaFiscalTipoModel.serieScan;
		plutoRow.cells['ultimoNumero']?.value = notaFiscalTipoModel.ultimoNumero;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await notaFiscalTipoRepository.save(notaFiscalTipoModel: notaFiscalTipoModel); 
        if (result != null) {
          notaFiscalTipoModel = result;
          if (_isInserting) {
            _notaFiscalTipoModelList.add(result);
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

	Future callNotaFiscalModeloLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Nota Fiscal Modelo]'; 
		lookupController.route = '/nota-fiscal-modelo/'; 
		lookupController.gridColumns = notaFiscalModeloGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NotaFiscalModeloModel.aliasColumns; 
		lookupController.dbColumns = NotaFiscalModeloModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			notaFiscalTipoModel.idNotaFiscalModelo = plutoRowResult.cells['id']!.value; 
			notaFiscalTipoModel.notaFiscalModeloModel!.plutoRowToObject(plutoRowResult); 
			notaFiscalModeloModelController.text = notaFiscalTipoModel.notaFiscalModeloModel?.modelo ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nota_fiscal_tipo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		notaFiscalModeloModelController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		serieController.dispose();
		serieScanController.dispose();
		ultimoNumeroController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}