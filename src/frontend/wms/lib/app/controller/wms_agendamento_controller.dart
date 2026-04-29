import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/controller/controller_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/page/grid_columns/grid_columns_imports.dart';

import 'package:wms/app/routes/app_routes.dart';
import 'package:wms/app/data/repository/wms_agendamento_repository.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';
import 'package:wms/app/mixin/controller_base_mixin.dart';

class WmsAgendamentoController extends GetxController with ControllerBaseMixin {
  final WmsAgendamentoRepository wmsAgendamentoRepository;
  WmsAgendamentoController({required this.wmsAgendamentoRepository});

  // general
  final _dbColumns = WmsAgendamentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = WmsAgendamentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = wmsAgendamentoGridColumns();
  
  var _wmsAgendamentoModelList = <WmsAgendamentoModel>[];

  final _wmsAgendamentoModel = WmsAgendamentoModel().obs;
  WmsAgendamentoModel get wmsAgendamentoModel => _wmsAgendamentoModel.value;
  set wmsAgendamentoModel(value) => _wmsAgendamentoModel.value = value ?? WmsAgendamentoModel();

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
    for (var wmsAgendamentoModel in _wmsAgendamentoModelList) {
      plutoRowList.add(_getPlutoRow(wmsAgendamentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(WmsAgendamentoModel wmsAgendamentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(wmsAgendamentoModel: wmsAgendamentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ WmsAgendamentoModel? wmsAgendamentoModel}) {
    return {
			"id": PlutoCell(value: wmsAgendamentoModel?.id ?? 0),
			"dataOperacao": PlutoCell(value: wmsAgendamentoModel?.dataOperacao ?? ''),
			"horaOperacao": PlutoCell(value: wmsAgendamentoModel?.horaOperacao ?? ''),
			"localOperacao": PlutoCell(value: wmsAgendamentoModel?.localOperacao ?? ''),
			"quantidadeVolume": PlutoCell(value: wmsAgendamentoModel?.quantidadeVolume ?? 0),
			"pesoTotalVolume": PlutoCell(value: wmsAgendamentoModel?.pesoTotalVolume ?? 0),
			"quantidadePessoa": PlutoCell(value: wmsAgendamentoModel?.quantidadePessoa ?? 0),
			"quantidadeHora": PlutoCell(value: wmsAgendamentoModel?.quantidadeHora ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _wmsAgendamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      wmsAgendamentoModel.plutoRowToObject(plutoRow);
    } else {
      wmsAgendamentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Agendamento]';
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
    await Get.find<WmsAgendamentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await wmsAgendamentoRepository.getList(filter: filter).then( (data){ _wmsAgendamentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Agendamento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			horaOperacaoController.text = currentRow.cells['horaOperacao']?.value ?? '';
			localOperacaoController.text = currentRow.cells['localOperacao']?.value ?? '';
			quantidadeVolumeController.text = currentRow.cells['quantidadeVolume']?.value?.toString() ?? '';
			pesoTotalVolumeController.text = currentRow.cells['pesoTotalVolume']?.value?.toStringAsFixed(2) ?? '';
			quantidadePessoaController.text = currentRow.cells['quantidadePessoa']?.value?.toString() ?? '';
			quantidadeHoraController.text = currentRow.cells['quantidadeHora']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.wmsAgendamentoEditPage)!.then((value) {
        if (wmsAgendamentoModel.id == 0) {
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
    wmsAgendamentoModel = WmsAgendamentoModel();
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
        if (await wmsAgendamentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _wmsAgendamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final horaOperacaoController = MaskedTextController(mask: '00:00:00',);
	final localOperacaoController = TextEditingController();
	final quantidadeVolumeController = TextEditingController();
	final pesoTotalVolumeController = MoneyMaskedTextController();
	final quantidadePessoaController = TextEditingController();
	final quantidadeHoraController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsAgendamentoModel.id;
		plutoRow.cells['dataOperacao']?.value = Util.formatDate(wmsAgendamentoModel.dataOperacao);
		plutoRow.cells['horaOperacao']?.value = wmsAgendamentoModel.horaOperacao;
		plutoRow.cells['localOperacao']?.value = wmsAgendamentoModel.localOperacao;
		plutoRow.cells['quantidadeVolume']?.value = wmsAgendamentoModel.quantidadeVolume;
		plutoRow.cells['pesoTotalVolume']?.value = wmsAgendamentoModel.pesoTotalVolume;
		plutoRow.cells['quantidadePessoa']?.value = wmsAgendamentoModel.quantidadePessoa;
		plutoRow.cells['quantidadeHora']?.value = wmsAgendamentoModel.quantidadeHora;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await wmsAgendamentoRepository.save(wmsAgendamentoModel: wmsAgendamentoModel); 
        if (result != null) {
          wmsAgendamentoModel = result;
          if (_isInserting) {
            _wmsAgendamentoModelList.add(result);
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
		functionName = "wms_agendamento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		horaOperacaoController.dispose();
		localOperacaoController.dispose();
		quantidadeVolumeController.dispose();
		pesoTotalVolumeController.dispose();
		quantidadePessoaController.dispose();
		quantidadeHoraController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}