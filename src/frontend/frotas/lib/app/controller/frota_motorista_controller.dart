import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/controller/controller_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/page/grid_columns/grid_columns_imports.dart';

import 'package:frotas/app/routes/app_routes.dart';
import 'package:frotas/app/data/repository/frota_motorista_repository.dart';
import 'package:frotas/app/page/shared_page/shared_page_imports.dart';
import 'package:frotas/app/page/shared_widget/message_dialog.dart';
import 'package:frotas/app/mixin/controller_base_mixin.dart';

class FrotaMotoristaController extends GetxController with ControllerBaseMixin {
  final FrotaMotoristaRepository frotaMotoristaRepository;
  FrotaMotoristaController({required this.frotaMotoristaRepository});

  // general
  final _dbColumns = FrotaMotoristaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FrotaMotoristaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = frotaMotoristaGridColumns();
  
  var _frotaMotoristaModelList = <FrotaMotoristaModel>[];

  final _frotaMotoristaModel = FrotaMotoristaModel().obs;
  FrotaMotoristaModel get frotaMotoristaModel => _frotaMotoristaModel.value;
  set frotaMotoristaModel(value) => _frotaMotoristaModel.value = value ?? FrotaMotoristaModel();

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
    for (var frotaMotoristaModel in _frotaMotoristaModelList) {
      plutoRowList.add(_getPlutoRow(frotaMotoristaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FrotaMotoristaModel frotaMotoristaModel) {
    return PlutoRow(
      cells: _getPlutoCells(frotaMotoristaModel: frotaMotoristaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FrotaMotoristaModel? frotaMotoristaModel}) {
    return {
			"id": PlutoCell(value: frotaMotoristaModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: frotaMotoristaModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"nome": PlutoCell(value: frotaMotoristaModel?.nome ?? ''),
			"numeroCnh": PlutoCell(value: frotaMotoristaModel?.numeroCnh ?? ''),
			"cnhCategoria": PlutoCell(value: frotaMotoristaModel?.cnhCategoria ?? ''),
			"idColaborador": PlutoCell(value: frotaMotoristaModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _frotaMotoristaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      frotaMotoristaModel.plutoRowToObject(plutoRow);
    } else {
      frotaMotoristaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Motorista]';
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
    await Get.find<FrotaMotoristaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await frotaMotoristaRepository.getList(filter: filter).then( (data){ _frotaMotoristaModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Motorista',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			numeroCnhController.text = currentRow.cells['numeroCnh']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.frotaMotoristaEditPage)!.then((value) {
        if (frotaMotoristaModel.id == 0) {
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
    frotaMotoristaModel = FrotaMotoristaModel();
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
        if (await frotaMotoristaRepository.delete(id: currentRow.cells['id']!.value)) {
          _frotaMotoristaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaColaboradorModelController = TextEditingController();
	final nomeController = TextEditingController();
	final numeroCnhController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = frotaMotoristaModel.id;
		plutoRow.cells['idColaborador']?.value = frotaMotoristaModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = frotaMotoristaModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['nome']?.value = frotaMotoristaModel.nome;
		plutoRow.cells['numeroCnh']?.value = frotaMotoristaModel.numeroCnh;
		plutoRow.cells['cnhCategoria']?.value = frotaMotoristaModel.cnhCategoria;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await frotaMotoristaRepository.save(frotaMotoristaModel: frotaMotoristaModel); 
        if (result != null) {
          frotaMotoristaModel = result;
          if (_isInserting) {
            _frotaMotoristaModelList.add(result);
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

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			frotaMotoristaModel.idColaborador = plutoRowResult.cells['id']!.value; 
			frotaMotoristaModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = frotaMotoristaModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "frota_motorista";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
		nomeController.dispose();
		numeroCnhController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}