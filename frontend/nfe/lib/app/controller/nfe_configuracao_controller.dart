import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/controller/controller_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:nfe/app/routes/app_routes.dart';
import 'package:nfe/app/data/repository/nfe_configuracao_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeConfiguracaoController extends GetxController with ControllerBaseMixin {
  final NfeConfiguracaoRepository nfeConfiguracaoRepository;
  NfeConfiguracaoController({required this.nfeConfiguracaoRepository});

  // general
  final _dbColumns = NfeConfiguracaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeConfiguracaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeConfiguracaoGridColumns();
  
  var _nfeConfiguracaoModelList = <NfeConfiguracaoModel>[];

  final _nfeConfiguracaoModel = NfeConfiguracaoModel().obs;
  NfeConfiguracaoModel get nfeConfiguracaoModel => _nfeConfiguracaoModel.value;
  set nfeConfiguracaoModel(value) => _nfeConfiguracaoModel.value = value ?? NfeConfiguracaoModel();

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
    for (var nfeConfiguracaoModel in _nfeConfiguracaoModelList) {
      plutoRowList.add(_getPlutoRow(nfeConfiguracaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeConfiguracaoModel nfeConfiguracaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeConfiguracaoModel: nfeConfiguracaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeConfiguracaoModel? nfeConfiguracaoModel}) {
    return {
			"id": PlutoCell(value: nfeConfiguracaoModel?.id ?? 0),
			"certificadoDigitalSerie": PlutoCell(value: nfeConfiguracaoModel?.certificadoDigitalSerie ?? ''),
			"certificadoDigitalCaminho": PlutoCell(value: nfeConfiguracaoModel?.certificadoDigitalCaminho ?? ''),
			"certificadoDigitalSenha": PlutoCell(value: nfeConfiguracaoModel?.certificadoDigitalSenha ?? ''),
			"tipoEmissao": PlutoCell(value: nfeConfiguracaoModel?.tipoEmissao ?? 0),
			"formatoImpressaoDanfe": PlutoCell(value: nfeConfiguracaoModel?.formatoImpressaoDanfe ?? 0),
			"processoEmissao": PlutoCell(value: nfeConfiguracaoModel?.processoEmissao ?? 0),
			"versaoProcessoEmissao": PlutoCell(value: nfeConfiguracaoModel?.versaoProcessoEmissao ?? ''),
			"caminhoLogomarca": PlutoCell(value: nfeConfiguracaoModel?.caminhoLogomarca ?? ''),
			"salvarXml": PlutoCell(value: nfeConfiguracaoModel?.salvarXml ?? ''),
			"caminhoSalvarXml": PlutoCell(value: nfeConfiguracaoModel?.caminhoSalvarXml ?? ''),
			"caminhoSchemas": PlutoCell(value: nfeConfiguracaoModel?.caminhoSchemas ?? ''),
			"caminhoArquivoDanfe": PlutoCell(value: nfeConfiguracaoModel?.caminhoArquivoDanfe ?? ''),
			"caminhoSalvarPdf": PlutoCell(value: nfeConfiguracaoModel?.caminhoSalvarPdf ?? ''),
			"webserviceUf": PlutoCell(value: nfeConfiguracaoModel?.webserviceUf ?? ''),
			"webserviceAmbiente": PlutoCell(value: nfeConfiguracaoModel?.webserviceAmbiente ?? 0),
			"webserviceProxyHost": PlutoCell(value: nfeConfiguracaoModel?.webserviceProxyHost ?? ''),
			"webserviceProxyPorta": PlutoCell(value: nfeConfiguracaoModel?.webserviceProxyPorta ?? 0),
			"webserviceProxyUsuario": PlutoCell(value: nfeConfiguracaoModel?.webserviceProxyUsuario ?? ''),
			"webserviceProxySenha": PlutoCell(value: nfeConfiguracaoModel?.webserviceProxySenha ?? ''),
			"webserviceVisualizar": PlutoCell(value: nfeConfiguracaoModel?.webserviceVisualizar ?? ''),
			"emailServidorSmtp": PlutoCell(value: nfeConfiguracaoModel?.emailServidorSmtp ?? ''),
			"emailPorta": PlutoCell(value: nfeConfiguracaoModel?.emailPorta ?? 0),
			"emailUsuario": PlutoCell(value: nfeConfiguracaoModel?.emailUsuario ?? ''),
			"emailSenha": PlutoCell(value: nfeConfiguracaoModel?.emailSenha ?? ''),
			"emailAssunto": PlutoCell(value: nfeConfiguracaoModel?.emailAssunto ?? ''),
			"emailAutenticaSsl": PlutoCell(value: nfeConfiguracaoModel?.emailAutenticaSsl ?? ''),
			"emailTexto": PlutoCell(value: nfeConfiguracaoModel?.emailTexto ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeConfiguracaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeConfiguracaoModel.plutoRowToObject(plutoRow);
    } else {
      nfeConfiguracaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Configurações da NF-e]';
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
    await Get.find<NfeConfiguracaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeConfiguracaoRepository.getList(filter: filter).then( (data){ _nfeConfiguracaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Configurações da NF-e',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			certificadoDigitalSerieController.text = currentRow.cells['certificadoDigitalSerie']?.value ?? '';
			certificadoDigitalCaminhoController.text = currentRow.cells['certificadoDigitalCaminho']?.value ?? '';
			certificadoDigitalSenhaController.text = currentRow.cells['certificadoDigitalSenha']?.value ?? '';
			tipoEmissaoController.text = currentRow.cells['tipoEmissao']?.value?.toString() ?? '';
			formatoImpressaoDanfeController.text = currentRow.cells['formatoImpressaoDanfe']?.value?.toString() ?? '';
			processoEmissaoController.text = currentRow.cells['processoEmissao']?.value?.toString() ?? '';
			versaoProcessoEmissaoController.text = currentRow.cells['versaoProcessoEmissao']?.value ?? '';
			caminhoLogomarcaController.text = currentRow.cells['caminhoLogomarca']?.value ?? '';
			caminhoSalvarXmlController.text = currentRow.cells['caminhoSalvarXml']?.value ?? '';
			caminhoSchemasController.text = currentRow.cells['caminhoSchemas']?.value ?? '';
			caminhoArquivoDanfeController.text = currentRow.cells['caminhoArquivoDanfe']?.value ?? '';
			caminhoSalvarPdfController.text = currentRow.cells['caminhoSalvarPdf']?.value ?? '';
			webserviceAmbienteController.text = currentRow.cells['webserviceAmbiente']?.value?.toString() ?? '';
			webserviceProxyHostController.text = currentRow.cells['webserviceProxyHost']?.value ?? '';
			webserviceProxyPortaController.text = currentRow.cells['webserviceProxyPorta']?.value?.toString() ?? '';
			webserviceProxyUsuarioController.text = currentRow.cells['webserviceProxyUsuario']?.value ?? '';
			webserviceProxySenhaController.text = currentRow.cells['webserviceProxySenha']?.value ?? '';
			emailServidorSmtpController.text = currentRow.cells['emailServidorSmtp']?.value ?? '';
			emailPortaController.text = currentRow.cells['emailPorta']?.value?.toString() ?? '';
			emailUsuarioController.text = currentRow.cells['emailUsuario']?.value ?? '';
			emailSenhaController.text = currentRow.cells['emailSenha']?.value ?? '';
			emailAssuntoController.text = currentRow.cells['emailAssunto']?.value ?? '';
			emailTextoController.text = currentRow.cells['emailTexto']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeConfiguracaoEditPage)!.then((value) {
        if (nfeConfiguracaoModel.id == 0) {
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
    nfeConfiguracaoModel = NfeConfiguracaoModel();
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
        if (await nfeConfiguracaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeConfiguracaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final certificadoDigitalSerieController = TextEditingController();
	final certificadoDigitalCaminhoController = TextEditingController();
	final certificadoDigitalSenhaController = TextEditingController();
	final tipoEmissaoController = TextEditingController();
	final formatoImpressaoDanfeController = TextEditingController();
	final processoEmissaoController = TextEditingController();
	final versaoProcessoEmissaoController = TextEditingController();
	final caminhoLogomarcaController = TextEditingController();
	final caminhoSalvarXmlController = TextEditingController();
	final caminhoSchemasController = TextEditingController();
	final caminhoArquivoDanfeController = TextEditingController();
	final caminhoSalvarPdfController = TextEditingController();
	final webserviceAmbienteController = TextEditingController();
	final webserviceProxyHostController = TextEditingController();
	final webserviceProxyPortaController = TextEditingController();
	final webserviceProxyUsuarioController = TextEditingController();
	final webserviceProxySenhaController = TextEditingController();
	final emailServidorSmtpController = TextEditingController();
	final emailPortaController = TextEditingController();
	final emailUsuarioController = TextEditingController();
	final emailSenhaController = TextEditingController();
	final emailAssuntoController = TextEditingController();
	final emailTextoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeConfiguracaoModel.id;
		plutoRow.cells['certificadoDigitalSerie']?.value = nfeConfiguracaoModel.certificadoDigitalSerie;
		plutoRow.cells['certificadoDigitalCaminho']?.value = nfeConfiguracaoModel.certificadoDigitalCaminho;
		plutoRow.cells['certificadoDigitalSenha']?.value = nfeConfiguracaoModel.certificadoDigitalSenha;
		plutoRow.cells['tipoEmissao']?.value = nfeConfiguracaoModel.tipoEmissao;
		plutoRow.cells['formatoImpressaoDanfe']?.value = nfeConfiguracaoModel.formatoImpressaoDanfe;
		plutoRow.cells['processoEmissao']?.value = nfeConfiguracaoModel.processoEmissao;
		plutoRow.cells['versaoProcessoEmissao']?.value = nfeConfiguracaoModel.versaoProcessoEmissao;
		plutoRow.cells['caminhoLogomarca']?.value = nfeConfiguracaoModel.caminhoLogomarca;
		plutoRow.cells['salvarXml']?.value = nfeConfiguracaoModel.salvarXml;
		plutoRow.cells['caminhoSalvarXml']?.value = nfeConfiguracaoModel.caminhoSalvarXml;
		plutoRow.cells['caminhoSchemas']?.value = nfeConfiguracaoModel.caminhoSchemas;
		plutoRow.cells['caminhoArquivoDanfe']?.value = nfeConfiguracaoModel.caminhoArquivoDanfe;
		plutoRow.cells['caminhoSalvarPdf']?.value = nfeConfiguracaoModel.caminhoSalvarPdf;
		plutoRow.cells['webserviceUf']?.value = nfeConfiguracaoModel.webserviceUf;
		plutoRow.cells['webserviceAmbiente']?.value = nfeConfiguracaoModel.webserviceAmbiente;
		plutoRow.cells['webserviceProxyHost']?.value = nfeConfiguracaoModel.webserviceProxyHost;
		plutoRow.cells['webserviceProxyPorta']?.value = nfeConfiguracaoModel.webserviceProxyPorta;
		plutoRow.cells['webserviceProxyUsuario']?.value = nfeConfiguracaoModel.webserviceProxyUsuario;
		plutoRow.cells['webserviceProxySenha']?.value = nfeConfiguracaoModel.webserviceProxySenha;
		plutoRow.cells['webserviceVisualizar']?.value = nfeConfiguracaoModel.webserviceVisualizar;
		plutoRow.cells['emailServidorSmtp']?.value = nfeConfiguracaoModel.emailServidorSmtp;
		plutoRow.cells['emailPorta']?.value = nfeConfiguracaoModel.emailPorta;
		plutoRow.cells['emailUsuario']?.value = nfeConfiguracaoModel.emailUsuario;
		plutoRow.cells['emailSenha']?.value = nfeConfiguracaoModel.emailSenha;
		plutoRow.cells['emailAssunto']?.value = nfeConfiguracaoModel.emailAssunto;
		plutoRow.cells['emailAutenticaSsl']?.value = nfeConfiguracaoModel.emailAutenticaSsl;
		plutoRow.cells['emailTexto']?.value = nfeConfiguracaoModel.emailTexto;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeConfiguracaoRepository.save(nfeConfiguracaoModel: nfeConfiguracaoModel); 
        if (result != null) {
          nfeConfiguracaoModel = result;
          if (_isInserting) {
            _nfeConfiguracaoModelList.add(result);
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
		functionName = "nfe_configuracao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		certificadoDigitalSerieController.dispose();
		certificadoDigitalCaminhoController.dispose();
		certificadoDigitalSenhaController.dispose();
		tipoEmissaoController.dispose();
		formatoImpressaoDanfeController.dispose();
		processoEmissaoController.dispose();
		versaoProcessoEmissaoController.dispose();
		caminhoLogomarcaController.dispose();
		caminhoSalvarXmlController.dispose();
		caminhoSchemasController.dispose();
		caminhoArquivoDanfeController.dispose();
		caminhoSalvarPdfController.dispose();
		webserviceAmbienteController.dispose();
		webserviceProxyHostController.dispose();
		webserviceProxyPortaController.dispose();
		webserviceProxyUsuarioController.dispose();
		webserviceProxySenhaController.dispose();
		emailServidorSmtpController.dispose();
		emailPortaController.dispose();
		emailUsuarioController.dispose();
		emailSenhaController.dispose();
		emailAssuntoController.dispose();
		emailTextoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}