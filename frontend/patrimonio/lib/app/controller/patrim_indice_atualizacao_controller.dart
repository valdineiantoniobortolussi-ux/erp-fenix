import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';

import 'package:patrimonio/app/routes/app_routes.dart';
import 'package:patrimonio/app/data/repository/patrim_indice_atualizacao_repository.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';
import 'package:patrimonio/app/mixin/controller_base_mixin.dart';

class PatrimIndiceAtualizacaoController extends GetxController with ControllerBaseMixin {
  final PatrimIndiceAtualizacaoRepository patrimIndiceAtualizacaoRepository;
  PatrimIndiceAtualizacaoController({required this.patrimIndiceAtualizacaoRepository});

  // general
  final _dbColumns = PatrimIndiceAtualizacaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PatrimIndiceAtualizacaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = patrimIndiceAtualizacaoGridColumns();
  
  var _patrimIndiceAtualizacaoModelList = <PatrimIndiceAtualizacaoModel>[];

  final _patrimIndiceAtualizacaoModel = PatrimIndiceAtualizacaoModel().obs;
  PatrimIndiceAtualizacaoModel get patrimIndiceAtualizacaoModel => _patrimIndiceAtualizacaoModel.value;
  set patrimIndiceAtualizacaoModel(value) => _patrimIndiceAtualizacaoModel.value = value ?? PatrimIndiceAtualizacaoModel();

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
    for (var patrimIndiceAtualizacaoModel in _patrimIndiceAtualizacaoModelList) {
      plutoRowList.add(_getPlutoRow(patrimIndiceAtualizacaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PatrimIndiceAtualizacaoModel patrimIndiceAtualizacaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(patrimIndiceAtualizacaoModel: patrimIndiceAtualizacaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PatrimIndiceAtualizacaoModel? patrimIndiceAtualizacaoModel}) {
    return {
			"id": PlutoCell(value: patrimIndiceAtualizacaoModel?.id ?? 0),
			"dataIndice": PlutoCell(value: patrimIndiceAtualizacaoModel?.dataIndice ?? ''),
			"nome": PlutoCell(value: patrimIndiceAtualizacaoModel?.nome ?? ''),
			"valor": PlutoCell(value: patrimIndiceAtualizacaoModel?.valor ?? 0),
			"valorAlternativo": PlutoCell(value: patrimIndiceAtualizacaoModel?.valorAlternativo ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _patrimIndiceAtualizacaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      patrimIndiceAtualizacaoModel.plutoRowToObject(plutoRow);
    } else {
      patrimIndiceAtualizacaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Índices de Atualização]';
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
    await Get.find<PatrimIndiceAtualizacaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await patrimIndiceAtualizacaoRepository.getList(filter: filter).then( (data){ _patrimIndiceAtualizacaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Índices de Atualização',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			valorAlternativoController.text = currentRow.cells['valorAlternativo']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.patrimIndiceAtualizacaoEditPage)!.then((value) {
        if (patrimIndiceAtualizacaoModel.id == 0) {
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
    patrimIndiceAtualizacaoModel = PatrimIndiceAtualizacaoModel();
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
        if (await patrimIndiceAtualizacaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _patrimIndiceAtualizacaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final valorAlternativoController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimIndiceAtualizacaoModel.id;
		plutoRow.cells['dataIndice']?.value = Util.formatDate(patrimIndiceAtualizacaoModel.dataIndice);
		plutoRow.cells['nome']?.value = patrimIndiceAtualizacaoModel.nome;
		plutoRow.cells['valor']?.value = patrimIndiceAtualizacaoModel.valor;
		plutoRow.cells['valorAlternativo']?.value = patrimIndiceAtualizacaoModel.valorAlternativo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await patrimIndiceAtualizacaoRepository.save(patrimIndiceAtualizacaoModel: patrimIndiceAtualizacaoModel); 
        if (result != null) {
          patrimIndiceAtualizacaoModel = result;
          if (_isInserting) {
            _patrimIndiceAtualizacaoModelList.add(result);
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
		functionName = "patrim_indice_atualizacao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		valorController.dispose();
		valorAlternativoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}