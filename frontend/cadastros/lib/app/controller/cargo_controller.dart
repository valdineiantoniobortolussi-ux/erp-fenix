import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/cargo_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class CargoController extends GetxController with ControllerBaseMixin {
  final CargoRepository cargoRepository;
  CargoController({required this.cargoRepository});

  // general
  final _dbColumns = CargoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = CargoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = cargoGridColumns();
  
  var _cargoModelList = <CargoModel>[];

  final _cargoModel = CargoModel().obs;
  CargoModel get cargoModel => _cargoModel.value;
  set cargoModel(value) => _cargoModel.value = value ?? CargoModel();

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
    for (var cargoModel in _cargoModelList) {
      plutoRowList.add(_getPlutoRow(cargoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(CargoModel cargoModel) {
    return PlutoRow(
      cells: _getPlutoCells(cargoModel: cargoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ CargoModel? cargoModel}) {
    return {
			"id": PlutoCell(value: cargoModel?.id ?? 0),
			"nome": PlutoCell(value: cargoModel?.nome ?? ''),
			"descricao": PlutoCell(value: cargoModel?.descricao ?? ''),
			"salario": PlutoCell(value: cargoModel?.salario ?? 0),
			"cbo1994": PlutoCell(value: cargoModel?.cbo1994 ?? ''),
			"cbo2002": PlutoCell(value: cargoModel?.cbo2002 ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _cargoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      cargoModel.plutoRowToObject(plutoRow);
    } else {
      cargoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Cargo]';
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
    await Get.find<CargoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await cargoRepository.getList(filter: filter).then( (data){ _cargoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Cargo',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			salarioController.text = currentRow.cells['salario']?.value?.toStringAsFixed(2) ?? '';
			cbo1994Controller.text = currentRow.cells['cbo1994']?.value ?? '';
			cbo2002Controller.text = currentRow.cells['cbo2002']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.cargoEditPage)!.then((value) {
        if (cargoModel.id == 0) {
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
    cargoModel = CargoModel();
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
        if (await cargoRepository.delete(id: currentRow.cells['id']!.value)) {
          _cargoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final salarioController = MoneyMaskedTextController();
	final cbo1994Controller = TextEditingController();
	final cbo2002Controller = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cargoModel.id;
		plutoRow.cells['nome']?.value = cargoModel.nome;
		plutoRow.cells['descricao']?.value = cargoModel.descricao;
		plutoRow.cells['salario']?.value = cargoModel.salario;
		plutoRow.cells['cbo1994']?.value = cargoModel.cbo1994;
		plutoRow.cells['cbo2002']?.value = cargoModel.cbo2002;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await cargoRepository.save(cargoModel: cargoModel); 
        if (result != null) {
          cargoModel = result;
          if (_isInserting) {
            _cargoModelList.add(result);
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


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "cargo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		descricaoController.dispose();
		salarioController.dispose();
		cbo1994Controller.dispose();
		cbo2002Controller.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}