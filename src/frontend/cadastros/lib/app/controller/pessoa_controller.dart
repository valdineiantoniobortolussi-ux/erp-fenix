import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/page/page_imports.dart';

import 'package:cadastros/app/routes/app_routes.dart';
import 'package:cadastros/app/data/repository/pessoa_repository.dart';
import 'package:cadastros/app/page/shared_page/shared_page_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';
import 'package:cadastros/app/mixin/controller_base_mixin.dart';

class PessoaController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final PessoaRepository pessoaRepository;
	PessoaController({required this.pessoaRepository});

	// general
	final _dbColumns = PessoaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PessoaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = pessoaGridColumns();
	
	var _pessoaModelList = <PessoaModel>[];

	var _pessoaModelOld = PessoaModel();

	final _pessoaModel = PessoaModel().obs;
	PessoaModel get pessoaModel => _pessoaModel.value;
	set pessoaModel(value) => _pessoaModel.value = value ?? PessoaModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Pessoa', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Pessoa Jurídica', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Fornecedor', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Cliente', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Pessoa Física', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Transportadora', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Contador', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Contatos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Telefones', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Endereços', 
		),
	];

	List<Widget> tabPages() {
		return [
			PessoaEditPage(),
			PessoaJuridicaEditPage(),
			FornecedorEditPage(),
			ClienteEditPage(),
			PessoaFisicaEditPage(),
			TransportadoraEditPage(),
			ContadorEditPage(),
			const PessoaContatoListPage(),
			const PessoaTelefoneListPage(),
			const PessoaEnderecoListPage(),
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
		for (var pessoaModel in _pessoaModelList) {
			plutoRowList.add(_getPlutoRow(pessoaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PessoaModel pessoaModel) {
		return PlutoRow(
			cells: _getPlutoCells(pessoaModel: pessoaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PessoaModel? pessoaModel}) {
		return {
			"id": PlutoCell(value: pessoaModel?.id ?? 0),
			"nome": PlutoCell(value: pessoaModel?.nome ?? ''),
			"tipo": PlutoCell(value: pessoaModel?.tipo ?? ''),
			"site": PlutoCell(value: pessoaModel?.site ?? ''),
			"email": PlutoCell(value: pessoaModel?.email ?? ''),
			"ehCliente": PlutoCell(value: pessoaModel?.ehCliente ?? ''),
			"ehFornecedor": PlutoCell(value: pessoaModel?.ehFornecedor ?? ''),
			"ehTransportadora": PlutoCell(value: pessoaModel?.ehTransportadora ?? ''),
			"ehColaborador": PlutoCell(value: pessoaModel?.ehColaborador ?? ''),
			"ehContador": PlutoCell(value: pessoaModel?.ehContador ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _pessoaModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			pessoaModel.plutoRowToObject(plutoRow);
		} else {
			pessoaModel = modelFromRow[0];
			_pessoaModelOld = pessoaModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Pessoa]';
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
		await Get.find<PessoaController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await pessoaRepository.getList(filter: filter).then( (data){ _pessoaModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Pessoa',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			siteController.text = currentRow.cells['site']?.value ?? '';
			emailController.text = currentRow.cells['email']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Pessoa Jurídica
			Get.put<PessoaJuridicaController>(PessoaJuridicaController()); 
			final pessoaJuridicaController = Get.find<PessoaJuridicaController>(); 
			pessoaJuridicaController.pessoaJuridicaModel = pessoaModel.pessoaJuridicaModel; 
			pessoaJuridicaController.formWasChanged = false; 
			pessoaJuridicaController.callEditPage(); 

			//Fornecedor
			Get.put<FornecedorController>(FornecedorController()); 
			final fornecedorController = Get.find<FornecedorController>(); 
			fornecedorController.fornecedorModel = pessoaModel.fornecedorModel; 
			fornecedorController.formWasChanged = false; 
			fornecedorController.callEditPage(); 

			//Cliente
			Get.put<ClienteController>(ClienteController()); 
			final clienteController = Get.find<ClienteController>(); 
			clienteController.clienteModel = pessoaModel.clienteModel; 
			clienteController.formWasChanged = false; 
			clienteController.callEditPage(); 

			//Pessoa Física
			Get.put<PessoaFisicaController>(PessoaFisicaController()); 
			final pessoaFisicaController = Get.find<PessoaFisicaController>(); 
			pessoaFisicaController.pessoaFisicaModel = pessoaModel.pessoaFisicaModel; 
			pessoaFisicaController.formWasChanged = false; 
			pessoaFisicaController.callEditPage(); 

			//Transportadora
			Get.put<TransportadoraController>(TransportadoraController()); 
			final transportadoraController = Get.find<TransportadoraController>(); 
			transportadoraController.transportadoraModel = pessoaModel.transportadoraModel; 
			transportadoraController.formWasChanged = false; 
			transportadoraController.callEditPage(); 

			//Contador
			Get.put<ContadorController>(ContadorController()); 
			final contadorController = Get.find<ContadorController>(); 
			contadorController.contadorModel = pessoaModel.contadorModel; 
			contadorController.formWasChanged = false; 
			contadorController.callEditPage(); 

			//Contatos
			Get.put<PessoaContatoController>(PessoaContatoController()); 
			final pessoaContatoController = Get.find<PessoaContatoController>(); 
			pessoaContatoController.pessoaContatoModelList = pessoaModel.pessoaContatoModelList!; 
			pessoaContatoController.userMadeChanges = false; 

			//Telefones
			Get.put<PessoaTelefoneController>(PessoaTelefoneController()); 
			final pessoaTelefoneController = Get.find<PessoaTelefoneController>(); 
			pessoaTelefoneController.pessoaTelefoneModelList = pessoaModel.pessoaTelefoneModelList!; 
			pessoaTelefoneController.userMadeChanges = false; 

			//Endereços
			Get.put<PessoaEnderecoController>(PessoaEnderecoController()); 
			final pessoaEnderecoController = Get.find<PessoaEnderecoController>(); 
			pessoaEnderecoController.pessoaEnderecoModelList = pessoaModel.pessoaEnderecoModelList!; 
			pessoaEnderecoController.userMadeChanges = false; 


			Get.toNamed(Routes.pessoaTabPage)!.then((value) {
				if (pessoaModel.id == 0) {
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
		pessoaModel = PessoaModel();
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
				if (await pessoaRepository.delete(id: currentRow.cells['id']!.value)) {
					_pessoaModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();
	final siteController = TextEditingController();
	final emailController = TextEditingController();

	final pessoaTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final pessoaEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final pessoaEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pessoaModel.id;
		plutoRow.cells['nome']?.value = pessoaModel.nome;
		plutoRow.cells['tipo']?.value = pessoaModel.tipo;
		plutoRow.cells['site']?.value = pessoaModel.site;
		plutoRow.cells['email']?.value = pessoaModel.email;
		plutoRow.cells['ehCliente']?.value = pessoaModel.ehCliente;
		plutoRow.cells['ehFornecedor']?.value = pessoaModel.ehFornecedor;
		plutoRow.cells['ehTransportadora']?.value = pessoaModel.ehTransportadora;
		plutoRow.cells['ehColaborador']?.value = pessoaModel.ehColaborador;
		plutoRow.cells['ehContador']?.value = pessoaModel.ehContador;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await pessoaRepository.save(pessoaModel: pessoaModel); 
				if (result != null) {
					pessoaModel = result;
					if (_isInserting) {
						_pessoaModelList.add(pessoaModel);
						_isInserting = false;
					} else {
            _pessoaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _pessoaModelList.add(pessoaModel);
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
		Get.find<PessoaJuridicaController>().formWasChanged
		|| 
		Get.find<FornecedorController>().formWasChanged
		|| 
		Get.find<ClienteController>().formWasChanged
		|| 
		Get.find<PessoaFisicaController>().formWasChanged
		|| 
		Get.find<TransportadoraController>().formWasChanged
		|| 
		Get.find<ContadorController>().formWasChanged
		|| 
		Get.find<PessoaContatoController>().userMadeChanges
		|| 
		Get.find<PessoaTelefoneController>().userMadeChanges
		|| 
		Get.find<PessoaEnderecoController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_pessoaModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_pessoaModelList.add(_pessoaModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
		final emailValidationMessage = ValidateFormField.validateEmail(pessoaModel.email); 
		if (emailValidationMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: emailValidationMessage); 
			return false; 
		}
		final resultPessoaJuridica = Get.find<PessoaJuridicaController>().validateForm(); 
		if (!resultPessoaJuridica) { 
			return false; 
		}
		final resultFornecedor = Get.find<FornecedorController>().validateForm(); 
		if (!resultFornecedor) { 
			return false; 
		}
		final resultCliente = Get.find<ClienteController>().validateForm(); 
		if (!resultCliente) { 
			return false; 
		}
		final resultPessoaFisica = Get.find<PessoaFisicaController>().validateForm(); 
		if (!resultPessoaFisica) { 
			return false; 
		}
		final resultTransportadora = Get.find<TransportadoraController>().validateForm(); 
		if (!resultTransportadora) { 
			return false; 
		}
		final resultContador = Get.find<ContadorController>().validateForm(); 
		if (!resultContador) { 
			return false; 
		}
		return true;
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
		functionName = "pessoa";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		nomeController.dispose();
		siteController.dispose();
		emailController.dispose();
		super.onClose();
	}
}