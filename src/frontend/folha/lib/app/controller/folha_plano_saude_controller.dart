import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_plano_saude_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaPlanoSaudeController extends GetxController with ControllerBaseMixin {
  final FolhaPlanoSaudeRepository folhaPlanoSaudeRepository;
  FolhaPlanoSaudeController({required this.folhaPlanoSaudeRepository});

  // general
  final _dbColumns = FolhaPlanoSaudeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaPlanoSaudeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaPlanoSaudeGridColumns();
  
  var _folhaPlanoSaudeModelList = <FolhaPlanoSaudeModel>[];

  final _folhaPlanoSaudeModel = FolhaPlanoSaudeModel().obs;
  FolhaPlanoSaudeModel get folhaPlanoSaudeModel => _folhaPlanoSaudeModel.value;
  set folhaPlanoSaudeModel(value) => _folhaPlanoSaudeModel.value = value ?? FolhaPlanoSaudeModel();

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
    for (var folhaPlanoSaudeModel in _folhaPlanoSaudeModelList) {
      plutoRowList.add(_getPlutoRow(folhaPlanoSaudeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaPlanoSaudeModel folhaPlanoSaudeModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaPlanoSaudeModel: folhaPlanoSaudeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaPlanoSaudeModel? folhaPlanoSaudeModel}) {
    return {
			"id": PlutoCell(value: folhaPlanoSaudeModel?.id ?? 0),
			"operadoraPlanoSaude": PlutoCell(value: folhaPlanoSaudeModel?.operadoraPlanoSaudeModel?.nome ?? ''),
			"viewPessoaColaborador": PlutoCell(value: folhaPlanoSaudeModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataInicio": PlutoCell(value: folhaPlanoSaudeModel?.dataInicio ?? ''),
			"beneficiario": PlutoCell(value: folhaPlanoSaudeModel?.beneficiario ?? ''),
			"idOperadoraPlanoSaude": PlutoCell(value: folhaPlanoSaudeModel?.idOperadoraPlanoSaude ?? 0),
			"idColaborador": PlutoCell(value: folhaPlanoSaudeModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaPlanoSaudeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaPlanoSaudeModel.plutoRowToObject(plutoRow);
    } else {
      folhaPlanoSaudeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Plano de Saúde]';
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
    await Get.find<FolhaPlanoSaudeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaPlanoSaudeRepository.getList(filter: filter).then( (data){ _folhaPlanoSaudeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Plano de Saúde',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			operadoraPlanoSaudeModelController.text = currentRow.cells['operadoraPlanoSaude']?.value ?? '';
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaPlanoSaudeEditPage)!.then((value) {
        if (folhaPlanoSaudeModel.id == 0) {
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
    folhaPlanoSaudeModel = FolhaPlanoSaudeModel();
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
        if (await folhaPlanoSaudeRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaPlanoSaudeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final operadoraPlanoSaudeModelController = TextEditingController();
	final viewPessoaColaboradorModelController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaPlanoSaudeModel.id;
		plutoRow.cells['idOperadoraPlanoSaude']?.value = folhaPlanoSaudeModel.idOperadoraPlanoSaude;
		plutoRow.cells['operadoraPlanoSaude']?.value = folhaPlanoSaudeModel.operadoraPlanoSaudeModel?.nome;
		plutoRow.cells['idColaborador']?.value = folhaPlanoSaudeModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaPlanoSaudeModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(folhaPlanoSaudeModel.dataInicio);
		plutoRow.cells['beneficiario']?.value = folhaPlanoSaudeModel.beneficiario;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaPlanoSaudeRepository.save(folhaPlanoSaudeModel: folhaPlanoSaudeModel); 
        if (result != null) {
          folhaPlanoSaudeModel = result;
          if (_isInserting) {
            _folhaPlanoSaudeModelList.add(result);
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

	Future callOperadoraPlanoSaudeLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Operadora]'; 
		lookupController.route = '/operadora-plano-saude/'; 
		lookupController.gridColumns = operadoraPlanoSaudeGridColumns(isForLookup: true); 
		lookupController.aliasColumns = OperadoraPlanoSaudeModel.aliasColumns; 
		lookupController.dbColumns = OperadoraPlanoSaudeModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			folhaPlanoSaudeModel.idOperadoraPlanoSaude = plutoRowResult.cells['id']!.value; 
			folhaPlanoSaudeModel.operadoraPlanoSaudeModel!.plutoRowToObject(plutoRowResult); 
			operadoraPlanoSaudeModelController.text = folhaPlanoSaudeModel.operadoraPlanoSaudeModel?.nome ?? ''; 
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
			folhaPlanoSaudeModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaPlanoSaudeModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaPlanoSaudeModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "folha_plano_saude";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		operadoraPlanoSaudeModelController.dispose();
		viewPessoaColaboradorModelController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}