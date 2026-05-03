import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';

import 'package:patrimonio/app/routes/app_routes.dart';
import 'package:patrimonio/app/data/repository/patrim_grupo_bem_repository.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';
import 'package:patrimonio/app/mixin/controller_base_mixin.dart';

class PatrimGrupoBemController extends GetxController with ControllerBaseMixin {
  final PatrimGrupoBemRepository patrimGrupoBemRepository;
  PatrimGrupoBemController({required this.patrimGrupoBemRepository});

  // general
  final _dbColumns = PatrimGrupoBemModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PatrimGrupoBemModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = patrimGrupoBemGridColumns();
  
  var _patrimGrupoBemModelList = <PatrimGrupoBemModel>[];

  final _patrimGrupoBemModel = PatrimGrupoBemModel().obs;
  PatrimGrupoBemModel get patrimGrupoBemModel => _patrimGrupoBemModel.value;
  set patrimGrupoBemModel(value) => _patrimGrupoBemModel.value = value ?? PatrimGrupoBemModel();

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
    for (var patrimGrupoBemModel in _patrimGrupoBemModelList) {
      plutoRowList.add(_getPlutoRow(patrimGrupoBemModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PatrimGrupoBemModel patrimGrupoBemModel) {
    return PlutoRow(
      cells: _getPlutoCells(patrimGrupoBemModel: patrimGrupoBemModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PatrimGrupoBemModel? patrimGrupoBemModel}) {
    return {
			"id": PlutoCell(value: patrimGrupoBemModel?.id ?? 0),
			"codigo": PlutoCell(value: patrimGrupoBemModel?.codigo ?? ''),
			"nome": PlutoCell(value: patrimGrupoBemModel?.nome ?? ''),
			"descricao": PlutoCell(value: patrimGrupoBemModel?.descricao ?? ''),
			"contaAtivoImobilizado": PlutoCell(value: patrimGrupoBemModel?.contaAtivoImobilizado ?? ''),
			"contaDepreciacaoAcumulada": PlutoCell(value: patrimGrupoBemModel?.contaDepreciacaoAcumulada ?? ''),
			"contaDespesaDepreciacao": PlutoCell(value: patrimGrupoBemModel?.contaDespesaDepreciacao ?? ''),
			"codigoHistorico": PlutoCell(value: patrimGrupoBemModel?.codigoHistorico ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _patrimGrupoBemModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      patrimGrupoBemModel.plutoRowToObject(plutoRow);
    } else {
      patrimGrupoBemModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Grupo]';
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
    await Get.find<PatrimGrupoBemController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await patrimGrupoBemRepository.getList(filter: filter).then( (data){ _patrimGrupoBemModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Grupo',
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
			contaAtivoImobilizadoController.text = currentRow.cells['contaAtivoImobilizado']?.value ?? '';
			contaDepreciacaoAcumuladaController.text = currentRow.cells['contaDepreciacaoAcumulada']?.value ?? '';
			contaDespesaDepreciacaoController.text = currentRow.cells['contaDespesaDepreciacao']?.value ?? '';
			codigoHistoricoController.text = currentRow.cells['codigoHistorico']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.patrimGrupoBemEditPage)!.then((value) {
        if (patrimGrupoBemModel.id == 0) {
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
    patrimGrupoBemModel = PatrimGrupoBemModel();
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
        if (await patrimGrupoBemRepository.delete(id: currentRow.cells['id']!.value)) {
          _patrimGrupoBemModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final contaAtivoImobilizadoController = TextEditingController();
	final contaDepreciacaoAcumuladaController = TextEditingController();
	final contaDespesaDepreciacaoController = TextEditingController();
	final codigoHistoricoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimGrupoBemModel.id;
		plutoRow.cells['codigo']?.value = patrimGrupoBemModel.codigo;
		plutoRow.cells['nome']?.value = patrimGrupoBemModel.nome;
		plutoRow.cells['descricao']?.value = patrimGrupoBemModel.descricao;
		plutoRow.cells['contaAtivoImobilizado']?.value = patrimGrupoBemModel.contaAtivoImobilizado;
		plutoRow.cells['contaDepreciacaoAcumulada']?.value = patrimGrupoBemModel.contaDepreciacaoAcumulada;
		plutoRow.cells['contaDespesaDepreciacao']?.value = patrimGrupoBemModel.contaDespesaDepreciacao;
		plutoRow.cells['codigoHistorico']?.value = patrimGrupoBemModel.codigoHistorico;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await patrimGrupoBemRepository.save(patrimGrupoBemModel: patrimGrupoBemModel); 
        if (result != null) {
          patrimGrupoBemModel = result;
          if (_isInserting) {
            _patrimGrupoBemModelList.add(result);
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
		functionName = "patrim_grupo_bem";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		contaAtivoImobilizadoController.dispose();
		contaDepreciacaoAcumuladaController.dispose();
		contaDespesaDepreciacaoController.dispose();
		codigoHistoricoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}