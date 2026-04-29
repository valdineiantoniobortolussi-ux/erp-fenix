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
import 'package:mdfe/app/data/repository/mdfe_rodoviario_ciot_repository.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';
import 'package:mdfe/app/mixin/controller_base_mixin.dart';

class MdfeRodoviarioCiotController extends GetxController with ControllerBaseMixin {
  final MdfeRodoviarioCiotRepository mdfeRodoviarioCiotRepository;
  MdfeRodoviarioCiotController({required this.mdfeRodoviarioCiotRepository});

  // general
  final _dbColumns = MdfeRodoviarioCiotModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = MdfeRodoviarioCiotModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = mdfeRodoviarioCiotGridColumns();
  
  var _mdfeRodoviarioCiotModelList = <MdfeRodoviarioCiotModel>[];

  final _mdfeRodoviarioCiotModel = MdfeRodoviarioCiotModel().obs;
  MdfeRodoviarioCiotModel get mdfeRodoviarioCiotModel => _mdfeRodoviarioCiotModel.value;
  set mdfeRodoviarioCiotModel(value) => _mdfeRodoviarioCiotModel.value = value ?? MdfeRodoviarioCiotModel();

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
    for (var mdfeRodoviarioCiotModel in _mdfeRodoviarioCiotModelList) {
      plutoRowList.add(_getPlutoRow(mdfeRodoviarioCiotModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(MdfeRodoviarioCiotModel mdfeRodoviarioCiotModel) {
    return PlutoRow(
      cells: _getPlutoCells(mdfeRodoviarioCiotModel: mdfeRodoviarioCiotModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ MdfeRodoviarioCiotModel? mdfeRodoviarioCiotModel}) {
    return {
			"id": PlutoCell(value: mdfeRodoviarioCiotModel?.id ?? 0),
			"mdfeRodoviario": PlutoCell(value: mdfeRodoviarioCiotModel?.mdfeRodoviarioModel?.codigoAgendamento ?? ''),
			"ciot": PlutoCell(value: mdfeRodoviarioCiotModel?.ciot ?? ''),
			"cpf": PlutoCell(value: mdfeRodoviarioCiotModel?.cpf ?? ''),
			"cnpj": PlutoCell(value: mdfeRodoviarioCiotModel?.cnpj ?? ''),
			"idMdfeRodoviario": PlutoCell(value: mdfeRodoviarioCiotModel?.idMdfeRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _mdfeRodoviarioCiotModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      mdfeRodoviarioCiotModel.plutoRowToObject(plutoRow);
    } else {
      mdfeRodoviarioCiotModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Rodoviario CIOT]';
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
    await Get.find<MdfeRodoviarioCiotController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await mdfeRodoviarioCiotRepository.getList(filter: filter).then( (data){ _mdfeRodoviarioCiotModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Rodoviario CIOT',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			mdfeRodoviarioModelController.text = currentRow.cells['mdfeRodoviario']?.value ?? '';
			ciotController.text = currentRow.cells['ciot']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.mdfeRodoviarioCiotEditPage)!.then((value) {
        if (mdfeRodoviarioCiotModel.id == 0) {
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
    mdfeRodoviarioCiotModel = MdfeRodoviarioCiotModel();
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
        if (await mdfeRodoviarioCiotRepository.delete(id: currentRow.cells['id']!.value)) {
          _mdfeRodoviarioCiotModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final ciotController = TextEditingController();
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeRodoviarioCiotModel.id;
		plutoRow.cells['idMdfeRodoviario']?.value = mdfeRodoviarioCiotModel.idMdfeRodoviario;
		plutoRow.cells['mdfeRodoviario']?.value = mdfeRodoviarioCiotModel.mdfeRodoviarioModel?.codigoAgendamento;
		plutoRow.cells['ciot']?.value = mdfeRodoviarioCiotModel.ciot;
		plutoRow.cells['cpf']?.value = mdfeRodoviarioCiotModel.cpf;
		plutoRow.cells['cnpj']?.value = mdfeRodoviarioCiotModel.cnpj;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await mdfeRodoviarioCiotRepository.save(mdfeRodoviarioCiotModel: mdfeRodoviarioCiotModel); 
        if (result != null) {
          mdfeRodoviarioCiotModel = result;
          if (_isInserting) {
            _mdfeRodoviarioCiotModelList.add(result);
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
			mdfeRodoviarioCiotModel.idMdfeRodoviario = plutoRowResult.cells['id']!.value; 
			mdfeRodoviarioCiotModel.mdfeRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			mdfeRodoviarioModelController.text = mdfeRodoviarioCiotModel.mdfeRodoviarioModel?.codigoAgendamento ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "mdfe_rodoviario_ciot";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mdfeRodoviarioModelController.dispose();
		ciotController.dispose();
		cpfController.dispose();
		cnpjController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}