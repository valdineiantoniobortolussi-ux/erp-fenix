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
import 'package:mdfe/app/data/repository/mdfe_rodoviario_pedagio_repository.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';
import 'package:mdfe/app/mixin/controller_base_mixin.dart';

class MdfeRodoviarioPedagioController extends GetxController with ControllerBaseMixin {
  final MdfeRodoviarioPedagioRepository mdfeRodoviarioPedagioRepository;
  MdfeRodoviarioPedagioController({required this.mdfeRodoviarioPedagioRepository});

  // general
  final _dbColumns = MdfeRodoviarioPedagioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = MdfeRodoviarioPedagioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = mdfeRodoviarioPedagioGridColumns();
  
  var _mdfeRodoviarioPedagioModelList = <MdfeRodoviarioPedagioModel>[];

  final _mdfeRodoviarioPedagioModel = MdfeRodoviarioPedagioModel().obs;
  MdfeRodoviarioPedagioModel get mdfeRodoviarioPedagioModel => _mdfeRodoviarioPedagioModel.value;
  set mdfeRodoviarioPedagioModel(value) => _mdfeRodoviarioPedagioModel.value = value ?? MdfeRodoviarioPedagioModel();

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
    for (var mdfeRodoviarioPedagioModel in _mdfeRodoviarioPedagioModelList) {
      plutoRowList.add(_getPlutoRow(mdfeRodoviarioPedagioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(MdfeRodoviarioPedagioModel mdfeRodoviarioPedagioModel) {
    return PlutoRow(
      cells: _getPlutoCells(mdfeRodoviarioPedagioModel: mdfeRodoviarioPedagioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ MdfeRodoviarioPedagioModel? mdfeRodoviarioPedagioModel}) {
    return {
			"id": PlutoCell(value: mdfeRodoviarioPedagioModel?.id ?? 0),
			"mdfeRodoviario": PlutoCell(value: mdfeRodoviarioPedagioModel?.mdfeRodoviarioModel?.codigoAgendamento ?? ''),
			"cnpjFornecedor": PlutoCell(value: mdfeRodoviarioPedagioModel?.cnpjFornecedor ?? ''),
			"cnpjResponsavel": PlutoCell(value: mdfeRodoviarioPedagioModel?.cnpjResponsavel ?? ''),
			"cpfResponsavel": PlutoCell(value: mdfeRodoviarioPedagioModel?.cpfResponsavel ?? ''),
			"numeroComprovante": PlutoCell(value: mdfeRodoviarioPedagioModel?.numeroComprovante ?? ''),
			"valor": PlutoCell(value: mdfeRodoviarioPedagioModel?.valor ?? 0),
			"idMdfeRodoviario": PlutoCell(value: mdfeRodoviarioPedagioModel?.idMdfeRodoviario ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _mdfeRodoviarioPedagioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      mdfeRodoviarioPedagioModel.plutoRowToObject(plutoRow);
    } else {
      mdfeRodoviarioPedagioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Rodoviario Pedagio]';
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
    await Get.find<MdfeRodoviarioPedagioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await mdfeRodoviarioPedagioRepository.getList(filter: filter).then( (data){ _mdfeRodoviarioPedagioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Rodoviario Pedagio',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			mdfeRodoviarioModelController.text = currentRow.cells['mdfeRodoviario']?.value ?? '';
			cnpjFornecedorController.text = currentRow.cells['cnpjFornecedor']?.value ?? '';
			cnpjResponsavelController.text = currentRow.cells['cnpjResponsavel']?.value ?? '';
			cpfResponsavelController.text = currentRow.cells['cpfResponsavel']?.value ?? '';
			numeroComprovanteController.text = currentRow.cells['numeroComprovante']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.mdfeRodoviarioPedagioEditPage)!.then((value) {
        if (mdfeRodoviarioPedagioModel.id == 0) {
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
    mdfeRodoviarioPedagioModel = MdfeRodoviarioPedagioModel();
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
        if (await mdfeRodoviarioPedagioRepository.delete(id: currentRow.cells['id']!.value)) {
          _mdfeRodoviarioPedagioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final cnpjFornecedorController = MaskedTextController(mask: '00.000.000/0000-00',);
	final cnpjResponsavelController = MaskedTextController(mask: '00.000.000/0000-00',);
	final cpfResponsavelController = MaskedTextController(mask: '000.000.000-00',);
	final numeroComprovanteController = TextEditingController();
	final valorController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeRodoviarioPedagioModel.id;
		plutoRow.cells['idMdfeRodoviario']?.value = mdfeRodoviarioPedagioModel.idMdfeRodoviario;
		plutoRow.cells['mdfeRodoviario']?.value = mdfeRodoviarioPedagioModel.mdfeRodoviarioModel?.codigoAgendamento;
		plutoRow.cells['cnpjFornecedor']?.value = mdfeRodoviarioPedagioModel.cnpjFornecedor;
		plutoRow.cells['cnpjResponsavel']?.value = mdfeRodoviarioPedagioModel.cnpjResponsavel;
		plutoRow.cells['cpfResponsavel']?.value = mdfeRodoviarioPedagioModel.cpfResponsavel;
		plutoRow.cells['numeroComprovante']?.value = mdfeRodoviarioPedagioModel.numeroComprovante;
		plutoRow.cells['valor']?.value = mdfeRodoviarioPedagioModel.valor;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await mdfeRodoviarioPedagioRepository.save(mdfeRodoviarioPedagioModel: mdfeRodoviarioPedagioModel); 
        if (result != null) {
          mdfeRodoviarioPedagioModel = result;
          if (_isInserting) {
            _mdfeRodoviarioPedagioModelList.add(result);
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
			mdfeRodoviarioPedagioModel.idMdfeRodoviario = plutoRowResult.cells['id']!.value; 
			mdfeRodoviarioPedagioModel.mdfeRodoviarioModel!.plutoRowToObject(plutoRowResult); 
			mdfeRodoviarioModelController.text = mdfeRodoviarioPedagioModel.mdfeRodoviarioModel?.codigoAgendamento ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "mdfe_rodoviario_pedagio";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mdfeRodoviarioModelController.dispose();
		cnpjFornecedorController.dispose();
		cnpjResponsavelController.dispose();
		cpfResponsavelController.dispose();
		numeroComprovanteController.dispose();
		valorController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}