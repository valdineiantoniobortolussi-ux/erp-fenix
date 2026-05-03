import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/controller/controller_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/page/grid_columns/grid_columns_imports.dart';

import 'package:estoque/app/routes/app_routes.dart';
import 'package:estoque/app/data/repository/estoque_grade_repository.dart';
import 'package:estoque/app/page/shared_page/shared_page_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';
import 'package:estoque/app/mixin/controller_base_mixin.dart';

class EstoqueGradeController extends GetxController with ControllerBaseMixin {
  final EstoqueGradeRepository estoqueGradeRepository;
  EstoqueGradeController({required this.estoqueGradeRepository});

  // general
  final _dbColumns = EstoqueGradeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EstoqueGradeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = estoqueGradeGridColumns();
  
  var _estoqueGradeModelList = <EstoqueGradeModel>[];

  final _estoqueGradeModel = EstoqueGradeModel().obs;
  EstoqueGradeModel get estoqueGradeModel => _estoqueGradeModel.value;
  set estoqueGradeModel(value) => _estoqueGradeModel.value = value ?? EstoqueGradeModel();

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
    for (var estoqueGradeModel in _estoqueGradeModelList) {
      plutoRowList.add(_getPlutoRow(estoqueGradeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EstoqueGradeModel estoqueGradeModel) {
    return PlutoRow(
      cells: _getPlutoCells(estoqueGradeModel: estoqueGradeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EstoqueGradeModel? estoqueGradeModel}) {
    return {
			"id": PlutoCell(value: estoqueGradeModel?.id ?? 0),
			"produto": PlutoCell(value: estoqueGradeModel?.produtoModel?.nome ?? ''),
			"estoqueMarca": PlutoCell(value: estoqueGradeModel?.estoqueMarcaModel?.nome ?? ''),
			"estoqueSabor": PlutoCell(value: estoqueGradeModel?.estoqueSaborModel?.nome ?? ''),
			"estoqueTamanho": PlutoCell(value: estoqueGradeModel?.estoqueTamanhoModel?.nome ?? ''),
			"estoqueCor": PlutoCell(value: estoqueGradeModel?.estoqueCorModel?.nome ?? ''),
			"codigo": PlutoCell(value: estoqueGradeModel?.codigo ?? ''),
			"quantidade": PlutoCell(value: estoqueGradeModel?.quantidade ?? 0),
			"idProduto": PlutoCell(value: estoqueGradeModel?.idProduto ?? 0),
			"idEstoqueMarca": PlutoCell(value: estoqueGradeModel?.idEstoqueMarca ?? 0),
			"idEstoqueSabor": PlutoCell(value: estoqueGradeModel?.idEstoqueSabor ?? 0),
			"idEstoqueTamanho": PlutoCell(value: estoqueGradeModel?.idEstoqueTamanho ?? 0),
			"idEstoqueCor": PlutoCell(value: estoqueGradeModel?.idEstoqueCor ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _estoqueGradeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      estoqueGradeModel.plutoRowToObject(plutoRow);
    } else {
      estoqueGradeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Grade de Estoque]';
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
    await Get.find<EstoqueGradeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await estoqueGradeRepository.getList(filter: filter).then( (data){ _estoqueGradeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Grade de Estoque',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			estoqueMarcaModelController.text = currentRow.cells['estoqueMarca']?.value ?? '';
			estoqueSaborModelController.text = currentRow.cells['estoqueSabor']?.value ?? '';
			estoqueTamanhoModelController.text = currentRow.cells['estoqueTamanho']?.value ?? '';
			estoqueCorModelController.text = currentRow.cells['estoqueCor']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.estoqueGradeEditPage)!.then((value) {
        if (estoqueGradeModel.id == 0) {
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
    estoqueGradeModel = EstoqueGradeModel();
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
        if (await estoqueGradeRepository.delete(id: currentRow.cells['id']!.value)) {
          _estoqueGradeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final produtoModelController = TextEditingController();
	final estoqueMarcaModelController = TextEditingController();
	final estoqueSaborModelController = TextEditingController();
	final estoqueTamanhoModelController = TextEditingController();
	final estoqueCorModelController = TextEditingController();
	final codigoController = TextEditingController();
	final quantidadeController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = estoqueGradeModel.id;
		plutoRow.cells['idProduto']?.value = estoqueGradeModel.idProduto;
		plutoRow.cells['produto']?.value = estoqueGradeModel.produtoModel?.nome;
		plutoRow.cells['idEstoqueMarca']?.value = estoqueGradeModel.idEstoqueMarca;
		plutoRow.cells['estoqueMarca']?.value = estoqueGradeModel.estoqueMarcaModel?.nome;
		plutoRow.cells['idEstoqueSabor']?.value = estoqueGradeModel.idEstoqueSabor;
		plutoRow.cells['estoqueSabor']?.value = estoqueGradeModel.estoqueSaborModel?.nome;
		plutoRow.cells['idEstoqueTamanho']?.value = estoqueGradeModel.idEstoqueTamanho;
		plutoRow.cells['estoqueTamanho']?.value = estoqueGradeModel.estoqueTamanhoModel?.nome;
		plutoRow.cells['idEstoqueCor']?.value = estoqueGradeModel.idEstoqueCor;
		plutoRow.cells['estoqueCor']?.value = estoqueGradeModel.estoqueCorModel?.nome;
		plutoRow.cells['codigo']?.value = estoqueGradeModel.codigo;
		plutoRow.cells['quantidade']?.value = estoqueGradeModel.quantidade;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await estoqueGradeRepository.save(estoqueGradeModel: estoqueGradeModel); 
        if (result != null) {
          estoqueGradeModel = result;
          if (_isInserting) {
            _estoqueGradeModelList.add(result);
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

	Future callProdutoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Produto]'; 
		lookupController.route = '/produto/'; 
		lookupController.gridColumns = produtoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoModel.aliasColumns; 
		lookupController.dbColumns = ProdutoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			estoqueGradeModel.idProduto = plutoRowResult.cells['id']!.value; 
			estoqueGradeModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = estoqueGradeModel.produtoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callEstoqueMarcaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Marca]'; 
		lookupController.route = '/estoque-marca/'; 
		lookupController.gridColumns = estoqueMarcaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = EstoqueMarcaModel.aliasColumns; 
		lookupController.dbColumns = EstoqueMarcaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			estoqueGradeModel.idEstoqueMarca = plutoRowResult.cells['id']!.value; 
			estoqueGradeModel.estoqueMarcaModel!.plutoRowToObject(plutoRowResult); 
			estoqueMarcaModelController.text = estoqueGradeModel.estoqueMarcaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callEstoqueSaborLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Sabor]'; 
		lookupController.route = '/estoque-sabor/'; 
		lookupController.gridColumns = estoqueSaborGridColumns(isForLookup: true); 
		lookupController.aliasColumns = EstoqueSaborModel.aliasColumns; 
		lookupController.dbColumns = EstoqueSaborModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			estoqueGradeModel.idEstoqueSabor = plutoRowResult.cells['id']!.value; 
			estoqueGradeModel.estoqueSaborModel!.plutoRowToObject(plutoRowResult); 
			estoqueSaborModelController.text = estoqueGradeModel.estoqueSaborModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callEstoqueTamanhoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tamanho]'; 
		lookupController.route = '/estoque-tamanho/'; 
		lookupController.gridColumns = estoqueTamanhoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = EstoqueTamanhoModel.aliasColumns; 
		lookupController.dbColumns = EstoqueTamanhoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			estoqueGradeModel.idEstoqueTamanho = plutoRowResult.cells['id']!.value; 
			estoqueGradeModel.estoqueTamanhoModel!.plutoRowToObject(plutoRowResult); 
			estoqueTamanhoModelController.text = estoqueGradeModel.estoqueTamanhoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callEstoqueCorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Cor]'; 
		lookupController.route = '/estoque-cor/'; 
		lookupController.gridColumns = estoqueCorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = EstoqueCorModel.aliasColumns; 
		lookupController.dbColumns = EstoqueCorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			estoqueGradeModel.idEstoqueCor = plutoRowResult.cells['id']!.value; 
			estoqueGradeModel.estoqueCorModel!.plutoRowToObject(plutoRowResult); 
			estoqueCorModelController.text = estoqueGradeModel.estoqueCorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "estoque_grade";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		produtoModelController.dispose();
		estoqueMarcaModelController.dispose();
		estoqueSaborModelController.dispose();
		estoqueTamanhoModelController.dispose();
		estoqueCorModelController.dispose();
		codigoController.dispose();
		quantidadeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}