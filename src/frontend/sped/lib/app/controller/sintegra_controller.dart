import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/controller/controller_imports.dart';
import 'package:sped/app/data/model/model_imports.dart';
import 'package:sped/app/page/grid_columns/grid_columns_imports.dart';

import 'package:sped/app/routes/app_routes.dart';
import 'package:sped/app/data/repository/sintegra_repository.dart';
import 'package:sped/app/page/shared_page/shared_page_imports.dart';
import 'package:sped/app/page/shared_widget/message_dialog.dart';
import 'package:sped/app/mixin/controller_base_mixin.dart';

class SintegraController extends GetxController with ControllerBaseMixin {
  final SintegraRepository sintegraRepository;
  SintegraController({required this.sintegraRepository});

  // general
  final _dbColumns = SintegraModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = SintegraModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = sintegraGridColumns();
  
  var _sintegraModelList = <SintegraModel>[];

  final _sintegraModel = SintegraModel().obs;
  SintegraModel get sintegraModel => _sintegraModel.value;
  set sintegraModel(value) => _sintegraModel.value = value ?? SintegraModel();

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
    for (var sintegraModel in _sintegraModelList) {
      plutoRowList.add(_getPlutoRow(sintegraModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(SintegraModel sintegraModel) {
    return PlutoRow(
      cells: _getPlutoCells(sintegraModel: sintegraModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ SintegraModel? sintegraModel}) {
    return {
			"id": PlutoCell(value: sintegraModel?.id ?? 0),
			"dataEmissao": PlutoCell(value: sintegraModel?.dataEmissao ?? ''),
			"periodoInicial": PlutoCell(value: sintegraModel?.periodoInicial ?? ''),
			"periodoFinal": PlutoCell(value: sintegraModel?.periodoFinal ?? ''),
			"codigoConvenio": PlutoCell(value: sintegraModel?.codigoConvenio ?? ''),
			"inventario": PlutoCell(value: sintegraModel?.inventario ?? ''),
			"finalidadeArquivo": PlutoCell(value: sintegraModel?.finalidadeArquivo ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _sintegraModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      sintegraModel.plutoRowToObject(plutoRow);
    } else {
      sintegraModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Sintegra]';
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
    await Get.find<SintegraController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await sintegraRepository.getList(filter: filter).then( (data){ _sintegraModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Sintegra',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			finalidadeArquivoController.text = currentRow.cells['finalidadeArquivo']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.sintegraEditPage)!.then((value) {
        if (sintegraModel.id == 0) {
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
    sintegraModel = SintegraModel();
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
        if (await sintegraRepository.delete(id: currentRow.cells['id']!.value)) {
          _sintegraModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final finalidadeArquivoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = sintegraModel.id;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(sintegraModel.dataEmissao);
		plutoRow.cells['periodoInicial']?.value = Util.formatDate(sintegraModel.periodoInicial);
		plutoRow.cells['periodoFinal']?.value = Util.formatDate(sintegraModel.periodoFinal);
		plutoRow.cells['codigoConvenio']?.value = sintegraModel.codigoConvenio;
		plutoRow.cells['inventario']?.value = sintegraModel.inventario;
		plutoRow.cells['finalidadeArquivo']?.value = sintegraModel.finalidadeArquivo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await sintegraRepository.save(sintegraModel: sintegraModel); 
        if (result != null) {
          sintegraModel = result;
          if (_isInserting) {
            _sintegraModelList.add(result);
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
		functionName = "sintegra";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		finalidadeArquivoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}