import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/controller/controller_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cte/app/routes/app_routes.dart';
import 'package:cte/app/data/repository/cte_aquaviario_balsa_repository.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';
import 'package:cte/app/mixin/controller_base_mixin.dart';

class CteAquaviarioBalsaController extends GetxController with ControllerBaseMixin {
  final CteAquaviarioBalsaRepository cteAquaviarioBalsaRepository;
  CteAquaviarioBalsaController({required this.cteAquaviarioBalsaRepository});

  // general
  final _dbColumns = CteAquaviarioBalsaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CteAquaviarioBalsaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cteAquaviarioBalsaGridColumns();
  
  var _cteAquaviarioBalsaModelList = <CteAquaviarioBalsaModel>[];

  final _cteAquaviarioBalsaModel = CteAquaviarioBalsaModel().obs;
  CteAquaviarioBalsaModel get cteAquaviarioBalsaModel => _cteAquaviarioBalsaModel.value;
  set cteAquaviarioBalsaModel(value) => _cteAquaviarioBalsaModel.value = value ?? CteAquaviarioBalsaModel();

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
    for (var cteAquaviarioBalsaModel in _cteAquaviarioBalsaModelList) {
      plutoRowList.add(_getPlutoRow(cteAquaviarioBalsaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CteAquaviarioBalsaModel cteAquaviarioBalsaModel) {
    return PlutoRow(
      cells: _getPlutoCells(cteAquaviarioBalsaModel: cteAquaviarioBalsaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CteAquaviarioBalsaModel? cteAquaviarioBalsaModel}) {
    return {
			"id": PlutoCell(value: cteAquaviarioBalsaModel?.id ?? 0),
			"cteAquaviario": PlutoCell(value: cteAquaviarioBalsaModel?.cteAquaviarioModel?.numeroControle ?? ''),
			"idBalsa": PlutoCell(value: cteAquaviarioBalsaModel?.idBalsa ?? ''),
			"numeroViagem": PlutoCell(value: cteAquaviarioBalsaModel?.numeroViagem ?? 0),
			"direcao": PlutoCell(value: cteAquaviarioBalsaModel?.direcao ?? ''),
			"portoEmbarque": PlutoCell(value: cteAquaviarioBalsaModel?.portoEmbarque ?? ''),
			"portoTransbordo": PlutoCell(value: cteAquaviarioBalsaModel?.portoTransbordo ?? ''),
			"portoDestino": PlutoCell(value: cteAquaviarioBalsaModel?.portoDestino ?? ''),
			"tipoNavegacao": PlutoCell(value: cteAquaviarioBalsaModel?.tipoNavegacao ?? ''),
			"irin": PlutoCell(value: cteAquaviarioBalsaModel?.irin ?? ''),
			"idCteAquaviario": PlutoCell(value: cteAquaviarioBalsaModel?.idCteAquaviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cteAquaviarioBalsaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cteAquaviarioBalsaModel.plutoRowToObject(plutoRow);
    } else {
      cteAquaviarioBalsaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cte Aquaviario Balsa]';
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
    await Get.find<CteAquaviarioBalsaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cteAquaviarioBalsaRepository.getList(filter: filter).then( (data){ _cteAquaviarioBalsaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cte Aquaviario Balsa',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			cteAquaviarioModelController.text = currentRow.cells['cteAquaviario']?.value ?? '';
			idBalsaController.text = currentRow.cells['idBalsa']?.value ?? '';
			numeroViagemController.text = currentRow.cells['numeroViagem']?.value?.toString() ?? '';
			portoEmbarqueController.text = currentRow.cells['portoEmbarque']?.value ?? '';
			portoTransbordoController.text = currentRow.cells['portoTransbordo']?.value ?? '';
			portoDestinoController.text = currentRow.cells['portoDestino']?.value ?? '';
			irinController.text = currentRow.cells['irin']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cteAquaviarioBalsaEditPage)!.then((value) {
        if (cteAquaviarioBalsaModel.id == 0) {
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
    cteAquaviarioBalsaModel = CteAquaviarioBalsaModel();
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
        if (await cteAquaviarioBalsaRepository.delete(id: currentRow.cells['id']!.value)) {
          _cteAquaviarioBalsaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cteAquaviarioModelController = TextEditingController();
	final idBalsaController = TextEditingController();
	final numeroViagemController = TextEditingController();
	final portoEmbarqueController = TextEditingController();
	final portoTransbordoController = TextEditingController();
	final portoDestinoController = TextEditingController();
	final irinController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteAquaviarioBalsaModel.id;
		plutoRow.cells['idCteAquaviario']?.value = cteAquaviarioBalsaModel.idCteAquaviario;
		plutoRow.cells['cteAquaviario']?.value = cteAquaviarioBalsaModel.cteAquaviarioModel?.numeroControle;
		plutoRow.cells['idBalsa']?.value = cteAquaviarioBalsaModel.idBalsa;
		plutoRow.cells['numeroViagem']?.value = cteAquaviarioBalsaModel.numeroViagem;
		plutoRow.cells['direcao']?.value = cteAquaviarioBalsaModel.direcao;
		plutoRow.cells['portoEmbarque']?.value = cteAquaviarioBalsaModel.portoEmbarque;
		plutoRow.cells['portoTransbordo']?.value = cteAquaviarioBalsaModel.portoTransbordo;
		plutoRow.cells['portoDestino']?.value = cteAquaviarioBalsaModel.portoDestino;
		plutoRow.cells['tipoNavegacao']?.value = cteAquaviarioBalsaModel.tipoNavegacao;
		plutoRow.cells['irin']?.value = cteAquaviarioBalsaModel.irin;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cteAquaviarioBalsaRepository.save(cteAquaviarioBalsaModel: cteAquaviarioBalsaModel); 
        if (result != null) {
          cteAquaviarioBalsaModel = result;
          if (_isInserting) {
            _cteAquaviarioBalsaModelList.add(result);
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

	Future callCteAquaviarioLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Cte Aquaviario]'; 
		lookupController.route = '/cte-aquaviario/'; 
		lookupController.gridColumns = cteAquaviarioGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CteAquaviarioModel.aliasColumns; 
		lookupController.dbColumns = CteAquaviarioModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			cteAquaviarioBalsaModel.idCteAquaviario = plutoRowResult.cells['id']!.value; 
			cteAquaviarioBalsaModel.cteAquaviarioModel!.plutoRowToObject(plutoRowResult); 
			cteAquaviarioModelController.text = cteAquaviarioBalsaModel.cteAquaviarioModel?.numeroControle ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cte_aquaviario_balsa";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		cteAquaviarioModelController.dispose();
		idBalsaController.dispose();
		numeroViagemController.dispose();
		portoEmbarqueController.dispose();
		portoTransbordoController.dispose();
		portoDestinoController.dispose();
		irinController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}