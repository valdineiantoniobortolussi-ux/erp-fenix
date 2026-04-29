import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/controller/controller_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:mdfe/app/routes/app_routes.dart';
import 'package:mdfe/app/data/repository/mdfe_informacao_nfe_repository.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';
import 'package:mdfe/app/mixin/controller_base_mixin.dart';

class MdfeInformacaoNfeController extends GetxController with ControllerBaseMixin {
  final MdfeInformacaoNfeRepository mdfeInformacaoNfeRepository;
  MdfeInformacaoNfeController({required this.mdfeInformacaoNfeRepository});

  // general
  final _dbColumns = MdfeInformacaoNfeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = MdfeInformacaoNfeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = mdfeInformacaoNfeGridColumns();
  
  var _mdfeInformacaoNfeModelList = <MdfeInformacaoNfeModel>[];

  final _mdfeInformacaoNfeModel = MdfeInformacaoNfeModel().obs;
  MdfeInformacaoNfeModel get mdfeInformacaoNfeModel => _mdfeInformacaoNfeModel.value;
  set mdfeInformacaoNfeModel(value) => _mdfeInformacaoNfeModel.value = value ?? MdfeInformacaoNfeModel();

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
    for (var mdfeInformacaoNfeModel in _mdfeInformacaoNfeModelList) {
      plutoRowList.add(_getPlutoRow(mdfeInformacaoNfeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(MdfeInformacaoNfeModel mdfeInformacaoNfeModel) {
    return PlutoRow(
      cells: _getPlutoCells(mdfeInformacaoNfeModel: mdfeInformacaoNfeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ MdfeInformacaoNfeModel? mdfeInformacaoNfeModel}) {
    return {
			"id": PlutoCell(value: mdfeInformacaoNfeModel?.id ?? 0),
			"mdfeMunicipioDescarrega": PlutoCell(value: mdfeInformacaoNfeModel?.mdfeMunicipioDescarregaModel?.nomeMunicipio ?? ''),
			"chaveNfe": PlutoCell(value: mdfeInformacaoNfeModel?.chaveNfe ?? ''),
			"segundoCodigoBarra": PlutoCell(value: mdfeInformacaoNfeModel?.segundoCodigoBarra ?? ''),
			"indicadorReentrega": PlutoCell(value: mdfeInformacaoNfeModel?.indicadorReentrega ?? 0),
			"idMdfeMunicipioDescarrega": PlutoCell(value: mdfeInformacaoNfeModel?.idMdfeMunicipioDescarrega ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _mdfeInformacaoNfeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      mdfeInformacaoNfeModel.plutoRowToObject(plutoRow);
    } else {
      mdfeInformacaoNfeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Informacao NFe]';
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
    await Get.find<MdfeInformacaoNfeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await mdfeInformacaoNfeRepository.getList(filter: filter).then( (data){ _mdfeInformacaoNfeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Informacao NFe',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			mdfeMunicipioDescarregaModelController.text = currentRow.cells['mdfeMunicipioDescarrega']?.value ?? '';
			chaveNfeController.text = currentRow.cells['chaveNfe']?.value ?? '';
			segundoCodigoBarraController.text = currentRow.cells['segundoCodigoBarra']?.value ?? '';
			indicadorReentregaController.text = currentRow.cells['indicadorReentrega']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.mdfeInformacaoNfeEditPage)!.then((value) {
        if (mdfeInformacaoNfeModel.id == 0) {
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
    mdfeInformacaoNfeModel = MdfeInformacaoNfeModel();
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
        if (await mdfeInformacaoNfeRepository.delete(id: currentRow.cells['id']!.value)) {
          _mdfeInformacaoNfeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final mdfeMunicipioDescarregaModelController = TextEditingController();
	final chaveNfeController = TextEditingController();
	final segundoCodigoBarraController = TextEditingController();
	final indicadorReentregaController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeInformacaoNfeModel.id;
		plutoRow.cells['idMdfeMunicipioDescarrega']?.value = mdfeInformacaoNfeModel.idMdfeMunicipioDescarrega;
		plutoRow.cells['mdfeMunicipioDescarrega']?.value = mdfeInformacaoNfeModel.mdfeMunicipioDescarregaModel?.nomeMunicipio;
		plutoRow.cells['chaveNfe']?.value = mdfeInformacaoNfeModel.chaveNfe;
		plutoRow.cells['segundoCodigoBarra']?.value = mdfeInformacaoNfeModel.segundoCodigoBarra;
		plutoRow.cells['indicadorReentrega']?.value = mdfeInformacaoNfeModel.indicadorReentrega;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await mdfeInformacaoNfeRepository.save(mdfeInformacaoNfeModel: mdfeInformacaoNfeModel); 
        if (result != null) {
          mdfeInformacaoNfeModel = result;
          if (_isInserting) {
            _mdfeInformacaoNfeModelList.add(result);
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

	Future callMdfeMunicipioDescarregaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Mdfe Municipio Descarrega]'; 
		lookupController.route = '/mdfe-municipio-descarrega/'; 
		lookupController.gridColumns = mdfeMunicipioDescarregaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = MdfeMunicipioDescarregaModel.aliasColumns; 
		lookupController.dbColumns = MdfeMunicipioDescarregaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			mdfeInformacaoNfeModel.idMdfeMunicipioDescarrega = plutoRowResult.cells['id']!.value; 
			mdfeInformacaoNfeModel.mdfeMunicipioDescarregaModel!.plutoRowToObject(plutoRowResult); 
			mdfeMunicipioDescarregaModelController.text = mdfeInformacaoNfeModel.mdfeMunicipioDescarregaModel?.nomeMunicipio ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "mdfe_informacao_nfe";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mdfeMunicipioDescarregaModelController.dispose();
		chaveNfeController.dispose();
		segundoCodigoBarraController.dispose();
		indicadorReentregaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}