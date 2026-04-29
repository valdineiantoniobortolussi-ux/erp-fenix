import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/data/repository/banco_conta_caixa_repository.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro/app/mixin/controller_base_mixin.dart';

class BancoContaCaixaController extends GetxController with ControllerBaseMixin {
  final BancoContaCaixaRepository bancoContaCaixaRepository;
  BancoContaCaixaController({required this.bancoContaCaixaRepository});

  // general
  final _dbColumns = BancoContaCaixaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = BancoContaCaixaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = bancoContaCaixaGridColumns();
  
  var _bancoContaCaixaModelList = <BancoContaCaixaModel>[];

  final _bancoContaCaixaModel = BancoContaCaixaModel().obs;
  BancoContaCaixaModel get bancoContaCaixaModel => _bancoContaCaixaModel.value;
  set bancoContaCaixaModel(value) => _bancoContaCaixaModel.value = value ?? BancoContaCaixaModel();

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
    for (var bancoContaCaixaModel in _bancoContaCaixaModelList) {
      plutoRowList.add(_getPlutoRow(bancoContaCaixaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(BancoContaCaixaModel bancoContaCaixaModel) {
    return PlutoRow(
      cells: _getPlutoCells(bancoContaCaixaModel: bancoContaCaixaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ BancoContaCaixaModel? bancoContaCaixaModel}) {
    return {
			"id": PlutoCell(value: bancoContaCaixaModel?.id ?? 0),
			"bancoAgencia": PlutoCell(value: bancoContaCaixaModel?.bancoAgenciaModel?.nome ?? ''),
			"numero": PlutoCell(value: bancoContaCaixaModel?.numero ?? ''),
			"digito": PlutoCell(value: bancoContaCaixaModel?.digito ?? ''),
			"nome": PlutoCell(value: bancoContaCaixaModel?.nome ?? ''),
			"tipo": PlutoCell(value: bancoContaCaixaModel?.tipo ?? ''),
			"descricao": PlutoCell(value: bancoContaCaixaModel?.descricao ?? ''),
			"idBancoAgencia": PlutoCell(value: bancoContaCaixaModel?.idBancoAgencia ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _bancoContaCaixaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      bancoContaCaixaModel.plutoRowToObject(plutoRow);
    } else {
      bancoContaCaixaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Conta/Caixa]';
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
    await Get.find<BancoContaCaixaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await bancoContaCaixaRepository.getList(filter: filter).then( (data){ _bancoContaCaixaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Conta/Caixa',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			bancoAgenciaModelController.text = currentRow.cells['bancoAgencia']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			digitoController.text = currentRow.cells['digito']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.bancoContaCaixaEditPage)!.then((value) {
        if (bancoContaCaixaModel.id == 0) {
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
    bancoContaCaixaModel = BancoContaCaixaModel();
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
        if (await bancoContaCaixaRepository.delete(id: currentRow.cells['id']!.value)) {
          _bancoContaCaixaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final bancoAgenciaModelController = TextEditingController();
	final numeroController = TextEditingController();
	final digitoController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = bancoContaCaixaModel.id;
		plutoRow.cells['idBancoAgencia']?.value = bancoContaCaixaModel.idBancoAgencia;
		plutoRow.cells['bancoAgencia']?.value = bancoContaCaixaModel.bancoAgenciaModel?.nome;
		plutoRow.cells['numero']?.value = bancoContaCaixaModel.numero;
		plutoRow.cells['digito']?.value = bancoContaCaixaModel.digito;
		plutoRow.cells['nome']?.value = bancoContaCaixaModel.nome;
		plutoRow.cells['tipo']?.value = bancoContaCaixaModel.tipo;
		plutoRow.cells['descricao']?.value = bancoContaCaixaModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await bancoContaCaixaRepository.save(bancoContaCaixaModel: bancoContaCaixaModel); 
        if (result != null) {
          bancoContaCaixaModel = result;
          if (_isInserting) {
            _bancoContaCaixaModelList.add(result);
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

	Future callBancoAgenciaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Agencia]'; 
		lookupController.route = '/banco-agencia/'; 
		lookupController.gridColumns = bancoAgenciaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = BancoAgenciaModel.aliasColumns; 
		lookupController.dbColumns = BancoAgenciaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			bancoContaCaixaModel.idBancoAgencia = plutoRowResult.cells['id']!.value; 
			bancoContaCaixaModel.bancoAgenciaModel!.plutoRowToObject(plutoRowResult); 
			bancoAgenciaModelController.text = bancoContaCaixaModel.bancoAgenciaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "banco_conta_caixa";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		bancoAgenciaModelController.dispose();
		numeroController.dispose();
		digitoController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}