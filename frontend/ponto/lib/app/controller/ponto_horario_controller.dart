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
import 'package:ponto/app/data/repository/ponto_horario_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoHorarioController extends GetxController with ControllerBaseMixin {
  final PontoHorarioRepository pontoHorarioRepository;
  PontoHorarioController({required this.pontoHorarioRepository});

  // general
  final _dbColumns = PontoHorarioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PontoHorarioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = pontoHorarioGridColumns();
  
  var _pontoHorarioModelList = <PontoHorarioModel>[];

  final _pontoHorarioModel = PontoHorarioModel().obs;
  PontoHorarioModel get pontoHorarioModel => _pontoHorarioModel.value;
  set pontoHorarioModel(value) => _pontoHorarioModel.value = value ?? PontoHorarioModel();

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
    for (var pontoHorarioModel in _pontoHorarioModelList) {
      plutoRowList.add(_getPlutoRow(pontoHorarioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PontoHorarioModel pontoHorarioModel) {
    return PlutoRow(
      cells: _getPlutoCells(pontoHorarioModel: pontoHorarioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PontoHorarioModel? pontoHorarioModel}) {
    return {
			"id": PlutoCell(value: pontoHorarioModel?.id ?? 0),
			"tipo": PlutoCell(value: pontoHorarioModel?.tipo ?? ''),
			"codigo": PlutoCell(value: pontoHorarioModel?.codigo ?? ''),
			"nome": PlutoCell(value: pontoHorarioModel?.nome ?? ''),
			"tipoTrabalho": PlutoCell(value: pontoHorarioModel?.tipoTrabalho ?? ''),
			"cargaHoraria": PlutoCell(value: pontoHorarioModel?.cargaHoraria ?? ''),
			"entrada01": PlutoCell(value: pontoHorarioModel?.entrada01 ?? ''),
			"saida01": PlutoCell(value: pontoHorarioModel?.saida01 ?? ''),
			"entrada02": PlutoCell(value: pontoHorarioModel?.entrada02 ?? ''),
			"saida02": PlutoCell(value: pontoHorarioModel?.saida02 ?? ''),
			"entrada03": PlutoCell(value: pontoHorarioModel?.entrada03 ?? ''),
			"saida03": PlutoCell(value: pontoHorarioModel?.saida03 ?? ''),
			"entrada04": PlutoCell(value: pontoHorarioModel?.entrada04 ?? ''),
			"saida04": PlutoCell(value: pontoHorarioModel?.saida04 ?? ''),
			"entrada05": PlutoCell(value: pontoHorarioModel?.entrada05 ?? ''),
			"saida05": PlutoCell(value: pontoHorarioModel?.saida05 ?? ''),
			"horaInicioJornada": PlutoCell(value: pontoHorarioModel?.horaInicioJornada ?? ''),
			"horaFimJornada": PlutoCell(value: pontoHorarioModel?.horaFimJornada ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _pontoHorarioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      pontoHorarioModel.plutoRowToObject(plutoRow);
    } else {
      pontoHorarioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Horários]';
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
    await Get.find<PontoHorarioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await pontoHorarioRepository.getList(filter: filter).then( (data){ _pontoHorarioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Horários',
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
			cargaHorariaController.text = currentRow.cells['cargaHoraria']?.value ?? '';
			entrada01Controller.text = currentRow.cells['entrada01']?.value ?? '';
			saida01Controller.text = currentRow.cells['saida01']?.value ?? '';
			entrada02Controller.text = currentRow.cells['entrada02']?.value ?? '';
			saida02Controller.text = currentRow.cells['saida02']?.value ?? '';
			entrada03Controller.text = currentRow.cells['entrada03']?.value ?? '';
			saida03Controller.text = currentRow.cells['saida03']?.value ?? '';
			entrada04Controller.text = currentRow.cells['entrada04']?.value ?? '';
			saida04Controller.text = currentRow.cells['saida04']?.value ?? '';
			entrada05Controller.text = currentRow.cells['entrada05']?.value ?? '';
			saida05Controller.text = currentRow.cells['saida05']?.value ?? '';
			horaInicioJornadaController.text = currentRow.cells['horaInicioJornada']?.value ?? '';
			horaFimJornadaController.text = currentRow.cells['horaFimJornada']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.pontoHorarioEditPage)!.then((value) {
        if (pontoHorarioModel.id == 0) {
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
    pontoHorarioModel = PontoHorarioModel();
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
        if (await pontoHorarioRepository.delete(id: currentRow.cells['id']!.value)) {
          _pontoHorarioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cargaHorariaController = MaskedTextController(mask: '00:00:00',);
	final entrada01Controller = MaskedTextController(mask: '00:00:00',);
	final saida01Controller = MaskedTextController(mask: '00:00:00',);
	final entrada02Controller = MaskedTextController(mask: '00:00:00',);
	final saida02Controller = MaskedTextController(mask: '00:00:00',);
	final entrada03Controller = MaskedTextController(mask: '00:00:00',);
	final saida03Controller = MaskedTextController(mask: '00:00:00',);
	final entrada04Controller = MaskedTextController(mask: '00:00:00',);
	final saida04Controller = MaskedTextController(mask: '00:00:00',);
	final entrada05Controller = MaskedTextController(mask: '00:00:00',);
	final saida05Controller = MaskedTextController(mask: '00:00:00',);
	final horaInicioJornadaController = MaskedTextController(mask: '00:00:00',);
	final horaFimJornadaController = MaskedTextController(mask: '00:00:00',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoHorarioModel.id;
		plutoRow.cells['tipo']?.value = pontoHorarioModel.tipo;
		plutoRow.cells['codigo']?.value = pontoHorarioModel.codigo;
		plutoRow.cells['nome']?.value = pontoHorarioModel.nome;
		plutoRow.cells['tipoTrabalho']?.value = pontoHorarioModel.tipoTrabalho;
		plutoRow.cells['cargaHoraria']?.value = pontoHorarioModel.cargaHoraria;
		plutoRow.cells['entrada01']?.value = pontoHorarioModel.entrada01;
		plutoRow.cells['saida01']?.value = pontoHorarioModel.saida01;
		plutoRow.cells['entrada02']?.value = pontoHorarioModel.entrada02;
		plutoRow.cells['saida02']?.value = pontoHorarioModel.saida02;
		plutoRow.cells['entrada03']?.value = pontoHorarioModel.entrada03;
		plutoRow.cells['saida03']?.value = pontoHorarioModel.saida03;
		plutoRow.cells['entrada04']?.value = pontoHorarioModel.entrada04;
		plutoRow.cells['saida04']?.value = pontoHorarioModel.saida04;
		plutoRow.cells['entrada05']?.value = pontoHorarioModel.entrada05;
		plutoRow.cells['saida05']?.value = pontoHorarioModel.saida05;
		plutoRow.cells['horaInicioJornada']?.value = pontoHorarioModel.horaInicioJornada;
		plutoRow.cells['horaFimJornada']?.value = pontoHorarioModel.horaFimJornada;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await pontoHorarioRepository.save(pontoHorarioModel: pontoHorarioModel); 
        if (result != null) {
          pontoHorarioModel = result;
          if (_isInserting) {
            _pontoHorarioModelList.add(result);
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
		functionName = "ponto_horario";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
		cargaHorariaController.dispose();
		entrada01Controller.dispose();
		saida01Controller.dispose();
		entrada02Controller.dispose();
		saida02Controller.dispose();
		entrada03Controller.dispose();
		saida03Controller.dispose();
		entrada04Controller.dispose();
		saida04Controller.dispose();
		entrada05Controller.dispose();
		saida05Controller.dispose();
		horaInicioJornadaController.dispose();
		horaFimJornadaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}