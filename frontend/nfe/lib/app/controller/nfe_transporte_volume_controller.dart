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
import 'package:nfe/app/data/repository/nfe_transporte_volume_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeTransporteVolumeController extends GetxController with ControllerBaseMixin {
  final NfeTransporteVolumeRepository nfeTransporteVolumeRepository;
  NfeTransporteVolumeController({required this.nfeTransporteVolumeRepository});

  // general
  final _dbColumns = NfeTransporteVolumeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeTransporteVolumeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeTransporteVolumeGridColumns();
  
  var _nfeTransporteVolumeModelList = <NfeTransporteVolumeModel>[];

  final _nfeTransporteVolumeModel = NfeTransporteVolumeModel().obs;
  NfeTransporteVolumeModel get nfeTransporteVolumeModel => _nfeTransporteVolumeModel.value;
  set nfeTransporteVolumeModel(value) => _nfeTransporteVolumeModel.value = value ?? NfeTransporteVolumeModel();

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
    for (var nfeTransporteVolumeModel in _nfeTransporteVolumeModelList) {
      plutoRowList.add(_getPlutoRow(nfeTransporteVolumeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeTransporteVolumeModel nfeTransporteVolumeModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeTransporteVolumeModel: nfeTransporteVolumeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeTransporteVolumeModel? nfeTransporteVolumeModel}) {
    return {
			"id": PlutoCell(value: nfeTransporteVolumeModel?.id ?? 0),
			"nfeTransporte": PlutoCell(value: nfeTransporteVolumeModel?.nfeTransporteModel?.cnpj ?? ''),
			"quantidade": PlutoCell(value: nfeTransporteVolumeModel?.quantidade ?? 0),
			"especie": PlutoCell(value: nfeTransporteVolumeModel?.especie ?? ''),
			"marca": PlutoCell(value: nfeTransporteVolumeModel?.marca ?? ''),
			"numeracao": PlutoCell(value: nfeTransporteVolumeModel?.numeracao ?? ''),
			"pesoLiquido": PlutoCell(value: nfeTransporteVolumeModel?.pesoLiquido ?? 0),
			"pesoBruto": PlutoCell(value: nfeTransporteVolumeModel?.pesoBruto ?? 0),
			"idNfeTransporte": PlutoCell(value: nfeTransporteVolumeModel?.idNfeTransporte ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeTransporteVolumeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeTransporteVolumeModel.plutoRowToObject(plutoRow);
    } else {
      nfeTransporteVolumeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Nfe Transporte Volume]';
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
    await Get.find<NfeTransporteVolumeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeTransporteVolumeRepository.getList(filter: filter).then( (data){ _nfeTransporteVolumeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Nfe Transporte Volume',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeTransporteModelController.text = currentRow.cells['nfeTransporte']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';
			especieController.text = currentRow.cells['especie']?.value ?? '';
			marcaController.text = currentRow.cells['marca']?.value ?? '';
			numeracaoController.text = currentRow.cells['numeracao']?.value ?? '';
			pesoLiquidoController.text = currentRow.cells['pesoLiquido']?.value?.toStringAsFixed(2) ?? '';
			pesoBrutoController.text = currentRow.cells['pesoBruto']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeTransporteVolumeEditPage)!.then((value) {
        if (nfeTransporteVolumeModel.id == 0) {
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
    nfeTransporteVolumeModel = NfeTransporteVolumeModel();
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
        if (await nfeTransporteVolumeRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeTransporteVolumeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeTransporteModelController = TextEditingController();
	final quantidadeController = TextEditingController();
	final especieController = TextEditingController();
	final marcaController = TextEditingController();
	final numeracaoController = TextEditingController();
	final pesoLiquidoController = MoneyMaskedTextController();
	final pesoBrutoController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeTransporteVolumeModel.id;
		plutoRow.cells['idNfeTransporte']?.value = nfeTransporteVolumeModel.idNfeTransporte;
		plutoRow.cells['nfeTransporte']?.value = nfeTransporteVolumeModel.nfeTransporteModel?.cnpj;
		plutoRow.cells['quantidade']?.value = nfeTransporteVolumeModel.quantidade;
		plutoRow.cells['especie']?.value = nfeTransporteVolumeModel.especie;
		plutoRow.cells['marca']?.value = nfeTransporteVolumeModel.marca;
		plutoRow.cells['numeracao']?.value = nfeTransporteVolumeModel.numeracao;
		plutoRow.cells['pesoLiquido']?.value = nfeTransporteVolumeModel.pesoLiquido;
		plutoRow.cells['pesoBruto']?.value = nfeTransporteVolumeModel.pesoBruto;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeTransporteVolumeRepository.save(nfeTransporteVolumeModel: nfeTransporteVolumeModel); 
        if (result != null) {
          nfeTransporteVolumeModel = result;
          if (_isInserting) {
            _nfeTransporteVolumeModelList.add(result);
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

	Future callNfeTransporteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Nfe Transporte]'; 
		lookupController.route = '/nfe-transporte/'; 
		lookupController.gridColumns = nfeTransporteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeTransporteModel.aliasColumns; 
		lookupController.dbColumns = NfeTransporteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeTransporteVolumeModel.idNfeTransporte = plutoRowResult.cells['id']!.value; 
			nfeTransporteVolumeModel.nfeTransporteModel!.plutoRowToObject(plutoRowResult); 
			nfeTransporteModelController.text = nfeTransporteVolumeModel.nfeTransporteModel?.cnpj ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nfe_transporte_volume";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeTransporteModelController.dispose();
		quantidadeController.dispose();
		especieController.dispose();
		marcaController.dispose();
		numeracaoController.dispose();
		pesoLiquidoController.dispose();
		pesoBrutoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}