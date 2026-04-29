import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/controller/controller_imports.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';
import 'package:etiquetas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:etiquetas/app/page/page_imports.dart';

import 'package:etiquetas/app/routes/app_routes.dart';
import 'package:etiquetas/app/data/repository/etiqueta_layout_repository.dart';
import 'package:etiquetas/app/page/shared_page/shared_page_imports.dart';
import 'package:etiquetas/app/page/shared_widget/message_dialog.dart';
import 'package:etiquetas/app/mixin/controller_base_mixin.dart';

class EtiquetaLayoutController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final EtiquetaLayoutRepository etiquetaLayoutRepository;
	EtiquetaLayoutController({required this.etiquetaLayoutRepository});

	// general
	final _dbColumns = EtiquetaLayoutModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = EtiquetaLayoutModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = etiquetaLayoutGridColumns();
	
	var _etiquetaLayoutModelList = <EtiquetaLayoutModel>[];

	var _etiquetaLayoutModelOld = EtiquetaLayoutModel();

	final _etiquetaLayoutModel = EtiquetaLayoutModel().obs;
	EtiquetaLayoutModel get etiquetaLayoutModel => _etiquetaLayoutModel.value;
	set etiquetaLayoutModel(value) => _etiquetaLayoutModel.value = value ?? EtiquetaLayoutModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Layout', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Templates', 
		),
	];

	List<Widget> tabPages() {
		return [
			EtiquetaLayoutEditPage(),
			const EtiquetaTemplateListPage(),
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
		for (var etiquetaLayoutModel in _etiquetaLayoutModelList) {
			plutoRowList.add(_getPlutoRow(etiquetaLayoutModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(EtiquetaLayoutModel etiquetaLayoutModel) {
		return PlutoRow(
			cells: _getPlutoCells(etiquetaLayoutModel: etiquetaLayoutModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ EtiquetaLayoutModel? etiquetaLayoutModel}) {
		return {
			"id": PlutoCell(value: etiquetaLayoutModel?.id ?? 0),
			"etiquetaFormatoPapel": PlutoCell(value: etiquetaLayoutModel?.etiquetaFormatoPapelModel?.nome ?? ''),
			"codigoFabricante": PlutoCell(value: etiquetaLayoutModel?.codigoFabricante ?? ''),
			"quantidade": PlutoCell(value: etiquetaLayoutModel?.quantidade ?? 0),
			"quantidadeHorizontal": PlutoCell(value: etiquetaLayoutModel?.quantidadeHorizontal ?? 0),
			"quantidadeVertical": PlutoCell(value: etiquetaLayoutModel?.quantidadeVertical ?? 0),
			"margemSuperior": PlutoCell(value: etiquetaLayoutModel?.margemSuperior ?? 0),
			"margemInferior": PlutoCell(value: etiquetaLayoutModel?.margemInferior ?? 0),
			"margemEsquerda": PlutoCell(value: etiquetaLayoutModel?.margemEsquerda ?? 0),
			"margemDireita": PlutoCell(value: etiquetaLayoutModel?.margemDireita ?? 0),
			"espacamentoHorizontal": PlutoCell(value: etiquetaLayoutModel?.espacamentoHorizontal ?? 0),
			"espacamentoVertical": PlutoCell(value: etiquetaLayoutModel?.espacamentoVertical ?? 0),
			"idFormatoPapel": PlutoCell(value: etiquetaLayoutModel?.idFormatoPapel ?? 0),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _etiquetaLayoutModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			etiquetaLayoutModel.plutoRowToObject(plutoRow);
		} else {
			etiquetaLayoutModel = modelFromRow[0];
			_etiquetaLayoutModelOld = etiquetaLayoutModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Layout]';
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
		await Get.find<EtiquetaLayoutController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await etiquetaLayoutRepository.getList(filter: filter).then( (data){ _etiquetaLayoutModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Layout',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			etiquetaFormatoPapelModelController.text = currentRow.cells['etiquetaFormatoPapel']?.value ?? '';
			codigoFabricanteController.text = currentRow.cells['codigoFabricante']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';
			quantidadeHorizontalController.text = currentRow.cells['quantidadeHorizontal']?.value?.toString() ?? '';
			quantidadeVerticalController.text = currentRow.cells['quantidadeVertical']?.value?.toString() ?? '';
			margemSuperiorController.text = currentRow.cells['margemSuperior']?.value?.toString() ?? '';
			margemInferiorController.text = currentRow.cells['margemInferior']?.value?.toString() ?? '';
			margemEsquerdaController.text = currentRow.cells['margemEsquerda']?.value?.toString() ?? '';
			margemDireitaController.text = currentRow.cells['margemDireita']?.value?.toString() ?? '';
			espacamentoHorizontalController.text = currentRow.cells['espacamentoHorizontal']?.value?.toString() ?? '';
			espacamentoVerticalController.text = currentRow.cells['espacamentoVertical']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Templates
			Get.put<EtiquetaTemplateController>(EtiquetaTemplateController()); 
			final etiquetaTemplateController = Get.find<EtiquetaTemplateController>(); 
			etiquetaTemplateController.etiquetaTemplateModelList = etiquetaLayoutModel.etiquetaTemplateModelList!; 
			etiquetaTemplateController.userMadeChanges = false; 


			Get.toNamed(Routes.etiquetaLayoutTabPage)!.then((value) {
				if (etiquetaLayoutModel.id == 0) {
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
		etiquetaLayoutModel = EtiquetaLayoutModel();
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
				if (await etiquetaLayoutRepository.delete(id: currentRow.cells['id']!.value)) {
					_etiquetaLayoutModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final etiquetaFormatoPapelModelController = TextEditingController();
	final codigoFabricanteController = TextEditingController();
	final quantidadeController = TextEditingController();
	final quantidadeHorizontalController = TextEditingController();
	final quantidadeVerticalController = TextEditingController();
	final margemSuperiorController = TextEditingController();
	final margemInferiorController = TextEditingController();
	final margemEsquerdaController = TextEditingController();
	final margemDireitaController = TextEditingController();
	final espacamentoHorizontalController = TextEditingController();
	final espacamentoVerticalController = TextEditingController();

	final etiquetaLayoutTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final etiquetaLayoutEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final etiquetaLayoutEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = etiquetaLayoutModel.id;
		plutoRow.cells['idFormatoPapel']?.value = etiquetaLayoutModel.idFormatoPapel;
		plutoRow.cells['etiquetaFormatoPapel']?.value = etiquetaLayoutModel.etiquetaFormatoPapelModel?.nome;
		plutoRow.cells['codigoFabricante']?.value = etiquetaLayoutModel.codigoFabricante;
		plutoRow.cells['quantidade']?.value = etiquetaLayoutModel.quantidade;
		plutoRow.cells['quantidadeHorizontal']?.value = etiquetaLayoutModel.quantidadeHorizontal;
		plutoRow.cells['quantidadeVertical']?.value = etiquetaLayoutModel.quantidadeVertical;
		plutoRow.cells['margemSuperior']?.value = etiquetaLayoutModel.margemSuperior;
		plutoRow.cells['margemInferior']?.value = etiquetaLayoutModel.margemInferior;
		plutoRow.cells['margemEsquerda']?.value = etiquetaLayoutModel.margemEsquerda;
		plutoRow.cells['margemDireita']?.value = etiquetaLayoutModel.margemDireita;
		plutoRow.cells['espacamentoHorizontal']?.value = etiquetaLayoutModel.espacamentoHorizontal;
		plutoRow.cells['espacamentoVertical']?.value = etiquetaLayoutModel.espacamentoVertical;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await etiquetaLayoutRepository.save(etiquetaLayoutModel: etiquetaLayoutModel); 
				if (result != null) {
					etiquetaLayoutModel = result;
					if (_isInserting) {
						_etiquetaLayoutModelList.add(etiquetaLayoutModel);
						_isInserting = false;
					} else {
            _etiquetaLayoutModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _etiquetaLayoutModelList.add(etiquetaLayoutModel);
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
		Get.find<EtiquetaTemplateController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_etiquetaLayoutModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_etiquetaLayoutModelList.add(_etiquetaLayoutModelOld);
	}

	void tabChange(int index) {
		validateForms();
	}

	bool validateForms() {
				mandatoryMessage = ValidateFormField.validateMandatory(etiquetaLayoutModel.etiquetaFormatoPapelModel?.nome); 
		if (mandatoryMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: '$mandatoryMessage [Formato Papel]'); 
			return false; 
		}
		return true;
	}

	Future callEtiquetaFormatoPapelLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Formato Papel]'; 
		lookupController.route = '/etiqueta-formato-papel/'; 
		lookupController.gridColumns = etiquetaFormatoPapelGridColumns(isForLookup: true); 
		lookupController.aliasColumns = EtiquetaFormatoPapelModel.aliasColumns; 
		lookupController.dbColumns = EtiquetaFormatoPapelModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			etiquetaLayoutModel.idFormatoPapel = plutoRowResult.cells['id']!.value; 
			etiquetaLayoutModel.etiquetaFormatoPapelModel!.plutoRowToObject(plutoRowResult); 
			etiquetaFormatoPapelModelController.text = etiquetaLayoutModel.etiquetaFormatoPapelModel?.nome ?? ''; 
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
		functionName = "etiqueta_layout";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		etiquetaFormatoPapelModelController.dispose();
		codigoFabricanteController.dispose();
		quantidadeController.dispose();
		quantidadeHorizontalController.dispose();
		quantidadeVerticalController.dispose();
		margemSuperiorController.dispose();
		margemInferiorController.dispose();
		margemEsquerdaController.dispose();
		margemDireitaController.dispose();
		espacamentoHorizontalController.dispose();
		espacamentoVerticalController.dispose();
		super.onClose();
	}
}