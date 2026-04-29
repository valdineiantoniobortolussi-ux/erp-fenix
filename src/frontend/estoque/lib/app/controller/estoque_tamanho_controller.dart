import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/controller/controller_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/page/grid_columns/grid_columns_imports.dart';

import 'package:estoque/app/routes/app_routes.dart';
import 'package:estoque/app/data/repository/estoque_tamanho_repository.dart';
import 'package:estoque/app/page/shared_page/shared_page_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';
import 'package:estoque/app/mixin/controller_base_mixin.dart';

class EstoqueTamanhoController extends GetxController with ControllerBaseMixin {
  final EstoqueTamanhoRepository estoqueTamanhoRepository;
  EstoqueTamanhoController({required this.estoqueTamanhoRepository});

  // general
  final _dbColumns = EstoqueTamanhoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EstoqueTamanhoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = estoqueTamanhoGridColumns();
  
  var _estoqueTamanhoModelList = <EstoqueTamanhoModel>[];

  final _estoqueTamanhoModel = EstoqueTamanhoModel().obs;
  EstoqueTamanhoModel get estoqueTamanhoModel => _estoqueTamanhoModel.value;
  set estoqueTamanhoModel(value) => _estoqueTamanhoModel.value = value ?? EstoqueTamanhoModel();

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
    for (var estoqueTamanhoModel in _estoqueTamanhoModelList) {
      plutoRowList.add(_getPlutoRow(estoqueTamanhoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EstoqueTamanhoModel estoqueTamanhoModel) {
    return PlutoRow(
      cells: _getPlutoCells(estoqueTamanhoModel: estoqueTamanhoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EstoqueTamanhoModel? estoqueTamanhoModel}) {
    return {
			"id": PlutoCell(value: estoqueTamanhoModel?.id ?? 0),
			"codigo": PlutoCell(value: estoqueTamanhoModel?.codigo ?? ''),
			"nome": PlutoCell(value: estoqueTamanhoModel?.nome ?? ''),
			"altura": PlutoCell(value: estoqueTamanhoModel?.altura ?? 0),
			"comprimento": PlutoCell(value: estoqueTamanhoModel?.comprimento ?? 0),
			"largura": PlutoCell(value: estoqueTamanhoModel?.largura ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _estoqueTamanhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      estoqueTamanhoModel.plutoRowToObject(plutoRow);
    } else {
      estoqueTamanhoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tamanhos]';
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
    await Get.find<EstoqueTamanhoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await estoqueTamanhoRepository.getList(filter: filter).then( (data){ _estoqueTamanhoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tamanhos',
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
			alturaController.text = currentRow.cells['altura']?.value?.toStringAsFixed(2) ?? '';
			comprimentoController.text = currentRow.cells['comprimento']?.value?.toStringAsFixed(2) ?? '';
			larguraController.text = currentRow.cells['largura']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.estoqueTamanhoEditPage)!.then((value) {
        if (estoqueTamanhoModel.id == 0) {
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
    estoqueTamanhoModel = EstoqueTamanhoModel();
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
        if (await estoqueTamanhoRepository.delete(id: currentRow.cells['id']!.value)) {
          _estoqueTamanhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final alturaController = MoneyMaskedTextController();
	final comprimentoController = MoneyMaskedTextController();
	final larguraController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = estoqueTamanhoModel.id;
		plutoRow.cells['codigo']?.value = estoqueTamanhoModel.codigo;
		plutoRow.cells['nome']?.value = estoqueTamanhoModel.nome;
		plutoRow.cells['altura']?.value = estoqueTamanhoModel.altura;
		plutoRow.cells['comprimento']?.value = estoqueTamanhoModel.comprimento;
		plutoRow.cells['largura']?.value = estoqueTamanhoModel.largura;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await estoqueTamanhoRepository.save(estoqueTamanhoModel: estoqueTamanhoModel); 
        if (result != null) {
          estoqueTamanhoModel = result;
          if (_isInserting) {
            _estoqueTamanhoModelList.add(result);
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
		functionName = "estoque_tamanho";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
		alturaController.dispose();
		comprimentoController.dispose();
		larguraController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}