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
import 'package:cadastros/app/data/repository/tipo_admissao_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class TipoAdmissaoController extends GetxController with ControllerBaseMixin {
  final TipoAdmissaoRepository tipoAdmissaoRepository;
  TipoAdmissaoController({required this.tipoAdmissaoRepository});

  // general
  final _dbColumns = TipoAdmissaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = TipoAdmissaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = tipoAdmissaoGridColumns();
  
  var _tipoAdmissaoModelList = <TipoAdmissaoModel>[];

  final _tipoAdmissaoModel = TipoAdmissaoModel().obs;
  TipoAdmissaoModel get tipoAdmissaoModel => _tipoAdmissaoModel.value;
  set tipoAdmissaoModel(value) => _tipoAdmissaoModel.value = value ?? TipoAdmissaoModel();

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
    for (var tipoAdmissaoModel in _tipoAdmissaoModelList) {
      plutoRowList.add(_getPlutoRow(tipoAdmissaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(TipoAdmissaoModel tipoAdmissaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(tipoAdmissaoModel: tipoAdmissaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ TipoAdmissaoModel? tipoAdmissaoModel}) {
    return {
			"id": PlutoCell(value: tipoAdmissaoModel?.id ?? 0),
			"codigo": PlutoCell(value: tipoAdmissaoModel?.codigo ?? ''),
			"nome": PlutoCell(value: tipoAdmissaoModel?.nome ?? ''),
			"descricao": PlutoCell(value: tipoAdmissaoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _tipoAdmissaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      tipoAdmissaoModel.plutoRowToObject(plutoRow);
    } else {
      tipoAdmissaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo Admissão]';
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
    await Get.find<TipoAdmissaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await tipoAdmissaoRepository.getList(filter: filter).then( (data){ _tipoAdmissaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo Admissão',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.tipoAdmissaoEditPage)!.then((value) {
        if (tipoAdmissaoModel.id == 0) {
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
    tipoAdmissaoModel = TipoAdmissaoModel();
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
        if (await tipoAdmissaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _tipoAdmissaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tipoAdmissaoModel.id;
		plutoRow.cells['codigo']?.value = tipoAdmissaoModel.codigo;
		plutoRow.cells['nome']?.value = tipoAdmissaoModel.nome;
		plutoRow.cells['descricao']?.value = tipoAdmissaoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await tipoAdmissaoRepository.save(tipoAdmissaoModel: tipoAdmissaoModel); 
        if (result != null) {
          tipoAdmissaoModel = result;
          if (_isInserting) {
            _tipoAdmissaoModelList.add(result);
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
		functionName = "tipo_admissao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}