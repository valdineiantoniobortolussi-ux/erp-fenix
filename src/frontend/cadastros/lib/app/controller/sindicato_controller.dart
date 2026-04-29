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
import 'package:cadastros/app/data/repository/sindicato_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class SindicatoController extends GetxController with ControllerBaseMixin {
  final SindicatoRepository sindicatoRepository;
  SindicatoController({required this.sindicatoRepository});

  // general
  final _dbColumns = SindicatoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = SindicatoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = sindicatoGridColumns();
  
  var _sindicatoModelList = <SindicatoModel>[];

  final _sindicatoModel = SindicatoModel().obs;
  SindicatoModel get sindicatoModel => _sindicatoModel.value;
  set sindicatoModel(value) => _sindicatoModel.value = value ?? SindicatoModel();

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
    for (var sindicatoModel in _sindicatoModelList) {
      plutoRowList.add(_getPlutoRow(sindicatoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(SindicatoModel sindicatoModel) {
    return PlutoRow(
      cells: _getPlutoCells(sindicatoModel: sindicatoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ SindicatoModel? sindicatoModel}) {
    return {
			"id": PlutoCell(value: sindicatoModel?.id ?? 0),
			"nome": PlutoCell(value: sindicatoModel?.nome ?? ''),
			"codigoBanco": PlutoCell(value: sindicatoModel?.codigoBanco ?? 0),
			"codigoAgencia": PlutoCell(value: sindicatoModel?.codigoAgencia ?? 0),
			"contaBanco": PlutoCell(value: sindicatoModel?.contaBanco ?? ''),
			"codigoCedente": PlutoCell(value: sindicatoModel?.codigoCedente ?? ''),
			"logradouro": PlutoCell(value: sindicatoModel?.logradouro ?? ''),
			"numero": PlutoCell(value: sindicatoModel?.numero ?? ''),
			"bairro": PlutoCell(value: sindicatoModel?.bairro ?? ''),
			"municipioIbge": PlutoCell(value: sindicatoModel?.municipioIbge ?? 0),
			"uf": PlutoCell(value: sindicatoModel?.uf ?? ''),
			"fone1": PlutoCell(value: sindicatoModel?.fone1 ?? ''),
			"fone2": PlutoCell(value: sindicatoModel?.fone2 ?? ''),
			"email": PlutoCell(value: sindicatoModel?.email ?? ''),
			"tipoSindicato": PlutoCell(value: sindicatoModel?.tipoSindicato ?? ''),
			"dataBase": PlutoCell(value: sindicatoModel?.dataBase ?? ''),
			"pisoSalarial": PlutoCell(value: sindicatoModel?.pisoSalarial ?? 0),
			"cnpj": PlutoCell(value: sindicatoModel?.cnpj ?? ''),
			"classificacaoContabilConta": PlutoCell(value: sindicatoModel?.classificacaoContabilConta ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _sindicatoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      sindicatoModel.plutoRowToObject(plutoRow);
    } else {
      sindicatoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Sindicato]';
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
    await Get.find<SindicatoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await sindicatoRepository.getList(filter: filter).then( (data){ _sindicatoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Sindicato',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			codigoBancoController.text = currentRow.cells['codigoBanco']?.value?.toString() ?? '';
			codigoAgenciaController.text = currentRow.cells['codigoAgencia']?.value?.toString() ?? '';
			contaBancoController.text = currentRow.cells['contaBanco']?.value ?? '';
			codigoCedenteController.text = currentRow.cells['codigoCedente']?.value ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			municipioIbgeController.text = currentRow.cells['municipioIbge']?.value?.toString() ?? '';
			fone1Controller.text = currentRow.cells['fone1']?.value ?? '';
			fone2Controller.text = currentRow.cells['fone2']?.value ?? '';
			emailController.text = currentRow.cells['email']?.value ?? '';
			pisoSalarialController.text = currentRow.cells['pisoSalarial']?.value?.toStringAsFixed(2) ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			classificacaoContabilContaController.text = currentRow.cells['classificacaoContabilConta']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.sindicatoEditPage)!.then((value) {
        if (sindicatoModel.id == 0) {
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
    sindicatoModel = SindicatoModel();
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
        if (await sindicatoRepository.delete(id: currentRow.cells['id']!.value)) {
          _sindicatoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoBancoController = TextEditingController();
	final codigoAgenciaController = TextEditingController();
	final contaBancoController = TextEditingController();
	final codigoCedenteController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final bairroController = TextEditingController();
	final municipioIbgeController = TextEditingController();
	final fone1Controller = MaskedTextController(mask: '(00)00000-0000',);
	final fone2Controller = MaskedTextController(mask: '(00)00000-0000',);
	final emailController = TextEditingController();
	final pisoSalarialController = MoneyMaskedTextController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final classificacaoContabilContaController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = sindicatoModel.id;
		plutoRow.cells['nome']?.value = sindicatoModel.nome;
		plutoRow.cells['codigoBanco']?.value = sindicatoModel.codigoBanco;
		plutoRow.cells['codigoAgencia']?.value = sindicatoModel.codigoAgencia;
		plutoRow.cells['contaBanco']?.value = sindicatoModel.contaBanco;
		plutoRow.cells['codigoCedente']?.value = sindicatoModel.codigoCedente;
		plutoRow.cells['logradouro']?.value = sindicatoModel.logradouro;
		plutoRow.cells['numero']?.value = sindicatoModel.numero;
		plutoRow.cells['bairro']?.value = sindicatoModel.bairro;
		plutoRow.cells['municipioIbge']?.value = sindicatoModel.municipioIbge;
		plutoRow.cells['uf']?.value = sindicatoModel.uf;
		plutoRow.cells['fone1']?.value = sindicatoModel.fone1;
		plutoRow.cells['fone2']?.value = sindicatoModel.fone2;
		plutoRow.cells['email']?.value = sindicatoModel.email;
		plutoRow.cells['tipoSindicato']?.value = sindicatoModel.tipoSindicato;
		plutoRow.cells['dataBase']?.value = Util.formatDate(sindicatoModel.dataBase);
		plutoRow.cells['pisoSalarial']?.value = sindicatoModel.pisoSalarial;
		plutoRow.cells['cnpj']?.value = sindicatoModel.cnpj;
		plutoRow.cells['classificacaoContabilConta']?.value = sindicatoModel.classificacaoContabilConta;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await sindicatoRepository.save(sindicatoModel: sindicatoModel); 
        if (result != null) {
          sindicatoModel = result;
          if (_isInserting) {
            _sindicatoModelList.add(result);
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
		functionName = "sindicato";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		codigoBancoController.dispose();
		codigoAgenciaController.dispose();
		contaBancoController.dispose();
		codigoCedenteController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		bairroController.dispose();
		municipioIbgeController.dispose();
		fone1Controller.dispose();
		fone2Controller.dispose();
		emailController.dispose();
		pisoSalarialController.dispose();
		cnpjController.dispose();
		classificacaoContabilContaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}