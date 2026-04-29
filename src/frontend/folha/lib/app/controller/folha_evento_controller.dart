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
import 'package:folha/app/data/repository/folha_evento_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaEventoController extends GetxController with ControllerBaseMixin {
  final FolhaEventoRepository folhaEventoRepository;
  FolhaEventoController({required this.folhaEventoRepository});

  // general
  final _dbColumns = FolhaEventoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaEventoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaEventoGridColumns();
  
  var _folhaEventoModelList = <FolhaEventoModel>[];

  final _folhaEventoModel = FolhaEventoModel().obs;
  FolhaEventoModel get folhaEventoModel => _folhaEventoModel.value;
  set folhaEventoModel(value) => _folhaEventoModel.value = value ?? FolhaEventoModel();

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
    for (var folhaEventoModel in _folhaEventoModelList) {
      plutoRowList.add(_getPlutoRow(folhaEventoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaEventoModel folhaEventoModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaEventoModel: folhaEventoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaEventoModel? folhaEventoModel}) {
    return {
			"id": PlutoCell(value: folhaEventoModel?.id ?? 0),
			"codigo": PlutoCell(value: folhaEventoModel?.codigo ?? ''),
			"nome": PlutoCell(value: folhaEventoModel?.nome ?? ''),
			"descricao": PlutoCell(value: folhaEventoModel?.descricao ?? ''),
			"baseCalculo": PlutoCell(value: folhaEventoModel?.baseCalculo ?? ''),
			"tipo": PlutoCell(value: folhaEventoModel?.tipo ?? ''),
			"unidade": PlutoCell(value: folhaEventoModel?.unidade ?? ''),
			"taxa": PlutoCell(value: folhaEventoModel?.taxa ?? 0),
			"rubricaEsocial": PlutoCell(value: folhaEventoModel?.rubricaEsocial ?? ''),
			"codIncidenciaPrevidencia": PlutoCell(value: folhaEventoModel?.codIncidenciaPrevidencia ?? ''),
			"codIncidenciaIrrf": PlutoCell(value: folhaEventoModel?.codIncidenciaIrrf ?? ''),
			"codIncidenciaFgts": PlutoCell(value: folhaEventoModel?.codIncidenciaFgts ?? ''),
			"codIncidenciaSindicato": PlutoCell(value: folhaEventoModel?.codIncidenciaSindicato ?? ''),
			"repercuteDsr": PlutoCell(value: folhaEventoModel?.repercuteDsr ?? ''),
			"repercute13": PlutoCell(value: folhaEventoModel?.repercute13 ?? ''),
			"repercuteFerias": PlutoCell(value: folhaEventoModel?.repercuteFerias ?? ''),
			"repercuteAviso": PlutoCell(value: folhaEventoModel?.repercuteAviso ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaEventoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaEventoModel.plutoRowToObject(plutoRow);
    } else {
      folhaEventoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Eventos]';
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
    await Get.find<FolhaEventoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaEventoRepository.getList(filter: filter).then( (data){ _folhaEventoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Eventos',
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
			taxaController.text = currentRow.cells['taxa']?.value?.toStringAsFixed(2) ?? '';
			rubricaEsocialController.text = currentRow.cells['rubricaEsocial']?.value ?? '';
			codIncidenciaPrevidenciaController.text = currentRow.cells['codIncidenciaPrevidencia']?.value ?? '';
			codIncidenciaIrrfController.text = currentRow.cells['codIncidenciaIrrf']?.value ?? '';
			codIncidenciaFgtsController.text = currentRow.cells['codIncidenciaFgts']?.value ?? '';
			codIncidenciaSindicatoController.text = currentRow.cells['codIncidenciaSindicato']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaEventoEditPage)!.then((value) {
        if (folhaEventoModel.id == 0) {
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
    folhaEventoModel = FolhaEventoModel();
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
        if (await folhaEventoRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaEventoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final taxaController = MoneyMaskedTextController();
	final rubricaEsocialController = TextEditingController();
	final codIncidenciaPrevidenciaController = TextEditingController();
	final codIncidenciaIrrfController = TextEditingController();
	final codIncidenciaFgtsController = TextEditingController();
	final codIncidenciaSindicatoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaEventoModel.id;
		plutoRow.cells['codigo']?.value = folhaEventoModel.codigo;
		plutoRow.cells['nome']?.value = folhaEventoModel.nome;
		plutoRow.cells['descricao']?.value = folhaEventoModel.descricao;
		plutoRow.cells['baseCalculo']?.value = folhaEventoModel.baseCalculo;
		plutoRow.cells['tipo']?.value = folhaEventoModel.tipo;
		plutoRow.cells['unidade']?.value = folhaEventoModel.unidade;
		plutoRow.cells['taxa']?.value = folhaEventoModel.taxa;
		plutoRow.cells['rubricaEsocial']?.value = folhaEventoModel.rubricaEsocial;
		plutoRow.cells['codIncidenciaPrevidencia']?.value = folhaEventoModel.codIncidenciaPrevidencia;
		plutoRow.cells['codIncidenciaIrrf']?.value = folhaEventoModel.codIncidenciaIrrf;
		plutoRow.cells['codIncidenciaFgts']?.value = folhaEventoModel.codIncidenciaFgts;
		plutoRow.cells['codIncidenciaSindicato']?.value = folhaEventoModel.codIncidenciaSindicato;
		plutoRow.cells['repercuteDsr']?.value = folhaEventoModel.repercuteDsr;
		plutoRow.cells['repercute13']?.value = folhaEventoModel.repercute13;
		plutoRow.cells['repercuteFerias']?.value = folhaEventoModel.repercuteFerias;
		plutoRow.cells['repercuteAviso']?.value = folhaEventoModel.repercuteAviso;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaEventoRepository.save(folhaEventoModel: folhaEventoModel); 
        if (result != null) {
          folhaEventoModel = result;
          if (_isInserting) {
            _folhaEventoModelList.add(result);
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
		functionName = "folha_evento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		taxaController.dispose();
		rubricaEsocialController.dispose();
		codIncidenciaPrevidenciaController.dispose();
		codIncidenciaIrrfController.dispose();
		codIncidenciaFgtsController.dispose();
		codIncidenciaSindicatoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}