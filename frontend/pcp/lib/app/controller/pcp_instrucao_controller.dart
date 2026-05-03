import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/controller/controller_imports.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:pcp/app/page/grid_columns/grid_columns_imports.dart';

import 'package:pcp/app/routes/app_routes.dart';
import 'package:pcp/app/data/repository/pcp_instrucao_repository.dart';
import 'package:pcp/app/page/shared_page/shared_page_imports.dart';
import 'package:pcp/app/page/shared_widget/message_dialog.dart';
import 'package:pcp/app/mixin/controller_base_mixin.dart';

class PcpInstrucaoController extends GetxController with ControllerBaseMixin {
  final PcpInstrucaoRepository pcpInstrucaoRepository;
  PcpInstrucaoController({required this.pcpInstrucaoRepository});

  // general
  final _dbColumns = PcpInstrucaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PcpInstrucaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = pcpInstrucaoGridColumns();
  
  var _pcpInstrucaoModelList = <PcpInstrucaoModel>[];

  final _pcpInstrucaoModel = PcpInstrucaoModel().obs;
  PcpInstrucaoModel get pcpInstrucaoModel => _pcpInstrucaoModel.value;
  set pcpInstrucaoModel(value) => _pcpInstrucaoModel.value = value ?? PcpInstrucaoModel();

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
    for (var pcpInstrucaoModel in _pcpInstrucaoModelList) {
      plutoRowList.add(_getPlutoRow(pcpInstrucaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PcpInstrucaoModel pcpInstrucaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(pcpInstrucaoModel: pcpInstrucaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PcpInstrucaoModel? pcpInstrucaoModel}) {
    return {
			"id": PlutoCell(value: pcpInstrucaoModel?.id ?? 0),
			"codigo": PlutoCell(value: pcpInstrucaoModel?.codigo ?? ''),
			"descricao": PlutoCell(value: pcpInstrucaoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _pcpInstrucaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      pcpInstrucaoModel.plutoRowToObject(plutoRow);
    } else {
      pcpInstrucaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Instruções]';
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
    await Get.find<PcpInstrucaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await pcpInstrucaoRepository.getList(filter: filter).then( (data){ _pcpInstrucaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Instruções',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.pcpInstrucaoEditPage)!.then((value) {
        if (pcpInstrucaoModel.id == 0) {
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
    pcpInstrucaoModel = PcpInstrucaoModel();
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
        if (await pcpInstrucaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _pcpInstrucaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pcpInstrucaoModel.id;
		plutoRow.cells['codigo']?.value = pcpInstrucaoModel.codigo;
		plutoRow.cells['descricao']?.value = pcpInstrucaoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await pcpInstrucaoRepository.save(pcpInstrucaoModel: pcpInstrucaoModel); 
        if (result != null) {
          pcpInstrucaoModel = result;
          if (_isInserting) {
            _pcpInstrucaoModelList.add(result);
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
		functionName = "pcp_instrucao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}