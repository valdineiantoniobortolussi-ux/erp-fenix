import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:tributacao/app/data/model/model_imports.dart';

class TributConfiguraOfGtModel {
	int? id;
	int? idTributGrupoTributario;
	int? idTributOperacaoFiscal;
	TributIpiModel? tributIpiModel;
	TributCofinsModel? tributCofinsModel;
	TributPisModel? tributPisModel;
	TributGrupoTributarioModel? tributGrupoTributarioModel;
	TributOperacaoFiscalModel? tributOperacaoFiscalModel;
	List<TributIcmsUfModel>? tributIcmsUfModelList;

	TributConfiguraOfGtModel({
		this.id,
		this.idTributGrupoTributario,
		this.idTributOperacaoFiscal,
		this.tributIpiModel,
		this.tributCofinsModel,
		this.tributPisModel,
		this.tributGrupoTributarioModel,
		this.tributOperacaoFiscalModel,
		this.tributIcmsUfModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
	];

	TributConfiguraOfGtModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idTributGrupoTributario = jsonData['idTributGrupoTributario'];
		idTributOperacaoFiscal = jsonData['idTributOperacaoFiscal'];
		tributIpiModel = jsonData['tributIpiModel'] == null ? TributIpiModel() : TributIpiModel.fromJson(jsonData['tributIpiModel']);
		tributCofinsModel = jsonData['tributCofinsModel'] == null ? TributCofinsModel() : TributCofinsModel.fromJson(jsonData['tributCofinsModel']);
		tributPisModel = jsonData['tributPisModel'] == null ? TributPisModel() : TributPisModel.fromJson(jsonData['tributPisModel']);
		tributGrupoTributarioModel = jsonData['tributGrupoTributarioModel'] == null ? TributGrupoTributarioModel() : TributGrupoTributarioModel.fromJson(jsonData['tributGrupoTributarioModel']);
		tributOperacaoFiscalModel = jsonData['tributOperacaoFiscalModel'] == null ? TributOperacaoFiscalModel() : TributOperacaoFiscalModel.fromJson(jsonData['tributOperacaoFiscalModel']);
		tributIcmsUfModelList = (jsonData['tributIcmsUfModelList'] as Iterable?)?.map((m) => TributIcmsUfModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idTributGrupoTributario'] = idTributGrupoTributario != 0 ? idTributGrupoTributario : null;
		jsonData['idTributOperacaoFiscal'] = idTributOperacaoFiscal != 0 ? idTributOperacaoFiscal : null;
		jsonData['tributIpiModel'] = tributIpiModel?.toJson;
		jsonData['tributCofinsModel'] = tributCofinsModel?.toJson;
		jsonData['tributPisModel'] = tributPisModel?.toJson;
		jsonData['tributGrupoTributarioModel'] = tributGrupoTributarioModel?.toJson;
		jsonData['tributOperacaoFiscalModel'] = tributOperacaoFiscalModel?.toJson;
		
		var tributIcmsUfModelLocalList = []; 
		for (TributIcmsUfModel object in tributIcmsUfModelList ?? []) { 
			tributIcmsUfModelLocalList.add(object.toJson); 
		}
		jsonData['tributIcmsUfModelList'] = tributIcmsUfModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idTributGrupoTributario = plutoRow.cells['idTributGrupoTributario']?.value;
		idTributOperacaoFiscal = plutoRow.cells['idTributOperacaoFiscal']?.value;
		tributIpiModel = TributIpiModel();
		tributCofinsModel = TributCofinsModel();
		tributPisModel = TributPisModel();
		tributGrupoTributarioModel = TributGrupoTributarioModel();
		tributGrupoTributarioModel?.descricao = plutoRow.cells['tributGrupoTributarioModel']?.value;
		tributOperacaoFiscalModel = TributOperacaoFiscalModel();
		tributOperacaoFiscalModel?.descricao = plutoRow.cells['tributOperacaoFiscalModel']?.value;
		tributIcmsUfModelList = [];
	}	

	TributConfiguraOfGtModel clone() {
		return TributConfiguraOfGtModel(
			id: id,
			idTributGrupoTributario: idTributGrupoTributario,
			idTributOperacaoFiscal: idTributOperacaoFiscal,
			tributIpiModel: TributIpiModel(
				id: tributIpiModel?.id,
				idTributConfiguraOfGt: tributIpiModel?.idTributConfiguraOfGt,
				cstIpi: tributIpiModel?.cstIpi,
				modalidadeBaseCalculo: tributIpiModel?.modalidadeBaseCalculo,
				porcentoBaseCalculo: tributIpiModel?.porcentoBaseCalculo,
				aliquotaPorcento: tributIpiModel?.aliquotaPorcento,
				aliquotaUnidade: tributIpiModel?.aliquotaUnidade,
				valorPrecoMaximo: tributIpiModel?.valorPrecoMaximo,
				valorPautaFiscal: tributIpiModel?.valorPautaFiscal,
			),
			tributCofinsModel: TributCofinsModel(
				id: tributCofinsModel?.id,
				idTributConfiguraOfGt: tributCofinsModel?.idTributConfiguraOfGt,
				cstCofins: tributCofinsModel?.cstCofins,
				modalidadeBaseCalculo: tributCofinsModel?.modalidadeBaseCalculo,
				efdTabela435: tributCofinsModel?.efdTabela435,
				porcentoBaseCalculo: tributCofinsModel?.porcentoBaseCalculo,
				aliquotaPorcento: tributCofinsModel?.aliquotaPorcento,
				aliquotaUnidade: tributCofinsModel?.aliquotaUnidade,
				valorPrecoMaximo: tributCofinsModel?.valorPrecoMaximo,
				valorPautaFiscal: tributCofinsModel?.valorPautaFiscal,
			),
			tributPisModel: TributPisModel(
				id: tributPisModel?.id,
				idTributConfiguraOfGt: tributPisModel?.idTributConfiguraOfGt,
				cstPis: tributPisModel?.cstPis,
				modalidadeBaseCalculo: tributPisModel?.modalidadeBaseCalculo,
				efdTabela435: tributPisModel?.efdTabela435,
				porcentoBaseCalculo: tributPisModel?.porcentoBaseCalculo,
				aliquotaPorcento: tributPisModel?.aliquotaPorcento,
				aliquotaUnidade: tributPisModel?.aliquotaUnidade,
				valorPrecoMaximo: tributPisModel?.valorPrecoMaximo,
				valorPautaFiscal: tributPisModel?.valorPautaFiscal,
			),
			tributIcmsUfModelList: tributIcmsUfModelListClone(tributIcmsUfModelList!),
		);			
	}

	tributIcmsUfModelListClone(List<TributIcmsUfModel> tributIcmsUfModelList) { 
		List<TributIcmsUfModel> resultList = [];
		for (var tributIcmsUfModel in tributIcmsUfModelList) {
			resultList.add(
				TributIcmsUfModel(
					id: tributIcmsUfModel.id,
					idTributConfiguraOfGt: tributIcmsUfModel.idTributConfiguraOfGt,
					ufDestino: tributIcmsUfModel.ufDestino,
					cst: tributIcmsUfModel.cst,
					csosn: tributIcmsUfModel.csosn,
					modalidadeBc: tributIcmsUfModel.modalidadeBc,
					cfop: tributIcmsUfModel.cfop,
					aliquota: tributIcmsUfModel.aliquota,
					valorPauta: tributIcmsUfModel.valorPauta,
					valorPrecoMaximo: tributIcmsUfModel.valorPrecoMaximo,
					mva: tributIcmsUfModel.mva,
					porcentoBc: tributIcmsUfModel.porcentoBc,
					modalidadeBcSt: tributIcmsUfModel.modalidadeBcSt,
					aliquotaInternaSt: tributIcmsUfModel.aliquotaInternaSt,
					aliquotaInterestadualSt: tributIcmsUfModel.aliquotaInterestadualSt,
					porcentoBcSt: tributIcmsUfModel.porcentoBcSt,
					aliquotaIcmsSt: tributIcmsUfModel.aliquotaIcmsSt,
					valorPautaSt: tributIcmsUfModel.valorPautaSt,
					valorPrecoMaximoSt: tributIcmsUfModel.valorPrecoMaximoSt,
				)
			);
		}
		return resultList;
	}

	
}