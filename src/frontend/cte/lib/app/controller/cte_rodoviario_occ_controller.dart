import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/controller/controller_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cte/app/routes/app_routes.dart';
import 'package:cte/app/data/repository/cte_rodoviario_occ_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteRodoviarioOccController extends GetxController with ControllerBaseMixin {
  final CteRodoviarioOccRepository cteRodoviarioOccRepository;
  CteRodoviarioOccController({required this.cteRodoviarioOccRepository});

  // general
  final _dbColumns = CteRodoviarioOccModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteRodoviarioOccModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteRodoviarioOccGridColumns();
  
  var _cteRodoviarioOccModelList = <CteRodoviarioOccModel>[];

  final _cteRodoviarioOccModel = CteRodoviarioOccModel().obs;
  CteRodoviarioOccModel get cteRodoviarioOccModel => _cteRodoviarioOccModel.value;
  set cteRodoviarioOccModel(value) => _cteRodoviarioOccModel.value = value ?? CteRodoviarioOccModel();

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
    for (var cteRodoviarioOccModel in _cteRodoviarioOccModelList) {
      plutoRowList.add(_getPlutoRow(cteRodoviarioOccModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteRodoviarioOccModel cteRodoviarioOccModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteRodoviarioOccModel: cteRodoviarioOccModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteRodoviarioOccModel? cteRodoviarioOccModel}) {
    return {
			"id": PlutoCell(value: cteRodoviarioOccModel?.id ?? 0),
			"cteRodoviario": PlutoCell(value: cteRodoviarioOccModel?.cteRodoviarioModel?.rntrc ?? ''),
			"serie": PlutoCell(value: cteRodoviarioOccModel?.serie ?? ''),
			"numero": PlutoCell(value: cteRodoviarioOccModel?.numero ?? 0),
			"dataEmissao": PlutoCell(value: cteRodoviarioOccModel?.dataEmissao ?? ''),
			"cnpj": PlutoCell(value: cteRodoviarioOccModel?.cnpj ?? ''),
			"codigoInterno": PlutoCell(value: cteRodoviarioOccModel?.codigoInterno ?? ''),
			"ie": PlutoCell(value: cteRodoviarioOccModel?.ie ?? ''),
			"uf": PlutoCell(value: cteRodoviarioOccModel?.uf ?? ''),
			"telefone": PlutoCell(value: cteRodoviarioOccModel?.telefone ?? ''),
			"idCteRodoviario": PlutoCell(value: cteRodoviarioOccModel?.idCteRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteRodoviarioOccModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteRodoviarioOccModel.plutoRowToObject(plutoRow);
    } else {
      cteRodoviarioOccModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Rodoviario Occ]';
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
    await Get.find<CteRodoviarioOccController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteRodoviarioOccRepository.getList(filter: filter).then( (data){ _cteRodoviarioOccModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Rodoviario Occ',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteRodoviarioModelController.text = currentRow.cells['cteRodoviario']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			codigoInternoController.text = currentRow.cells['codigoInterno']?.value ?? '';
			ieController.text = currentRow.cells['ie']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteRodoviarioOccEditPage)!.then((value) {
        if (cteRodoviarioOccModel.id == 0) {
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
    cteRodoviarioOccModel = CteRodoviarioOccModel();
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
        if (await cteRodoviarioOccRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteRodoviarioOccModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteRodoviarioModelController = TextEditingController();
	final numeroController = TextEditingController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final codigoInternoController = TextEditingController();
	final ieController = TextEditingController();
	final telefoneController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteRodoviarioOccModel.id;
		plutoRow.cells['idCteRodoviario']?.value = cteRodoviarioOccModel.idCteRodoviario;
		plutoRow.cells['cteRodoviario']?.value = cteRodoviarioOccModel.cteRodoviarioModel?.rntrc;
		plutoRow.cells['serie']?.value = cteRodoviarioOccModel.serie;
		plutoRow.cells['numero']?.value = cteRodoviarioOccModel.numero;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(cteRodoviarioOccModel.dataEmissao);
		plutoRow.cells['cnpj']?.value = cteRodoviarioOccModel.cnpj;
		plutoRow.cells['codigoInterno']?.value = cteRodoviarioOccModel.codigoInterno;
		plutoRow.cells['ie']?.value = cteRodoviarioOccModel.ie;
		plutoRow.cells['uf']?.value = cteRodoviarioOccModel.uf;
		plutoRow.cells['telefone']?.value = cteRodoviarioOccModel.telefone;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteRodoviarioOccRepository.save(cteRodoviarioOccModel: cteRodoviarioOccModel); 
        if (result != null) {
          cteRodoviarioOccModel = result;
          if (_isInserting) {
            _cteRodoviarioOccModelList.add(result);
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

	Future callCteRodoviarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Rodoviario]'; 
		lookupController.route = '/cte-rodoviario/'; 
		lookupController.gridColumns = cteRodoviarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteRodoviarioModel.aliasColumns; 
		lookupController.dbColumns = CteRodoviarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteRodoviarioOccModel.idCteRodoviario = plutoRowResult.cells['id']!.value; 
			cteRodoviarioOccModel.cteRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			cteRodoviarioModelController.text = cteRodoviarioOccModel.cteRodoviarioModel?.rntrc ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_rodoviario_occ";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteRodoviarioModelController.dispose();
		numeroController.dispose();
		cnpjController.dispose();
		codigoInternoController.dispose();
		ieController.dispose();
		telefoneController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}