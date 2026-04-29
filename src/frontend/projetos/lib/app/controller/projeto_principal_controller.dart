import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/controller/controller_imports.dart';
import 'package:projetos/app/data/model/model_imports.dart';
import 'package:projetos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:projetos/app/page/page_imports.dart';

import 'package:projetos/app/routes/app_routes.dart';
import 'package:projetos/app/data/repository/projeto_principal_repository.dart';
import 'package:projetos/app/page/shared_page/shared_page_imports.dart';
import 'package:projetos/app/page/shared_widget/message_dialog.dart';
import 'package:projetos/app/mixin/controller_base_mixin.dart';

class ProjetoPrincipalController extends GetxController with GetSingleTickerProviderStateMixin, ControllerBaseMixin {
	final ProjetoPrincipalRepository projetoPrincipalRepository;
	ProjetoPrincipalController({required this.projetoPrincipalRepository});

	// general
	final _dbColumns = ProjetoPrincipalModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ProjetoPrincipalModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final gridColumns = projetoPrincipalGridColumns();
	
	var _projetoPrincipalModelList = <ProjetoPrincipalModel>[];

	var _projetoPrincipalModelOld = ProjetoPrincipalModel();

	final _projetoPrincipalModel = ProjetoPrincipalModel().obs;
	ProjetoPrincipalModel get projetoPrincipalModel => _projetoPrincipalModel.value;
	set projetoPrincipalModel(value) => _projetoPrincipalModel.value = value ?? ProjetoPrincipalModel();

	final _filter = Filter().obs;
	Filter get filter => _filter.value;
	set filter(value) => _filter.value = value ?? Filter(); 
	
	var _isInserting = false;

	// tab page
	late TabController tabController;

	List<Tab> tabItems = [
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Projeto', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Cronograma', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Riscos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Custos', 
		),
		Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Stakeholders', 
		),
	];

	List<Widget> tabPages() {
		return [
			ProjetoPrincipalEditPage(),
			const ProjetoCronogramaListPage(),
			const ProjetoRiscoListPage(),
			const ProjetoCustoListPage(),
			const ProjetoStakeholdersListPage(),
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
		for (var projetoPrincipalModel in _projetoPrincipalModelList) {
			plutoRowList.add(_getPlutoRow(projetoPrincipalModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ProjetoPrincipalModel projetoPrincipalModel) {
		return PlutoRow(
			cells: _getPlutoCells(projetoPrincipalModel: projetoPrincipalModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ProjetoPrincipalModel? projetoPrincipalModel}) {
		return {
			"id": PlutoCell(value: projetoPrincipalModel?.id ?? 0),
			"nome": PlutoCell(value: projetoPrincipalModel?.nome ?? ''),
			"dataInicio": PlutoCell(value: projetoPrincipalModel?.dataInicio ?? ''),
			"dataPrevisaoFim": PlutoCell(value: projetoPrincipalModel?.dataPrevisaoFim ?? ''),
			"dataFim": PlutoCell(value: projetoPrincipalModel?.dataFim ?? ''),
			"valorOrcamento": PlutoCell(value: projetoPrincipalModel?.valorOrcamento ?? 0),
			"linkQuadroKanban": PlutoCell(value: projetoPrincipalModel?.linkQuadroKanban ?? ''),
			"observacao": PlutoCell(value: projetoPrincipalModel?.observacao ?? ''),
		};
	}

	void plutoRowToObject() {
		final modelFromRow = _projetoPrincipalModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
		if (modelFromRow.isEmpty) {
			projetoPrincipalModel.plutoRowToObject(plutoRow);
		} else {
			projetoPrincipalModel = modelFromRow[0];
			_projetoPrincipalModelOld = projetoPrincipalModel.clone();
		}		
	}

	Future callFilter() async {
		final filterController = Get.find<FilterController>();
		filterController.title = '${'filter_page_title'.tr} [Projeto]';
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
		await Get.find<ProjetoPrincipalController>().getList(filter: filter);
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		await projetoPrincipalRepository.getList(filter: filter).then( (data){ _projetoPrincipalModelList = data; } );
	}

	void printReport() {
		Get.dialog(AlertDialog(
			content: ReportPage(
				title: 'Projeto',
				columns: gridColumns.map((column) => column.title).toList(),
				plutoRows: plutoRows(),
			),
		));
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			valorOrcamentoController.text = currentRow.cells['valorOrcamento']?.value?.toStringAsFixed(2) ?? '';
			linkQuadroKanbanController.text = currentRow.cells['linkQuadroKanban']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();

			tabController.animateTo(0);
			
			//Cronograma
			Get.put<ProjetoCronogramaController>(ProjetoCronogramaController()); 
			final projetoCronogramaController = Get.find<ProjetoCronogramaController>(); 
			projetoCronogramaController.projetoCronogramaModelList = projetoPrincipalModel.projetoCronogramaModelList!; 
			projetoCronogramaController.userMadeChanges = false; 

			//Riscos
			Get.put<ProjetoRiscoController>(ProjetoRiscoController()); 
			final projetoRiscoController = Get.find<ProjetoRiscoController>(); 
			projetoRiscoController.projetoRiscoModelList = projetoPrincipalModel.projetoRiscoModelList!; 
			projetoRiscoController.userMadeChanges = false; 

			//Custos
			Get.put<ProjetoCustoController>(ProjetoCustoController()); 
			final projetoCustoController = Get.find<ProjetoCustoController>(); 
			projetoCustoController.projetoCustoModelList = projetoPrincipalModel.projetoCustoModelList!; 
			projetoCustoController.userMadeChanges = false; 

			//Stakeholders
			Get.put<ProjetoStakeholdersController>(ProjetoStakeholdersController()); 
			final projetoStakeholdersController = Get.find<ProjetoStakeholdersController>(); 
			projetoStakeholdersController.projetoStakeholdersModelList = projetoPrincipalModel.projetoStakeholdersModelList!; 
			projetoStakeholdersController.userMadeChanges = false; 


			Get.toNamed(Routes.projetoPrincipalTabPage)!.then((value) {
				if (projetoPrincipalModel.id == 0) {
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
		projetoPrincipalModel = ProjetoPrincipalModel();
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
				if (await projetoPrincipalRepository.delete(id: currentRow.cells['id']!.value)) {
					_projetoPrincipalModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final valorOrcamentoController = MoneyMaskedTextController();
	final linkQuadroKanbanController = TextEditingController();
	final observacaoController = TextEditingController();

	final projetoPrincipalTabPageScaffoldKey = GlobalKey<ScaffoldState>();

	final projetoPrincipalEditPageScaffoldKey = GlobalKey<ScaffoldState>();
	final projetoPrincipalEditPageFormKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = projetoPrincipalModel.id;
		plutoRow.cells['nome']?.value = projetoPrincipalModel.nome;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(projetoPrincipalModel.dataInicio);
		plutoRow.cells['dataPrevisaoFim']?.value = Util.formatDate(projetoPrincipalModel.dataPrevisaoFim);
		plutoRow.cells['dataFim']?.value = Util.formatDate(projetoPrincipalModel.dataFim);
		plutoRow.cells['valorOrcamento']?.value = projetoPrincipalModel.valorOrcamento;
		plutoRow.cells['linkQuadroKanban']?.value = projetoPrincipalModel.linkQuadroKanban;
		plutoRow.cells['observacao']?.value = projetoPrincipalModel.observacao;
	}

	Future<void> save() async {
		if (validateForms()) {
			if (userMadeChanges()) {
				final result = await projetoPrincipalRepository.save(projetoPrincipalModel: projetoPrincipalModel); 
				if (result != null) {
					projetoPrincipalModel = result;
					if (_isInserting) {
						_projetoPrincipalModelList.add(projetoPrincipalModel);
						_isInserting = false;
					} else {
            _projetoPrincipalModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
            _projetoPrincipalModelList.add(projetoPrincipalModel);
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
		Get.find<ProjetoCronogramaController>().userMadeChanges
		|| 
		Get.find<ProjetoRiscoController>().userMadeChanges
		|| 
		Get.find<ProjetoCustoController>().userMadeChanges
		|| 
		Get.find<ProjetoStakeholdersController>().userMadeChanges
		;
	}

	void clearUserChanges() {
		_projetoPrincipalModelList.removeWhere( ((t) => t.id == plutoRow.cells['id']!.value) );
		_projetoPrincipalModelList.add(_projetoPrincipalModelOld);
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
		functionName = "projeto_principal";
    setPrivilege();		
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose(); 
		tabController.dispose();
		nomeController.dispose();
		valorOrcamentoController.dispose();
		linkQuadroKanbanController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}