import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/contabil_parametro_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class ContabilParametroController extends GetxController with ControllerBaseMixin {
  final ContabilParametroRepository contabilParametroRepository;
  ContabilParametroController({required this.contabilParametroRepository});

  // general
  final _dbColumns = ContabilParametroModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContabilParametroModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contabilParametroGridColumns();
  
  var _contabilParametroModelList = <ContabilParametroModel>[];

  final _contabilParametroModel = ContabilParametroModel().obs;
  ContabilParametroModel get contabilParametroModel => _contabilParametroModel.value;
  set contabilParametroModel(value) => _contabilParametroModel.value = value ?? ContabilParametroModel();

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
    for (var contabilParametroModel in _contabilParametroModelList) {
      plutoRowList.add(_getPlutoRow(contabilParametroModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContabilParametroModel contabilParametroModel) {
    return PlutoRow(
      cells: _getPlutoCells(contabilParametroModel: contabilParametroModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContabilParametroModel? contabilParametroModel}) {
    return {
			"id": PlutoCell(value: contabilParametroModel?.id ?? 0),
			"mascara": PlutoCell(value: contabilParametroModel?.mascara ?? ''),
			"niveis": PlutoCell(value: contabilParametroModel?.niveis ?? 0),
			"informarContaPor": PlutoCell(value: contabilParametroModel?.informarContaPor ?? ''),
			"compartilhaPlanoConta": PlutoCell(value: contabilParametroModel?.compartilhaPlanoConta ?? ''),
			"compartilhaHistoricos": PlutoCell(value: contabilParametroModel?.compartilhaHistoricos ?? ''),
			"alteraLancamentoOutro": PlutoCell(value: contabilParametroModel?.alteraLancamentoOutro ?? ''),
			"historicoObrigatorio": PlutoCell(value: contabilParametroModel?.historicoObrigatorio ?? ''),
			"permiteLancamentoZerado": PlutoCell(value: contabilParametroModel?.permiteLancamentoZerado ?? ''),
			"geraInformativoSped": PlutoCell(value: contabilParametroModel?.geraInformativoSped ?? ''),
			"spedFormaEscritDiario": PlutoCell(value: contabilParametroModel?.spedFormaEscritDiario ?? ''),
			"spedNomeLivroDiario": PlutoCell(value: contabilParametroModel?.spedNomeLivroDiario ?? ''),
			"assinaturaDireita": PlutoCell(value: contabilParametroModel?.assinaturaDireita ?? ''),
			"assinaturaEsquerda": PlutoCell(value: contabilParametroModel?.assinaturaEsquerda ?? ''),
			"contaAtivo": PlutoCell(value: contabilParametroModel?.contaAtivo ?? ''),
			"contaPassivo": PlutoCell(value: contabilParametroModel?.contaPassivo ?? ''),
			"contaPatrimonioLiquido": PlutoCell(value: contabilParametroModel?.contaPatrimonioLiquido ?? ''),
			"contaDepreciacaoAcumulada": PlutoCell(value: contabilParametroModel?.contaDepreciacaoAcumulada ?? ''),
			"contaCapitalSocial": PlutoCell(value: contabilParametroModel?.contaCapitalSocial ?? ''),
			"contaResultadoExercicio": PlutoCell(value: contabilParametroModel?.contaResultadoExercicio ?? ''),
			"contaPrejuizoAcumulado": PlutoCell(value: contabilParametroModel?.contaPrejuizoAcumulado ?? ''),
			"contaLucroAcumulado": PlutoCell(value: contabilParametroModel?.contaLucroAcumulado ?? ''),
			"contaTituloPagar": PlutoCell(value: contabilParametroModel?.contaTituloPagar ?? ''),
			"contaTituloReceber": PlutoCell(value: contabilParametroModel?.contaTituloReceber ?? ''),
			"contaJurosPassivo": PlutoCell(value: contabilParametroModel?.contaJurosPassivo ?? ''),
			"contaJurosAtivo": PlutoCell(value: contabilParametroModel?.contaJurosAtivo ?? ''),
			"contaDescontoObtido": PlutoCell(value: contabilParametroModel?.contaDescontoObtido ?? ''),
			"contaDescontoConcedido": PlutoCell(value: contabilParametroModel?.contaDescontoConcedido ?? ''),
			"contaCmv": PlutoCell(value: contabilParametroModel?.contaCmv ?? ''),
			"contaVenda": PlutoCell(value: contabilParametroModel?.contaVenda ?? ''),
			"contaVendaServico": PlutoCell(value: contabilParametroModel?.contaVendaServico ?? ''),
			"contaEstoque": PlutoCell(value: contabilParametroModel?.contaEstoque ?? ''),
			"contaApuraResultado": PlutoCell(value: contabilParametroModel?.contaApuraResultado ?? ''),
			"contaJurosApropriar": PlutoCell(value: contabilParametroModel?.contaJurosApropriar ?? ''),
			"idHistPadraoResultado": PlutoCell(value: contabilParametroModel?.idHistPadraoResultado ?? 0),
			"idHistPadraoLucro": PlutoCell(value: contabilParametroModel?.idHistPadraoLucro ?? 0),
			"idHistPadraoPrejuizo": PlutoCell(value: contabilParametroModel?.idHistPadraoPrejuizo ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contabilParametroModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contabilParametroModel.plutoRowToObject(plutoRow);
    } else {
      contabilParametroModel = modelFromRow[0];
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
    await Get.find<ContabilParametroController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contabilParametroRepository.getList(filter: filter).then( (data){ _contabilParametroModelList = data; } );
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
			mascaraController.text = currentRow.cells['mascara']?.value ?? '';
			niveisController.text = currentRow.cells['niveis']?.value?.toString() ?? '';
			spedNomeLivroDiarioController.text = currentRow.cells['spedNomeLivroDiario']?.value ?? '';
			assinaturaDireitaController.text = currentRow.cells['assinaturaDireita']?.value ?? '';
			assinaturaEsquerdaController.text = currentRow.cells['assinaturaEsquerda']?.value ?? '';
			contaAtivoController.text = currentRow.cells['contaAtivo']?.value ?? '';
			contaPassivoController.text = currentRow.cells['contaPassivo']?.value ?? '';
			contaPatrimonioLiquidoController.text = currentRow.cells['contaPatrimonioLiquido']?.value ?? '';
			contaDepreciacaoAcumuladaController.text = currentRow.cells['contaDepreciacaoAcumulada']?.value ?? '';
			contaCapitalSocialController.text = currentRow.cells['contaCapitalSocial']?.value ?? '';
			contaResultadoExercicioController.text = currentRow.cells['contaResultadoExercicio']?.value ?? '';
			contaPrejuizoAcumuladoController.text = currentRow.cells['contaPrejuizoAcumulado']?.value ?? '';
			contaLucroAcumuladoController.text = currentRow.cells['contaLucroAcumulado']?.value ?? '';
			contaTituloPagarController.text = currentRow.cells['contaTituloPagar']?.value ?? '';
			contaTituloReceberController.text = currentRow.cells['contaTituloReceber']?.value ?? '';
			contaJurosPassivoController.text = currentRow.cells['contaJurosPassivo']?.value ?? '';
			contaJurosAtivoController.text = currentRow.cells['contaJurosAtivo']?.value ?? '';
			contaDescontoObtidoController.text = currentRow.cells['contaDescontoObtido']?.value ?? '';
			contaDescontoConcedidoController.text = currentRow.cells['contaDescontoConcedido']?.value ?? '';
			contaCmvController.text = currentRow.cells['contaCmv']?.value ?? '';
			contaVendaController.text = currentRow.cells['contaVenda']?.value ?? '';
			contaVendaServicoController.text = currentRow.cells['contaVendaServico']?.value ?? '';
			contaEstoqueController.text = currentRow.cells['contaEstoque']?.value ?? '';
			contaApuraResultadoController.text = currentRow.cells['contaApuraResultado']?.value ?? '';
			contaJurosApropriarController.text = currentRow.cells['contaJurosApropriar']?.value ?? '';
			idHistPadraoResultadoController.text = currentRow.cells['idHistPadraoResultado']?.value?.toString() ?? '';
			idHistPadraoLucroController.text = currentRow.cells['idHistPadraoLucro']?.value?.toString() ?? '';
			idHistPadraoPrejuizoController.text = currentRow.cells['idHistPadraoPrejuizo']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contabilParametroEditPage)!.then((value) {
        if (contabilParametroModel.id == 0) {
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
    contabilParametroModel = ContabilParametroModel();
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
        if (await contabilParametroRepository.delete(id: currentRow.cells['id']!.value)) {
          _contabilParametroModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final mascaraController = TextEditingController();
	final niveisController = TextEditingController();
	final spedNomeLivroDiarioController = TextEditingController();
	final assinaturaDireitaController = TextEditingController();
	final assinaturaEsquerdaController = TextEditingController();
	final contaAtivoController = TextEditingController();
	final contaPassivoController = TextEditingController();
	final contaPatrimonioLiquidoController = TextEditingController();
	final contaDepreciacaoAcumuladaController = TextEditingController();
	final contaCapitalSocialController = TextEditingController();
	final contaResultadoExercicioController = TextEditingController();
	final contaPrejuizoAcumuladoController = TextEditingController();
	final contaLucroAcumuladoController = TextEditingController();
	final contaTituloPagarController = TextEditingController();
	final contaTituloReceberController = TextEditingController();
	final contaJurosPassivoController = TextEditingController();
	final contaJurosAtivoController = TextEditingController();
	final contaDescontoObtidoController = TextEditingController();
	final contaDescontoConcedidoController = TextEditingController();
	final contaCmvController = TextEditingController();
	final contaVendaController = TextEditingController();
	final contaVendaServicoController = TextEditingController();
	final contaEstoqueController = TextEditingController();
	final contaApuraResultadoController = TextEditingController();
	final contaJurosApropriarController = TextEditingController();
	final idHistPadraoResultadoController = TextEditingController();
	final idHistPadraoLucroController = TextEditingController();
	final idHistPadraoPrejuizoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilParametroModel.id;
		plutoRow.cells['mascara']?.value = contabilParametroModel.mascara;
		plutoRow.cells['niveis']?.value = contabilParametroModel.niveis;
		plutoRow.cells['informarContaPor']?.value = contabilParametroModel.informarContaPor;
		plutoRow.cells['compartilhaPlanoConta']?.value = contabilParametroModel.compartilhaPlanoConta;
		plutoRow.cells['compartilhaHistoricos']?.value = contabilParametroModel.compartilhaHistoricos;
		plutoRow.cells['alteraLancamentoOutro']?.value = contabilParametroModel.alteraLancamentoOutro;
		plutoRow.cells['historicoObrigatorio']?.value = contabilParametroModel.historicoObrigatorio;
		plutoRow.cells['permiteLancamentoZerado']?.value = contabilParametroModel.permiteLancamentoZerado;
		plutoRow.cells['geraInformativoSped']?.value = contabilParametroModel.geraInformativoSped;
		plutoRow.cells['spedFormaEscritDiario']?.value = contabilParametroModel.spedFormaEscritDiario;
		plutoRow.cells['spedNomeLivroDiario']?.value = contabilParametroModel.spedNomeLivroDiario;
		plutoRow.cells['assinaturaDireita']?.value = contabilParametroModel.assinaturaDireita;
		plutoRow.cells['assinaturaEsquerda']?.value = contabilParametroModel.assinaturaEsquerda;
		plutoRow.cells['contaAtivo']?.value = contabilParametroModel.contaAtivo;
		plutoRow.cells['contaPassivo']?.value = contabilParametroModel.contaPassivo;
		plutoRow.cells['contaPatrimonioLiquido']?.value = contabilParametroModel.contaPatrimonioLiquido;
		plutoRow.cells['contaDepreciacaoAcumulada']?.value = contabilParametroModel.contaDepreciacaoAcumulada;
		plutoRow.cells['contaCapitalSocial']?.value = contabilParametroModel.contaCapitalSocial;
		plutoRow.cells['contaResultadoExercicio']?.value = contabilParametroModel.contaResultadoExercicio;
		plutoRow.cells['contaPrejuizoAcumulado']?.value = contabilParametroModel.contaPrejuizoAcumulado;
		plutoRow.cells['contaLucroAcumulado']?.value = contabilParametroModel.contaLucroAcumulado;
		plutoRow.cells['contaTituloPagar']?.value = contabilParametroModel.contaTituloPagar;
		plutoRow.cells['contaTituloReceber']?.value = contabilParametroModel.contaTituloReceber;
		plutoRow.cells['contaJurosPassivo']?.value = contabilParametroModel.contaJurosPassivo;
		plutoRow.cells['contaJurosAtivo']?.value = contabilParametroModel.contaJurosAtivo;
		plutoRow.cells['contaDescontoObtido']?.value = contabilParametroModel.contaDescontoObtido;
		plutoRow.cells['contaDescontoConcedido']?.value = contabilParametroModel.contaDescontoConcedido;
		plutoRow.cells['contaCmv']?.value = contabilParametroModel.contaCmv;
		plutoRow.cells['contaVenda']?.value = contabilParametroModel.contaVenda;
		plutoRow.cells['contaVendaServico']?.value = contabilParametroModel.contaVendaServico;
		plutoRow.cells['contaEstoque']?.value = contabilParametroModel.contaEstoque;
		plutoRow.cells['contaApuraResultado']?.value = contabilParametroModel.contaApuraResultado;
		plutoRow.cells['contaJurosApropriar']?.value = contabilParametroModel.contaJurosApropriar;
		plutoRow.cells['idHistPadraoResultado']?.value = contabilParametroModel.idHistPadraoResultado;
		plutoRow.cells['idHistPadraoLucro']?.value = contabilParametroModel.idHistPadraoLucro;
		plutoRow.cells['idHistPadraoPrejuizo']?.value = contabilParametroModel.idHistPadraoPrejuizo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contabilParametroRepository.save(contabilParametroModel: contabilParametroModel); 
        if (result != null) {
          contabilParametroModel = result;
          if (_isInserting) {
            _contabilParametroModelList.add(result);
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
		functionName = "contabil_parametro";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		mascaraController.dispose();
		niveisController.dispose();
		spedNomeLivroDiarioController.dispose();
		assinaturaDireitaController.dispose();
		assinaturaEsquerdaController.dispose();
		contaAtivoController.dispose();
		contaPassivoController.dispose();
		contaPatrimonioLiquidoController.dispose();
		contaDepreciacaoAcumuladaController.dispose();
		contaCapitalSocialController.dispose();
		contaResultadoExercicioController.dispose();
		contaPrejuizoAcumuladoController.dispose();
		contaLucroAcumuladoController.dispose();
		contaTituloPagarController.dispose();
		contaTituloReceberController.dispose();
		contaJurosPassivoController.dispose();
		contaJurosAtivoController.dispose();
		contaDescontoObtidoController.dispose();
		contaDescontoConcedidoController.dispose();
		contaCmvController.dispose();
		contaVendaController.dispose();
		contaVendaServicoController.dispose();
		contaEstoqueController.dispose();
		contaApuraResultadoController.dispose();
		contaJurosApropriarController.dispose();
		idHistPadraoResultadoController.dispose();
		idHistPadraoLucroController.dispose();
		idHistPadraoPrejuizoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}