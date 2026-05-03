import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/controller/controller_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/page/grid_columns/grid_columns_imports.dart';

import 'package:ponto/app/routes/app_routes.dart';
import 'package:ponto/app/data/repository/ponto_classificacao_jornada_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoClassificacaoJornadaController extends GetxController with ControllerBaseMixin {
  final PontoClassificacaoJornadaRepository pontoClassificacaoJornadaRepository;
  PontoClassificacaoJornadaController({required this.pontoClassificacaoJornadaRepository});

  // general
  final _dbColumns = PontoClassificacaoJornadaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PontoClassificacaoJornadaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = pontoClassificacaoJornadaGridColumns();
  
  var _pontoClassificacaoJornadaModelList = <PontoClassificacaoJornadaModel>[];

  final _pontoClassificacaoJornadaModel = PontoClassificacaoJornadaModel().obs;
  PontoClassificacaoJornadaModel get pontoClassificacaoJornadaModel => _pontoClassificacaoJornadaModel.value;
  set pontoClassificacaoJornadaModel(value) => _pontoClassificacaoJornadaModel.value = value ?? PontoClassificacaoJornadaModel();

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
    for (var pontoClassificacaoJornadaModel in _pontoClassificacaoJornadaModelList) {
      plutoRowList.add(_getPlutoRow(pontoClassificacaoJornadaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PontoClassificacaoJornadaModel pontoClassificacaoJornadaModel) {
    return PlutoRow(
      cells: _getPlutoCells(pontoClassificacaoJornadaModel: pontoClassificacaoJornadaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PontoClassificacaoJornadaModel? pontoClassificacaoJornadaModel}) {
    return {
			"id": PlutoCell(value: pontoClassificacaoJornadaModel?.id ?? 0),
			"codigo": PlutoCell(value: pontoClassificacaoJornadaModel?.codigo ?? ''),
			"nome": PlutoCell(value: pontoClassificacaoJornadaModel?.nome ?? ''),
			"descricao": PlutoCell(value: pontoClassificacaoJornadaModel?.descricao ?? ''),
			"padrao": PlutoCell(value: pontoClassificacaoJornadaModel?.padrao ?? ''),
			"descontarHoras": PlutoCell(value: pontoClassificacaoJornadaModel?.descontarHoras ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _pontoClassificacaoJornadaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      pontoClassificacaoJornadaModel.plutoRowToObject(plutoRow);
    } else {
      pontoClassificacaoJornadaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Classificação da Jornada]';
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
    await Get.find<PontoClassificacaoJornadaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await pontoClassificacaoJornadaRepository.getList(filter: filter).then( (data){ _pontoClassificacaoJornadaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Classificação da Jornada',
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
      Get.toNamed(Routes.pontoClassificacaoJornadaEditPage)!.then((value) {
        if (pontoClassificacaoJornadaModel.id == 0) {
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
    pontoClassificacaoJornadaModel = PontoClassificacaoJornadaModel();
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
        if (await pontoClassificacaoJornadaRepository.delete(id: currentRow.cells['id']!.value)) {
          _pontoClassificacaoJornadaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = pontoClassificacaoJornadaModel.id;
		plutoRow.cells['codigo']?.value = pontoClassificacaoJornadaModel.codigo;
		plutoRow.cells['nome']?.value = pontoClassificacaoJornadaModel.nome;
		plutoRow.cells['descricao']?.value = pontoClassificacaoJornadaModel.descricao;
		plutoRow.cells['padrao']?.value = pontoClassificacaoJornadaModel.padrao;
		plutoRow.cells['descontarHoras']?.value = pontoClassificacaoJornadaModel.descontarHoras;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await pontoClassificacaoJornadaRepository.save(pontoClassificacaoJornadaModel: pontoClassificacaoJornadaModel); 
        if (result != null) {
          pontoClassificacaoJornadaModel = result;
          if (_isInserting) {
            _pontoClassificacaoJornadaModelList.add(result);
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
		functionName = "ponto_classificacao_jornada";
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