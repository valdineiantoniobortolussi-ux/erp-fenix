import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/controller/controller_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:frotas/app/page/page_imports.dart';

import 'package:frotas/app/routes/app_routes.dart';
import 'package:frotas/app/data/repository/frota_veiculo_repository.dart';
import 'package:frotas/app/page/shared_page/shared_page_imports.dart';
import 'package:frotas/app/page/shared_widget/message_dialog.dart';
import 'package:frotas/app/mixin/controller_base_mixin.dart';

class FrotaVeiculoController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final FrotaVeiculoRepository frotaVeiculoRepository;
	FrotaVeiculoController({required this.frotaVeiculoRepository});

	// general
	final _dbColumns = FrotaVeiculoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FrotaVeiculoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = frotaVeiculoGridColumns();
	
	var _frotaVeiculoModelList = <FrotaVeiculoModel>[];

	var _frotaVeiculoModelOld = FrotaVeiculoModel();

	final _frotaVeiculoModel = FrotaVeiculoModel().obs;
	FrotaVeiculoModel get frotaVeiculoModel => _frotaVeiculoModel.value;
	set frotaVeiculoModel(value) => _frotaVeiculoModel.value = value ?? FrotaVeiculoModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Frota Veiculo', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'IPVA', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'DPVAT', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Sinistros', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Movimentação', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Pneus', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Manutenção', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Multas', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Controle Combustível', 
		),
	];

	List<Widget> tabPages() {
		return [
			FrotaVeiculoEditPage(),
			const FrotaIpvaControleListPage(),
			const FrotaDpvatControleListPage(),
			const FrotaVeiculoSinistroListPage(),
			const FrotaVeiculoMovimentacaoListPage(),
			const FrotaVeiculoPneuListPage(),
			const FrotaVeiculoManutencaoListPage(),
			const FrotaMultaControleListPage(),
			const FrotaCombustivelControleListPage(),
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
		for (var frotaVeiculoModel in _frotaVeiculoModelList) {
			plutoRowList.add(_getPlutoRow(frotaVeiculoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FrotaVeiculoModel frotaVeiculoModel) {
		return PlutoRow(
			cells: _getPlutoCells(frotaVeiculoModel: frotaVeiculoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FrotaVeiculoModel? frotaVeiculoModel}) {
		return {
			"id": PlutoCell(value: frotaVeiculoModel?.id ?? 0),
			"frotaVeiculoTipo": PlutoCell(value: frotaVeiculoModel?.frotaVeiculoTipoModel?.nome ?? ''),
			"frotaCombustivelTipo": PlutoCell(value: frotaVeiculoModel?.frotaCombustivelTipoModel?.nome ?? ''),
			"marca": PlutoCell(value: frotaVeiculoModel?.marca ?? ''),
			"modelo": PlutoCell(value: frotaVeiculoModel?.modelo ?? ''),
			"modeloAno": PlutoCell(value: frotaVeiculoModel?.modeloAno ?? ''),
			"placa": PlutoCell(value: frotaVeiculoModel?.placa ?? ''),
			"codigoFipe": PlutoCell(value: frotaVeiculoModel?.codigoFipe ?? ''),
			"renavam": PlutoCell(value: frotaVeiculoModel?.renavam ?? ''),
			"ipvaMesVencimento": PlutoCell(value: frotaVeiculoModel?.ipvaMesVencimento ?? ''),
			"dpvatMesVencimento": PlutoCell(value: frotaVeiculoModel?.dpvatMesVencimento ?? ''),
			"idFrotaVeiculoTipo": PlutoCell(value: frotaVeiculoModel?.idFrotaVeiculoTipo ?? 0),
			"idFrotaCombustivelTipo": PlutoCell(value: frotaVeiculoModel?.idFrotaCombustivelTipo ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _frotaVeiculoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			frotaVeiculoModel.plutoRowToObject(plutoRow);
		} else {
			frotaVeiculoModel = modelFromRow[0];
			_frotaVeiculoModelOld = frotaVeiculoModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Frota Veiculo]';
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
		await Get.find<FrotaVeiculoController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await frotaVeiculoRepository.getList(filter: filter).then( (data){ _frotaVeiculoModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Frota Veiculo',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			frotaVeiculoTipoModelController.text = currentRow.cells['frotaVeiculoTipo']?.value ?? '';
			frotaCombustivelTipoModelController.text = currentRow.cells['frotaCombustivelTipo']?.value ?? '';
			marcaController.text = currentRow.cells['marca']?.value ?? '';
			modeloController.text = currentRow.cells['modelo']?.value ?? '';
			modeloAnoController.text = currentRow.cells['modeloAno']?.value ?? '';
			placaController.text = currentRow.cells['placa']?.value ?? '';
			codigoFipeController.text = currentRow.cells['codigoFipe']?.value ?? '';
			renavamController.text = currentRow.cells['renavam']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//IPVA
			Get.put<FrotaIpvaControleController>(FrotaIpvaControleController()); 
			final frotaIpvaControleController = Get.find<FrotaIpvaControleController>(); 
			frotaIpvaControleController.frotaIpvaControleModelList = frotaVeiculoModel.frotaIpvaControleModelList!; 
			frotaIpvaControleController.userMadeChanges = false; 

			//DPVAT
			Get.put<FrotaDpvatControleController>(FrotaDpvatControleController()); 
			final frotaDpvatControleController = Get.find<FrotaDpvatControleController>(); 
			frotaDpvatControleController.frotaDpvatControleModelList = frotaVeiculoModel.frotaDpvatControleModelList!; 
			frotaDpvatControleController.userMadeChanges = false; 

			//Sinistros
			Get.put<FrotaVeiculoSinistroController>(FrotaVeiculoSinistroController()); 
			final frotaVeiculoSinistroController = Get.find<FrotaVeiculoSinistroController>(); 
			frotaVeiculoSinistroController.frotaVeiculoSinistroModelList = frotaVeiculoModel.frotaVeiculoSinistroModelList!; 
			frotaVeiculoSinistroController.userMadeChanges = false; 

			//Movimentação
			Get.put<FrotaVeiculoMovimentacaoController>(FrotaVeiculoMovimentacaoController()); 
			final frotaVeiculoMovimentacaoController = Get.find<FrotaVeiculoMovimentacaoController>(); 
			frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModelList = frotaVeiculoModel.frotaVeiculoMovimentacaoModelList!; 
			frotaVeiculoMovimentacaoController.userMadeChanges = false; 

			//Pneus
			Get.put<FrotaVeiculoPneuController>(FrotaVeiculoPneuController()); 
			final frotaVeiculoPneuController = Get.find<FrotaVeiculoPneuController>(); 
			frotaVeiculoPneuController.frotaVeiculoPneuModelList = frotaVeiculoModel.frotaVeiculoPneuModelList!; 
			frotaVeiculoPneuController.userMadeChanges = false; 

			//Manutenção
			Get.put<FrotaVeiculoManutencaoController>(FrotaVeiculoManutencaoController()); 
			final frotaVeiculoManutencaoController = Get.find<FrotaVeiculoManutencaoController>(); 
			frotaVeiculoManutencaoController.frotaVeiculoManutencaoModelList = frotaVeiculoModel.frotaVeiculoManutencaoModelList!; 
			frotaVeiculoManutencaoController.userMadeChanges = false; 

			//Multas
			Get.put<FrotaMultaControleController>(FrotaMultaControleController()); 
			final frotaMultaControleController = Get.find<FrotaMultaControleController>(); 
			frotaMultaControleController.frotaMultaControleModelList = frotaVeiculoModel.frotaMultaControleModelList!; 
			frotaMultaControleController.userMadeChanges = false; 

			//Controle Combustível
			Get.put<FrotaCombustivelControleController>(FrotaCombustivelControleController()); 
			final frotaCombustivelControleController = Get.find<FrotaCombustivelControleController>(); 
			frotaCombustivelControleController.frotaCombustivelControleModelList = frotaVeiculoModel.frotaCombustivelControleModelList!; 
			frotaCombustivelControleController.userMadeChanges = false; 


			Get.toNamed(Routes.frotaVeiculoTabPage)!.then((value) {
				if (frotaVeiculoModel.id == 0) {
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
		frotaVeiculoModel = FrotaVeiculoModel();
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
				if (await frotaVeiculoRepository.delete(id: currentRow.cells['id']!.value)) {
					_frotaVeiculoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final frotaVeiculoTipoModelController = TextEditingController();
	final frotaCombustivelTipoModelController = TextEditingController();
	final marcaController = TextEditingController();
	final modeloController = TextEditingController();
	final modeloAnoController = TextEditingController();
	final placaController = TextEditingController();
	final codigoFipeController = TextEditingController();
	final renavamController = TextEditingController();

	final frotaVeiculoTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final frotaVeiculoEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final frotaVeiculoEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = frotaVeiculoModel.id;
		plutoRow.cells['idFrotaVeiculoTipo']?.value = frotaVeiculoModel.idFrotaVeiculoTipo;
		plutoRow.cells['frotaVeiculoTipo']?.value = frotaVeiculoModel.frotaVeiculoTipoModel?.nome;
		plutoRow.cells['idFrotaCombustivelTipo']?.value = frotaVeiculoModel.idFrotaCombustivelTipo;
		plutoRow.cells['frotaCombustivelTipo']?.value = frotaVeiculoModel.frotaCombustivelTipoModel?.nome;
		plutoRow.cells['marca']?.value = frotaVeiculoModel.marca;
		plutoRow.cells['modelo']?.value = frotaVeiculoModel.modelo;
		plutoRow.cells['modeloAno']?.value = frotaVeiculoModel.modeloAno;
		plutoRow.cells['placa']?.value = frotaVeiculoModel.placa;
		plutoRow.cells['codigoFipe']?.value = frotaVeiculoModel.codigoFipe;
		plutoRow.cells['renavam']?.value = frotaVeiculoModel.renavam;
		plutoRow.cells['ipvaMesVencimento']?.value = frotaVeiculoModel.ipvaMesVencimento;
		plutoRow.cells['dpvatMesVencimento']?.value = frotaVeiculoModel.dpvatMesVencimento;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await frotaVeiculoRepository.save(frotaVeiculoModel: frotaVeiculoModel); 
				if (result != null) {
					frotaVeiculoModel = result;
					if (_isInserting) {
						_frotaVeiculoModelList.add(frotaVeiculoModel);
						_isInserting = false;
					} else {
            _frotaVeiculoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _frotaVeiculoModelList.add(frotaVeiculoModel);
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
		Get.find<FrotaIpvaControleController>().userMadeChanges
		|| 
		Get.find<FrotaDpvatControleController>().userMadeChanges
		|| 
		Get.find<FrotaVeiculoSinistroController>().userMadeChanges
		|| 
		Get.find<FrotaVeiculoMovimentacaoController>().userMadeChanges
		|| 
		Get.find<FrotaVeiculoPneuController>().userMadeChanges
		|| 
		Get.find<FrotaVeiculoManutencaoController>().userMadeChanges
		|| 
		Get.find<FrotaMultaControleController>().userMadeChanges
		|| 
		Get.find<FrotaCombustivelControleController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_frotaVeiculoModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_frotaVeiculoModelList.add(_frotaVeiculoModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(frotaVeiculoModel.frotaVeiculoTipoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Tipo]'); 
			return false; 
		}
				mandatoryMessage = ValidateFormField.validateMandatory(frotaVeiculoModel.frotaCombustivelTipoModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Combustivel]'); 
			return false; 
		}
		return true;
	}

	Future callFrotaVeiculoTipoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo]'; 
		lookupController.route = '/frota-veiculo-tipo/'; 
		lookupController.gridColumns = frotaVeiculoTipoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FrotaVeiculoTipoModel.aliasColumns; 
		lookupController.dbColumns = FrotaVeiculoTipoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			frotaVeiculoModel.idFrotaVeiculoTipo = plutoRowResult.cells['id']!.value; 
			frotaVeiculoModel.frotaVeiculoTipoModel!.plutoRowToObject(plutoRowResult); 
			frotaVeiculoTipoModelController.text = frotaVeiculoModel.frotaVeiculoTipoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFrotaCombustivelTipoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Combustivel]'; 
		lookupController.route = '/frota-combustivel-tipo/'; 
		lookupController.gridColumns = frotaCombustivelTipoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FrotaCombustivelTipoModel.aliasColumns; 
		lookupController.dbColumns = FrotaCombustivelTipoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			frotaVeiculoModel.idFrotaCombustivelTipo = plutoRowResult.cells['id']!.value; 
			frotaVeiculoModel.frotaCombustivelTipoModel!.plutoRowToObject(plutoRowResult); 
			frotaCombustivelTipoModelController.text = frotaVeiculoModel.frotaCombustivelTipoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		tabController = TabController(vsync: this, length: tabItems.length);
		functionName = "frota_veiculo";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		frotaVeiculoTipoModelController.dispose();
		frotaCombustivelTipoModelController.dispose();
		marcaController.dispose();
		modeloController.dispose();
		modeloAnoController.dispose();
		placaController.dispose();
		codigoFipeController.dispose();
		renavamController.dispose();
		super.onClose();
	}
}