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
import 'package:folha/app/data/repository/folha_rescisao_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaRescisaoController extends GetxController with ControllerBaseMixin {
  final FolhaRescisaoRepository folhaRescisaoRepository;
  FolhaRescisaoController({required this.folhaRescisaoRepository});

  // general
  final _dbColumns = FolhaRescisaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaRescisaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaRescisaoGridColumns();
  
  var _folhaRescisaoModelList = <FolhaRescisaoModel>[];

  final _folhaRescisaoModel = FolhaRescisaoModel().obs;
  FolhaRescisaoModel get folhaRescisaoModel => _folhaRescisaoModel.value;
  set folhaRescisaoModel(value) => _folhaRescisaoModel.value = value ?? FolhaRescisaoModel();

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
    for (var folhaRescisaoModel in _folhaRescisaoModelList) {
      plutoRowList.add(_getPlutoRow(folhaRescisaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaRescisaoModel folhaRescisaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaRescisaoModel: folhaRescisaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaRescisaoModel? folhaRescisaoModel}) {
    return {
			"id": PlutoCell(value: folhaRescisaoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: folhaRescisaoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataDemissao": PlutoCell(value: folhaRescisaoModel?.dataDemissao ?? ''),
			"dataPagamento": PlutoCell(value: folhaRescisaoModel?.dataPagamento ?? ''),
			"motivo": PlutoCell(value: folhaRescisaoModel?.motivo ?? ''),
			"motivoEsocial": PlutoCell(value: folhaRescisaoModel?.motivoEsocial ?? ''),
			"dataAvisoPrevio": PlutoCell(value: folhaRescisaoModel?.dataAvisoPrevio ?? ''),
			"diasAvisoPrevio": PlutoCell(value: folhaRescisaoModel?.diasAvisoPrevio ?? 0),
			"comprovouNovoEmprego": PlutoCell(value: folhaRescisaoModel?.comprovouNovoEmprego ?? ''),
			"dispensouEmpregado": PlutoCell(value: folhaRescisaoModel?.dispensouEmpregado ?? ''),
			"pensaoAlimenticia": PlutoCell(value: folhaRescisaoModel?.pensaoAlimenticia ?? 0),
			"pensaoAlimenticiaFgts": PlutoCell(value: folhaRescisaoModel?.pensaoAlimenticiaFgts ?? 0),
			"fgtsValorRescisao": PlutoCell(value: folhaRescisaoModel?.fgtsValorRescisao ?? 0),
			"fgtsSaldoBanco": PlutoCell(value: folhaRescisaoModel?.fgtsSaldoBanco ?? 0),
			"fgtsComplementoSaldo": PlutoCell(value: folhaRescisaoModel?.fgtsComplementoSaldo ?? 0),
			"fgtsCodigoAfastamento": PlutoCell(value: folhaRescisaoModel?.fgtsCodigoAfastamento ?? ''),
			"fgtsCodigoSaque": PlutoCell(value: folhaRescisaoModel?.fgtsCodigoSaque ?? ''),
			"idColaborador": PlutoCell(value: folhaRescisaoModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaRescisaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaRescisaoModel.plutoRowToObject(plutoRow);
    } else {
      folhaRescisaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Rescisão]';
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
    await Get.find<FolhaRescisaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaRescisaoRepository.getList(filter: filter).then( (data){ _folhaRescisaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Rescisão',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			motivoController.text = currentRow.cells['motivo']?.value ?? '';
			motivoEsocialController.text = currentRow.cells['motivoEsocial']?.value ?? '';
			diasAvisoPrevioController.text = currentRow.cells['diasAvisoPrevio']?.value?.toString() ?? '';
			pensaoAlimenticiaController.text = currentRow.cells['pensaoAlimenticia']?.value?.toStringAsFixed(2) ?? '';
			pensaoAlimenticiaFgtsController.text = currentRow.cells['pensaoAlimenticiaFgts']?.value?.toStringAsFixed(2) ?? '';
			fgtsValorRescisaoController.text = currentRow.cells['fgtsValorRescisao']?.value?.toStringAsFixed(2) ?? '';
			fgtsSaldoBancoController.text = currentRow.cells['fgtsSaldoBanco']?.value?.toStringAsFixed(2) ?? '';
			fgtsComplementoSaldoController.text = currentRow.cells['fgtsComplementoSaldo']?.value?.toStringAsFixed(2) ?? '';
			fgtsCodigoAfastamentoController.text = currentRow.cells['fgtsCodigoAfastamento']?.value ?? '';
			fgtsCodigoSaqueController.text = currentRow.cells['fgtsCodigoSaque']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaRescisaoEditPage)!.then((value) {
        if (folhaRescisaoModel.id == 0) {
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
    folhaRescisaoModel = FolhaRescisaoModel();
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
        if (await folhaRescisaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaRescisaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final motivoController = TextEditingController();
	final motivoEsocialController = TextEditingController();
	final diasAvisoPrevioController = TextEditingController();
	final pensaoAlimenticiaController = MoneyMaskedTextController();
	final pensaoAlimenticiaFgtsController = MoneyMaskedTextController();
	final fgtsValorRescisaoController = MoneyMaskedTextController();
	final fgtsSaldoBancoController = MoneyMaskedTextController();
	final fgtsComplementoSaldoController = MoneyMaskedTextController();
	final fgtsCodigoAfastamentoController = TextEditingController();
	final fgtsCodigoSaqueController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaRescisaoModel.id;
		plutoRow.cells['idColaborador']?.value = folhaRescisaoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaRescisaoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataDemissao']?.value = Util.formatDate(folhaRescisaoModel.dataDemissao);
		plutoRow.cells['dataPagamento']?.value = Util.formatDate(folhaRescisaoModel.dataPagamento);
		plutoRow.cells['motivo']?.value = folhaRescisaoModel.motivo;
		plutoRow.cells['motivoEsocial']?.value = folhaRescisaoModel.motivoEsocial;
		plutoRow.cells['dataAvisoPrevio']?.value = Util.formatDate(folhaRescisaoModel.dataAvisoPrevio);
		plutoRow.cells['diasAvisoPrevio']?.value = folhaRescisaoModel.diasAvisoPrevio;
		plutoRow.cells['comprovouNovoEmprego']?.value = folhaRescisaoModel.comprovouNovoEmprego;
		plutoRow.cells['dispensouEmpregado']?.value = folhaRescisaoModel.dispensouEmpregado;
		plutoRow.cells['pensaoAlimenticia']?.value = folhaRescisaoModel.pensaoAlimenticia;
		plutoRow.cells['pensaoAlimenticiaFgts']?.value = folhaRescisaoModel.pensaoAlimenticiaFgts;
		plutoRow.cells['fgtsValorRescisao']?.value = folhaRescisaoModel.fgtsValorRescisao;
		plutoRow.cells['fgtsSaldoBanco']?.value = folhaRescisaoModel.fgtsSaldoBanco;
		plutoRow.cells['fgtsComplementoSaldo']?.value = folhaRescisaoModel.fgtsComplementoSaldo;
		plutoRow.cells['fgtsCodigoAfastamento']?.value = folhaRescisaoModel.fgtsCodigoAfastamento;
		plutoRow.cells['fgtsCodigoSaque']?.value = folhaRescisaoModel.fgtsCodigoSaque;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaRescisaoRepository.save(folhaRescisaoModel: folhaRescisaoModel); 
        if (result != null) {
          folhaRescisaoModel = result;
          if (_isInserting) {
            _folhaRescisaoModelList.add(result);
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
			folhaRescisaoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaRescisaoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaRescisaoModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "folha_rescisao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
		motivoController.dispose();
		motivoEsocialController.dispose();
		diasAvisoPrevioController.dispose();
		pensaoAlimenticiaController.dispose();
		pensaoAlimenticiaFgtsController.dispose();
		fgtsValorRescisaoController.dispose();
		fgtsSaldoBancoController.dispose();
		fgtsComplementoSaldoController.dispose();
		fgtsCodigoAfastamentoController.dispose();
		fgtsCodigoSaqueController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}