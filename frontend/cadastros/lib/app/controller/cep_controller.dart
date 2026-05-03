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
import 'package:cadastros/app/data/repository/cep_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class CepController extends GetxController with ControllerBaseMixin {
  final CepRepository cepRepository;
  CepController({required this.cepRepository});

  // general
  final _dbColumns = CepModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CepModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cepGridColumns();
  
  var _cepModelList = <CepModel>[];

  final _cepModel = CepModel().obs;
  CepModel get cepModel => _cepModel.value;
  set cepModel(value) => _cepModel.value = value ?? CepModel();

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
    for (var cepModel in _cepModelList) {
      plutoRowList.add(_getPlutoRow(cepModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CepModel cepModel) {
    return PlutoRow(
      cells: _getPlutoCells(cepModel: cepModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CepModel? cepModel}) {
    return {
			"id": PlutoCell(value: cepModel?.id ?? 0),
			"numero": PlutoCell(value: cepModel?.numero ?? ''),
			"logradouro": PlutoCell(value: cepModel?.logradouro ?? ''),
			"complemento": PlutoCell(value: cepModel?.complemento ?? ''),
			"bairro": PlutoCell(value: cepModel?.bairro ?? ''),
			"municipio": PlutoCell(value: cepModel?.municipio ?? ''),
			"uf": PlutoCell(value: cepModel?.uf ?? ''),
			"codigoIbgeMunicipio": PlutoCell(value: cepModel?.codigoIbgeMunicipio ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cepModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cepModel.plutoRowToObject(plutoRow);
    } else {
      cepModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [CEP]';
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
    await Get.find<CepController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cepRepository.getList(filter: filter).then( (data){ _cepModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'CEP',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			municipioController.text = currentRow.cells['municipio']?.value ?? '';
			codigoIbgeMunicipioController.text = currentRow.cells['codigoIbgeMunicipio']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cepEditPage)!.then((value) {
        if (cepModel.id == 0) {
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
    cepModel = CepModel();
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
        if (await cepRepository.delete(id: currentRow.cells['id']!.value)) {
          _cepModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final numeroController = TextEditingController();
	final logradouroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final municipioController = TextEditingController();
	final codigoIbgeMunicipioController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cepModel.id;
		plutoRow.cells['numero']?.value = cepModel.numero;
		plutoRow.cells['logradouro']?.value = cepModel.logradouro;
		plutoRow.cells['complemento']?.value = cepModel.complemento;
		plutoRow.cells['bairro']?.value = cepModel.bairro;
		plutoRow.cells['municipio']?.value = cepModel.municipio;
		plutoRow.cells['uf']?.value = cepModel.uf;
		plutoRow.cells['codigoIbgeMunicipio']?.value = cepModel.codigoIbgeMunicipio;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cepRepository.save(cepModel: cepModel); 
        if (result != null) {
          cepModel = result;
          if (_isInserting) {
            _cepModelList.add(result);
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


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cep";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		numeroController.dispose();
		logradouroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		municipioController.dispose();
		codigoIbgeMunicipioController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}