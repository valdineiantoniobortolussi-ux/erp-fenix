import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:comissoes/app/infra/infra_imports.dart';
import 'package:comissoes/app/controller/controller_imports.dart';
import 'package:comissoes/app/data/model/model_imports.dart';
import 'package:comissoes/app/page/grid_columns/grid_columns_imports.dart';

import 'package:comissoes/app/routes/app_routes.dart';
import 'package:comissoes/app/data/repository/comissao_objetivo_repository.dart';
import 'package:comissoes/app/page/shared_page/shared_page_imports.dart';
import 'package:comissoes/app/page/shared_widget/message_dialog.dart';
import 'package:comissoes/app/mixin/controller_base_mixin.dart';

class ComissaoObjetivoController extends GetxController with ControllerBaseMixin {
  final ComissaoObjetivoRepository comissaoObjetivoRepository;
  ComissaoObjetivoController({required this.comissaoObjetivoRepository});

  // general
  final _dbColumns = ComissaoObjetivoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ComissaoObjetivoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = comissaoObjetivoGridColumns();
  
  var _comissaoObjetivoModelList = <ComissaoObjetivoModel>[];

  final _comissaoObjetivoModel = ComissaoObjetivoModel().obs;
  ComissaoObjetivoModel get comissaoObjetivoModel => _comissaoObjetivoModel.value;
  set comissaoObjetivoModel(value) => _comissaoObjetivoModel.value = value ?? ComissaoObjetivoModel();

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
    for (var comissaoObjetivoModel in _comissaoObjetivoModelList) {
      plutoRowList.add(_getPlutoRow(comissaoObjetivoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ComissaoObjetivoModel comissaoObjetivoModel) {
    return PlutoRow(
      cells: _getPlutoCells(comissaoObjetivoModel: comissaoObjetivoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ComissaoObjetivoModel? comissaoObjetivoModel}) {
    return {
			"id": PlutoCell(value: comissaoObjetivoModel?.id ?? 0),
			"comissaoPerfil": PlutoCell(value: comissaoObjetivoModel?.comissaoPerfilModel?.nome ?? ''),
			"codigo": PlutoCell(value: comissaoObjetivoModel?.codigo ?? ''),
			"nome": PlutoCell(value: comissaoObjetivoModel?.nome ?? ''),
			"descricao": PlutoCell(value: comissaoObjetivoModel?.descricao ?? ''),
			"taxaPagamento": PlutoCell(value: comissaoObjetivoModel?.taxaPagamento ?? 0),
			"valorPagamento": PlutoCell(value: comissaoObjetivoModel?.valorPagamento ?? 0),
			"valorMeta": PlutoCell(value: comissaoObjetivoModel?.valorMeta ?? 0),
			"dataInicio": PlutoCell(value: comissaoObjetivoModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: comissaoObjetivoModel?.dataFim ?? ''),
			"idComissaoPerfil": PlutoCell(value: comissaoObjetivoModel?.idComissaoPerfil ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _comissaoObjetivoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      comissaoObjetivoModel.plutoRowToObject(plutoRow);
    } else {
      comissaoObjetivoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Objetivos e Metas]';
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
    await Get.find<ComissaoObjetivoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await comissaoObjetivoRepository.getList(filter: filter).then( (data){ _comissaoObjetivoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Objetivos e Metas',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			comissaoPerfilModelController.text = currentRow.cells['comissaoPerfil']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			taxaPagamentoController.text = currentRow.cells['taxaPagamento']?.value?.toStringAsFixed(2) ?? '';
			valorPagamentoController.text = currentRow.cells['valorPagamento']?.value?.toStringAsFixed(2) ?? '';
			valorMetaController.text = currentRow.cells['valorMeta']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.comissaoObjetivoEditPage)!.then((value) {
        if (comissaoObjetivoModel.id == 0) {
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
    comissaoObjetivoModel = ComissaoObjetivoModel();
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
        if (await comissaoObjetivoRepository.delete(id: currentRow.cells['id']!.value)) {
          _comissaoObjetivoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final comissaoPerfilModelController = TextEditingController();
	final codigoController = TextEditingController();
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final taxaPagamentoController = MoneyMaskedTextController();
	final valorPagamentoController = MoneyMaskedTextController();
	final valorMetaController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = comissaoObjetivoModel.id;
		plutoRow.cells['idComissaoPerfil']?.value = comissaoObjetivoModel.idComissaoPerfil;
		plutoRow.cells['comissaoPerfil']?.value = comissaoObjetivoModel.comissaoPerfilModel?.nome;
		plutoRow.cells['codigo']?.value = comissaoObjetivoModel.codigo;
		plutoRow.cells['nome']?.value = comissaoObjetivoModel.nome;
		plutoRow.cells['descricao']?.value = comissaoObjetivoModel.descricao;
		plutoRow.cells['taxaPagamento']?.value = comissaoObjetivoModel.taxaPagamento;
		plutoRow.cells['valorPagamento']?.value = comissaoObjetivoModel.valorPagamento;
		plutoRow.cells['valorMeta']?.value = comissaoObjetivoModel.valorMeta;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(comissaoObjetivoModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(comissaoObjetivoModel.dataFim);
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await comissaoObjetivoRepository.save(comissaoObjetivoModel: comissaoObjetivoModel); 
        if (result != null) {
          comissaoObjetivoModel = result;
          if (_isInserting) {
            _comissaoObjetivoModelList.add(result);
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

	Future callComissaoPerfilLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Perfil]'; 
		lookupController.route = '/comissao-perfil/'; 
		lookupController.gridColumns = comissaoPerfilGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ComissaoPerfilModel.aliasColumns; 
		lookupController.dbColumns = ComissaoPerfilModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			comissaoObjetivoModel.idComissaoPerfil = plutoRowResult.cells['id']!.value; 
			comissaoObjetivoModel.comissaoPerfilModel!.plutoRowToObject(plutoRowResult); 
			comissaoPerfilModelController.text = comissaoObjetivoModel.comissaoPerfilModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "comissao_objetivo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		comissaoPerfilModelController.dispose();
		codigoController.dispose();
		nomeController.dispose();
		descricaoController.dispose();
		taxaPagamentoController.dispose();
		valorPagamentoController.dispose();
		valorMetaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}