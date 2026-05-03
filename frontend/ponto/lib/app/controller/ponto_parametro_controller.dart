import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/controller/controller_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/page/grid_columns/grid_columns_imports.dart';

import 'package:ponto/app/routes/app_routes.dart';
import 'package:ponto/app/data/repository/ponto_parametro_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoParametroController extends GetxController with ControllerBaseMixin {
  final PontoParametroRepository pontoParametroRepository;
  PontoParametroController({required this.pontoParametroRepository});

  // general
  final _dbColumns = PontoParametroModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PontoParametroModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = pontoParametroGridColumns();
  
  var _pontoParametroModelList = <PontoParametroModel>[];

  final _pontoParametroModel = PontoParametroModel().obs;
  PontoParametroModel get pontoParametroModel => _pontoParametroModel.value;
  set pontoParametroModel(value) => _pontoParametroModel.value = value ?? PontoParametroModel();

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
    for (var pontoParametroModel in _pontoParametroModelList) {
      plutoRowList.add(_getPlutoRow(pontoParametroModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PontoParametroModel pontoParametroModel) {
    return PlutoRow(
      cells: _getPlutoCells(pontoParametroModel: pontoParametroModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PontoParametroModel? pontoParametroModel}) {
    return {
			"id": PlutoCell(value: pontoParametroModel?.id ?? 0),
			"mesAno": PlutoCell(value: pontoParametroModel?.mesAno ?? ''),
			"diaInicialApuracao": PlutoCell(value: pontoParametroModel?.diaInicialApuracao ?? 0),
			"horaNoturnaInicio": PlutoCell(value: pontoParametroModel?.horaNoturnaInicio ?? ''),
			"horaNoturnaFim": PlutoCell(value: pontoParametroModel?.horaNoturnaFim ?? ''),
			"periodoMinimoInterjornada": PlutoCell(value: pontoParametroModel?.periodoMinimoInterjornada ?? ''),
			"percentualHeDiurna": PlutoCell(value: pontoParametroModel?.percentualHeDiurna ?? 0),
			"percentualHeNoturna": PlutoCell(value: pontoParametroModel?.percentualHeNoturna ?? 0),
			"duracaoHoraNoturna": PlutoCell(value: pontoParametroModel?.duracaoHoraNoturna ?? ''),
			"tratamentoHoraMais": PlutoCell(value: pontoParametroModel?.tratamentoHoraMais ?? ''),
			"tratamentoHoraMenos": PlutoCell(value: pontoParametroModel?.tratamentoHoraMenos ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _pontoParametroModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      pontoParametroModel.plutoRowToObject(plutoRow);
    } else {
      pontoParametroModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Parâmetros]';
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
    await Get.find<PontoParametroController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await pontoParametroRepository.getList(filter: filter).then( (data){ _pontoParametroModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Parâmetros',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			mesAnoController.text = currentRow.cells['mesAno']?.value ?? '';
			diaInicialApuracaoController.text = currentRow.cells['diaInicialApuracao']?.value?.toString() ?? '';
			horaNoturnaInicioController.text = currentRow.cells['horaNoturnaInicio']?.value ?? '';
			horaNoturnaFimController.text = currentRow.cells['horaNoturnaFim']?.value ?? '';
			periodoMinimoInterjornadaController.text = currentRow.cells['periodoMinimoInterjornada']?.value ?? '';
			percentualHeDiurnaController.text = currentRow.cells['percentualHeDiurna']?.value?.toStringAsFixed(2) ?? '';
			percentualHeNoturnaController.text = currentRow.cells['percentualHeNoturna']?.value?.toStringAsFixed(2) ?? '';
			duracaoHoraNoturnaController.text = currentRow.cells['duracaoHoraNoturna']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.pontoParametroEditPage)!.then((value) {
        if (pontoParametroModel.id == 0) {
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
    pontoParametroModel = PontoParametroModel();
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
        if (await pontoParametroRepository.delete(id: currentRow.cells['id']!.value)) {
          _pontoParametroModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final mesAnoController = MaskedTextController(mask: '00/0000',);
	final diaInicialApuracaoController = TextEditingController();
	final horaNoturnaInicioController = MaskedTextController(mask: '00:00:00',);
	final horaNoturnaFimController = MaskedTextController(mask: '00:00:00',);
	final periodoMinimoInterjornadaController = MaskedTextController(mask: '00:00:00',);
	final percentualHeDiurnaController = MoneyMaskedTextController();
	final percentualHeNoturnaController = MoneyMaskedTextController();
	final duracaoHoraNoturnaController = MaskedTextController(mask: '00:00:00',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoParametroModel.id;
		plutoRow.cells['mesAno']?.value = pontoParametroModel.mesAno;
		plutoRow.cells['diaInicialApuracao']?.value = pontoParametroModel.diaInicialApuracao;
		plutoRow.cells['horaNoturnaInicio']?.value = pontoParametroModel.horaNoturnaInicio;
		plutoRow.cells['horaNoturnaFim']?.value = pontoParametroModel.horaNoturnaFim;
		plutoRow.cells['periodoMinimoInterjornada']?.value = pontoParametroModel.periodoMinimoInterjornada;
		plutoRow.cells['percentualHeDiurna']?.value = pontoParametroModel.percentualHeDiurna;
		plutoRow.cells['percentualHeNoturna']?.value = pontoParametroModel.percentualHeNoturna;
		plutoRow.cells['duracaoHoraNoturna']?.value = pontoParametroModel.duracaoHoraNoturna;
		plutoRow.cells['tratamentoHoraMais']?.value = pontoParametroModel.tratamentoHoraMais;
		plutoRow.cells['tratamentoHoraMenos']?.value = pontoParametroModel.tratamentoHoraMenos;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await pontoParametroRepository.save(pontoParametroModel: pontoParametroModel); 
        if (result != null) {
          pontoParametroModel = result;
          if (_isInserting) {
            _pontoParametroModelList.add(result);
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
		functionName = "ponto_parametro";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mesAnoController.dispose();
		diaInicialApuracaoController.dispose();
		horaNoturnaInicioController.dispose();
		horaNoturnaFimController.dispose();
		periodoMinimoInterjornadaController.dispose();
		percentualHeDiurnaController.dispose();
		percentualHeNoturnaController.dispose();
		duracaoHoraNoturnaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}