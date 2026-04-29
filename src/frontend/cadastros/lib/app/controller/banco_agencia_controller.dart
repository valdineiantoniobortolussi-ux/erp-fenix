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
import 'package:cadastros/app/data/repository/banco_agencia_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class BancoAgenciaController extends GetxController with ControllerBaseMixin {
  final BancoAgenciaRepository bancoAgenciaRepository;
  BancoAgenciaController({required this.bancoAgenciaRepository});

  // general
  final _dbColumns = BancoAgenciaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = BancoAgenciaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = bancoAgenciaGridColumns();
  
  var _bancoAgenciaModelList = <BancoAgenciaModel>[];

  final _bancoAgenciaModel = BancoAgenciaModel().obs;
  BancoAgenciaModel get bancoAgenciaModel => _bancoAgenciaModel.value;
  set bancoAgenciaModel(value) => _bancoAgenciaModel.value = value ?? BancoAgenciaModel();

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
    for (var bancoAgenciaModel in _bancoAgenciaModelList) {
      plutoRowList.add(_getPlutoRow(bancoAgenciaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(BancoAgenciaModel bancoAgenciaModel) {
    return PlutoRow(
      cells: _getPlutoCells(bancoAgenciaModel: bancoAgenciaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ BancoAgenciaModel? bancoAgenciaModel}) {
    return {
			"id": PlutoCell(value: bancoAgenciaModel?.id ?? 0),
			"banco": PlutoCell(value: bancoAgenciaModel?.bancoModel?.nome ?? ''),
			"nome": PlutoCell(value: bancoAgenciaModel?.nome ?? ''),
			"numero": PlutoCell(value: bancoAgenciaModel?.numero ?? ''),
			"digito": PlutoCell(value: bancoAgenciaModel?.digito ?? ''),
			"telefone": PlutoCell(value: bancoAgenciaModel?.telefone ?? ''),
			"contato": PlutoCell(value: bancoAgenciaModel?.contato ?? ''),
			"gerente": PlutoCell(value: bancoAgenciaModel?.gerente ?? ''),
			"observacao": PlutoCell(value: bancoAgenciaModel?.observacao ?? ''),
			"idBanco": PlutoCell(value: bancoAgenciaModel?.idBanco ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _bancoAgenciaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      bancoAgenciaModel.plutoRowToObject(plutoRow);
    } else {
      bancoAgenciaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Agência]';
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
    await Get.find<BancoAgenciaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await bancoAgenciaRepository.getList(filter: filter).then( (data){ _bancoAgenciaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Agência',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			bancoModelController.text = currentRow.cells['banco']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			digitoController.text = currentRow.cells['digito']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';
			contatoController.text = currentRow.cells['contato']?.value ?? '';
			gerenteController.text = currentRow.cells['gerente']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.bancoAgenciaEditPage)!.then((value) {
        if (bancoAgenciaModel.id == 0) {
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
    bancoAgenciaModel = BancoAgenciaModel();
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
        if (await bancoAgenciaRepository.delete(id: currentRow.cells['id']!.value)) {
          _bancoAgenciaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final bancoModelController = TextEditingController();
	final nomeController = TextEditingController();
	final numeroController = TextEditingController();
	final digitoController = TextEditingController();
	final telefoneController = MaskedTextController(mask: '(00)00000-0000',);
	final contatoController = TextEditingController();
	final gerenteController = TextEditingController();
	final observacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = bancoAgenciaModel.id;
		plutoRow.cells['idBanco']?.value = bancoAgenciaModel.idBanco;
		plutoRow.cells['banco']?.value = bancoAgenciaModel.bancoModel?.nome;
		plutoRow.cells['nome']?.value = bancoAgenciaModel.nome;
		plutoRow.cells['numero']?.value = bancoAgenciaModel.numero;
		plutoRow.cells['digito']?.value = bancoAgenciaModel.digito;
		plutoRow.cells['telefone']?.value = bancoAgenciaModel.telefone;
		plutoRow.cells['contato']?.value = bancoAgenciaModel.contato;
		plutoRow.cells['gerente']?.value = bancoAgenciaModel.gerente;
		plutoRow.cells['observacao']?.value = bancoAgenciaModel.observacao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await bancoAgenciaRepository.save(bancoAgenciaModel: bancoAgenciaModel); 
        if (result != null) {
          bancoAgenciaModel = result;
          if (_isInserting) {
            _bancoAgenciaModelList.add(result);
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

	Future callBancoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Banco]'; 
		lookupController.route = '/banco/'; 
		lookupController.gridColumns = bancoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = BancoModel.aliasColumns; 
		lookupController.dbColumns = BancoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			bancoAgenciaModel.idBanco = plutoRowResult.cells['id']!.value; 
			bancoAgenciaModel.bancoModel!.plutoRowToObject(plutoRowResult); 
			bancoModelController.text = bancoAgenciaModel.bancoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "banco_agencia";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		bancoModelController.dispose();
		nomeController.dispose();
		numeroController.dispose();
		digitoController.dispose();
		telefoneController.dispose();
		contatoController.dispose();
		gerenteController.dispose();
		observacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}