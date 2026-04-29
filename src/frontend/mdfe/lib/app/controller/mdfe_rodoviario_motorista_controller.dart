import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/controller/controller_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:mdfe/app/routes/app_routes.dart';
import 'package:mdfe/app/data/repository/mdfe_rodoviario_motorista_repository.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';
import 'package:mdfe/app/mixin/controller_base_mixin.dart';

class MdfeRodoviarioMotoristaController extends GetxController with ControllerBaseMixin {
  final MdfeRodoviarioMotoristaRepository mdfeRodoviarioMotoristaRepository;
  MdfeRodoviarioMotoristaController({required this.mdfeRodoviarioMotoristaRepository});

  // general
  final _dbColumns = MdfeRodoviarioMotoristaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = MdfeRodoviarioMotoristaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = mdfeRodoviarioMotoristaGridColumns();
  
  var _mdfeRodoviarioMotoristaModelList = <MdfeRodoviarioMotoristaModel>[];

  final _mdfeRodoviarioMotoristaModel = MdfeRodoviarioMotoristaModel().obs;
  MdfeRodoviarioMotoristaModel get mdfeRodoviarioMotoristaModel => _mdfeRodoviarioMotoristaModel.value;
  set mdfeRodoviarioMotoristaModel(value) => _mdfeRodoviarioMotoristaModel.value = value ?? MdfeRodoviarioMotoristaModel();

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
    for (var mdfeRodoviarioMotoristaModel in _mdfeRodoviarioMotoristaModelList) {
      plutoRowList.add(_getPlutoRow(mdfeRodoviarioMotoristaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(MdfeRodoviarioMotoristaModel mdfeRodoviarioMotoristaModel) {
    return PlutoRow(
      cells: _getPlutoCells(mdfeRodoviarioMotoristaModel: mdfeRodoviarioMotoristaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ MdfeRodoviarioMotoristaModel? mdfeRodoviarioMotoristaModel}) {
    return {
			"id": PlutoCell(value: mdfeRodoviarioMotoristaModel?.id ?? 0),
			"mdfeRodoviario": PlutoCell(value: mdfeRodoviarioMotoristaModel?.mdfeRodoviarioModel?.codigoAgendamento ?? ''),
			"nome": PlutoCell(value: mdfeRodoviarioMotoristaModel?.nome ?? ''),
			"cpf": PlutoCell(value: mdfeRodoviarioMotoristaModel?.cpf ?? ''),
			"idMdfeRodoviario": PlutoCell(value: mdfeRodoviarioMotoristaModel?.idMdfeRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _mdfeRodoviarioMotoristaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      mdfeRodoviarioMotoristaModel.plutoRowToObject(plutoRow);
    } else {
      mdfeRodoviarioMotoristaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Rodoviario Motorista]';
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
    await Get.find<MdfeRodoviarioMotoristaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await mdfeRodoviarioMotoristaRepository.getList(filter: filter).then( (data){ _mdfeRodoviarioMotoristaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Rodoviario Motorista',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			mdfeRodoviarioModelController.text = currentRow.cells['mdfeRodoviario']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.mdfeRodoviarioMotoristaEditPage)!.then((value) {
        if (mdfeRodoviarioMotoristaModel.id == 0) {
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
    mdfeRodoviarioMotoristaModel = MdfeRodoviarioMotoristaModel();
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
        if (await mdfeRodoviarioMotoristaRepository.delete(id: currentRow.cells['id']!.value)) {
          _mdfeRodoviarioMotoristaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final mdfeRodoviarioModelController = TextEditingController();
	final nomeController = TextEditingController();
	final cpfController = MaskedTextController(mask: '000.000.000-00',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeRodoviarioMotoristaModel.id;
		plutoRow.cells['idMdfeRodoviario']?.value = mdfeRodoviarioMotoristaModel.idMdfeRodoviario;
		plutoRow.cells['mdfeRodoviario']?.value = mdfeRodoviarioMotoristaModel.mdfeRodoviarioModel?.codigoAgendamento;
		plutoRow.cells['nome']?.value = mdfeRodoviarioMotoristaModel.nome;
		plutoRow.cells['cpf']?.value = mdfeRodoviarioMotoristaModel.cpf;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await mdfeRodoviarioMotoristaRepository.save(mdfeRodoviarioMotoristaModel: mdfeRodoviarioMotoristaModel); 
        if (result != null) {
          mdfeRodoviarioMotoristaModel = result;
          if (_isInserting) {
            _mdfeRodoviarioMotoristaModelList.add(result);
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

	Future callMdfeRodoviarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Mdfe Rodoviario]'; 
		lookupController.route = '/mdfe-rodoviario/'; 
		lookupController.gridColumns = mdfeRodoviarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = MdfeRodoviarioModel.aliasColumns; 
		lookupController.dbColumns = MdfeRodoviarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			mdfeRodoviarioMotoristaModel.idMdfeRodoviario = plutoRowResult.cells['id']!.value; 
			mdfeRodoviarioMotoristaModel.mdfeRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			mdfeRodoviarioModelController.text = mdfeRodoviarioMotoristaModel.mdfeRodoviarioModel?.codigoAgendamento ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "mdfe_rodoviario_motorista";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mdfeRodoviarioModelController.dispose();
		nomeController.dispose();
		cpfController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}