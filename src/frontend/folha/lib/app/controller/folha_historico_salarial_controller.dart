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
import 'package:folha/app/data/repository/folha_historico_salarial_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaHistoricoSalarialController extends GetxController with ControllerBaseMixin {
  final FolhaHistoricoSalarialRepository folhaHistoricoSalarialRepository;
  FolhaHistoricoSalarialController({required this.folhaHistoricoSalarialRepository});

  // general
  final _dbColumns = FolhaHistoricoSalarialModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaHistoricoSalarialModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaHistoricoSalarialGridColumns();
  
  var _folhaHistoricoSalarialModelList = <FolhaHistoricoSalarialModel>[];

  final _folhaHistoricoSalarialModel = FolhaHistoricoSalarialModel().obs;
  FolhaHistoricoSalarialModel get folhaHistoricoSalarialModel => _folhaHistoricoSalarialModel.value;
  set folhaHistoricoSalarialModel(value) => _folhaHistoricoSalarialModel.value = value ?? FolhaHistoricoSalarialModel();

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
    for (var folhaHistoricoSalarialModel in _folhaHistoricoSalarialModelList) {
      plutoRowList.add(_getPlutoRow(folhaHistoricoSalarialModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaHistoricoSalarialModel folhaHistoricoSalarialModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaHistoricoSalarialModel: folhaHistoricoSalarialModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaHistoricoSalarialModel? folhaHistoricoSalarialModel}) {
    return {
			"id": PlutoCell(value: folhaHistoricoSalarialModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: folhaHistoricoSalarialModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"competencia": PlutoCell(value: folhaHistoricoSalarialModel?.competencia ?? ''),
			"salarioAtual": PlutoCell(value: folhaHistoricoSalarialModel?.salarioAtual ?? 0),
			"percentualAumento": PlutoCell(value: folhaHistoricoSalarialModel?.percentualAumento ?? 0),
			"salarioNovo": PlutoCell(value: folhaHistoricoSalarialModel?.salarioNovo ?? 0),
			"validoAPartir": PlutoCell(value: folhaHistoricoSalarialModel?.validoAPartir ?? ''),
			"motivo": PlutoCell(value: folhaHistoricoSalarialModel?.motivo ?? ''),
			"idColaborador": PlutoCell(value: folhaHistoricoSalarialModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaHistoricoSalarialModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaHistoricoSalarialModel.plutoRowToObject(plutoRow);
    } else {
      folhaHistoricoSalarialModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Histórico Salarial]';
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
    await Get.find<FolhaHistoricoSalarialController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaHistoricoSalarialRepository.getList(filter: filter).then( (data){ _folhaHistoricoSalarialModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Histórico Salarial',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			salarioAtualController.text = currentRow.cells['salarioAtual']?.value?.toStringAsFixed(2) ?? '';
			percentualAumentoController.text = currentRow.cells['percentualAumento']?.value?.toStringAsFixed(2) ?? '';
			salarioNovoController.text = currentRow.cells['salarioNovo']?.value?.toStringAsFixed(2) ?? '';
			validoAPartirController.text = currentRow.cells['validoAPartir']?.value ?? '';
			motivoController.text = currentRow.cells['motivo']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaHistoricoSalarialEditPage)!.then((value) {
        if (folhaHistoricoSalarialModel.id == 0) {
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
    folhaHistoricoSalarialModel = FolhaHistoricoSalarialModel();
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
        if (await folhaHistoricoSalarialRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaHistoricoSalarialModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final competenciaController = MaskedTextController(mask: '00/0000',);
	final salarioAtualController = MoneyMaskedTextController();
	final percentualAumentoController = MoneyMaskedTextController();
	final salarioNovoController = MoneyMaskedTextController();
	final validoAPartirController = MaskedTextController(mask: '00/0000',);
	final motivoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaHistoricoSalarialModel.id;
		plutoRow.cells['idColaborador']?.value = folhaHistoricoSalarialModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaHistoricoSalarialModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['competencia']?.value = folhaHistoricoSalarialModel.competencia;
		plutoRow.cells['salarioAtual']?.value = folhaHistoricoSalarialModel.salarioAtual;
		plutoRow.cells['percentualAumento']?.value = folhaHistoricoSalarialModel.percentualAumento;
		plutoRow.cells['salarioNovo']?.value = folhaHistoricoSalarialModel.salarioNovo;
		plutoRow.cells['validoAPartir']?.value = folhaHistoricoSalarialModel.validoAPartir;
		plutoRow.cells['motivo']?.value = folhaHistoricoSalarialModel.motivo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaHistoricoSalarialRepository.save(folhaHistoricoSalarialModel: folhaHistoricoSalarialModel); 
        if (result != null) {
          folhaHistoricoSalarialModel = result;
          if (_isInserting) {
            _folhaHistoricoSalarialModelList.add(result);
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
			folhaHistoricoSalarialModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaHistoricoSalarialModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaHistoricoSalarialModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "folha_historico_salarial";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
		competenciaController.dispose();
		salarioAtualController.dispose();
		percentualAumentoController.dispose();
		salarioNovoController.dispose();
		validoAPartirController.dispose();
		motivoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}