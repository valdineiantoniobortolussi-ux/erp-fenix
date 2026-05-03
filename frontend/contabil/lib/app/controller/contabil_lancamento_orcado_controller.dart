import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_lancamento_orcado_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilLancamentoOrcadoController extends GetxController with ControllerBaseMixin {
  final ContabilLancamentoOrcadoRepository contabilLancamentoOrcadoRepository;
  ContabilLancamentoOrcadoController({required this.contabilLancamentoOrcadoRepository});

  // general
  final _dbColumns = ContabilLancamentoOrcadoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilLancamentoOrcadoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilLancamentoOrcadoGridColumns();
  
  var _contabilLancamentoOrcadoModelList = <ContabilLancamentoOrcadoModel>[];

  final _contabilLancamentoOrcadoModel = ContabilLancamentoOrcadoModel().obs;
  ContabilLancamentoOrcadoModel get contabilLancamentoOrcadoModel => _contabilLancamentoOrcadoModel.value;
  set contabilLancamentoOrcadoModel(value) => _contabilLancamentoOrcadoModel.value = value ?? ContabilLancamentoOrcadoModel();

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
    for (var contabilLancamentoOrcadoModel in _contabilLancamentoOrcadoModelList) {
      plutoRowList.add(_getPlutoRow(contabilLancamentoOrcadoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilLancamentoOrcadoModel contabilLancamentoOrcadoModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilLancamentoOrcadoModel: contabilLancamentoOrcadoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilLancamentoOrcadoModel? contabilLancamentoOrcadoModel}) {
    return {
			"id": PlutoCell(value: contabilLancamentoOrcadoModel?.id ?? 0),
			"contabilConta": PlutoCell(value: contabilLancamentoOrcadoModel?.contabilContaModel?.descricao ?? ''),
			"ano": PlutoCell(value: contabilLancamentoOrcadoModel?.ano ?? ''),
			"janeiro": PlutoCell(value: contabilLancamentoOrcadoModel?.janeiro ?? 0),
			"fevereiro": PlutoCell(value: contabilLancamentoOrcadoModel?.fevereiro ?? 0),
			"marco": PlutoCell(value: contabilLancamentoOrcadoModel?.marco ?? 0),
			"abril": PlutoCell(value: contabilLancamentoOrcadoModel?.abril ?? 0),
			"maio": PlutoCell(value: contabilLancamentoOrcadoModel?.maio ?? 0),
			"junho": PlutoCell(value: contabilLancamentoOrcadoModel?.junho ?? 0),
			"julho": PlutoCell(value: contabilLancamentoOrcadoModel?.julho ?? 0),
			"agosto": PlutoCell(value: contabilLancamentoOrcadoModel?.agosto ?? 0),
			"setembro": PlutoCell(value: contabilLancamentoOrcadoModel?.setembro ?? 0),
			"outubro": PlutoCell(value: contabilLancamentoOrcadoModel?.outubro ?? 0),
			"novembro": PlutoCell(value: contabilLancamentoOrcadoModel?.novembro ?? 0),
			"dezembro": PlutoCell(value: contabilLancamentoOrcadoModel?.dezembro ?? 0),
			"idContabilConta": PlutoCell(value: contabilLancamentoOrcadoModel?.idContabilConta ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilLancamentoOrcadoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilLancamentoOrcadoModel.plutoRowToObject(plutoRow);
    } else {
      contabilLancamentoOrcadoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Lançamento Orcado]';
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
    await Get.find<ContabilLancamentoOrcadoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilLancamentoOrcadoRepository.getList(filter: filter).then( (data){ _contabilLancamentoOrcadoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Lançamento Orcado',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			contabilContaModelController.text = currentRow.cells['contabilConta']?.value ?? '';
			anoController.text = currentRow.cells['ano']?.value ?? '';
			janeiroController.text = currentRow.cells['janeiro']?.value?.toStringAsFixed(2) ?? '';
			fevereiroController.text = currentRow.cells['fevereiro']?.value?.toStringAsFixed(2) ?? '';
			marcoController.text = currentRow.cells['marco']?.value?.toStringAsFixed(2) ?? '';
			abrilController.text = currentRow.cells['abril']?.value?.toStringAsFixed(2) ?? '';
			maioController.text = currentRow.cells['maio']?.value?.toStringAsFixed(2) ?? '';
			junhoController.text = currentRow.cells['junho']?.value?.toStringAsFixed(2) ?? '';
			julhoController.text = currentRow.cells['julho']?.value?.toStringAsFixed(2) ?? '';
			agostoController.text = currentRow.cells['agosto']?.value?.toStringAsFixed(2) ?? '';
			setembroController.text = currentRow.cells['setembro']?.value?.toStringAsFixed(2) ?? '';
			outubroController.text = currentRow.cells['outubro']?.value?.toStringAsFixed(2) ?? '';
			novembroController.text = currentRow.cells['novembro']?.value?.toStringAsFixed(2) ?? '';
			dezembroController.text = currentRow.cells['dezembro']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilLancamentoOrcadoEditPage)!.then((value) {
        if (contabilLancamentoOrcadoModel.id == 0) {
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
    contabilLancamentoOrcadoModel = ContabilLancamentoOrcadoModel();
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
        if (await contabilLancamentoOrcadoRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilLancamentoOrcadoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final contabilContaModelController = TextEditingController();
	final anoController = TextEditingController();
	final janeiroController = MoneyMaskedTextController();
	final fevereiroController = MoneyMaskedTextController();
	final marcoController = MoneyMaskedTextController();
	final abrilController = MoneyMaskedTextController();
	final maioController = MoneyMaskedTextController();
	final junhoController = MoneyMaskedTextController();
	final julhoController = MoneyMaskedTextController();
	final agostoController = MoneyMaskedTextController();
	final setembroController = MoneyMaskedTextController();
	final outubroController = MoneyMaskedTextController();
	final novembroController = MoneyMaskedTextController();
	final dezembroController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilLancamentoOrcadoModel.id;
		plutoRow.cells['idContabilConta']?.value = contabilLancamentoOrcadoModel.idContabilConta;
		plutoRow.cells['contabilConta']?.value = contabilLancamentoOrcadoModel.contabilContaModel?.descricao;
		plutoRow.cells['ano']?.value = contabilLancamentoOrcadoModel.ano;
		plutoRow.cells['janeiro']?.value = contabilLancamentoOrcadoModel.janeiro;
		plutoRow.cells['fevereiro']?.value = contabilLancamentoOrcadoModel.fevereiro;
		plutoRow.cells['marco']?.value = contabilLancamentoOrcadoModel.marco;
		plutoRow.cells['abril']?.value = contabilLancamentoOrcadoModel.abril;
		plutoRow.cells['maio']?.value = contabilLancamentoOrcadoModel.maio;
		plutoRow.cells['junho']?.value = contabilLancamentoOrcadoModel.junho;
		plutoRow.cells['julho']?.value = contabilLancamentoOrcadoModel.julho;
		plutoRow.cells['agosto']?.value = contabilLancamentoOrcadoModel.agosto;
		plutoRow.cells['setembro']?.value = contabilLancamentoOrcadoModel.setembro;
		plutoRow.cells['outubro']?.value = contabilLancamentoOrcadoModel.outubro;
		plutoRow.cells['novembro']?.value = contabilLancamentoOrcadoModel.novembro;
		plutoRow.cells['dezembro']?.value = contabilLancamentoOrcadoModel.dezembro;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilLancamentoOrcadoRepository.save(contabilLancamentoOrcadoModel: contabilLancamentoOrcadoModel); 
        if (result != null) {
          contabilLancamentoOrcadoModel = result;
          if (_isInserting) {
            _contabilLancamentoOrcadoModelList.add(result);
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

	Future callContabilContaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Conta Contabil]'; 
		lookupController.route = '/contabil-conta/'; 
		lookupController.gridColumns = contabilContaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContabilContaModel.aliasColumns; 
		lookupController.dbColumns = ContabilContaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilLancamentoOrcadoModel.idContabilConta = plutoRowResult.cells['id']!.value; 
			contabilLancamentoOrcadoModel.contabilContaModel!.plutoRowToObject(plutoRowResult); 
			contabilContaModelController.text = contabilLancamentoOrcadoModel.contabilContaModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "contabil_lancamento_orcado";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		contabilContaModelController.dispose();
		anoController.dispose();
		janeiroController.dispose();
		fevereiroController.dispose();
		marcoController.dispose();
		abrilController.dispose();
		maioController.dispose();
		junhoController.dispose();
		julhoController.dispose();
		agostoController.dispose();
		setembroController.dispose();
		outubroController.dispose();
		novembroController.dispose();
		dezembroController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}