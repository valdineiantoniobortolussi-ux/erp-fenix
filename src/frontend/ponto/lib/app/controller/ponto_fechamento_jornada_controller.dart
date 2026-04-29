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
import 'package:ponto/app/data/repository/ponto_fechamento_jornada_repository.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';
import 'package:ponto/app/mixin/controller_base_mixin.dart';

class PontoFechamentoJornadaController extends GetxController with ControllerBaseMixin {
  final PontoFechamentoJornadaRepository pontoFechamentoJornadaRepository;
  PontoFechamentoJornadaController({required this.pontoFechamentoJornadaRepository});

  // general
  final _dbColumns = PontoFechamentoJornadaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = PontoFechamentoJornadaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = pontoFechamentoJornadaGridColumns();
  
  var _pontoFechamentoJornadaModelList = <PontoFechamentoJornadaModel>[];

  final _pontoFechamentoJornadaModel = PontoFechamentoJornadaModel().obs;
  PontoFechamentoJornadaModel get pontoFechamentoJornadaModel => _pontoFechamentoJornadaModel.value;
  set pontoFechamentoJornadaModel(value) => _pontoFechamentoJornadaModel.value = value ?? PontoFechamentoJornadaModel();

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
    for (var pontoFechamentoJornadaModel in _pontoFechamentoJornadaModelList) {
      plutoRowList.add(_getPlutoRow(pontoFechamentoJornadaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(PontoFechamentoJornadaModel pontoFechamentoJornadaModel) {
    return PlutoRow(
      cells: _getPlutoCells(pontoFechamentoJornadaModel: pontoFechamentoJornadaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ PontoFechamentoJornadaModel? pontoFechamentoJornadaModel}) {
    return {
			"id": PlutoCell(value: pontoFechamentoJornadaModel?.id ?? 0),
			"pontoClassificacaoJornada": PlutoCell(value: pontoFechamentoJornadaModel?.pontoClassificacaoJornadaModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: pontoFechamentoJornadaModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataFechamento": PlutoCell(value: pontoFechamentoJornadaModel?.dataFechamento ?? ''),
			"diaSemana": PlutoCell(value: pontoFechamentoJornadaModel?.diaSemana ?? ''),
			"codigoHorario": PlutoCell(value: pontoFechamentoJornadaModel?.codigoHorario ?? ''),
			"cargaHorariaEsperada": PlutoCell(value: pontoFechamentoJornadaModel?.cargaHorariaEsperada ?? ''),
			"cargaHorariaDiurna": PlutoCell(value: pontoFechamentoJornadaModel?.cargaHorariaDiurna ?? ''),
			"cargaHorariaNoturna": PlutoCell(value: pontoFechamentoJornadaModel?.cargaHorariaNoturna ?? ''),
			"cargaHorariaTotal": PlutoCell(value: pontoFechamentoJornadaModel?.cargaHorariaTotal ?? ''),
			"entrada01": PlutoCell(value: pontoFechamentoJornadaModel?.entrada01 ?? ''),
			"saida01": PlutoCell(value: pontoFechamentoJornadaModel?.saida01 ?? ''),
			"entrada02": PlutoCell(value: pontoFechamentoJornadaModel?.entrada02 ?? ''),
			"saida02": PlutoCell(value: pontoFechamentoJornadaModel?.saida02 ?? ''),
			"entrada03": PlutoCell(value: pontoFechamentoJornadaModel?.entrada03 ?? ''),
			"saida03": PlutoCell(value: pontoFechamentoJornadaModel?.saida03 ?? ''),
			"entrada04": PlutoCell(value: pontoFechamentoJornadaModel?.entrada04 ?? ''),
			"saida04": PlutoCell(value: pontoFechamentoJornadaModel?.saida04 ?? ''),
			"entrada05": PlutoCell(value: pontoFechamentoJornadaModel?.entrada05 ?? ''),
			"saida05": PlutoCell(value: pontoFechamentoJornadaModel?.saida05 ?? ''),
			"horaInicioJornada": PlutoCell(value: pontoFechamentoJornadaModel?.horaInicioJornada ?? ''),
			"horaFimJornada": PlutoCell(value: pontoFechamentoJornadaModel?.horaFimJornada ?? ''),
			"horaExtra01": PlutoCell(value: pontoFechamentoJornadaModel?.horaExtra01 ?? ''),
			"percentualHoraExtra01": PlutoCell(value: pontoFechamentoJornadaModel?.percentualHoraExtra01 ?? 0),
			"modalidadeHoraExtra01": PlutoCell(value: pontoFechamentoJornadaModel?.modalidadeHoraExtra01 ?? ''),
			"horaExtra02": PlutoCell(value: pontoFechamentoJornadaModel?.horaExtra02 ?? ''),
			"percentualHoraExtra02": PlutoCell(value: pontoFechamentoJornadaModel?.percentualHoraExtra02 ?? 0),
			"modalidadeHoraExtra02": PlutoCell(value: pontoFechamentoJornadaModel?.modalidadeHoraExtra02 ?? ''),
			"horaExtra03": PlutoCell(value: pontoFechamentoJornadaModel?.horaExtra03 ?? ''),
			"percentualHoraExtra03": PlutoCell(value: pontoFechamentoJornadaModel?.percentualHoraExtra03 ?? 0),
			"modalidadeHoraExtra03": PlutoCell(value: pontoFechamentoJornadaModel?.modalidadeHoraExtra03 ?? ''),
			"horaExtra04": PlutoCell(value: pontoFechamentoJornadaModel?.horaExtra04 ?? ''),
			"percentualHoraExtra04": PlutoCell(value: pontoFechamentoJornadaModel?.percentualHoraExtra04 ?? 0),
			"modalidadeHoraExtra04": PlutoCell(value: pontoFechamentoJornadaModel?.modalidadeHoraExtra04 ?? ''),
			"faltaAtraso": PlutoCell(value: pontoFechamentoJornadaModel?.faltaAtraso ?? ''),
			"compensar": PlutoCell(value: pontoFechamentoJornadaModel?.compensar ?? ''),
			"bancoHoras": PlutoCell(value: pontoFechamentoJornadaModel?.bancoHoras ?? ''),
			"observacao": PlutoCell(value: pontoFechamentoJornadaModel?.observacao ?? ''),
			"idPontoClassificacaoJornada": PlutoCell(value: pontoFechamentoJornadaModel?.idPontoClassificacaoJornada ?? 0),
			"idColaborador": PlutoCell(value: pontoFechamentoJornadaModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _pontoFechamentoJornadaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      pontoFechamentoJornadaModel.plutoRowToObject(plutoRow);
    } else {
      pontoFechamentoJornadaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Fechamento da Jornada]';
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
    await Get.find<PontoFechamentoJornadaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await pontoFechamentoJornadaRepository.getList(filter: filter).then( (data){ _pontoFechamentoJornadaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Fechamento da Jornada',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			pontoClassificacaoJornadaModelController.text = currentRow.cells['pontoClassificacaoJornada']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			codigoHorarioController.text = currentRow.cells['codigoHorario']?.value ?? '';
			cargaHorariaEsperadaController.text = currentRow.cells['cargaHorariaEsperada']?.value ?? '';
			cargaHorariaDiurnaController.text = currentRow.cells['cargaHorariaDiurna']?.value ?? '';
			cargaHorariaNoturnaController.text = currentRow.cells['cargaHorariaNoturna']?.value ?? '';
			cargaHorariaTotalController.text = currentRow.cells['cargaHorariaTotal']?.value ?? '';
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
			horaExtra01Controller.text = currentRow.cells['horaExtra01']?.value ?? '';
			percentualHoraExtra01Controller.text = currentRow.cells['percentualHoraExtra01']?.value?.toStringAsFixed(2) ?? '';
			horaExtra02Controller.text = currentRow.cells['horaExtra02']?.value ?? '';
			percentualHoraExtra02Controller.text = currentRow.cells['percentualHoraExtra02']?.value?.toStringAsFixed(2) ?? '';
			horaExtra03Controller.text = currentRow.cells['horaExtra03']?.value ?? '';
			percentualHoraExtra03Controller.text = currentRow.cells['percentualHoraExtra03']?.value?.toStringAsFixed(2) ?? '';
			horaExtra04Controller.text = currentRow.cells['horaExtra04']?.value ?? '';
			percentualHoraExtra04Controller.text = currentRow.cells['percentualHoraExtra04']?.value?.toStringAsFixed(2) ?? '';
			faltaAtrasoController.text = currentRow.cells['faltaAtraso']?.value ?? '';
			bancoHorasController.text = currentRow.cells['bancoHoras']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.pontoFechamentoJornadaEditPage)!.then((value) {
        if (pontoFechamentoJornadaModel.id == 0) {
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
    pontoFechamentoJornadaModel = PontoFechamentoJornadaModel();
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
        if (await pontoFechamentoJornadaRepository.delete(id: currentRow.cells['id']!.value)) {
          _pontoFechamentoJornadaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final pontoClassificacaoJornadaModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final codigoHorarioController = TextEditingController();
	final cargaHorariaEsperadaController = MaskedTextController(mask: '00:00:00',);
	final cargaHorariaDiurnaController = MaskedTextController(mask: '00:00:00',);
	final cargaHorariaNoturnaController = MaskedTextController(mask: '00:00:00',);
	final cargaHorariaTotalController = MaskedTextController(mask: '00:00:00',);
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
	final horaExtra01Controller = MaskedTextController(mask: '00:00:00',);
	final percentualHoraExtra01Controller = MoneyMaskedTextController();
	final horaExtra02Controller = MaskedTextController(mask: '00:00:00',);
	final percentualHoraExtra02Controller = MoneyMaskedTextController();
	final horaExtra03Controller = MaskedTextController(mask: '00:00:00',);
	final percentualHoraExtra03Controller = MoneyMaskedTextController();
	final horaExtra04Controller = MaskedTextController(mask: '00:00:00',);
	final percentualHoraExtra04Controller = MoneyMaskedTextController();
	final faltaAtrasoController = MaskedTextController(mask: '00:00:00',);
	final bancoHorasController = MaskedTextController(mask: '00:00:00',);
	final observacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoFechamentoJornadaModel.id;
		plutoRow.cells['idPontoClassificacaoJornada']?.value = pontoFechamentoJornadaModel.idPontoClassificacaoJornada;
		plutoRow.cells['pontoClassificacaoJornada']?.value = pontoFechamentoJornadaModel.pontoClassificacaoJornadaModel?.nome;
		plutoRow.cells['idColaborador']?.value = pontoFechamentoJornadaModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = pontoFechamentoJornadaModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataFechamento']?.value = Util.formatDate(pontoFechamentoJornadaModel.dataFechamento);
		plutoRow.cells['diaSemana']?.value = pontoFechamentoJornadaModel.diaSemana;
		plutoRow.cells['codigoHorario']?.value = pontoFechamentoJornadaModel.codigoHorario;
		plutoRow.cells['cargaHorariaEsperada']?.value = pontoFechamentoJornadaModel.cargaHorariaEsperada;
		plutoRow.cells['cargaHorariaDiurna']?.value = pontoFechamentoJornadaModel.cargaHorariaDiurna;
		plutoRow.cells['cargaHorariaNoturna']?.value = pontoFechamentoJornadaModel.cargaHorariaNoturna;
		plutoRow.cells['cargaHorariaTotal']?.value = pontoFechamentoJornadaModel.cargaHorariaTotal;
		plutoRow.cells['entrada01']?.value = pontoFechamentoJornadaModel.entrada01;
		plutoRow.cells['saida01']?.value = pontoFechamentoJornadaModel.saida01;
		plutoRow.cells['entrada02']?.value = pontoFechamentoJornadaModel.entrada02;
		plutoRow.cells['saida02']?.value = pontoFechamentoJornadaModel.saida02;
		plutoRow.cells['entrada03']?.value = pontoFechamentoJornadaModel.entrada03;
		plutoRow.cells['saida03']?.value = pontoFechamentoJornadaModel.saida03;
		plutoRow.cells['entrada04']?.value = pontoFechamentoJornadaModel.entrada04;
		plutoRow.cells['saida04']?.value = pontoFechamentoJornadaModel.saida04;
		plutoRow.cells['entrada05']?.value = pontoFechamentoJornadaModel.entrada05;
		plutoRow.cells['saida05']?.value = pontoFechamentoJornadaModel.saida05;
		plutoRow.cells['horaInicioJornada']?.value = pontoFechamentoJornadaModel.horaInicioJornada;
		plutoRow.cells['horaFimJornada']?.value = pontoFechamentoJornadaModel.horaFimJornada;
		plutoRow.cells['horaExtra01']?.value = pontoFechamentoJornadaModel.horaExtra01;
		plutoRow.cells['percentualHoraExtra01']?.value = pontoFechamentoJornadaModel.percentualHoraExtra01;
		plutoRow.cells['modalidadeHoraExtra01']?.value = pontoFechamentoJornadaModel.modalidadeHoraExtra01;
		plutoRow.cells['horaExtra02']?.value = pontoFechamentoJornadaModel.horaExtra02;
		plutoRow.cells['percentualHoraExtra02']?.value = pontoFechamentoJornadaModel.percentualHoraExtra02;
		plutoRow.cells['modalidadeHoraExtra02']?.value = pontoFechamentoJornadaModel.modalidadeHoraExtra02;
		plutoRow.cells['horaExtra03']?.value = pontoFechamentoJornadaModel.horaExtra03;
		plutoRow.cells['percentualHoraExtra03']?.value = pontoFechamentoJornadaModel.percentualHoraExtra03;
		plutoRow.cells['modalidadeHoraExtra03']?.value = pontoFechamentoJornadaModel.modalidadeHoraExtra03;
		plutoRow.cells['horaExtra04']?.value = pontoFechamentoJornadaModel.horaExtra04;
		plutoRow.cells['percentualHoraExtra04']?.value = pontoFechamentoJornadaModel.percentualHoraExtra04;
		plutoRow.cells['modalidadeHoraExtra04']?.value = pontoFechamentoJornadaModel.modalidadeHoraExtra04;
		plutoRow.cells['faltaAtraso']?.value = pontoFechamentoJornadaModel.faltaAtraso;
		plutoRow.cells['compensar']?.value = pontoFechamentoJornadaModel.compensar;
		plutoRow.cells['bancoHoras']?.value = pontoFechamentoJornadaModel.bancoHoras;
		plutoRow.cells['observacao']?.value = pontoFechamentoJornadaModel.observacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await pontoFechamentoJornadaRepository.save(pontoFechamentoJornadaModel: pontoFechamentoJornadaModel); 
        if (result != null) {
          pontoFechamentoJornadaModel = result;
          if (_isInserting) {
            _pontoFechamentoJornadaModelList.add(result);
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

	Future callPontoClassificacaoJornadaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Classificação Jornada]'; 
		lookupController.route = '/ponto-classificacao-jornada/'; 
		lookupController.gridColumns = pontoClassificacaoJornadaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PontoClassificacaoJornadaModel.aliasColumns; 
		lookupController.dbColumns = PontoClassificacaoJornadaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pontoFechamentoJornadaModel.idPontoClassificacaoJornada = plutoRowResult.cells['id']!.value; 
			pontoFechamentoJornadaModel.pontoClassificacaoJornadaModel!.plutoRowToObject(plutoRowResult); 
			pontoClassificacaoJornadaModelController.text = pontoFechamentoJornadaModel.pontoClassificacaoJornadaModel?.nome ?? ''; 
			formWasChanged = true; 
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
			pontoFechamentoJornadaModel.idColaborador = plutoRowResult.cells['id']!.value; 
			pontoFechamentoJornadaModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = pontoFechamentoJornadaModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "ponto_fechamento_jornada";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		pontoClassificacaoJornadaModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		codigoHorarioController.dispose();
		cargaHorariaEsperadaController.dispose();
		cargaHorariaDiurnaController.dispose();
		cargaHorariaNoturnaController.dispose();
		cargaHorariaTotalController.dispose();
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
		horaExtra01Controller.dispose();
		percentualHoraExtra01Controller.dispose();
		horaExtra02Controller.dispose();
		percentualHoraExtra02Controller.dispose();
		horaExtra03Controller.dispose();
		percentualHoraExtra03Controller.dispose();
		horaExtra04Controller.dispose();
		percentualHoraExtra04Controller.dispose();
		faltaAtrasoController.dispose();
		bancoHorasController.dispose();
		observacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}