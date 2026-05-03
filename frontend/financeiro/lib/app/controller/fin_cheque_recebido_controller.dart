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
import 'package:financeiro/app/data/repository/fin_cheque_recebido_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class FinChequeRecebidoController extends GetxController with ControllerBaseMixin {
  final FinChequeRecebidoRepository finChequeRecebidoRepository;
  FinChequeRecebidoController({required this.finChequeRecebidoRepository});

  // general
  final _dbColumns = FinChequeRecebidoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FinChequeRecebidoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = finChequeRecebidoGridColumns();
  
  var _finChequeRecebidoModelList = <FinChequeRecebidoModel>[];

  final _finChequeRecebidoModel = FinChequeRecebidoModel().obs;
  FinChequeRecebidoModel get finChequeRecebidoModel => _finChequeRecebidoModel.value;
  set finChequeRecebidoModel(value) => _finChequeRecebidoModel.value = value ?? FinChequeRecebidoModel();

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
    for (var finChequeRecebidoModel in _finChequeRecebidoModelList) {
      plutoRowList.add(_getPlutoRow(finChequeRecebidoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FinChequeRecebidoModel finChequeRecebidoModel) {
    return PlutoRow(
      cells: _getPlutoCells(finChequeRecebidoModel: finChequeRecebidoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FinChequeRecebidoModel? finChequeRecebidoModel}) {
    return {
			"id": PlutoCell(value: finChequeRecebidoModel?.id ?? 0),
			"viewPessoaCliente": PlutoCell(value: finChequeRecebidoModel?.viewPessoaClienteModel?.nome ?? ''),
			"cpf": PlutoCell(value: finChequeRecebidoModel?.cpf ?? ''),
			"cnpj": PlutoCell(value: finChequeRecebidoModel?.cnpj ?? ''),
			"nome": PlutoCell(value: finChequeRecebidoModel?.nome ?? ''),
			"codigoBanco": PlutoCell(value: finChequeRecebidoModel?.codigoBanco ?? ''),
			"codigoAgencia": PlutoCell(value: finChequeRecebidoModel?.codigoAgencia ?? ''),
			"conta": PlutoCell(value: finChequeRecebidoModel?.conta ?? ''),
			"numero": PlutoCell(value: finChequeRecebidoModel?.numero ?? 0),
			"dataEmissao": PlutoCell(value: finChequeRecebidoModel?.dataEmissao ?? ''),
			"bomPara": PlutoCell(value: finChequeRecebidoModel?.bomPara ?? ''),
			"dataCompensacao": PlutoCell(value: finChequeRecebidoModel?.dataCompensacao ?? ''),
			"valor": PlutoCell(value: finChequeRecebidoModel?.valor ?? 0),
			"custodiaData": PlutoCell(value: finChequeRecebidoModel?.custodiaData ?? ''),
			"custodiaTarifa": PlutoCell(value: finChequeRecebidoModel?.custodiaTarifa ?? 0),
			"custodiaComissao": PlutoCell(value: finChequeRecebidoModel?.custodiaComissao ?? 0),
			"descontoData": PlutoCell(value: finChequeRecebidoModel?.descontoData ?? ''),
			"descontoTarifa": PlutoCell(value: finChequeRecebidoModel?.descontoTarifa ?? 0),
			"descontoComissao": PlutoCell(value: finChequeRecebidoModel?.descontoComissao ?? 0),
			"valorRecebido": PlutoCell(value: finChequeRecebidoModel?.valorRecebido ?? 0),
			"idCliente": PlutoCell(value: finChequeRecebidoModel?.idCliente ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _finChequeRecebidoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      finChequeRecebidoModel.plutoRowToObject(plutoRow);
    } else {
      finChequeRecebidoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cheque Recebido]';
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
    await Get.find<FinChequeRecebidoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await finChequeRecebidoRepository.getList(filter: filter).then( (data){ _finChequeRecebidoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cheque Recebido',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaClienteModelController.text = currentRow.cells['viewPessoaCliente']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			codigoBancoController.text = currentRow.cells['codigoBanco']?.value ?? '';
			codigoAgenciaController.text = currentRow.cells['codigoAgencia']?.value ?? '';
			contaController.text = currentRow.cells['conta']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			custodiaTarifaController.text = currentRow.cells['custodiaTarifa']?.value?.toStringAsFixed(2) ?? '';
			custodiaComissaoController.text = currentRow.cells['custodiaComissao']?.value?.toStringAsFixed(2) ?? '';
			descontoTarifaController.text = currentRow.cells['descontoTarifa']?.value?.toStringAsFixed(2) ?? '';
			descontoComissaoController.text = currentRow.cells['descontoComissao']?.value?.toStringAsFixed(2) ?? '';
			valorRecebidoController.text = currentRow.cells['valorRecebido']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.finChequeRecebidoEditPage)!.then((value) {
        if (finChequeRecebidoModel.id == 0) {
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
    finChequeRecebidoModel = FinChequeRecebidoModel();
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
        if (await finChequeRecebidoRepository.delete(id: currentRow.cells['id']!.value)) {
          _finChequeRecebidoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaClienteModelController = TextEditingController();
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final nomeController = TextEditingController();
	final codigoBancoController = TextEditingController();
	final codigoAgenciaController = TextEditingController();
	final contaController = TextEditingController();
	final numeroController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final custodiaTarifaController = MoneyMaskedTextController();
	final custodiaComissaoController = MoneyMaskedTextController();
	final descontoTarifaController = MoneyMaskedTextController();
	final descontoComissaoController = MoneyMaskedTextController();
	final valorRecebidoController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finChequeRecebidoModel.id;
		plutoRow.cells['idCliente']?.value = finChequeRecebidoModel.idCliente;
		plutoRow.cells['viewPessoaCliente']?.value = finChequeRecebidoModel.viewPessoaClienteModel?.nome;
		plutoRow.cells['cpf']?.value = finChequeRecebidoModel.cpf;
		plutoRow.cells['cnpj']?.value = finChequeRecebidoModel.cnpj;
		plutoRow.cells['nome']?.value = finChequeRecebidoModel.nome;
		plutoRow.cells['codigoBanco']?.value = finChequeRecebidoModel.codigoBanco;
		plutoRow.cells['codigoAgencia']?.value = finChequeRecebidoModel.codigoAgencia;
		plutoRow.cells['conta']?.value = finChequeRecebidoModel.conta;
		plutoRow.cells['numero']?.value = finChequeRecebidoModel.numero;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(finChequeRecebidoModel.dataEmissao);
		plutoRow.cells['bomPara']?.value = Util.formatDate(finChequeRecebidoModel.bomPara);
		plutoRow.cells['dataCompensacao']?.value = Util.formatDate(finChequeRecebidoModel.dataCompensacao);
		plutoRow.cells['valor']?.value = finChequeRecebidoModel.valor;
		plutoRow.cells['custodiaData']?.value = Util.formatDate(finChequeRecebidoModel.custodiaData);
		plutoRow.cells['custodiaTarifa']?.value = finChequeRecebidoModel.custodiaTarifa;
		plutoRow.cells['custodiaComissao']?.value = finChequeRecebidoModel.custodiaComissao;
		plutoRow.cells['descontoData']?.value = Util.formatDate(finChequeRecebidoModel.descontoData);
		plutoRow.cells['descontoTarifa']?.value = finChequeRecebidoModel.descontoTarifa;
		plutoRow.cells['descontoComissao']?.value = finChequeRecebidoModel.descontoComissao;
		plutoRow.cells['valorRecebido']?.value = finChequeRecebidoModel.valorRecebido;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await finChequeRecebidoRepository.save(finChequeRecebidoModel: finChequeRecebidoModel); 
        if (result != null) {
          finChequeRecebidoModel = result;
          if (_isInserting) {
            _finChequeRecebidoModelList.add(result);
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

	Future callViewPessoaClienteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Cliente]'; 
		lookupController.route = '/view-pessoa-cliente/'; 
		lookupController.gridColumns = viewPessoaClienteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaClienteModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaClienteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finChequeRecebidoModel.idCliente = plutoRowResult.cells['id']!.value; 
			finChequeRecebidoModel.viewPessoaClienteModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaClienteModelController.text = finChequeRecebidoModel.viewPessoaClienteModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "fin_cheque_recebido";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaClienteModelController.dispose();
		cpfController.dispose();
		cnpjController.dispose();
		nomeController.dispose();
		codigoBancoController.dispose();
		codigoAgenciaController.dispose();
		contaController.dispose();
		numeroController.dispose();
		valorController.dispose();
		custodiaTarifaController.dispose();
		custodiaComissaoController.dispose();
		descontoTarifaController.dispose();
		descontoComissaoController.dispose();
		valorRecebidoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}