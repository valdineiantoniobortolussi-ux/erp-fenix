import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/tabela_preco_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class TabelaPrecoController extends GetxController with ControllerBaseMixin {
  final TabelaPrecoRepository tabelaPrecoRepository;
  TabelaPrecoController({required this.tabelaPrecoRepository});

  // general
  final _dbColumns = TabelaPrecoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = TabelaPrecoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = tabelaPrecoGridColumns();
  
  var _tabelaPrecoModelList = <TabelaPrecoModel>[];

  final _tabelaPrecoModel = TabelaPrecoModel().obs;
  TabelaPrecoModel get tabelaPrecoModel => _tabelaPrecoModel.value;
  set tabelaPrecoModel(value) => _tabelaPrecoModel.value = value ?? TabelaPrecoModel();

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
    for (var tabelaPrecoModel in _tabelaPrecoModelList) {
      plutoRowList.add(_getPlutoRow(tabelaPrecoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(TabelaPrecoModel tabelaPrecoModel) {
    return PlutoRow(
      cells: _getPlutoCells(tabelaPrecoModel: tabelaPrecoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ TabelaPrecoModel? tabelaPrecoModel}) {
    return {
			"id": PlutoCell(value: tabelaPrecoModel?.id ?? 0),
			"nome": PlutoCell(value: tabelaPrecoModel?.nome ?? ''),
			"principal": PlutoCell(value: tabelaPrecoModel?.principal ?? ''),
			"coeficiente": PlutoCell(value: tabelaPrecoModel?.coeficiente ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _tabelaPrecoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      tabelaPrecoModel.plutoRowToObject(plutoRow);
    } else {
      tabelaPrecoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tabelas de Preço]';
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
    await Get.find<TabelaPrecoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await tabelaPrecoRepository.getList(filter: filter).then( (data){ _tabelaPrecoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tabelas de Preço',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			coeficienteController.text = currentRow.cells['coeficiente']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.tabelaPrecoEditPage)!.then((value) {
        if (tabelaPrecoModel.id == 0) {
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
    tabelaPrecoModel = TabelaPrecoModel();
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
        if (await tabelaPrecoRepository.delete(id: currentRow.cells['id']!.value)) {
          _tabelaPrecoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final coeficienteController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tabelaPrecoModel.id;
		plutoRow.cells['nome']?.value = tabelaPrecoModel.nome;
		plutoRow.cells['principal']?.value = tabelaPrecoModel.principal;
		plutoRow.cells['coeficiente']?.value = tabelaPrecoModel.coeficiente;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await tabelaPrecoRepository.save(tabelaPrecoModel: tabelaPrecoModel); 
        if (result != null) {
          tabelaPrecoModel = result;
          if (_isInserting) {
            _tabelaPrecoModelList.add(result);
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
		functionName = "tabela_preco";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		coeficienteController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}