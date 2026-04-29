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
import 'package:folha/app/data/repository/folha_afastamento_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaAfastamentoController extends GetxController with ControllerBaseMixin {
  final FolhaAfastamentoRepository folhaAfastamentoRepository;
  FolhaAfastamentoController({required this.folhaAfastamentoRepository});

  // general
  final _dbColumns = FolhaAfastamentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaAfastamentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaAfastamentoGridColumns();
  
  var _folhaAfastamentoModelList = <FolhaAfastamentoModel>[];

  final _folhaAfastamentoModel = FolhaAfastamentoModel().obs;
  FolhaAfastamentoModel get folhaAfastamentoModel => _folhaAfastamentoModel.value;
  set folhaAfastamentoModel(value) => _folhaAfastamentoModel.value = value ?? FolhaAfastamentoModel();

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
    for (var folhaAfastamentoModel in _folhaAfastamentoModelList) {
      plutoRowList.add(_getPlutoRow(folhaAfastamentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaAfastamentoModel folhaAfastamentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaAfastamentoModel: folhaAfastamentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaAfastamentoModel? folhaAfastamentoModel}) {
    return {
			"id": PlutoCell(value: folhaAfastamentoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: folhaAfastamentoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"folhaTipoAfastamento": PlutoCell(value: folhaAfastamentoModel?.folhaTipoAfastamentoModel?.nome ?? ''),
			"dataInicio": PlutoCell(value: folhaAfastamentoModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: folhaAfastamentoModel?.dataFim ?? ''),
			"diasAfastado": PlutoCell(value: folhaAfastamentoModel?.diasAfastado ?? 0),
			"idColaborador": PlutoCell(value: folhaAfastamentoModel?.idColaborador ?? 0),
			"idFolhaTipoAfastamento": PlutoCell(value: folhaAfastamentoModel?.idFolhaTipoAfastamento ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaAfastamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaAfastamentoModel.plutoRowToObject(plutoRow);
    } else {
      folhaAfastamentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Afastamentos]';
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
    await Get.find<FolhaAfastamentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaAfastamentoRepository.getList(filter: filter).then( (data){ _folhaAfastamentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Afastamentos',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			folhaTipoAfastamentoModelController.text = currentRow.cells['folhaTipoAfastamento']?.value ?? '';
			diasAfastadoController.text = currentRow.cells['diasAfastado']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaAfastamentoEditPage)!.then((value) {
        if (folhaAfastamentoModel.id == 0) {
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
    folhaAfastamentoModel = FolhaAfastamentoModel();
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
        if (await folhaAfastamentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaAfastamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final folhaTipoAfastamentoModelController = TextEditingController();
	final diasAfastadoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaAfastamentoModel.id;
		plutoRow.cells['idColaborador']?.value = folhaAfastamentoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaAfastamentoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['idFolhaTipoAfastamento']?.value = folhaAfastamentoModel.idFolhaTipoAfastamento;
		plutoRow.cells['folhaTipoAfastamento']?.value = folhaAfastamentoModel.folhaTipoAfastamentoModel?.nome;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(folhaAfastamentoModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(folhaAfastamentoModel.dataFim);
		plutoRow.cells['diasAfastado']?.value = folhaAfastamentoModel.diasAfastado;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaAfastamentoRepository.save(folhaAfastamentoModel: folhaAfastamentoModel); 
        if (result != null) {
          folhaAfastamentoModel = result;
          if (_isInserting) {
            _folhaAfastamentoModelList.add(result);
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
			folhaAfastamentoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaAfastamentoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaAfastamentoModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFolhaTipoAfastamentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Afastamento]'; 
		lookupController.route = '/folha-tipo-afastamento/'; 
		lookupController.gridColumns = folhaTipoAfastamentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FolhaTipoAfastamentoModel.aliasColumns; 
		lookupController.dbColumns = FolhaTipoAfastamentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			folhaAfastamentoModel.idFolhaTipoAfastamento = plutoRowResult.cells['id']!.value; 
			folhaAfastamentoModel.folhaTipoAfastamentoModel!.plutoRowToObject(plutoRowResult); 
			folhaTipoAfastamentoModelController.text = folhaAfastamentoModel.folhaTipoAfastamentoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "folha_afastamento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
		folhaTipoAfastamentoModelController.dispose();
		diasAfastadoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}