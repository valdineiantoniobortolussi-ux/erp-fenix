import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/guias_acumuladas_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class GuiasAcumuladasController extends GetxController with ControllerBaseMixin {
  final GuiasAcumuladasRepository guiasAcumuladasRepository;
  GuiasAcumuladasController({required this.guiasAcumuladasRepository});

  // general
  final _dbColumns = GuiasAcumuladasModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = GuiasAcumuladasModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = guiasAcumuladasGridColumns();
  
  var _guiasAcumuladasModelList = <GuiasAcumuladasModel>[];

  final _guiasAcumuladasModel = GuiasAcumuladasModel().obs;
  GuiasAcumuladasModel get guiasAcumuladasModel => _guiasAcumuladasModel.value;
  set guiasAcumuladasModel(value) => _guiasAcumuladasModel.value = value ?? GuiasAcumuladasModel();

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
    for (var guiasAcumuladasModel in _guiasAcumuladasModelList) {
      plutoRowList.add(_getPlutoRow(guiasAcumuladasModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(GuiasAcumuladasModel guiasAcumuladasModel) {
    return PlutoRow(
      cells: _getPlutoCells(guiasAcumuladasModel: guiasAcumuladasModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ GuiasAcumuladasModel? guiasAcumuladasModel}) {
    return {
			"id": PlutoCell(value: guiasAcumuladasModel?.id ?? 0),
			"gpsTipo": PlutoCell(value: guiasAcumuladasModel?.gpsTipo ?? ''),
			"gpsCompetencia": PlutoCell(value: guiasAcumuladasModel?.gpsCompetencia ?? ''),
			"gpsValorInss": PlutoCell(value: guiasAcumuladasModel?.gpsValorInss ?? 0),
			"gpsValorOutrasEnt": PlutoCell(value: guiasAcumuladasModel?.gpsValorOutrasEnt ?? 0),
			"gpsDataPagamento": PlutoCell(value: guiasAcumuladasModel?.gpsDataPagamento ?? ''),
			"irrfCompetencia": PlutoCell(value: guiasAcumuladasModel?.irrfCompetencia ?? ''),
			"irrfCodigoRecolhimento": PlutoCell(value: guiasAcumuladasModel?.irrfCodigoRecolhimento ?? 0),
			"irrfValorAcumulado": PlutoCell(value: guiasAcumuladasModel?.irrfValorAcumulado ?? 0),
			"irrfDataPagamento": PlutoCell(value: guiasAcumuladasModel?.irrfDataPagamento ?? ''),
			"pisCompetencia": PlutoCell(value: guiasAcumuladasModel?.pisCompetencia ?? ''),
			"pisValorAcumulado": PlutoCell(value: guiasAcumuladasModel?.pisValorAcumulado ?? 0),
			"pisDataPagamento": PlutoCell(value: guiasAcumuladasModel?.pisDataPagamento ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _guiasAcumuladasModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      guiasAcumuladasModel.plutoRowToObject(plutoRow);
    } else {
      guiasAcumuladasModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Guias Acumuladas]';
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
    await Get.find<GuiasAcumuladasController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await guiasAcumuladasRepository.getList(filter: filter).then( (data){ _guiasAcumuladasModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Guias Acumuladas',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			gpsCompetenciaController.text = currentRow.cells['gpsCompetencia']?.value ?? '';
			gpsValorInssController.text = currentRow.cells['gpsValorInss']?.value?.toStringAsFixed(2) ?? '';
			gpsValorOutrasEntController.text = currentRow.cells['gpsValorOutrasEnt']?.value?.toStringAsFixed(2) ?? '';
			irrfCompetenciaController.text = currentRow.cells['irrfCompetencia']?.value ?? '';
			irrfCodigoRecolhimentoController.text = currentRow.cells['irrfCodigoRecolhimento']?.value?.toString() ?? '';
			irrfValorAcumuladoController.text = currentRow.cells['irrfValorAcumulado']?.value?.toStringAsFixed(2) ?? '';
			pisCompetenciaController.text = currentRow.cells['pisCompetencia']?.value ?? '';
			pisValorAcumuladoController.text = currentRow.cells['pisValorAcumulado']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.guiasAcumuladasEditPage)!.then((value) {
        if (guiasAcumuladasModel.id == 0) {
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
    guiasAcumuladasModel = GuiasAcumuladasModel();
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
        if (await guiasAcumuladasRepository.delete(id: currentRow.cells['id']!.value)) {
          _guiasAcumuladasModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final gpsCompetenciaController = MaskedTextController(mask: '00/0000',);
	final gpsValorInssController = MoneyMaskedTextController();
	final gpsValorOutrasEntController = MoneyMaskedTextController();
	final irrfCompetenciaController = MaskedTextController(mask: '00/0000',);
	final irrfCodigoRecolhimentoController = TextEditingController();
	final irrfValorAcumuladoController = MoneyMaskedTextController();
	final pisCompetenciaController = MaskedTextController(mask: '00/0000',);
	final pisValorAcumuladoController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = guiasAcumuladasModel.id;
		plutoRow.cells['gpsTipo']?.value = guiasAcumuladasModel.gpsTipo;
		plutoRow.cells['gpsCompetencia']?.value = guiasAcumuladasModel.gpsCompetencia;
		plutoRow.cells['gpsValorInss']?.value = guiasAcumuladasModel.gpsValorInss;
		plutoRow.cells['gpsValorOutrasEnt']?.value = guiasAcumuladasModel.gpsValorOutrasEnt;
		plutoRow.cells['gpsDataPagamento']?.value = Util.formatDate(guiasAcumuladasModel.gpsDataPagamento);
		plutoRow.cells['irrfCompetencia']?.value = guiasAcumuladasModel.irrfCompetencia;
		plutoRow.cells['irrfCodigoRecolhimento']?.value = guiasAcumuladasModel.irrfCodigoRecolhimento;
		plutoRow.cells['irrfValorAcumulado']?.value = guiasAcumuladasModel.irrfValorAcumulado;
		plutoRow.cells['irrfDataPagamento']?.value = Util.formatDate(guiasAcumuladasModel.irrfDataPagamento);
		plutoRow.cells['pisCompetencia']?.value = guiasAcumuladasModel.pisCompetencia;
		plutoRow.cells['pisValorAcumulado']?.value = guiasAcumuladasModel.pisValorAcumulado;
		plutoRow.cells['pisDataPagamento']?.value = Util.formatDate(guiasAcumuladasModel.pisDataPagamento);
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await guiasAcumuladasRepository.save(guiasAcumuladasModel: guiasAcumuladasModel); 
        if (result != null) {
          guiasAcumuladasModel = result;
          if (_isInserting) {
            _guiasAcumuladasModelList.add(result);
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
		functionName = "guias_acumuladas";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		gpsCompetenciaController.dispose();
		gpsValorInssController.dispose();
		gpsValorOutrasEntController.dispose();
		irrfCompetenciaController.dispose();
		irrfCodigoRecolhimentoController.dispose();
		irrfValorAcumuladoController.dispose();
		pisCompetenciaController.dispose();
		pisValorAcumuladoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}