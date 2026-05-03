import 'dart:async';
import 'dart:math';

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
import 'package:mdfe/app/page/page_imports.dart';

import 'package:mdfe/app/routes/app_routes.dart';
import 'package:mdfe/app/data/repository/mdfe_cabecalho_repository.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';
import 'package:mdfe/app/mixin/controller_base_mixin.dart';

class MdfeCabecalhoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final MdfeCabecalhoRepository mdfeCabecalhoRepository;
	MdfeCabecalhoController({required this.mdfeCabecalhoRepository});

	// general
	final _dbColumns = MdfeCabecalhoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = MdfeCabecalhoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = mdfeCabecalhoGridColumns();
	
	var _mdfeCabecalhoModelList = <MdfeCabecalhoModel>[];

	var _mdfeCabecalhoModelOld = MdfeCabecalhoModel();

	final _mdfeCabecalhoModel = MdfeCabecalhoModel().obs;
	MdfeCabecalhoModel get mdfeCabecalhoModel => _mdfeCabecalhoModel.value;
	set mdfeCabecalhoModel(value) => _mdfeCabecalhoModel.value = value ?? MdfeCabecalhoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'MDFe', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Lacre', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Município Descarrega', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Emitente', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Percurso', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Município Carregamento', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Rodoviário', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Informação Seguro', 
		),
	];

	List<Widget> tabPages() {
		return [
			MdfeCabecalhoEditPage(),
			const MdfeLacreListPage(),
			const MdfeMunicipioDescarregaListPage(),
			const MdfeEmitenteListPage(),
			const MdfePercursoListPage(),
			const MdfeMunicipioCarregamentoListPage(),
			const MdfeRodoviarioListPage(),
			const MdfeInformacaoSeguroListPage(),
		];
	}

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
		for (var mdfeCabecalhoModel in _mdfeCabecalhoModelList) {
			plutoRowList.add(_getPlutoRow(mdfeCabecalhoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(MdfeCabecalhoModel mdfeCabecalhoModel) {
		return PlutoRow(
			cells: _getPlutoCells(mdfeCabecalhoModel: mdfeCabecalhoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ MdfeCabecalhoModel? mdfeCabecalhoModel}) {
		return {
			"id": PlutoCell(value: mdfeCabecalhoModel?.id ?? 0),
			"uf": PlutoCell(value: mdfeCabecalhoModel?.uf ?? ''),
			"tipoAmbiente": PlutoCell(value: mdfeCabecalhoModel?.tipoAmbiente ?? ''),
			"tipoEmitente": PlutoCell(value: mdfeCabecalhoModel?.tipoEmitente ?? ''),
			"tipoTransportadora": PlutoCell(value: mdfeCabecalhoModel?.tipoTransportadora ?? ''),
			"modelo": PlutoCell(value: mdfeCabecalhoModel?.modelo ?? ''),
			"serie": PlutoCell(value: mdfeCabecalhoModel?.serie ?? ''),
			"numeroMdfe": PlutoCell(value: mdfeCabecalhoModel?.numeroMdfe ?? ''),
			"codigoNumerico": PlutoCell(value: mdfeCabecalhoModel?.codigoNumerico ?? ''),
			"chaveAcesso": PlutoCell(value: mdfeCabecalhoModel?.chaveAcesso ?? ''),
			"digitoVerificador": PlutoCell(value: mdfeCabecalhoModel?.digitoVerificador ?? 0),
			"modal": PlutoCell(value: mdfeCabecalhoModel?.modal ?? ''),
			"dataHoraEmissao": PlutoCell(value: mdfeCabecalhoModel?.dataHoraEmissao ?? ''),
			"tipoEmissao": PlutoCell(value: mdfeCabecalhoModel?.tipoEmissao ?? ''),
			"processoEmissao": PlutoCell(value: mdfeCabecalhoModel?.processoEmissao ?? ''),
			"versaoProcessoEmissao": PlutoCell(value: mdfeCabecalhoModel?.versaoProcessoEmissao ?? ''),
			"ufInicio": PlutoCell(value: mdfeCabecalhoModel?.ufInicio ?? ''),
			"ufFim": PlutoCell(value: mdfeCabecalhoModel?.ufFim ?? ''),
			"dataHoraPrevisaoViagem": PlutoCell(value: mdfeCabecalhoModel?.dataHoraPrevisaoViagem ?? ''),
			"quantidadeTotalCte": PlutoCell(value: mdfeCabecalhoModel?.quantidadeTotalCte ?? 0),
			"quantidadeTotalNfe": PlutoCell(value: mdfeCabecalhoModel?.quantidadeTotalNfe ?? 0),
			"quantidadeTotalMdfe": PlutoCell(value: mdfeCabecalhoModel?.quantidadeTotalMdfe ?? 0),
			"codigoUnidadeMedida": PlutoCell(value: mdfeCabecalhoModel?.codigoUnidadeMedida ?? ''),
			"pesoBrutoCarga": PlutoCell(value: mdfeCabecalhoModel?.pesoBrutoCarga ?? 0),
			"valorCarga": PlutoCell(value: mdfeCabecalhoModel?.valorCarga ?? 0),
			"numeroProtocolo": PlutoCell(value: mdfeCabecalhoModel?.numeroProtocolo ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _mdfeCabecalhoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			mdfeCabecalhoModel.plutoRowToObject(plutoRow);
		} else {
			mdfeCabecalhoModel = modelFromRow[0];
			_mdfeCabecalhoModelOld = mdfeCabecalhoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [MDFe]';
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
		await Get.find<MdfeCabecalhoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await mdfeCabecalhoRepository.getList(filter: filter).then( (data){ _mdfeCabecalhoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'MDFe',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			serieController.text = currentRow.cells['serie']?.value ?? '';
			numeroMdfeController.text = currentRow.cells['numeroMdfe']?.value ?? '';
			codigoNumericoController.text = currentRow.cells['codigoNumerico']?.value ?? '';
			chaveAcessoController.text = currentRow.cells['chaveAcesso']?.value ?? '';
			digitoVerificadorController.text = currentRow.cells['digitoVerificador']?.value?.toString() ?? '';
			versaoProcessoEmissaoController.text = currentRow.cells['versaoProcessoEmissao']?.value ?? '';
			quantidadeTotalCteController.text = currentRow.cells['quantidadeTotalCte']?.value?.toString() ?? '';
			quantidadeTotalNfeController.text = currentRow.cells['quantidadeTotalNfe']?.value?.toString() ?? '';
			quantidadeTotalMdfeController.text = currentRow.cells['quantidadeTotalMdfe']?.value?.toString() ?? '';
			pesoBrutoCargaController.text = currentRow.cells['pesoBrutoCarga']?.value?.toStringAsFixed(2) ?? '';
			valorCargaController.text = currentRow.cells['valorCarga']?.value?.toStringAsFixed(2) ?? '';
			numeroProtocoloController.text = currentRow.cells['numeroProtocolo']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Lacre
			Get.put<MdfeLacreController>(MdfeLacreController()); 
			final mdfeLacreController = Get.find<MdfeLacreController>(); 
			mdfeLacreController.mdfeLacreModelList = mdfeCabecalhoModel.mdfeLacreModelList!; 
			mdfeLacreController.userMadeChanges = false; 

			//Município Descarrega
			Get.put<MdfeMunicipioDescarregaController>(MdfeMunicipioDescarregaController()); 
			final mdfeMunicipioDescarregaController = Get.find<MdfeMunicipioDescarregaController>(); 
			mdfeMunicipioDescarregaController.mdfeMunicipioDescarregaModelList = mdfeCabecalhoModel.mdfeMunicipioDescarregaModelList!; 
			mdfeMunicipioDescarregaController.userMadeChanges = false; 

			//Emitente
			Get.put<MdfeEmitenteController>(MdfeEmitenteController()); 
			final mdfeEmitenteController = Get.find<MdfeEmitenteController>(); 
			mdfeEmitenteController.mdfeEmitenteModelList = mdfeCabecalhoModel.mdfeEmitenteModelList!; 
			mdfeEmitenteController.userMadeChanges = false; 

			//Percurso
			Get.put<MdfePercursoController>(MdfePercursoController()); 
			final mdfePercursoController = Get.find<MdfePercursoController>(); 
			mdfePercursoController.mdfePercursoModelList = mdfeCabecalhoModel.mdfePercursoModelList!; 
			mdfePercursoController.userMadeChanges = false; 

			//Município Carregamento
			Get.put<MdfeMunicipioCarregamentoController>(MdfeMunicipioCarregamentoController()); 
			final mdfeMunicipioCarregamentoController = Get.find<MdfeMunicipioCarregamentoController>(); 
			mdfeMunicipioCarregamentoController.mdfeMunicipioCarregamentoModelList = mdfeCabecalhoModel.mdfeMunicipioCarregamentoModelList!; 
			mdfeMunicipioCarregamentoController.userMadeChanges = false; 

			//Rodoviário
			Get.put<MdfeRodoviarioController>(MdfeRodoviarioController()); 
			final mdfeRodoviarioController = Get.find<MdfeRodoviarioController>(); 
			mdfeRodoviarioController.mdfeRodoviarioModelList = mdfeCabecalhoModel.mdfeRodoviarioModelList!; 
			mdfeRodoviarioController.userMadeChanges = false; 

			//Informação Seguro
			Get.put<MdfeInformacaoSeguroController>(MdfeInformacaoSeguroController()); 
			final mdfeInformacaoSeguroController = Get.find<MdfeInformacaoSeguroController>(); 
			mdfeInformacaoSeguroController.mdfeInformacaoSeguroModelList = mdfeCabecalhoModel.mdfeInformacaoSeguroModelList!; 
			mdfeInformacaoSeguroController.userMadeChanges = false; 


			Get.toNamed(Routes.mdfeCabecalhoTabPage)!.then((value) {
				if (mdfeCabecalhoModel.id == 0) {
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
		mdfeCabecalhoModel = MdfeCabecalhoModel();
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
				if (await mdfeCabecalhoRepository.delete(id: currentRow.cells['id']!.value)) {
					_mdfeCabecalhoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	String? mandatoryMessage;
	
	final scrollController = ScrollController();
	final serieController = TextEditingController();
	final numeroMdfeController = TextEditingController();
	final codigoNumericoController = TextEditingController();
	final chaveAcessoController = TextEditingController();
	final digitoVerificadorController = TextEditingController();
	final versaoProcessoEmissaoController = TextEditingController();
	final quantidadeTotalCteController = TextEditingController();
	final quantidadeTotalNfeController = TextEditingController();
	final quantidadeTotalMdfeController = TextEditingController();
	final pesoBrutoCargaController = MoneyMaskedTextController();
	final valorCargaController = MoneyMaskedTextController();
	final numeroProtocoloController = TextEditingController();

	final mdfeCabecalhoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final mdfeCabecalhoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final mdfeCabecalhoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeCabecalhoModel.id;
		plutoRow.cells['uf']?.value = mdfeCabecalhoModel.uf;
		plutoRow.cells['tipoAmbiente']?.value = mdfeCabecalhoModel.tipoAmbiente;
		plutoRow.cells['tipoEmitente']?.value = mdfeCabecalhoModel.tipoEmitente;
		plutoRow.cells['tipoTransportadora']?.value = mdfeCabecalhoModel.tipoTransportadora;
		plutoRow.cells['modelo']?.value = mdfeCabecalhoModel.modelo;
		plutoRow.cells['serie']?.value = mdfeCabecalhoModel.serie;
		plutoRow.cells['numeroMdfe']?.value = mdfeCabecalhoModel.numeroMdfe;
		plutoRow.cells['codigoNumerico']?.value = mdfeCabecalhoModel.codigoNumerico;
		plutoRow.cells['chaveAcesso']?.value = mdfeCabecalhoModel.chaveAcesso;
		plutoRow.cells['digitoVerificador']?.value = mdfeCabecalhoModel.digitoVerificador;
		plutoRow.cells['modal']?.value = mdfeCabecalhoModel.modal;
		plutoRow.cells['dataHoraEmissao']?.value = Util.formatDate(mdfeCabecalhoModel.dataHoraEmissao);
		plutoRow.cells['tipoEmissao']?.value = mdfeCabecalhoModel.tipoEmissao;
		plutoRow.cells['processoEmissao']?.value = mdfeCabecalhoModel.processoEmissao;
		plutoRow.cells['versaoProcessoEmissao']?.value = mdfeCabecalhoModel.versaoProcessoEmissao;
		plutoRow.cells['ufInicio']?.value = mdfeCabecalhoModel.ufInicio;
		plutoRow.cells['ufFim']?.value = mdfeCabecalhoModel.ufFim;
		plutoRow.cells['dataHoraPrevisaoViagem']?.value = Util.formatDate(mdfeCabecalhoModel.dataHoraPrevisaoViagem);
		plutoRow.cells['quantidadeTotalCte']?.value = mdfeCabecalhoModel.quantidadeTotalCte;
		plutoRow.cells['quantidadeTotalNfe']?.value = mdfeCabecalhoModel.quantidadeTotalNfe;
		plutoRow.cells['quantidadeTotalMdfe']?.value = mdfeCabecalhoModel.quantidadeTotalMdfe;
		plutoRow.cells['codigoUnidadeMedida']?.value = mdfeCabecalhoModel.codigoUnidadeMedida;
		plutoRow.cells['pesoBrutoCarga']?.value = mdfeCabecalhoModel.pesoBrutoCarga;
		plutoRow.cells['valorCarga']?.value = mdfeCabecalhoModel.valorCarga;
		plutoRow.cells['numeroProtocolo']?.value = mdfeCabecalhoModel.numeroProtocolo;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await mdfeCabecalhoRepository.save(mdfeCabecalhoModel: mdfeCabecalhoModel); 
				if (result != null) {
					mdfeCabecalhoModel = result;
					if (_isInserting) {
						_mdfeCabecalhoModelList.add(mdfeCabecalhoModel);
						_isInserting = false;
					} else {
            _mdfeCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _mdfeCabecalhoModelList.add(mdfeCabecalhoModel);
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
		if (userMadeChanges()) {
			showQuestionDialog('message_data_loss'.tr, () { 
				clearUserChanges();
				Get.back(); 
			});
		} else {
			clearUserChanges();
			Get.back();
		}
	}	

	bool userMadeChanges() {
		return
		formWasChanged 
		|| 
		Get.find<MdfeLacreController>().userMadeChanges
		|| 
		Get.find<MdfeMunicipioDescarregaController>().userMadeChanges
		|| 
		Get.find<MdfeEmitenteController>().userMadeChanges
		|| 
		Get.find<MdfePercursoController>().userMadeChanges
		|| 
		Get.find<MdfeMunicipioCarregamentoController>().userMadeChanges
		|| 
		Get.find<MdfeRodoviarioController>().userMadeChanges
		|| 
		Get.find<MdfeInformacaoSeguroController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_mdfeCabecalhoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_mdfeCabecalhoModelList.add(_mdfeCabecalhoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
		return true;
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
		functionName = "mdfe_cabecalho";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		serieController.dispose();
		numeroMdfeController.dispose();
		codigoNumericoController.dispose();
		chaveAcessoController.dispose();
		digitoVerificadorController.dispose();
		versaoProcessoEmissaoController.dispose();
		quantidadeTotalCteController.dispose();
		quantidadeTotalNfeController.dispose();
		quantidadeTotalMdfeController.dispose();
		pesoBrutoCargaController.dispose();
		valorCargaController.dispose();
		numeroProtocoloController.dispose();
		super.onClose();
	}
}