import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/controller/controller_imports.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/page/grid_columns/grid_columns_imports.dart';

import 'package:orcamentos/app/routes/app_routes.dart';
import 'package:orcamentos/app/data/repository/orcamento_fluxo_caixa_periodo_repository.dart';
import 'package:orcamentos/app/page/shared_page/shared_page_imports.dart';
import 'package:orcamentos/app/page/shared_widget/message_dialog.dart';
import 'package:orcamentos/app/mixin/controller_base_mixin.dart';

class OrcamentoFluxoCaixaPeriodoController extends GetxController with ControllerBaseMixin {
  final OrcamentoFluxoCaixaPeriodoRepository orcamentoFluxoCaixaPeriodoRepository;
  OrcamentoFluxoCaixaPeriodoController({required this.orcamentoFluxoCaixaPeriodoRepository});

  // general
  final _dbColumns = OrcamentoFluxoCaixaPeriodoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = OrcamentoFluxoCaixaPeriodoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = orcamentoFluxoCaixaPeriodoGridColumns();
  
  var _orcamentoFluxoCaixaPeriodoModelList = <OrcamentoFluxoCaixaPeriodoModel>[];

  final _orcamentoFluxoCaixaPeriodoModel = OrcamentoFluxoCaixaPeriodoModel().obs;
  OrcamentoFluxoCaixaPeriodoModel get orcamentoFluxoCaixaPeriodoModel => _orcamentoFluxoCaixaPeriodoModel.value;
  set orcamentoFluxoCaixaPeriodoModel(value) => _orcamentoFluxoCaixaPeriodoModel.value = value ?? OrcamentoFluxoCaixaPeriodoModel();

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
    for (var orcamentoFluxoCaixaPeriodoModel in _orcamentoFluxoCaixaPeriodoModelList) {
      plutoRowList.add(_getPlutoRow(orcamentoFluxoCaixaPeriodoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(OrcamentoFluxoCaixaPeriodoModel orcamentoFluxoCaixaPeriodoModel) {
    return PlutoRow(
      cells: _getPlutoCells(orcamentoFluxoCaixaPeriodoModel: orcamentoFluxoCaixaPeriodoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ OrcamentoFluxoCaixaPeriodoModel? orcamentoFluxoCaixaPeriodoModel}) {
    return {
			"id": PlutoCell(value: orcamentoFluxoCaixaPeriodoModel?.id ?? 0),
			"bancoContaCaixa": PlutoCell(value: orcamentoFluxoCaixaPeriodoModel?.bancoContaCaixaModel?.nome ?? ''),
			"periodo": PlutoCell(value: orcamentoFluxoCaixaPeriodoModel?.periodo ?? ''),
			"nome": PlutoCell(value: orcamentoFluxoCaixaPeriodoModel?.nome ?? ''),
			"idBancoContaCaixa": PlutoCell(value: orcamentoFluxoCaixaPeriodoModel?.idBancoContaCaixa ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _orcamentoFluxoCaixaPeriodoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      orcamentoFluxoCaixaPeriodoModel.plutoRowToObject(plutoRow);
    } else {
      orcamentoFluxoCaixaPeriodoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Períodos - Fluxo de Caixa]';
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
    await Get.find<OrcamentoFluxoCaixaPeriodoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await orcamentoFluxoCaixaPeriodoRepository.getList(filter: filter).then( (data){ _orcamentoFluxoCaixaPeriodoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Períodos - Fluxo de Caixa',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			bancoContaCaixaModelController.text = currentRow.cells['bancoContaCaixa']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.orcamentoFluxoCaixaPeriodoEditPage)!.then((value) {
        if (orcamentoFluxoCaixaPeriodoModel.id == 0) {
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
    orcamentoFluxoCaixaPeriodoModel = OrcamentoFluxoCaixaPeriodoModel();
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
        if (await orcamentoFluxoCaixaPeriodoRepository.delete(id: currentRow.cells['id']!.value)) {
          _orcamentoFluxoCaixaPeriodoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = orcamentoFluxoCaixaPeriodoModel.id;
		plutoRow.cells['idBancoContaCaixa']?.value = orcamentoFluxoCaixaPeriodoModel.idBancoContaCaixa;
		plutoRow.cells['bancoContaCaixa']?.value = orcamentoFluxoCaixaPeriodoModel.bancoContaCaixaModel?.nome;
		plutoRow.cells['periodo']?.value = orcamentoFluxoCaixaPeriodoModel.periodo;
		plutoRow.cells['nome']?.value = orcamentoFluxoCaixaPeriodoModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await orcamentoFluxoCaixaPeriodoRepository.save(orcamentoFluxoCaixaPeriodoModel: orcamentoFluxoCaixaPeriodoModel); 
        if (result != null) {
          orcamentoFluxoCaixaPeriodoModel = result;
          if (_isInserting) {
            _orcamentoFluxoCaixaPeriodoModelList.add(result);
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
			orcamentoFluxoCaixaPeriodoModel.idBancoContaCaixa = plutoRowResult.cells['id']!.value; 
			orcamentoFluxoCaixaPeriodoModel.bancoContaCaixaModel!.plutoRowToObject(plutoRowResult); 
			bancoContaCaixaModelController.text = orcamentoFluxoCaixaPeriodoModel.bancoContaCaixaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "orcamento_fluxo_caixa_periodo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		bancoContaCaixaModelController.dispose();
		nomeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}