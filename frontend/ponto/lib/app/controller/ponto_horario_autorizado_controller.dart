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
import 'package:ponto/app/data/repository/ponto_horario_autorizado_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoHorarioAutorizadoController extends GetxController with ControllerBaseMixin {
  final PontoHorarioAutorizadoRepository pontoHorarioAutorizadoRepository;
  PontoHorarioAutorizadoController({required this.pontoHorarioAutorizadoRepository});

  // general
  final _dbColumns = PontoHorarioAutorizadoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PontoHorarioAutorizadoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = pontoHorarioAutorizadoGridColumns();
  
  var _pontoHorarioAutorizadoModelList = <PontoHorarioAutorizadoModel>[];

  final _pontoHorarioAutorizadoModel = PontoHorarioAutorizadoModel().obs;
  PontoHorarioAutorizadoModel get pontoHorarioAutorizadoModel => _pontoHorarioAutorizadoModel.value;
  set pontoHorarioAutorizadoModel(value) => _pontoHorarioAutorizadoModel.value = value ?? PontoHorarioAutorizadoModel();

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
    for (var pontoHorarioAutorizadoModel in _pontoHorarioAutorizadoModelList) {
      plutoRowList.add(_getPlutoRow(pontoHorarioAutorizadoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PontoHorarioAutorizadoModel pontoHorarioAutorizadoModel) {
    return PlutoRow(
      cells: _getPlutoCells(pontoHorarioAutorizadoModel: pontoHorarioAutorizadoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PontoHorarioAutorizadoModel? pontoHorarioAutorizadoModel}) {
    return {
			"id": PlutoCell(value: pontoHorarioAutorizadoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: pontoHorarioAutorizadoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataHorario": PlutoCell(value: pontoHorarioAutorizadoModel?.dataHorario ?? ''),
			"tipo": PlutoCell(value: pontoHorarioAutorizadoModel?.tipo ?? ''),
			"cargaHoraria": PlutoCell(value: pontoHorarioAutorizadoModel?.cargaHoraria ?? ''),
			"entrada01": PlutoCell(value: pontoHorarioAutorizadoModel?.entrada01 ?? ''),
			"saida01": PlutoCell(value: pontoHorarioAutorizadoModel?.saida01 ?? ''),
			"entrada02": PlutoCell(value: pontoHorarioAutorizadoModel?.entrada02 ?? ''),
			"saida02": PlutoCell(value: pontoHorarioAutorizadoModel?.saida02 ?? ''),
			"entrada03": PlutoCell(value: pontoHorarioAutorizadoModel?.entrada03 ?? ''),
			"saida03": PlutoCell(value: pontoHorarioAutorizadoModel?.saida03 ?? ''),
			"entrada04": PlutoCell(value: pontoHorarioAutorizadoModel?.entrada04 ?? ''),
			"saida04": PlutoCell(value: pontoHorarioAutorizadoModel?.saida04 ?? ''),
			"entrada05": PlutoCell(value: pontoHorarioAutorizadoModel?.entrada05 ?? ''),
			"saida05": PlutoCell(value: pontoHorarioAutorizadoModel?.saida05 ?? ''),
			"horaFechamentoDia": PlutoCell(value: pontoHorarioAutorizadoModel?.horaFechamentoDia ?? ''),
			"idColaborador": PlutoCell(value: pontoHorarioAutorizadoModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _pontoHorarioAutorizadoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      pontoHorarioAutorizadoModel.plutoRowToObject(plutoRow);
    } else {
      pontoHorarioAutorizadoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Horário Autorizado]';
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
    await Get.find<PontoHorarioAutorizadoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await pontoHorarioAutorizadoRepository.getList(filter: filter).then( (data){ _pontoHorarioAutorizadoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Horário Autorizado',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
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
			horaFechamentoDiaController.text = currentRow.cells['horaFechamentoDia']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.pontoHorarioAutorizadoEditPage)!.then((value) {
        if (pontoHorarioAutorizadoModel.id == 0) {
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
    pontoHorarioAutorizadoModel = PontoHorarioAutorizadoModel();
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
        if (await pontoHorarioAutorizadoRepository.delete(id: currentRow.cells['id']!.value)) {
          _pontoHorarioAutorizadoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaColaboradorModelController = TextEditingController();
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
	final horaFechamentoDiaController = MaskedTextController(mask: '00:00:00',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoHorarioAutorizadoModel.id;
		plutoRow.cells['idColaborador']?.value = pontoHorarioAutorizadoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = pontoHorarioAutorizadoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataHorario']?.value = Util.formatDate(pontoHorarioAutorizadoModel.dataHorario);
		plutoRow.cells['tipo']?.value = pontoHorarioAutorizadoModel.tipo;
		plutoRow.cells['cargaHoraria']?.value = pontoHorarioAutorizadoModel.cargaHoraria;
		plutoRow.cells['entrada01']?.value = pontoHorarioAutorizadoModel.entrada01;
		plutoRow.cells['saida01']?.value = pontoHorarioAutorizadoModel.saida01;
		plutoRow.cells['entrada02']?.value = pontoHorarioAutorizadoModel.entrada02;
		plutoRow.cells['saida02']?.value = pontoHorarioAutorizadoModel.saida02;
		plutoRow.cells['entrada03']?.value = pontoHorarioAutorizadoModel.entrada03;
		plutoRow.cells['saida03']?.value = pontoHorarioAutorizadoModel.saida03;
		plutoRow.cells['entrada04']?.value = pontoHorarioAutorizadoModel.entrada04;
		plutoRow.cells['saida04']?.value = pontoHorarioAutorizadoModel.saida04;
		plutoRow.cells['entrada05']?.value = pontoHorarioAutorizadoModel.entrada05;
		plutoRow.cells['saida05']?.value = pontoHorarioAutorizadoModel.saida05;
		plutoRow.cells['horaFechamentoDia']?.value = pontoHorarioAutorizadoModel.horaFechamentoDia;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await pontoHorarioAutorizadoRepository.save(pontoHorarioAutorizadoModel: pontoHorarioAutorizadoModel); 
        if (result != null) {
          pontoHorarioAutorizadoModel = result;
          if (_isInserting) {
            _pontoHorarioAutorizadoModelList.add(result);
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

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pontoHorarioAutorizadoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			pontoHorarioAutorizadoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = pontoHorarioAutorizadoModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "ponto_horario_autorizado";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
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
		horaFechamentoDiaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}