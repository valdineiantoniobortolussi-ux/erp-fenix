import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_vale_transporte_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaValeTransporteController extends GetxController with ControllerBaseMixin {
  final FolhaValeTransporteRepository folhaValeTransporteRepository;
  FolhaValeTransporteController({required this.folhaValeTransporteRepository});

  // general
  final _dbColumns = FolhaValeTransporteModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaValeTransporteModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaValeTransporteGridColumns();
  
  var _folhaValeTransporteModelList = <FolhaValeTransporteModel>[];

  final _folhaValeTransporteModel = FolhaValeTransporteModel().obs;
  FolhaValeTransporteModel get folhaValeTransporteModel => _folhaValeTransporteModel.value;
  set folhaValeTransporteModel(value) => _folhaValeTransporteModel.value = value ?? FolhaValeTransporteModel();

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
    for (var folhaValeTransporteModel in _folhaValeTransporteModelList) {
      plutoRowList.add(_getPlutoRow(folhaValeTransporteModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaValeTransporteModel folhaValeTransporteModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaValeTransporteModel: folhaValeTransporteModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaValeTransporteModel? folhaValeTransporteModel}) {
    return {
			"id": PlutoCell(value: folhaValeTransporteModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: folhaValeTransporteModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"empresaTransporteItinerario": PlutoCell(value: folhaValeTransporteModel?.empresaTransporteItinerarioModel?.nome ?? ''),
			"quantidade": PlutoCell(value: folhaValeTransporteModel?.quantidade ?? 0),
			"idColaborador": PlutoCell(value: folhaValeTransporteModel?.idColaborador ?? 0),
			"idEmpresaTranspItin": PlutoCell(value: folhaValeTransporteModel?.idEmpresaTranspItin ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaValeTransporteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaValeTransporteModel.plutoRowToObject(plutoRow);
    } else {
      folhaValeTransporteModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Vale Transporte]';
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
    await Get.find<FolhaValeTransporteController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaValeTransporteRepository.getList(filter: filter).then( (data){ _folhaValeTransporteModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Vale Transporte',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			empresaTransporteItinerarioModelController.text = currentRow.cells['empresaTransporteItinerario']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaValeTransporteEditPage)!.then((value) {
        if (folhaValeTransporteModel.id == 0) {
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
    folhaValeTransporteModel = FolhaValeTransporteModel();
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
        if (await folhaValeTransporteRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaValeTransporteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaColaboradorModelController = TextEditingController();
	final empresaTransporteItinerarioModelController = TextEditingController();
	final quantidadeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaValeTransporteModel.id;
		plutoRow.cells['idColaborador']?.value = folhaValeTransporteModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaValeTransporteModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['idEmpresaTranspItin']?.value = folhaValeTransporteModel.idEmpresaTranspItin;
		plutoRow.cells['empresaTransporteItinerario']?.value = folhaValeTransporteModel.empresaTransporteItinerarioModel?.nome;
		plutoRow.cells['quantidade']?.value = folhaValeTransporteModel.quantidade;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaValeTransporteRepository.save(folhaValeTransporteModel: folhaValeTransporteModel); 
        if (result != null) {
          folhaValeTransporteModel = result;
          if (_isInserting) {
            _folhaValeTransporteModelList.add(result);
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

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			folhaValeTransporteModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaValeTransporteModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaValeTransporteModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callEmpresaTransporteItinerarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Itinerario]'; 
		lookupController.route = '/empresa-transporte-itinerario/'; 
		lookupController.gridColumns = empresaTransporteItinerarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = EmpresaTransporteItinerarioModel.aliasColumns; 
		lookupController.dbColumns = EmpresaTransporteItinerarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			folhaValeTransporteModel.idEmpresaTranspItin = plutoRowResult.cells['id']!.value; 
			folhaValeTransporteModel.empresaTransporteItinerarioModel!.plutoRowToObject(plutoRowResult); 
			empresaTransporteItinerarioModelController.text = folhaValeTransporteModel.empresaTransporteItinerarioModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "folha_vale_transporte";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
		empresaTransporteItinerarioModelController.dispose();
		quantidadeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}