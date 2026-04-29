import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/fin_configuracao_boleto_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinConfiguracaoBoletoController extends GetxController with ControllerBaseMixin {
  final FinConfiguracaoBoletoRepository finConfiguracaoBoletoRepository;
  FinConfiguracaoBoletoController({required this.finConfiguracaoBoletoRepository});

  // general
  final _dbColumns = FinConfiguracaoBoletoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinConfiguracaoBoletoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finConfiguracaoBoletoGridColumns();
  
  var _finConfiguracaoBoletoModelList = <FinConfiguracaoBoletoModel>[];

  final _finConfiguracaoBoletoModel = FinConfiguracaoBoletoModel().obs;
  FinConfiguracaoBoletoModel get finConfiguracaoBoletoModel => _finConfiguracaoBoletoModel.value;
  set finConfiguracaoBoletoModel(value) => _finConfiguracaoBoletoModel.value = value ?? FinConfiguracaoBoletoModel();

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
    for (var finConfiguracaoBoletoModel in _finConfiguracaoBoletoModelList) {
      plutoRowList.add(_getPlutoRow(finConfiguracaoBoletoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinConfiguracaoBoletoModel finConfiguracaoBoletoModel) {
    return PlutoRow(
      cells: _getPlutoCells(finConfiguracaoBoletoModel: finConfiguracaoBoletoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinConfiguracaoBoletoModel? finConfiguracaoBoletoModel}) {
    return {
			"id": PlutoCell(value: finConfiguracaoBoletoModel?.id ?? 0),
			"bancoContaCaixa": PlutoCell(value: finConfiguracaoBoletoModel?.bancoContaCaixaModel?.nome ?? ''),
			"instrucao01": PlutoCell(value: finConfiguracaoBoletoModel?.instrucao01 ?? ''),
			"instrucao02": PlutoCell(value: finConfiguracaoBoletoModel?.instrucao02 ?? ''),
			"caminhoArquivoRemessa": PlutoCell(value: finConfiguracaoBoletoModel?.caminhoArquivoRemessa ?? ''),
			"caminhoArquivoRetorno": PlutoCell(value: finConfiguracaoBoletoModel?.caminhoArquivoRetorno ?? ''),
			"caminhoArquivoLogotipo": PlutoCell(value: finConfiguracaoBoletoModel?.caminhoArquivoLogotipo ?? ''),
			"caminhoArquivoPdf": PlutoCell(value: finConfiguracaoBoletoModel?.caminhoArquivoPdf ?? ''),
			"mensagem": PlutoCell(value: finConfiguracaoBoletoModel?.mensagem ?? ''),
			"localPagamento": PlutoCell(value: finConfiguracaoBoletoModel?.localPagamento ?? ''),
			"layoutRemessa": PlutoCell(value: finConfiguracaoBoletoModel?.layoutRemessa ?? ''),
			"aceite": PlutoCell(value: finConfiguracaoBoletoModel?.aceite ?? ''),
			"especie": PlutoCell(value: finConfiguracaoBoletoModel?.especie ?? ''),
			"carteira": PlutoCell(value: finConfiguracaoBoletoModel?.carteira ?? ''),
			"codigoConvenio": PlutoCell(value: finConfiguracaoBoletoModel?.codigoConvenio ?? ''),
			"codigoCedente": PlutoCell(value: finConfiguracaoBoletoModel?.codigoCedente ?? ''),
			"taxaMulta": PlutoCell(value: finConfiguracaoBoletoModel?.taxaMulta ?? 0),
			"taxaJuro": PlutoCell(value: finConfiguracaoBoletoModel?.taxaJuro ?? 0),
			"diasProtesto": PlutoCell(value: finConfiguracaoBoletoModel?.diasProtesto ?? 0),
			"nossoNumeroAnterior": PlutoCell(value: finConfiguracaoBoletoModel?.nossoNumeroAnterior ?? ''),
			"idBancoContaCaixa": PlutoCell(value: finConfiguracaoBoletoModel?.idBancoContaCaixa ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finConfiguracaoBoletoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finConfiguracaoBoletoModel.plutoRowToObject(plutoRow);
    } else {
      finConfiguracaoBoletoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Configuracões Boleto]';
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
    await Get.find<FinConfiguracaoBoletoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finConfiguracaoBoletoRepository.getList(filter: filter).then( (data){ _finConfiguracaoBoletoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Configuracões Boleto',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			bancoContaCaixaModelController.text = currentRow.cells['bancoContaCaixa']?.value ?? '';
			instrucao01Controller.text = currentRow.cells['instrucao01']?.value ?? '';
			instrucao02Controller.text = currentRow.cells['instrucao02']?.value ?? '';
			caminhoArquivoRemessaController.text = currentRow.cells['caminhoArquivoRemessa']?.value ?? '';
			caminhoArquivoRetornoController.text = currentRow.cells['caminhoArquivoRetorno']?.value ?? '';
			caminhoArquivoLogotipoController.text = currentRow.cells['caminhoArquivoLogotipo']?.value ?? '';
			caminhoArquivoPdfController.text = currentRow.cells['caminhoArquivoPdf']?.value ?? '';
			mensagemController.text = currentRow.cells['mensagem']?.value ?? '';
			localPagamentoController.text = currentRow.cells['localPagamento']?.value ?? '';
			carteiraController.text = currentRow.cells['carteira']?.value ?? '';
			codigoConvenioController.text = currentRow.cells['codigoConvenio']?.value ?? '';
			codigoCedenteController.text = currentRow.cells['codigoCedente']?.value ?? '';
			taxaMultaController.text = currentRow.cells['taxaMulta']?.value?.toStringAsFixed(2) ?? '';
			taxaJuroController.text = currentRow.cells['taxaJuro']?.value?.toStringAsFixed(2) ?? '';
			diasProtestoController.text = currentRow.cells['diasProtesto']?.value?.toString() ?? '';
			nossoNumeroAnteriorController.text = currentRow.cells['nossoNumeroAnterior']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finConfiguracaoBoletoEditPage)!.then((value) {
        if (finConfiguracaoBoletoModel.id == 0) {
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
    finConfiguracaoBoletoModel = FinConfiguracaoBoletoModel();
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
        if (await finConfiguracaoBoletoRepository.delete(id: currentRow.cells['id']!.value)) {
          _finConfiguracaoBoletoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final bancoContaCaixaModelController = TextEditingController();
	final instrucao01Controller = TextEditingController();
	final instrucao02Controller = TextEditingController();
	final caminhoArquivoRemessaController = TextEditingController();
	final caminhoArquivoRetornoController = TextEditingController();
	final caminhoArquivoLogotipoController = TextEditingController();
	final caminhoArquivoPdfController = TextEditingController();
	final mensagemController = TextEditingController();
	final localPagamentoController = TextEditingController();
	final carteiraController = TextEditingController();
	final codigoConvenioController = TextEditingController();
	final codigoCedenteController = TextEditingController();
	final taxaMultaController = MoneyMaskedTextController();
	final taxaJuroController = MoneyMaskedTextController();
	final diasProtestoController = TextEditingController();
	final nossoNumeroAnteriorController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finConfiguracaoBoletoModel.id;
		plutoRow.cells['idBancoContaCaixa']?.value = finConfiguracaoBoletoModel.idBancoContaCaixa;
		plutoRow.cells['bancoContaCaixa']?.value = finConfiguracaoBoletoModel.bancoContaCaixaModel?.nome;
		plutoRow.cells['instrucao01']?.value = finConfiguracaoBoletoModel.instrucao01;
		plutoRow.cells['instrucao02']?.value = finConfiguracaoBoletoModel.instrucao02;
		plutoRow.cells['caminhoArquivoRemessa']?.value = finConfiguracaoBoletoModel.caminhoArquivoRemessa;
		plutoRow.cells['caminhoArquivoRetorno']?.value = finConfiguracaoBoletoModel.caminhoArquivoRetorno;
		plutoRow.cells['caminhoArquivoLogotipo']?.value = finConfiguracaoBoletoModel.caminhoArquivoLogotipo;
		plutoRow.cells['caminhoArquivoPdf']?.value = finConfiguracaoBoletoModel.caminhoArquivoPdf;
		plutoRow.cells['mensagem']?.value = finConfiguracaoBoletoModel.mensagem;
		plutoRow.cells['localPagamento']?.value = finConfiguracaoBoletoModel.localPagamento;
		plutoRow.cells['layoutRemessa']?.value = finConfiguracaoBoletoModel.layoutRemessa;
		plutoRow.cells['aceite']?.value = finConfiguracaoBoletoModel.aceite;
		plutoRow.cells['especie']?.value = finConfiguracaoBoletoModel.especie;
		plutoRow.cells['carteira']?.value = finConfiguracaoBoletoModel.carteira;
		plutoRow.cells['codigoConvenio']?.value = finConfiguracaoBoletoModel.codigoConvenio;
		plutoRow.cells['codigoCedente']?.value = finConfiguracaoBoletoModel.codigoCedente;
		plutoRow.cells['taxaMulta']?.value = finConfiguracaoBoletoModel.taxaMulta;
		plutoRow.cells['taxaJuro']?.value = finConfiguracaoBoletoModel.taxaJuro;
		plutoRow.cells['diasProtesto']?.value = finConfiguracaoBoletoModel.diasProtesto;
		plutoRow.cells['nossoNumeroAnterior']?.value = finConfiguracaoBoletoModel.nossoNumeroAnterior;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finConfiguracaoBoletoRepository.save(finConfiguracaoBoletoModel: finConfiguracaoBoletoModel); 
        if (result != null) {
          finConfiguracaoBoletoModel = result;
          if (_isInserting) {
            _finConfiguracaoBoletoModelList.add(result);
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

	Future callBancoContaCaixaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Conta/Caixa]'; 
		lookupController.route = '/banco-conta-caixa/'; 
		lookupController.gridColumns = bancoContaCaixaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = BancoContaCaixaModel.aliasColumns; 
		lookupController.dbColumns = BancoContaCaixaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finConfiguracaoBoletoModel.idBancoContaCaixa = plutoRowResult.cells['id']!.value; 
			finConfiguracaoBoletoModel.bancoContaCaixaModel!.plutoRowToObject(plutoRowResult); 
			bancoContaCaixaModelController.text = finConfiguracaoBoletoModel.bancoContaCaixaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "fin_configuracao_boleto";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		bancoContaCaixaModelController.dispose();
		instrucao01Controller.dispose();
		instrucao02Controller.dispose();
		caminhoArquivoRemessaController.dispose();
		caminhoArquivoRetornoController.dispose();
		caminhoArquivoLogotipoController.dispose();
		caminhoArquivoPdfController.dispose();
		mensagemController.dispose();
		localPagamentoController.dispose();
		carteiraController.dispose();
		codigoConvenioController.dispose();
		codigoCedenteController.dispose();
		taxaMultaController.dispose();
		taxaJuroController.dispose();
		diasProtestoController.dispose();
		nossoNumeroAnteriorController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}