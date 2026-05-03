import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/ferias_periodo_aquisitivo_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FeriasPeriodoAquisitivoController extends GetxController with ControllerBaseMixin {
  final FeriasPeriodoAquisitivoRepository feriasPeriodoAquisitivoRepository;
  FeriasPeriodoAquisitivoController({required this.feriasPeriodoAquisitivoRepository});

  // general
  final _dbColumns = FeriasPeriodoAquisitivoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FeriasPeriodoAquisitivoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = feriasPeriodoAquisitivoGridColumns();
  
  var _feriasPeriodoAquisitivoModelList = <FeriasPeriodoAquisitivoModel>[];

  final _feriasPeriodoAquisitivoModel = FeriasPeriodoAquisitivoModel().obs;
  FeriasPeriodoAquisitivoModel get feriasPeriodoAquisitivoModel => _feriasPeriodoAquisitivoModel.value;
  set feriasPeriodoAquisitivoModel(value) => _feriasPeriodoAquisitivoModel.value = value ?? FeriasPeriodoAquisitivoModel();

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
    for (var feriasPeriodoAquisitivoModel in _feriasPeriodoAquisitivoModelList) {
      plutoRowList.add(_getPlutoRow(feriasPeriodoAquisitivoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FeriasPeriodoAquisitivoModel feriasPeriodoAquisitivoModel) {
    return PlutoRow(
      cells: _getPlutoCells(feriasPeriodoAquisitivoModel: feriasPeriodoAquisitivoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FeriasPeriodoAquisitivoModel? feriasPeriodoAquisitivoModel}) {
    return {
			"id": PlutoCell(value: feriasPeriodoAquisitivoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: feriasPeriodoAquisitivoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataInicio": PlutoCell(value: feriasPeriodoAquisitivoModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: feriasPeriodoAquisitivoModel?.dataFim ?? ''),
			"situacao": PlutoCell(value: feriasPeriodoAquisitivoModel?.situacao ?? ''),
			"limiteParaGozo": PlutoCell(value: feriasPeriodoAquisitivoModel?.limiteParaGozo ?? ''),
			"descontarFaltas": PlutoCell(value: feriasPeriodoAquisitivoModel?.descontarFaltas ?? ''),
			"desconsiderarAfastamento": PlutoCell(value: feriasPeriodoAquisitivoModel?.desconsiderarAfastamento ?? ''),
			"afastamentoPrevidencia": PlutoCell(value: feriasPeriodoAquisitivoModel?.afastamentoPrevidencia ?? 0),
			"afastamentoSemRemun": PlutoCell(value: feriasPeriodoAquisitivoModel?.afastamentoSemRemun ?? 0),
			"afastamentoComRemun": PlutoCell(value: feriasPeriodoAquisitivoModel?.afastamentoComRemun ?? 0),
			"diasDireito": PlutoCell(value: feriasPeriodoAquisitivoModel?.diasDireito ?? 0),
			"diasGozados": PlutoCell(value: feriasPeriodoAquisitivoModel?.diasGozados ?? 0),
			"diasFaltas": PlutoCell(value: feriasPeriodoAquisitivoModel?.diasFaltas ?? 0),
			"diasRestantes": PlutoCell(value: feriasPeriodoAquisitivoModel?.diasRestantes ?? 0),
			"idColaborador": PlutoCell(value: feriasPeriodoAquisitivoModel?.idColaborador ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _feriasPeriodoAquisitivoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      feriasPeriodoAquisitivoModel.plutoRowToObject(plutoRow);
    } else {
      feriasPeriodoAquisitivoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Períodos Aquisitivos]';
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
    await Get.find<FeriasPeriodoAquisitivoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await feriasPeriodoAquisitivoRepository.getList(filter: filter).then( (data){ _feriasPeriodoAquisitivoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Períodos Aquisitivos',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			afastamentoPrevidenciaController.text = currentRow.cells['afastamentoPrevidencia']?.value?.toString() ?? '';
			afastamentoSemRemunController.text = currentRow.cells['afastamentoSemRemun']?.value?.toString() ?? '';
			afastamentoComRemunController.text = currentRow.cells['afastamentoComRemun']?.value?.toString() ?? '';
			diasDireitoController.text = currentRow.cells['diasDireito']?.value?.toString() ?? '';
			diasGozadosController.text = currentRow.cells['diasGozados']?.value?.toString() ?? '';
			diasFaltasController.text = currentRow.cells['diasFaltas']?.value?.toString() ?? '';
			diasRestantesController.text = currentRow.cells['diasRestantes']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.feriasPeriodoAquisitivoEditPage)!.then((value) {
        if (feriasPeriodoAquisitivoModel.id == 0) {
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
    feriasPeriodoAquisitivoModel = FeriasPeriodoAquisitivoModel();
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
        if (await feriasPeriodoAquisitivoRepository.delete(id: currentRow.cells['id']!.value)) {
          _feriasPeriodoAquisitivoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final afastamentoPrevidenciaController = TextEditingController();
	final afastamentoSemRemunController = TextEditingController();
	final afastamentoComRemunController = TextEditingController();
	final diasDireitoController = TextEditingController();
	final diasGozadosController = TextEditingController();
	final diasFaltasController = TextEditingController();
	final diasRestantesController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = feriasPeriodoAquisitivoModel.id;
		plutoRow.cells['idColaborador']?.value = feriasPeriodoAquisitivoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = feriasPeriodoAquisitivoModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(feriasPeriodoAquisitivoModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(feriasPeriodoAquisitivoModel.dataFim);
		plutoRow.cells['situacao']?.value = feriasPeriodoAquisitivoModel.situacao;
		plutoRow.cells['limiteParaGozo']?.value = Util.formatDate(feriasPeriodoAquisitivoModel.limiteParaGozo);
		plutoRow.cells['descontarFaltas']?.value = feriasPeriodoAquisitivoModel.descontarFaltas;
		plutoRow.cells['desconsiderarAfastamento']?.value = feriasPeriodoAquisitivoModel.desconsiderarAfastamento;
		plutoRow.cells['afastamentoPrevidencia']?.value = feriasPeriodoAquisitivoModel.afastamentoPrevidencia;
		plutoRow.cells['afastamentoSemRemun']?.value = feriasPeriodoAquisitivoModel.afastamentoSemRemun;
		plutoRow.cells['afastamentoComRemun']?.value = feriasPeriodoAquisitivoModel.afastamentoComRemun;
		plutoRow.cells['diasDireito']?.value = feriasPeriodoAquisitivoModel.diasDireito;
		plutoRow.cells['diasGozados']?.value = feriasPeriodoAquisitivoModel.diasGozados;
		plutoRow.cells['diasFaltas']?.value = feriasPeriodoAquisitivoModel.diasFaltas;
		plutoRow.cells['diasRestantes']?.value = feriasPeriodoAquisitivoModel.diasRestantes;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await feriasPeriodoAquisitivoRepository.save(feriasPeriodoAquisitivoModel: feriasPeriodoAquisitivoModel); 
        if (result != null) {
          feriasPeriodoAquisitivoModel = result;
          if (_isInserting) {
            _feriasPeriodoAquisitivoModelList.add(result);
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
			feriasPeriodoAquisitivoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			feriasPeriodoAquisitivoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = feriasPeriodoAquisitivoModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "ferias_periodo_aquisitivo";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		viewPessoaColaboradorModelController.dispose();
		afastamentoPrevidenciaController.dispose();
		afastamentoSemRemunController.dispose();
		afastamentoComRemunController.dispose();
		diasDireitoController.dispose();
		diasGozadosController.dispose();
		diasFaltasController.dispose();
		diasRestantesController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}