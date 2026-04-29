import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_parametro_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaParametroController extends GetxController with ControllerBaseMixin {
  final FolhaParametroRepository folhaParametroRepository;
  FolhaParametroController({required this.folhaParametroRepository});

  // general
  final _dbColumns = FolhaParametroModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaParametroModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaParametroGridColumns();
  
  var _folhaParametroModelList = <FolhaParametroModel>[];

  final _folhaParametroModel = FolhaParametroModel().obs;
  FolhaParametroModel get folhaParametroModel => _folhaParametroModel.value;
  set folhaParametroModel(value) => _folhaParametroModel.value = value ?? FolhaParametroModel();

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
    for (var folhaParametroModel in _folhaParametroModelList) {
      plutoRowList.add(_getPlutoRow(folhaParametroModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaParametroModel folhaParametroModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaParametroModel: folhaParametroModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaParametroModel? folhaParametroModel}) {
    return {
			"id": PlutoCell(value: folhaParametroModel?.id ?? 0),
			"competencia": PlutoCell(value: folhaParametroModel?.competencia ?? ''),
			"contribuiPis": PlutoCell(value: folhaParametroModel?.contribuiPis ?? ''),
			"aliquotaPis": PlutoCell(value: folhaParametroModel?.aliquotaPis ?? 0),
			"discriminarDsr": PlutoCell(value: folhaParametroModel?.discriminarDsr ?? ''),
			"diaPagamento": PlutoCell(value: folhaParametroModel?.diaPagamento ?? ''),
			"calculoProporcionalidade": PlutoCell(value: folhaParametroModel?.calculoProporcionalidade ?? ''),
			"descontarFaltas13": PlutoCell(value: folhaParametroModel?.descontarFaltas13 ?? ''),
			"pagarAdicionais13": PlutoCell(value: folhaParametroModel?.pagarAdicionais13 ?? ''),
			"pagarEstagiarios13": PlutoCell(value: folhaParametroModel?.pagarEstagiarios13 ?? ''),
			"mesAdiantamento13": PlutoCell(value: folhaParametroModel?.mesAdiantamento13 ?? ''),
			"percentualAdiantam13": PlutoCell(value: folhaParametroModel?.percentualAdiantam13 ?? 0),
			"feriasDescontarFaltas": PlutoCell(value: folhaParametroModel?.feriasDescontarFaltas ?? ''),
			"feriasPagarAdicionais": PlutoCell(value: folhaParametroModel?.feriasPagarAdicionais ?? ''),
			"feriasAdiantar13": PlutoCell(value: folhaParametroModel?.feriasAdiantar13 ?? ''),
			"feriasPagarEstagiarios": PlutoCell(value: folhaParametroModel?.feriasPagarEstagiarios ?? ''),
			"feriasCalcJustaCausa": PlutoCell(value: folhaParametroModel?.feriasCalcJustaCausa ?? ''),
			"feriasMovimentoMensal": PlutoCell(value: folhaParametroModel?.feriasMovimentoMensal ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaParametroModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaParametroModel.plutoRowToObject(plutoRow);
    } else {
      folhaParametroModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Parâmetros]';
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
    await Get.find<FolhaParametroController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaParametroRepository.getList(filter: filter).then( (data){ _folhaParametroModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Parâmetros',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			competenciaController.text = currentRow.cells['competencia']?.value ?? '';
			aliquotaPisController.text = currentRow.cells['aliquotaPis']?.value?.toStringAsFixed(2) ?? '';
			diaPagamentoController.text = currentRow.cells['diaPagamento']?.value ?? '';
			mesAdiantamento13Controller.text = currentRow.cells['mesAdiantamento13']?.value ?? '';
			percentualAdiantam13Controller.text = currentRow.cells['percentualAdiantam13']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaParametroEditPage)!.then((value) {
        if (folhaParametroModel.id == 0) {
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
    folhaParametroModel = FolhaParametroModel();
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
        if (await folhaParametroRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaParametroModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final competenciaController = MaskedTextController(mask: '00/0000',);
	final aliquotaPisController = MoneyMaskedTextController();
	final diaPagamentoController = TextEditingController();
	final mesAdiantamento13Controller = TextEditingController();
	final percentualAdiantam13Controller = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaParametroModel.id;
		plutoRow.cells['competencia']?.value = folhaParametroModel.competencia;
		plutoRow.cells['contribuiPis']?.value = folhaParametroModel.contribuiPis;
		plutoRow.cells['aliquotaPis']?.value = folhaParametroModel.aliquotaPis;
		plutoRow.cells['discriminarDsr']?.value = folhaParametroModel.discriminarDsr;
		plutoRow.cells['diaPagamento']?.value = folhaParametroModel.diaPagamento;
		plutoRow.cells['calculoProporcionalidade']?.value = folhaParametroModel.calculoProporcionalidade;
		plutoRow.cells['descontarFaltas13']?.value = folhaParametroModel.descontarFaltas13;
		plutoRow.cells['pagarAdicionais13']?.value = folhaParametroModel.pagarAdicionais13;
		plutoRow.cells['pagarEstagiarios13']?.value = folhaParametroModel.pagarEstagiarios13;
		plutoRow.cells['mesAdiantamento13']?.value = folhaParametroModel.mesAdiantamento13;
		plutoRow.cells['percentualAdiantam13']?.value = folhaParametroModel.percentualAdiantam13;
		plutoRow.cells['feriasDescontarFaltas']?.value = folhaParametroModel.feriasDescontarFaltas;
		plutoRow.cells['feriasPagarAdicionais']?.value = folhaParametroModel.feriasPagarAdicionais;
		plutoRow.cells['feriasAdiantar13']?.value = folhaParametroModel.feriasAdiantar13;
		plutoRow.cells['feriasPagarEstagiarios']?.value = folhaParametroModel.feriasPagarEstagiarios;
		plutoRow.cells['feriasCalcJustaCausa']?.value = folhaParametroModel.feriasCalcJustaCausa;
		plutoRow.cells['feriasMovimentoMensal']?.value = folhaParametroModel.feriasMovimentoMensal;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaParametroRepository.save(folhaParametroModel: folhaParametroModel); 
        if (result != null) {
          folhaParametroModel = result;
          if (_isInserting) {
            _folhaParametroModelList.add(result);
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
		functionName = "folha_parametro";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		competenciaController.dispose();
		aliquotaPisController.dispose();
		diaPagamentoController.dispose();
		mesAdiantamento13Controller.dispose();
		percentualAdiantam13Controller.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}