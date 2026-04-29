import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/controller/controller_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:agenda/app/page/grid_columns/grid_columns_imports.dart';
import 'package:agenda/app/page/page_imports.dart';

import 'package:agenda/app/routes/app_routes.dart';
import 'package:agenda/app/data/repository/recado_remetente_repository.dart';
import 'package:agenda/app/page/shared_page/shared_page_imports.dart';
import 'package:agenda/app/page/shared_widget/message_dialog.dart';
import 'package:agenda/app/mixin/controller_base_mixin.dart';

class RecadoRemetenteController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final RecadoRemetenteRepository recadoRemetenteRepository;
	RecadoRemetenteController({required this.recadoRemetenteRepository});

	// general
	final _dbColumns = RecadoRemetenteModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = RecadoRemetenteModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = recadoRemetenteGridColumns();
	
	var _recadoRemetenteModelList = <RecadoRemetenteModel>[];

	var _recadoRemetenteModelOld = RecadoRemetenteModel();

	final _recadoRemetenteModel = RecadoRemetenteModel().obs;
	RecadoRemetenteModel get recadoRemetenteModel => _recadoRemetenteModel.value;
	set recadoRemetenteModel(value) => _recadoRemetenteModel.value = value ?? RecadoRemetenteModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Recado', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Destinatarios', 
		),
	];

	List<Widget> tabPages() {
		return [
			RecadoRemetenteEditPage(),
			const RecadoDestinatarioListPage(),
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
		for (var recadoRemetenteModel in _recadoRemetenteModelList) {
			plutoRowList.add(_getPlutoRow(recadoRemetenteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(RecadoRemetenteModel recadoRemetenteModel) {
		return PlutoRow(
			cells: _getPlutoCells(recadoRemetenteModel: recadoRemetenteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ RecadoRemetenteModel? recadoRemetenteModel}) {
		return {
			"id": PlutoCell(value: recadoRemetenteModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: recadoRemetenteModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"dataEnvio": PlutoCell(value: recadoRemetenteModel?.dataEnvio ?? ''),
			"horaEnvio": PlutoCell(value: recadoRemetenteModel?.horaEnvio ?? ''),
			"assunto": PlutoCell(value: recadoRemetenteModel?.assunto ?? ''),
			"texto": PlutoCell(value: recadoRemetenteModel?.texto ?? ''),
			"idColaborador": PlutoCell(value: recadoRemetenteModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _recadoRemetenteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			recadoRemetenteModel.plutoRowToObject(plutoRow);
		} else {
			recadoRemetenteModel = modelFromRow[0];
			_recadoRemetenteModelOld = recadoRemetenteModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Recado]';
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
		await Get.find<RecadoRemetenteController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await recadoRemetenteRepository.getList(filter: filter).then( (data){ _recadoRemetenteModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Recado',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			horaEnvioController.text = currentRow.cells['horaEnvio']?.value ?? '';
			assuntoController.text = currentRow.cells['assunto']?.value ?? '';
			textoController.text = currentRow.cells['texto']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Destinatarios
			Get.put<RecadoDestinatarioController>(RecadoDestinatarioController()); 
			final recadoDestinatarioController = Get.find<RecadoDestinatarioController>(); 
			recadoDestinatarioController.recadoDestinatarioModelList = recadoRemetenteModel.recadoDestinatarioModelList!; 
			recadoDestinatarioController.userMadeChanges = false; 


			Get.toNamed(Routes.recadoRemetenteTabPage)!.then((value) {
				if (recadoRemetenteModel.id == 0) {
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
		recadoRemetenteModel = RecadoRemetenteModel();
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
				if (await recadoRemetenteRepository.delete(id: currentRow.cells['id']!.value)) {
					_recadoRemetenteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final viewPessoaColaboradorModelController = TextEditingController();
	final horaEnvioController = MaskedTextController(mask: '00:00:00',);
	final assuntoController = TextEditingController();
	final textoController = TextEditingController();

	final recadoRemetenteTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final recadoRemetenteEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final recadoRemetenteEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = recadoRemetenteModel.id;
		plutoRow.cells['idColaborador']?.value = recadoRemetenteModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = recadoRemetenteModel.viewPessoaColaboradorModel?.nome;
		plutoRow.cells['dataEnvio']?.value = Util.formatDate(recadoRemetenteModel.dataEnvio);
		plutoRow.cells['horaEnvio']?.value = recadoRemetenteModel.horaEnvio;
		plutoRow.cells['assunto']?.value = recadoRemetenteModel.assunto;
		plutoRow.cells['texto']?.value = recadoRemetenteModel.texto;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await recadoRemetenteRepository.save(recadoRemetenteModel: recadoRemetenteModel); 
				if (result != null) {
					recadoRemetenteModel = result;
					if (_isInserting) {
						_recadoRemetenteModelList.add(recadoRemetenteModel);
						_isInserting = false;
					} else {
            _recadoRemetenteModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _recadoRemetenteModelList.add(recadoRemetenteModel);
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
		Get.find<RecadoDestinatarioController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_recadoRemetenteModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_recadoRemetenteModelList.add(_recadoRemetenteModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(recadoRemetenteModel.viewPessoaColaboradorModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Remetente]'); 
			return false; 
		}
		return true;
	}

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Remetente]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			recadoRemetenteModel.idColaborador = plutoRowResult.cells['id']!.value; 
			recadoRemetenteModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = recadoRemetenteModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		functionName = "recado_remetente";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		viewPessoaColaboradorModelController.dispose();
		horaEnvioController.dispose();
		assuntoController.dispose();
		textoController.dispose();
		super.onClose();
	}
}