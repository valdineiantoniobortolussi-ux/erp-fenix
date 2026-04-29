import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/encerra_centro_resultado_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class EncerraCentroResultadoController extends GetxController with ControllerBaseMixin {
  final EncerraCentroResultadoRepository encerraCentroResultadoRepository;
  EncerraCentroResultadoController({required this.encerraCentroResultadoRepository});

  // general
  final _dbColumns = EncerraCentroResultadoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EncerraCentroResultadoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = encerraCentroResultadoGridColumns();
  
  var _encerraCentroResultadoModelList = <EncerraCentroResultadoModel>[];

  final _encerraCentroResultadoModel = EncerraCentroResultadoModel().obs;
  EncerraCentroResultadoModel get encerraCentroResultadoModel => _encerraCentroResultadoModel.value;
  set encerraCentroResultadoModel(value) => _encerraCentroResultadoModel.value = value ?? EncerraCentroResultadoModel();

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
    for (var encerraCentroResultadoModel in _encerraCentroResultadoModelList) {
      plutoRowList.add(_getPlutoRow(encerraCentroResultadoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EncerraCentroResultadoModel encerraCentroResultadoModel) {
    return PlutoRow(
      cells: _getPlutoCells(encerraCentroResultadoModel: encerraCentroResultadoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EncerraCentroResultadoModel? encerraCentroResultadoModel}) {
    return {
			"id": PlutoCell(value: encerraCentroResultadoModel?.id ?? 0),
			"centroResultado": PlutoCell(value: encerraCentroResultadoModel?.centroResultadoModel?.descricao ?? ''),
			"competencia": PlutoCell(value: encerraCentroResultadoModel?.competencia ?? ''),
			"valorTotal": PlutoCell(value: encerraCentroResultadoModel?.valorTotal ?? 0),
			"valorSubRateio": PlutoCell(value: encerraCentroResultadoModel?.valorSubRateio ?? 0),
			"idCentroResultado": PlutoCell(value: encerraCentroResultadoModel?.idCentroResultado ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _encerraCentroResultadoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      encerraCentroResultadoModel.plutoRowToObject(plutoRow);
    } else {
      encerraCentroResultadoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Encerra Centro Resultado]';
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
    await Get.find<EncerraCentroResultadoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await encerraCentroResultadoRepository.getList(filter: filter).then( (data){ _encerraCentroResultadoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Encerra Centro Resultado',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			centroResultadoModelController.text = currentRow.cells['centroResultado']?.value ?? '';
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			valorSubRateioController.text = currentRow.cells['valorSubRateio']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.encerraCentroResultadoEditPage)!.then((value) {
        if (encerraCentroResultadoModel.id == 0) {
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
    encerraCentroResultadoModel = EncerraCentroResultadoModel();
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
        if (await encerraCentroResultadoRepository.delete(id: currentRow.cells['id']!.value)) {
          _encerraCentroResultadoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final centroResultadoModelController = TextEditingController();
	final competenciaController = MaskedTextController(mask: '00:0000',);
	final valorTotalController = MoneyMaskedTextController();
	final valorSubRateioController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = encerraCentroResultadoModel.id;
		plutoRow.cells['idCentroResultado']?.value = encerraCentroResultadoModel.idCentroResultado;
		plutoRow.cells['centroResultado']?.value = encerraCentroResultadoModel.centroResultadoModel?.descricao;
		plutoRow.cells['competencia']?.value = encerraCentroResultadoModel.competencia;
		plutoRow.cells['valorTotal']?.value = encerraCentroResultadoModel.valorTotal;
		plutoRow.cells['valorSubRateio']?.value = encerraCentroResultadoModel.valorSubRateio;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await encerraCentroResultadoRepository.save(encerraCentroResultadoModel: encerraCentroResultadoModel); 
        if (result != null) {
          encerraCentroResultadoModel = result;
          if (_isInserting) {
            _encerraCentroResultadoModelList.add(result);
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

	Future callCentroResultadoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Centro Resultado]'; 
		lookupController.route = '/centro-resultado/'; 
		lookupController.gridColumns = centroResultadoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CentroResultadoModel.aliasColumns; 
		lookupController.dbColumns = CentroResultadoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			encerraCentroResultadoModel.idCentroResultado = plutoRowResult.cells['id']!.value; 
			encerraCentroResultadoModel.centroResultadoModel!.plutoRowToObject(plutoRowResult); 
			centroResultadoModelController.text = encerraCentroResultadoModel.centroResultadoModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "encerra_centro_resultado";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		centroResultadoModelController.dispose();
		competenciaController.dispose();
		valorTotalController.dispose();
		valorSubRateioController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}