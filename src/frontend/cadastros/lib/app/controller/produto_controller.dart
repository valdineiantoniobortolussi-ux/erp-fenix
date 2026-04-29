import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/produto_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class ProdutoController extends GetxController with ControllerBaseMixin {
  final ProdutoRepository produtoRepository;
  ProdutoController({required this.produtoRepository});

  // general
  final _dbColumns = ProdutoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ProdutoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = produtoGridColumns();
  
  var _produtoModelList = <ProdutoModel>[];

  final _produtoModel = ProdutoModel().obs;
  ProdutoModel get produtoModel => _produtoModel.value;
  set produtoModel(value) => _produtoModel.value = value ?? ProdutoModel();

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
    for (var produtoModel in _produtoModelList) {
      plutoRowList.add(_getPlutoRow(produtoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ProdutoModel produtoModel) {
    return PlutoRow(
      cells: _getPlutoCells(produtoModel: produtoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ProdutoModel? produtoModel}) {
    return {
			"id": PlutoCell(value: produtoModel?.id ?? 0),
			"produtoSubgrupo": PlutoCell(value: produtoModel?.produtoSubgrupoModel?.nome ?? ''),
			"produtoMarca": PlutoCell(value: produtoModel?.produtoMarcaModel?.nome ?? ''),
			"produtoUnidade": PlutoCell(value: produtoModel?.produtoUnidadeModel?.sigla ?? ''),
			"tributIcmsCustomCab": PlutoCell(value: produtoModel?.tributIcmsCustomCabModel?.descricao ?? ''),
			"tributGrupoTributario": PlutoCell(value: produtoModel?.tributGrupoTributarioModel?.descricao ?? ''),
			"nome": PlutoCell(value: produtoModel?.nome ?? ''),
			"descricao": PlutoCell(value: produtoModel?.descricao ?? ''),
			"gtin": PlutoCell(value: produtoModel?.gtin ?? ''),
			"codigoInterno": PlutoCell(value: produtoModel?.codigoInterno ?? ''),
			"valorCompra": PlutoCell(value: produtoModel?.valorCompra ?? 0),
			"valorVenda": PlutoCell(value: produtoModel?.valorVenda ?? 0),
			"codigoNcm": PlutoCell(value: produtoModel?.codigoNcm ?? ''),
			"dataCadastro": PlutoCell(value: produtoModel?.dataCadastro ?? ''),
			"estoqueMinimo": PlutoCell(value: produtoModel?.estoqueMinimo ?? 0),
			"estoqueMaximo": PlutoCell(value: produtoModel?.estoqueMaximo ?? 0),
			"quantidadeEstoque": PlutoCell(value: produtoModel?.quantidadeEstoque ?? 0),
			"idProdutoSubgrupo": PlutoCell(value: produtoModel?.idProdutoSubgrupo ?? 0),
			"idProdutoMarca": PlutoCell(value: produtoModel?.idProdutoMarca ?? 0),
			"idProdutoUnidade": PlutoCell(value: produtoModel?.idProdutoUnidade ?? 0),
			"idTributIcmsCustomCab": PlutoCell(value: produtoModel?.idTributIcmsCustomCab ?? 0),
			"idTributGrupoTributario": PlutoCell(value: produtoModel?.idTributGrupoTributario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _produtoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      produtoModel.plutoRowToObject(plutoRow);
    } else {
      produtoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Produto]';
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
    await Get.find<ProdutoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await produtoRepository.getList(filter: filter).then( (data){ _produtoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Produto',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			produtoSubgrupoModelController.text = currentRow.cells['produtoSubgrupo']?.value ?? '';
			produtoMarcaModelController.text = currentRow.cells['produtoMarca']?.value ?? '';
			produtoUnidadeModelController.text = currentRow.cells['produtoUnidade']?.value ?? '';
			tributIcmsCustomCabModelController.text = currentRow.cells['tributIcmsCustomCab']?.value ?? '';
			tributGrupoTributarioModelController.text = currentRow.cells['tributGrupoTributario']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			gtinController.text = currentRow.cells['gtin']?.value ?? '';
			codigoInternoController.text = currentRow.cells['codigoInterno']?.value ?? '';
			valorCompraController.text = currentRow.cells['valorCompra']?.value?.toStringAsFixed(2) ?? '';
			valorVendaController.text = currentRow.cells['valorVenda']?.value?.toStringAsFixed(2) ?? '';
			codigoNcmController.text = currentRow.cells['codigoNcm']?.value ?? '';
			estoqueMinimoController.text = currentRow.cells['estoqueMinimo']?.value?.toStringAsFixed(2) ?? '';
			estoqueMaximoController.text = currentRow.cells['estoqueMaximo']?.value?.toStringAsFixed(2) ?? '';
			quantidadeEstoqueController.text = currentRow.cells['quantidadeEstoque']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.produtoEditPage)!.then((value) {
        if (produtoModel.id == 0) {
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
    produtoModel = ProdutoModel();
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
        if (await produtoRepository.delete(id: currentRow.cells['id']!.value)) {
          _produtoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final produtoSubgrupoModelController = TextEditingController();
	final produtoMarcaModelController = TextEditingController();
	final produtoUnidadeModelController = TextEditingController();
	final tributIcmsCustomCabModelController = TextEditingController();
	final tributGrupoTributarioModelController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final gtinController = TextEditingController();
	final codigoInternoController = TextEditingController();
	final valorCompraController = MoneyMaskedTextController();
	final valorVendaController = MoneyMaskedTextController();
	final codigoNcmController = TextEditingController();
	final estoqueMinimoController = MoneyMaskedTextController();
	final estoqueMaximoController = MoneyMaskedTextController();
	final quantidadeEstoqueController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = produtoModel.id;
		plutoRow.cells['idProdutoSubgrupo']?.value = produtoModel.idProdutoSubgrupo;
		plutoRow.cells['produtoSubgrupo']?.value = produtoModel.produtoSubgrupoModel?.nome;
		plutoRow.cells['idProdutoMarca']?.value = produtoModel.idProdutoMarca;
		plutoRow.cells['produtoMarca']?.value = produtoModel.produtoMarcaModel?.nome;
		plutoRow.cells['idProdutoUnidade']?.value = produtoModel.idProdutoUnidade;
		plutoRow.cells['produtoUnidade']?.value = produtoModel.produtoUnidadeModel?.sigla;
		plutoRow.cells['idTributIcmsCustomCab']?.value = produtoModel.idTributIcmsCustomCab;
		plutoRow.cells['tributIcmsCustomCab']?.value = produtoModel.tributIcmsCustomCabModel?.descricao;
		plutoRow.cells['idTributGrupoTributario']?.value = produtoModel.idTributGrupoTributario;
		plutoRow.cells['tributGrupoTributario']?.value = produtoModel.tributGrupoTributarioModel?.descricao;
		plutoRow.cells['nome']?.value = produtoModel.nome;
		plutoRow.cells['descricao']?.value = produtoModel.descricao;
		plutoRow.cells['gtin']?.value = produtoModel.gtin;
		plutoRow.cells['codigoInterno']?.value = produtoModel.codigoInterno;
		plutoRow.cells['valorCompra']?.value = produtoModel.valorCompra;
		plutoRow.cells['valorVenda']?.value = produtoModel.valorVenda;
		plutoRow.cells['codigoNcm']?.value = produtoModel.codigoNcm;
		plutoRow.cells['dataCadastro']?.value = Util.formatDate(produtoModel.dataCadastro);
		plutoRow.cells['estoqueMinimo']?.value = produtoModel.estoqueMinimo;
		plutoRow.cells['estoqueMaximo']?.value = produtoModel.estoqueMaximo;
		plutoRow.cells['quantidadeEstoque']?.value = produtoModel.quantidadeEstoque;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await produtoRepository.save(produtoModel: produtoModel); 
        if (result != null) {
          produtoModel = result;
          if (_isInserting) {
            _produtoModelList.add(result);
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

	Future callProdutoSubgrupoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Subgrupo]'; 
		lookupController.route = '/produto-subgrupo/'; 
		lookupController.gridColumns = produtoSubgrupoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoSubgrupoModel.aliasColumns; 
		lookupController.dbColumns = ProdutoSubgrupoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			produtoModel.idProdutoSubgrupo = plutoRowResult.cells['id']!.value; 
			produtoModel.produtoSubgrupoModel!.plutoRowToObject(plutoRowResult); 
			produtoSubgrupoModelController.text = produtoModel.produtoSubgrupoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callProdutoMarcaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Marca]'; 
		lookupController.route = '/produto-marca/'; 
		lookupController.gridColumns = produtoMarcaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoMarcaModel.aliasColumns; 
		lookupController.dbColumns = ProdutoMarcaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			produtoModel.idProdutoMarca = plutoRowResult.cells['id']!.value; 
			produtoModel.produtoMarcaModel!.plutoRowToObject(plutoRowResult); 
			produtoMarcaModelController.text = produtoModel.produtoMarcaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callProdutoUnidadeLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Unidade]'; 
		lookupController.route = '/produto-unidade/'; 
		lookupController.gridColumns = produtoUnidadeGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoUnidadeModel.aliasColumns; 
		lookupController.dbColumns = ProdutoUnidadeModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			produtoModel.idProdutoUnidade = plutoRowResult.cells['id']!.value; 
			produtoModel.produtoUnidadeModel!.plutoRowToObject(plutoRowResult); 
			produtoUnidadeModelController.text = produtoModel.produtoUnidadeModel?.sigla ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callTributIcmsCustomCabLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tributação Customizada]'; 
		lookupController.route = '/tribut-icms-custom-cab/'; 
		lookupController.gridColumns = tributIcmsCustomCabGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TributIcmsCustomCabModel.aliasColumns; 
		lookupController.dbColumns = TributIcmsCustomCabModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			produtoModel.idTributIcmsCustomCab = plutoRowResult.cells['id']!.value; 
			produtoModel.tributIcmsCustomCabModel!.plutoRowToObject(plutoRowResult); 
			tributIcmsCustomCabModelController.text = produtoModel.tributIcmsCustomCabModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callTributGrupoTributarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Grupo Tributário]'; 
		lookupController.route = '/tribut-grupo-tributario/'; 
		lookupController.gridColumns = tributGrupoTributarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TributGrupoTributarioModel.aliasColumns; 
		lookupController.dbColumns = TributGrupoTributarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			produtoModel.idTributGrupoTributario = plutoRowResult.cells['id']!.value; 
			produtoModel.tributGrupoTributarioModel!.plutoRowToObject(plutoRowResult); 
			tributGrupoTributarioModelController.text = produtoModel.tributGrupoTributarioModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "produto";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		produtoSubgrupoModelController.dispose();
		produtoMarcaModelController.dispose();
		produtoUnidadeModelController.dispose();
		tributIcmsCustomCabModelController.dispose();
		tributGrupoTributarioModelController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		gtinController.dispose();
		codigoInternoController.dispose();
		valorCompraController.dispose();
		valorVendaController.dispose();
		codigoNcmController.dispose();
		estoqueMinimoController.dispose();
		estoqueMaximoController.dispose();
		quantidadeEstoqueController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}