import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/municipio_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class MunicipioController extends GetxController with ControllerBaseMixin {
  final MunicipioRepository municipioRepository;
  MunicipioController({required this.municipioRepository});

  // general
  final _dbColumns = MunicipioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = MunicipioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = municipioGridColumns();
  
  var _municipioModelList = <MunicipioModel>[];

  final _municipioModel = MunicipioModel().obs;
  MunicipioModel get municipioModel => _municipioModel.value;
  set municipioModel(value) => _municipioModel.value = value ?? MunicipioModel();

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
    for (var municipioModel in _municipioModelList) {
      plutoRowList.add(_getPlutoRow(municipioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(MunicipioModel municipioModel) {
    return PlutoRow(
      cells: _getPlutoCells(municipioModel: municipioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ MunicipioModel? municipioModel}) {
    return {
			"id": PlutoCell(value: municipioModel?.id ?? 0),
			"uf": PlutoCell(value: municipioModel?.ufModel?.sigla ?? ''),
			"nome": PlutoCell(value: municipioModel?.nome ?? ''),
			"codigoIbge": PlutoCell(value: municipioModel?.codigoIbge ?? 0),
			"codigoReceitaFederal": PlutoCell(value: municipioModel?.codigoReceitaFederal ?? 0),
			"codigoEstadual": PlutoCell(value: municipioModel?.codigoEstadual ?? 0),
			"idUf": PlutoCell(value: municipioModel?.idUf ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _municipioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      municipioModel.plutoRowToObject(plutoRow);
    } else {
      municipioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Município]';
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
    await Get.find<MunicipioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await municipioRepository.getList(filter: filter).then( (data){ _municipioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Município',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			ufModelController.text = currentRow.cells['uf']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			codigoIbgeController.text = currentRow.cells['codigoIbge']?.value?.toString() ?? '';
			codigoReceitaFederalController.text = currentRow.cells['codigoReceitaFederal']?.value?.toString() ?? '';
			codigoEstadualController.text = currentRow.cells['codigoEstadual']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.municipioEditPage)!.then((value) {
        if (municipioModel.id == 0) {
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
    municipioModel = MunicipioModel();
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
        if (await municipioRepository.delete(id: currentRow.cells['id']!.value)) {
          _municipioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final ufModelController = TextEditingController();
	final nomeController = TextEditingController();
	final codigoIbgeController = TextEditingController();
	final codigoReceitaFederalController = TextEditingController();
	final codigoEstadualController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = municipioModel.id;
		plutoRow.cells['idUf']?.value = municipioModel.idUf;
		plutoRow.cells['uf']?.value = municipioModel.ufModel?.sigla;
		plutoRow.cells['nome']?.value = municipioModel.nome;
		plutoRow.cells['codigoIbge']?.value = municipioModel.codigoIbge;
		plutoRow.cells['codigoReceitaFederal']?.value = municipioModel.codigoReceitaFederal;
		plutoRow.cells['codigoEstadual']?.value = municipioModel.codigoEstadual;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await municipioRepository.save(municipioModel: municipioModel); 
        if (result != null) {
          municipioModel = result;
          if (_isInserting) {
            _municipioModelList.add(result);
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

	Future callUfLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [UF]'; 
		lookupController.route = '/uf/'; 
		lookupController.gridColumns = ufGridColumns(isForLookup: true); 
		lookupController.aliasColumns = UfModel.aliasColumns; 
		lookupController.dbColumns = UfModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			municipioModel.idUf = plutoRowResult.cells['id']!.value; 
			municipioModel.ufModel!.plutoRowToObject(plutoRowResult); 
			ufModelController.text = municipioModel.ufModel?.sigla ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "municipio";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		ufModelController.dispose();
		nomeController.dispose();
		codigoIbgeController.dispose();
		codigoReceitaFederalController.dispose();
		codigoEstadualController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}