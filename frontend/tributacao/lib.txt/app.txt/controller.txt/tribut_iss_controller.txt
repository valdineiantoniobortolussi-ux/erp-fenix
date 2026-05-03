import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/controller/controller_imports.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/page/grid_columns/grid_columns_imports.dart';
import 'package:tributacao/app/mixin/controller_base_mixin.dart';

import 'package:tributacao/app/routes/app_routes.dart';
import 'package:tributacao/app/data/repository/tribut_iss_repository.dart';
import 'package:tributacao/app/page/shared_page/shared_page_imports.dart';
import 'package:tributacao/app/page/shared_widget/message_dialog.dart';

class TributIssController extends GetxController with ControllerBaseMixin {
  final TributIssRepository tributIssRepository;
  TributIssController({required this.tributIssRepository});

  // general
  final _dbColumns = TributIssModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = TributIssModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = tributIssGridColumns();
  
  var _tributIssModelList = <TributIssModel>[];

  final _tributIssModel = TributIssModel().obs;
  TributIssModel get tributIssModel => _tributIssModel.value;
  set tributIssModel(value) => _tributIssModel.value = value ?? TributIssModel();

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
    for (var tributIssModel in _tributIssModelList) {
      plutoRowList.add(_getPlutoRow(tributIssModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(TributIssModel tributIssModel) {
    return PlutoRow(
      cells: _getPlutoCells(tributIssModel: tributIssModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ TributIssModel? tributIssModel}) {
    return {
			"id": PlutoCell(value: tributIssModel?.id ?? 0),
			"tributOperacaoFiscal": PlutoCell(value: tributIssModel?.tributOperacaoFiscalModel?.descricao ?? ''),
			"modalidadeBaseCalculo": PlutoCell(value: tributIssModel?.modalidadeBaseCalculo ?? ''),
			"codigoTributacao": PlutoCell(value: tributIssModel?.codigoTributacao ?? ''),
			"itemListaServico": PlutoCell(value: tributIssModel?.itemListaServico ?? 0),
			"porcentoBaseCalculo": PlutoCell(value: tributIssModel?.porcentoBaseCalculo ?? 0),
			"aliquotaPorcento": PlutoCell(value: tributIssModel?.aliquotaPorcento ?? 0),
			"aliquotaUnidade": PlutoCell(value: tributIssModel?.aliquotaUnidade ?? 0),
			"valorPrecoMaximo": PlutoCell(value: tributIssModel?.valorPrecoMaximo ?? 0),
			"valorPautaFiscal": PlutoCell(value: tributIssModel?.valorPautaFiscal ?? 0),
			"idTributOperacaoFiscal": PlutoCell(value: tributIssModel?.idTributOperacaoFiscal ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _tributIssModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      tributIssModel.plutoRowToObject(plutoRow);
    } else {
      tributIssModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tribut Iss]';
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
    await Get.find<TributIssController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await tributIssRepository.getList(filter: filter).then( (data){ _tributIssModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tribut Iss',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			tributOperacaoFiscalModelController.text = currentRow.cells['tributOperacaoFiscal']?.value ?? '';
			itemListaServicoController.text = currentRow.cells['itemListaServico']?.value?.toString() ?? '';
			porcentoBaseCalculoController.text = currentRow.cells['porcentoBaseCalculo']?.value?.toStringAsFixed(2) ?? '';
			aliquotaPorcentoController.text = currentRow.cells['aliquotaPorcento']?.value?.toStringAsFixed(2) ?? '';
			aliquotaUnidadeController.text = currentRow.cells['aliquotaUnidade']?.value?.toStringAsFixed(2) ?? '';
			valorPrecoMaximoController.text = currentRow.cells['valorPrecoMaximo']?.value?.toStringAsFixed(2) ?? '';
			valorPautaFiscalController.text = currentRow.cells['valorPautaFiscal']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.tributIssEditPage)!.then((value) {
        if (tributIssModel.id == 0) {
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
    tributIssModel = TributIssModel();
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
        if (await tributIssRepository.delete(id: currentRow.cells['id']!.value)) {
          _tributIssModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final tributOperacaoFiscalModelController = TextEditingController();
	final itemListaServicoController = TextEditingController();
	final porcentoBaseCalculoController = MoneyMaskedTextController();
	final aliquotaPorcentoController = MoneyMaskedTextController();
	final aliquotaUnidadeController = MoneyMaskedTextController();
	final valorPrecoMaximoController = MoneyMaskedTextController();
	final valorPautaFiscalController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = tributIssModel.id;
		plutoRow.cells['idTributOperacaoFiscal']?.value = tributIssModel.idTributOperacaoFiscal;
		plutoRow.cells['tributOperacaoFiscal']?.value = tributIssModel.tributOperacaoFiscalModel?.descricao;
		plutoRow.cells['modalidadeBaseCalculo']?.value = tributIssModel.modalidadeBaseCalculo;
		plutoRow.cells['codigoTributacao']?.value = tributIssModel.codigoTributacao;
		plutoRow.cells['itemListaServico']?.value = tributIssModel.itemListaServico;
		plutoRow.cells['porcentoBaseCalculo']?.value = tributIssModel.porcentoBaseCalculo;
		plutoRow.cells['aliquotaPorcento']?.value = tributIssModel.aliquotaPorcento;
		plutoRow.cells['aliquotaUnidade']?.value = tributIssModel.aliquotaUnidade;
		plutoRow.cells['valorPrecoMaximo']?.value = tributIssModel.valorPrecoMaximo;
		plutoRow.cells['valorPautaFiscal']?.value = tributIssModel.valorPautaFiscal;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await tributIssRepository.save(tributIssModel: tributIssModel); 
        if (result != null) {
          tributIssModel = result;
          if (_isInserting) {
            _tributIssModelList.add(result);
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

	Future callTributOperacaoFiscalLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tribut Operacao Fiscal]'; 
		lookupController.route = '/tribut-operacao-fiscal/'; 
		lookupController.gridColumns = tributOperacaoFiscalGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TributOperacaoFiscalModel.aliasColumns; 
		lookupController.dbColumns = TributOperacaoFiscalModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			tributIssModel.idTributOperacaoFiscal = plutoRowResult.cells['id']!.value; 
			tributIssModel.tributOperacaoFiscalModel!.plutoRowToObject(plutoRowResult); 
			tributOperacaoFiscalModelController.text = tributIssModel.tributOperacaoFiscalModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
    functionName = "TRIBUT_ISS";
    setPrivilege();    
    super.onInit();
  }

  @override
  void onClose() {
		tributOperacaoFiscalModelController.dispose();
		itemListaServicoController.dispose();
		porcentoBaseCalculoController.dispose();
		aliquotaPorcentoController.dispose();
		aliquotaUnidadeController.dispose();
		valorPrecoMaximoController.dispose();
		valorPautaFiscalController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}