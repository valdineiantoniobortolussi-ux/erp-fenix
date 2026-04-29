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
import 'package:folha/app/data/repository/folha_lancamento_comissao_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaLancamentoComissaoController extends GetxController with ControllerBaseMixin {
  final FolhaLancamentoComissaoRepository folhaLancamentoComissaoRepository;
  FolhaLancamentoComissaoController({required this.folhaLancamentoComissaoRepository});

  // general
  final _dbColumns = FolhaLancamentoComissaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaLancamentoComissaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaLancamentoComissaoGridColumns();
  
  var _folhaLancamentoComissaoModelList = <FolhaLancamentoComissaoModel>[];

  final _folhaLancamentoComissaoModel = FolhaLancamentoComissaoModel().obs;
  FolhaLancamentoComissaoModel get folhaLancamentoComissaoModel => _folhaLancamentoComissaoModel.value;
  set folhaLancamentoComissaoModel(value) => _folhaLancamentoComissaoModel.value = value ?? FolhaLancamentoComissaoModel();

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
    for (var folhaLancamentoComissaoModel in _folhaLancamentoComissaoModelList) {
      plutoRowList.add(_getPlutoRow(folhaLancamentoComissaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaLancamentoComissaoModel folhaLancamentoComissaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaLancamentoComissaoModel: folhaLancamentoComissaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaLancamentoComissaoModel? folhaLancamentoComissaoModel}) {
    return {
			"id": PlutoCell(value: folhaLancamentoComissaoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: folhaLancamentoComissaoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"competencia": PlutoCell(value: folhaLancamentoComissaoModel?.competencia ?? ''),
			"vencimento": PlutoCell(value: folhaLancamentoComissaoModel?.vencimento ?? ''),
			"baseCalculo": PlutoCell(value: folhaLancamentoComissaoModel?.baseCalculo ?? 0),
			"valorComissao": PlutoCell(value: folhaLancamentoComissaoModel?.valorComissao ?? 0),
			"idColaborador": PlutoCell(value: folhaLancamentoComissaoModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaLancamentoComissaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaLancamentoComissaoModel.plutoRowToObject(plutoRow);
    } else {
      folhaLancamentoComissaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Comissões]';
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
    await Get.find<FolhaLancamentoComissaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaLancamentoComissaoRepository.getList(filter: filter).then( (data){ _folhaLancamentoComissaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Comissões',
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
			baseCalculoController.text = currentRow.cells['baseCalculo']?.value?.toStringAsFixed(2) ?? '';
			valorComissaoController.text = currentRow.cells['valorComissao']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaLancamentoComissaoEditPage)!.then((value) {
        if (folhaLancamentoComissaoModel.id == 0) {
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
    folhaLancamentoComissaoModel = FolhaLancamentoComissaoModel();
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
        if (await folhaLancamentoComissaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaLancamentoComissaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final baseCalculoController = MoneyMaskedTextController();
	final valorComissaoController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaLancamentoComissaoModel.id;
		plutoRow.cells['idColaborador']?.value = folhaLancamentoComissaoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = folhaLancamentoComissaoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['competencia']?.value = folhaLancamentoComissaoModel.competencia;
		plutoRow.cells['vencimento']?.value = Util.formatDate(folhaLancamentoComissaoModel.vencimento);
		plutoRow.cells['baseCalculo']?.value = folhaLancamentoComissaoModel.baseCalculo;
		plutoRow.cells['valorComissao']?.value = folhaLancamentoComissaoModel.valorComissao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaLancamentoComissaoRepository.save(folhaLancamentoComissaoModel: folhaLancamentoComissaoModel); 
        if (result != null) {
          folhaLancamentoComissaoModel = result;
          if (_isInserting) {
            _folhaLancamentoComissaoModelList.add(result);
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
			folhaLancamentoComissaoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			folhaLancamentoComissaoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = folhaLancamentoComissaoModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "folha_lancamento_comissao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
		competenciaController.dispose();
		baseCalculoController.dispose();
		valorComissaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}