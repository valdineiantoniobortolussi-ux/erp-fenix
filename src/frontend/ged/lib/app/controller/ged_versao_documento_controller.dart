import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/controller/controller_imports.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:ged/app/page/grid_columns/grid_columns_imports.dart';

import 'package:ged/app/routes/app_routes.dart';
import 'package:ged/app/data/repository/ged_versao_documento_repository.dart';
import 'package:ged/app/page/shared_page/shared_page_imports.dart';
import 'package:ged/app/page/shared_widget/message_dialog.dart';
import 'package:ged/app/mixin/controller_base_mixin.dart';

class GedVersaoDocumentoController extends GetxController with ControllerBaseMixin {
  final GedVersaoDocumentoRepository gedVersaoDocumentoRepository;
  GedVersaoDocumentoController({required this.gedVersaoDocumentoRepository});

  // general
  final _dbColumns = GedVersaoDocumentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = GedVersaoDocumentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = gedVersaoDocumentoGridColumns();
  
  var _gedVersaoDocumentoModelList = <GedVersaoDocumentoModel>[];

  final _gedVersaoDocumentoModel = GedVersaoDocumentoModel().obs;
  GedVersaoDocumentoModel get gedVersaoDocumentoModel => _gedVersaoDocumentoModel.value;
  set gedVersaoDocumentoModel(value) => _gedVersaoDocumentoModel.value = value ?? GedVersaoDocumentoModel();

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
    for (var gedVersaoDocumentoModel in _gedVersaoDocumentoModelList) {
      plutoRowList.add(_getPlutoRow(gedVersaoDocumentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(GedVersaoDocumentoModel gedVersaoDocumentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(gedVersaoDocumentoModel: gedVersaoDocumentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ GedVersaoDocumentoModel? gedVersaoDocumentoModel}) {
    return {
			"id": PlutoCell(value: gedVersaoDocumentoModel?.id ?? 0),
			"gedDocumentoDetalhe": PlutoCell(value: gedVersaoDocumentoModel?.gedDocumentoDetalheModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: gedVersaoDocumentoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"acao": PlutoCell(value: gedVersaoDocumentoModel?.acao ?? ''),
			"versao": PlutoCell(value: gedVersaoDocumentoModel?.versao ?? 0),
			"dataVersao": PlutoCell(value: gedVersaoDocumentoModel?.dataVersao ?? ''),
			"horaVersao": PlutoCell(value: gedVersaoDocumentoModel?.horaVersao ?? ''),
			"hashArquivo": PlutoCell(value: gedVersaoDocumentoModel?.hashArquivo ?? ''),
			"caminho": PlutoCell(value: gedVersaoDocumentoModel?.caminho ?? ''),
			"idGedDocumentoDetalhe": PlutoCell(value: gedVersaoDocumentoModel?.idGedDocumentoDetalhe ?? 0),
			"idColaborador": PlutoCell(value: gedVersaoDocumentoModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _gedVersaoDocumentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      gedVersaoDocumentoModel.plutoRowToObject(plutoRow);
    } else {
      gedVersaoDocumentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Versionamento]';
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
    await Get.find<GedVersaoDocumentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await gedVersaoDocumentoRepository.getList(filter: filter).then( (data){ _gedVersaoDocumentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Versionamento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			gedDocumentoDetalheModelController.text = currentRow.cells['gedDocumentoDetalhe']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			versaoController.text = currentRow.cells['versao']?.value?.toString() ?? '';
			horaVersaoController.text = currentRow.cells['horaVersao']?.value ?? '';
			hashArquivoController.text = currentRow.cells['hashArquivo']?.value ?? '';
			caminhoController.text = currentRow.cells['caminho']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.gedVersaoDocumentoEditPage)!.then((value) {
        if (gedVersaoDocumentoModel.id == 0) {
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
    gedVersaoDocumentoModel = GedVersaoDocumentoModel();
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
        if (await gedVersaoDocumentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _gedVersaoDocumentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final gedDocumentoDetalheModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();
	final versaoController = TextEditingController();
	final horaVersaoController = MaskedTextController(mask: '00:00:00',);
	final hashArquivoController = TextEditingController();
	final caminhoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = gedVersaoDocumentoModel.id;
		plutoRow.cells['idGedDocumentoDetalhe']?.value = gedVersaoDocumentoModel.idGedDocumentoDetalhe;
		plutoRow.cells['gedDocumentoDetalhe']?.value = gedVersaoDocumentoModel.gedDocumentoDetalheModel?.nome;
		plutoRow.cells['idColaborador']?.value = gedVersaoDocumentoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = gedVersaoDocumentoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['acao']?.value = gedVersaoDocumentoModel.acao;
		plutoRow.cells['versao']?.value = gedVersaoDocumentoModel.versao;
		plutoRow.cells['dataVersao']?.value = Util.formatDate(gedVersaoDocumentoModel.dataVersao);
		plutoRow.cells['horaVersao']?.value = gedVersaoDocumentoModel.horaVersao;
		plutoRow.cells['hashArquivo']?.value = gedVersaoDocumentoModel.hashArquivo;
		plutoRow.cells['caminho']?.value = gedVersaoDocumentoModel.caminho;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await gedVersaoDocumentoRepository.save(gedVersaoDocumentoModel: gedVersaoDocumentoModel); 
        if (result != null) {
          gedVersaoDocumentoModel = result;
          if (_isInserting) {
            _gedVersaoDocumentoModelList.add(result);
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

	Future callGedDocumentoDetalheLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Documento]'; 
		lookupController.route = '/ged-documento-detalhe/'; 
		lookupController.gridColumns = gedDocumentoDetalheGridColumns(isForLookup: true); 
		lookupController.aliasColumns = GedDocumentoDetalheModel.aliasColumns; 
		lookupController.dbColumns = GedDocumentoDetalheModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			gedVersaoDocumentoModel.idGedDocumentoDetalhe = plutoRowResult.cells['id']!.value; 
			gedVersaoDocumentoModel.gedDocumentoDetalheModel!.plutoRowToObject(plutoRowResult); 
			gedDocumentoDetalheModelController.text = gedVersaoDocumentoModel.gedDocumentoDetalheModel?.nome ?? ''; 
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
			gedVersaoDocumentoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			gedVersaoDocumentoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = gedVersaoDocumentoModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "ged_versao_documento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		gedDocumentoDetalheModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
		versaoController.dispose();
		horaVersaoController.dispose();
		hashArquivoController.dispose();
		caminhoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}