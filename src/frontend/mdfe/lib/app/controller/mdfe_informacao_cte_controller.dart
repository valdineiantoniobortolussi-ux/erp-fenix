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
import 'package:mdfe/app/data/repository/mdfe_informacao_cte_repository.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';
import 'package:mdfe/app/mixin/controller_base_mixin.dart';

class MdfeInformacaoCteController extends GetxController with ControllerBaseMixin {
  final MdfeInformacaoCteRepository mdfeInformacaoCteRepository;
  MdfeInformacaoCteController({required this.mdfeInformacaoCteRepository});

  // general
  final _dbColumns = MdfeInformacaoCteModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = MdfeInformacaoCteModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = mdfeInformacaoCteGridColumns();
  
  var _mdfeInformacaoCteModelList = <MdfeInformacaoCteModel>[];

  final _mdfeInformacaoCteModel = MdfeInformacaoCteModel().obs;
  MdfeInformacaoCteModel get mdfeInformacaoCteModel => _mdfeInformacaoCteModel.value;
  set mdfeInformacaoCteModel(value) => _mdfeInformacaoCteModel.value = value ?? MdfeInformacaoCteModel();

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
    for (var mdfeInformacaoCteModel in _mdfeInformacaoCteModelList) {
      plutoRowList.add(_getPlutoRow(mdfeInformacaoCteModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(MdfeInformacaoCteModel mdfeInformacaoCteModel) {
    return PlutoRow(
      cells: _getPlutoCells(mdfeInformacaoCteModel: mdfeInformacaoCteModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ MdfeInformacaoCteModel? mdfeInformacaoCteModel}) {
    return {
			"id": PlutoCell(value: mdfeInformacaoCteModel?.id ?? 0),
			"mdfeMunicipioDescarrega": PlutoCell(value: mdfeInformacaoCteModel?.mdfeMunicipioDescarregaModel?.nomeMunicipio ?? ''),
			"chaveCte": PlutoCell(value: mdfeInformacaoCteModel?.chaveCte ?? ''),
			"segundoCodigoBarra": PlutoCell(value: mdfeInformacaoCteModel?.segundoCodigoBarra ?? ''),
			"indicadorReentrega": PlutoCell(value: mdfeInformacaoCteModel?.indicadorReentrega ?? 0),
			"idMdfeMunicipioDescarrega": PlutoCell(value: mdfeInformacaoCteModel?.idMdfeMunicipioDescarrega ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _mdfeInformacaoCteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      mdfeInformacaoCteModel.plutoRowToObject(plutoRow);
    } else {
      mdfeInformacaoCteModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Informacão CTE]';
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
    await Get.find<MdfeInformacaoCteController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await mdfeInformacaoCteRepository.getList(filter: filter).then( (data){ _mdfeInformacaoCteModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Informacão CTE',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			mdfeMunicipioDescarregaModelController.text = currentRow.cells['mdfeMunicipioDescarrega']?.value ?? '';
			chaveCteController.text = currentRow.cells['chaveCte']?.value ?? '';
			segundoCodigoBarraController.text = currentRow.cells['segundoCodigoBarra']?.value ?? '';
			indicadorReentregaController.text = currentRow.cells['indicadorReentrega']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.mdfeInformacaoCteEditPage)!.then((value) {
        if (mdfeInformacaoCteModel.id == 0) {
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
    mdfeInformacaoCteModel = MdfeInformacaoCteModel();
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
        if (await mdfeInformacaoCteRepository.delete(id: currentRow.cells['id']!.value)) {
          _mdfeInformacaoCteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final chaveCteController = TextEditingController();
	final segundoCodigoBarraController = TextEditingController();
	final indicadorReentregaController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeInformacaoCteModel.id;
		plutoRow.cells['idMdfeMunicipioDescarrega']?.value = mdfeInformacaoCteModel.idMdfeMunicipioDescarrega;
		plutoRow.cells['mdfeMunicipioDescarrega']?.value = mdfeInformacaoCteModel.mdfeMunicipioDescarregaModel?.nomeMunicipio;
		plutoRow.cells['chaveCte']?.value = mdfeInformacaoCteModel.chaveCte;
		plutoRow.cells['segundoCodigoBarra']?.value = mdfeInformacaoCteModel.segundoCodigoBarra;
		plutoRow.cells['indicadorReentrega']?.value = mdfeInformacaoCteModel.indicadorReentrega;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await mdfeInformacaoCteRepository.save(mdfeInformacaoCteModel: mdfeInformacaoCteModel); 
        if (result != null) {
          mdfeInformacaoCteModel = result;
          if (_isInserting) {
            _mdfeInformacaoCteModelList.add(result);
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
			mdfeInformacaoCteModel.idMdfeMunicipioDescarrega = plutoRowResult.cells['id']!.value; 
			mdfeInformacaoCteModel.mdfeMunicipioDescarregaModel!.plutoRowToObject(plutoRowResult); 
			mdfeMunicipioDescarregaModelController.text = mdfeInformacaoCteModel.mdfeMunicipioDescarregaModel?.nomeMunicipio ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "mdfe_informacao_cte";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mdfeMunicipioDescarregaModelController.dispose();
		chaveCteController.dispose();
		segundoCodigoBarraController.dispose();
		indicadorReentregaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}