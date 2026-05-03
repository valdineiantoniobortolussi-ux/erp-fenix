import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/lanca_centro_resultado_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class LancaCentroResultadoController extends GetxController with ControllerBaseMixin {
  final LancaCentroResultadoRepository lancaCentroResultadoRepository;
  LancaCentroResultadoController({required this.lancaCentroResultadoRepository});

  // general
  final _dbColumns = LancaCentroResultadoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = LancaCentroResultadoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = lancaCentroResultadoGridColumns();
  
  var _lancaCentroResultadoModelList = <LancaCentroResultadoModel>[];

  final _lancaCentroResultadoModel = LancaCentroResultadoModel().obs;
  LancaCentroResultadoModel get lancaCentroResultadoModel => _lancaCentroResultadoModel.value;
  set lancaCentroResultadoModel(value) => _lancaCentroResultadoModel.value = value ?? LancaCentroResultadoModel();

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
    for (var lancaCentroResultadoModel in _lancaCentroResultadoModelList) {
      plutoRowList.add(_getPlutoRow(lancaCentroResultadoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(LancaCentroResultadoModel lancaCentroResultadoModel) {
    return PlutoRow(
      cells: _getPlutoCells(lancaCentroResultadoModel: lancaCentroResultadoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ LancaCentroResultadoModel? lancaCentroResultadoModel}) {
    return {
			"id": PlutoCell(value: lancaCentroResultadoModel?.id ?? 0),
			"centroResultado": PlutoCell(value: lancaCentroResultadoModel?.centroResultadoModel?.descricao ?? ''),
			"valor": PlutoCell(value: lancaCentroResultadoModel?.valor ?? 0),
			"dataLancamento": PlutoCell(value: lancaCentroResultadoModel?.dataLancamento ?? ''),
			"dataInclusao": PlutoCell(value: lancaCentroResultadoModel?.dataInclusao ?? ''),
			"origemDeRateio": PlutoCell(value: lancaCentroResultadoModel?.origemDeRateio ?? ''),
			"historico": PlutoCell(value: lancaCentroResultadoModel?.historico ?? ''),
			"idCentroResultado": PlutoCell(value: lancaCentroResultadoModel?.idCentroResultado ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _lancaCentroResultadoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      lancaCentroResultadoModel.plutoRowToObject(plutoRow);
    } else {
      lancaCentroResultadoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Lançamento Centro Resultado]';
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
    await Get.find<LancaCentroResultadoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await lancaCentroResultadoRepository.getList(filter: filter).then( (data){ _lancaCentroResultadoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Lançamento Centro Resultado',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			centroResultadoModelController.text = currentRow.cells['centroResultado']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			historicoController.text = currentRow.cells['historico']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.lancaCentroResultadoEditPage)!.then((value) {
        if (lancaCentroResultadoModel.id == 0) {
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
    lancaCentroResultadoModel = LancaCentroResultadoModel();
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
        if (await lancaCentroResultadoRepository.delete(id: currentRow.cells['id']!.value)) {
          _lancaCentroResultadoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final centroResultadoModelController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final historicoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = lancaCentroResultadoModel.id;
		plutoRow.cells['idCentroResultado']?.value = lancaCentroResultadoModel.idCentroResultado;
		plutoRow.cells['centroResultado']?.value = lancaCentroResultadoModel.centroResultadoModel?.descricao;
		plutoRow.cells['valor']?.value = lancaCentroResultadoModel.valor;
		plutoRow.cells['dataLancamento']?.value = Util.formatDate(lancaCentroResultadoModel.dataLancamento);
		plutoRow.cells['dataInclusao']?.value = Util.formatDate(lancaCentroResultadoModel.dataInclusao);
		plutoRow.cells['origemDeRateio']?.value = lancaCentroResultadoModel.origemDeRateio;
		plutoRow.cells['historico']?.value = lancaCentroResultadoModel.historico;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await lancaCentroResultadoRepository.save(lancaCentroResultadoModel: lancaCentroResultadoModel); 
        if (result != null) {
          lancaCentroResultadoModel = result;
          if (_isInserting) {
            _lancaCentroResultadoModelList.add(result);
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

	Future callCentroResultadoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Centro Resultado]'; 
		lookupController.route = '/centro-resultado/'; 
		lookupController.gridColumns = centroResultadoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CentroResultadoModel.aliasColumns; 
		lookupController.dbColumns = CentroResultadoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			lancaCentroResultadoModel.idCentroResultado = plutoRowResult.cells['id']!.value; 
			lancaCentroResultadoModel.centroResultadoModel!.plutoRowToObject(plutoRowResult); 
			centroResultadoModelController.text = lancaCentroResultadoModel.centroResultadoModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "lanca_centro_resultado";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		centroResultadoModelController.dispose();
		valorController.dispose();
		historicoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}