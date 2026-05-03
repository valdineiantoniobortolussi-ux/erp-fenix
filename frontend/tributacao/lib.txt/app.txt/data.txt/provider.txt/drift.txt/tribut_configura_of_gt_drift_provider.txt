import 'package:tributacao/app/data/provider/drift/database/database_imports.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/provider/provider_base.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributConfiguraOfGtDriftProvider extends ProviderBase {

	Future<List<TributConfiguraOfGtModel>?> getList({Filter? filter}) async {
		List<TributConfiguraOfGtGrouped> tributConfiguraOfGtDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tributConfiguraOfGtDriftList = await Session.database.tributConfiguraOfGtDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tributConfiguraOfGtDriftList = await Session.database.tributConfiguraOfGtDao.getGroupedList(); 
			}
			if (tributConfiguraOfGtDriftList.isNotEmpty) {
				return toListModel(tributConfiguraOfGtDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TributConfiguraOfGtModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tributConfiguraOfGtDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributConfiguraOfGtModel?>? insert(TributConfiguraOfGtModel tributConfiguraOfGtModel) async {
		try {
			final lastPk = await Session.database.tributConfiguraOfGtDao.insertObject(toDrift(tributConfiguraOfGtModel));
			tributConfiguraOfGtModel.id = lastPk;
			return tributConfiguraOfGtModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributConfiguraOfGtModel?>? update(TributConfiguraOfGtModel tributConfiguraOfGtModel) async {
		try {
			await Session.database.tributConfiguraOfGtDao.updateObject(toDrift(tributConfiguraOfGtModel));
			return tributConfiguraOfGtModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tributConfiguraOfGtDao.deleteObject(toDrift(TributConfiguraOfGtModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TributConfiguraOfGtModel> toListModel(List<TributConfiguraOfGtGrouped> tributConfiguraOfGtDriftList) {
		List<TributConfiguraOfGtModel> listModel = [];
		for (var tributConfiguraOfGtDrift in tributConfiguraOfGtDriftList) {
			listModel.add(toModel(tributConfiguraOfGtDrift)!);
		}
		return listModel;
	}	

	TributConfiguraOfGtModel? toModel(TributConfiguraOfGtGrouped? tributConfiguraOfGtDrift) {
		if (tributConfiguraOfGtDrift != null) {
			return TributConfiguraOfGtModel(
				id: tributConfiguraOfGtDrift.tributConfiguraOfGt?.id,
				idTributGrupoTributario: tributConfiguraOfGtDrift.tributConfiguraOfGt?.idTributGrupoTributario,
				idTributOperacaoFiscal: tributConfiguraOfGtDrift.tributConfiguraOfGt?.idTributOperacaoFiscal,
				tributIpiModel: TributIpiModel(
					id: tributConfiguraOfGtDrift.tributIpi?.id,
					idTributConfiguraOfGt: tributConfiguraOfGtDrift.tributIpi?.idTributConfiguraOfGt,
					cstIpi: TributIpiDomain.getCstIpi(tributConfiguraOfGtDrift.tributIpi?.cstIpi),
					modalidadeBaseCalculo: TributIpiDomain.getModalidadeBaseCalculo(tributConfiguraOfGtDrift.tributIpi?.modalidadeBaseCalculo),
					porcentoBaseCalculo: tributConfiguraOfGtDrift.tributIpi?.porcentoBaseCalculo,
					aliquotaPorcento: tributConfiguraOfGtDrift.tributIpi?.aliquotaPorcento,
					aliquotaUnidade: tributConfiguraOfGtDrift.tributIpi?.aliquotaUnidade,
					valorPrecoMaximo: tributConfiguraOfGtDrift.tributIpi?.valorPrecoMaximo,
					valorPautaFiscal: tributConfiguraOfGtDrift.tributIpi?.valorPautaFiscal,
				),
				tributCofinsModel: TributCofinsModel(
					id: tributConfiguraOfGtDrift.tributCofins?.id,
					idTributConfiguraOfGt: tributConfiguraOfGtDrift.tributCofins?.idTributConfiguraOfGt,
					cstCofins: TributCofinsDomain.getCstCofins(tributConfiguraOfGtDrift.tributCofins?.cstCofins),
					modalidadeBaseCalculo: TributCofinsDomain.getModalidadeBaseCalculo(tributConfiguraOfGtDrift.tributCofins?.modalidadeBaseCalculo),
					efdTabela435: tributConfiguraOfGtDrift.tributCofins?.efdTabela435,
					porcentoBaseCalculo: tributConfiguraOfGtDrift.tributCofins?.porcentoBaseCalculo,
					aliquotaPorcento: tributConfiguraOfGtDrift.tributCofins?.aliquotaPorcento,
					aliquotaUnidade: tributConfiguraOfGtDrift.tributCofins?.aliquotaUnidade,
					valorPrecoMaximo: tributConfiguraOfGtDrift.tributCofins?.valorPrecoMaximo,
					valorPautaFiscal: tributConfiguraOfGtDrift.tributCofins?.valorPautaFiscal,
				),
				tributPisModel: TributPisModel(
					id: tributConfiguraOfGtDrift.tributPis?.id,
					idTributConfiguraOfGt: tributConfiguraOfGtDrift.tributPis?.idTributConfiguraOfGt,
					cstPis: TributPisDomain.getCstPis(tributConfiguraOfGtDrift.tributPis?.cstPis),
					modalidadeBaseCalculo: TributPisDomain.getModalidadeBaseCalculo(tributConfiguraOfGtDrift.tributPis?.modalidadeBaseCalculo),
					efdTabela435: tributConfiguraOfGtDrift.tributPis?.efdTabela435,
					porcentoBaseCalculo: tributConfiguraOfGtDrift.tributPis?.porcentoBaseCalculo,
					aliquotaPorcento: tributConfiguraOfGtDrift.tributPis?.aliquotaPorcento,
					aliquotaUnidade: tributConfiguraOfGtDrift.tributPis?.aliquotaUnidade,
					valorPrecoMaximo: tributConfiguraOfGtDrift.tributPis?.valorPrecoMaximo,
					valorPautaFiscal: tributConfiguraOfGtDrift.tributPis?.valorPautaFiscal,
				),
				tributGrupoTributarioModel: TributGrupoTributarioModel(
					id: tributConfiguraOfGtDrift.tributGrupoTributario?.id,
					descricao: tributConfiguraOfGtDrift.tributGrupoTributario?.descricao,
					origemMercadoria: tributConfiguraOfGtDrift.tributGrupoTributario?.origemMercadoria,
					observacao: tributConfiguraOfGtDrift.tributGrupoTributario?.observacao,
				),
				tributOperacaoFiscalModel: TributOperacaoFiscalModel(
					id: tributConfiguraOfGtDrift.tributOperacaoFiscal?.id,
					cfop: tributConfiguraOfGtDrift.tributOperacaoFiscal?.cfop,
					descricao: tributConfiguraOfGtDrift.tributOperacaoFiscal?.descricao,
					descricaoNaNf: tributConfiguraOfGtDrift.tributOperacaoFiscal?.descricaoNaNf,
					observacao: tributConfiguraOfGtDrift.tributOperacaoFiscal?.observacao,
				),
				tributIcmsUfModelList: tributIcmsUfDriftToModel(tributConfiguraOfGtDrift.tributIcmsUfGroupedList),
			);
		} else {
			return null;
		}
	}

	List<TributIcmsUfModel> tributIcmsUfDriftToModel(List<TributIcmsUfGrouped>? tributIcmsUfDriftList) { 
		List<TributIcmsUfModel> tributIcmsUfModelList = [];
		if (tributIcmsUfDriftList != null) {
			for (var tributIcmsUfGrouped in tributIcmsUfDriftList) {
				tributIcmsUfModelList.add(
					TributIcmsUfModel(
						id: tributIcmsUfGrouped.tributIcmsUf?.id,
						idTributConfiguraOfGt: tributIcmsUfGrouped.tributIcmsUf?.idTributConfiguraOfGt,
						ufDestino: TributIcmsUfDomain.getUfDestino(tributIcmsUfGrouped.tributIcmsUf?.ufDestino),
						cst: TributIcmsUfDomain.getCst(tributIcmsUfGrouped.tributIcmsUf?.cst),
						csosn: TributIcmsUfDomain.getCsosn(tributIcmsUfGrouped.tributIcmsUf?.csosn),
						modalidadeBc: TributIcmsUfDomain.getModalidadeBc(tributIcmsUfGrouped.tributIcmsUf?.modalidadeBc),
						cfop: tributIcmsUfGrouped.tributIcmsUf?.cfop,
						aliquota: tributIcmsUfGrouped.tributIcmsUf?.aliquota,
						valorPauta: tributIcmsUfGrouped.tributIcmsUf?.valorPauta,
						valorPrecoMaximo: tributIcmsUfGrouped.tributIcmsUf?.valorPrecoMaximo,
						mva: tributIcmsUfGrouped.tributIcmsUf?.mva,
						porcentoBc: tributIcmsUfGrouped.tributIcmsUf?.porcentoBc,
						modalidadeBcSt: TributIcmsUfDomain.getModalidadeBcSt(tributIcmsUfGrouped.tributIcmsUf?.modalidadeBcSt),
						aliquotaInternaSt: tributIcmsUfGrouped.tributIcmsUf?.aliquotaInternaSt,
						aliquotaInterestadualSt: tributIcmsUfGrouped.tributIcmsUf?.aliquotaInterestadualSt,
						porcentoBcSt: tributIcmsUfGrouped.tributIcmsUf?.porcentoBcSt,
						aliquotaIcmsSt: tributIcmsUfGrouped.tributIcmsUf?.aliquotaIcmsSt,
						valorPautaSt: tributIcmsUfGrouped.tributIcmsUf?.valorPautaSt,
						valorPrecoMaximoSt: tributIcmsUfGrouped.tributIcmsUf?.valorPrecoMaximoSt,
					)
				);
			}
			return tributIcmsUfModelList;
		}
		return [];
	}


	TributConfiguraOfGtGrouped toDrift(TributConfiguraOfGtModel tributConfiguraOfGtModel) {
		return TributConfiguraOfGtGrouped(
			tributConfiguraOfGt: TributConfiguraOfGt(
				id: tributConfiguraOfGtModel.id,
				idTributGrupoTributario: tributConfiguraOfGtModel.idTributGrupoTributario,
				idTributOperacaoFiscal: tributConfiguraOfGtModel.idTributOperacaoFiscal,
			),
			tributIpi: TributIpi(
				id: tributConfiguraOfGtModel.tributIpiModel?.id,
				idTributConfiguraOfGt: tributConfiguraOfGtModel.tributIpiModel?.idTributConfiguraOfGt,
				cstIpi: TributIpiDomain.setCstIpi(tributConfiguraOfGtModel.tributIpiModel?.cstIpi),
				modalidadeBaseCalculo: TributIpiDomain.setModalidadeBaseCalculo(tributConfiguraOfGtModel.tributIpiModel?.modalidadeBaseCalculo),
				porcentoBaseCalculo: tributConfiguraOfGtModel.tributIpiModel?.porcentoBaseCalculo,
				aliquotaPorcento: tributConfiguraOfGtModel.tributIpiModel?.aliquotaPorcento,
				aliquotaUnidade: tributConfiguraOfGtModel.tributIpiModel?.aliquotaUnidade,
				valorPrecoMaximo: tributConfiguraOfGtModel.tributIpiModel?.valorPrecoMaximo,
				valorPautaFiscal: tributConfiguraOfGtModel.tributIpiModel?.valorPautaFiscal,
			),
			tributCofins: TributCofins(
				id: tributConfiguraOfGtModel.tributCofinsModel?.id,
				idTributConfiguraOfGt: tributConfiguraOfGtModel.tributCofinsModel?.idTributConfiguraOfGt,
				cstCofins: TributCofinsDomain.setCstCofins(tributConfiguraOfGtModel.tributCofinsModel?.cstCofins),
				modalidadeBaseCalculo: TributCofinsDomain.setModalidadeBaseCalculo(tributConfiguraOfGtModel.tributCofinsModel?.modalidadeBaseCalculo),
				efdTabela435: tributConfiguraOfGtModel.tributCofinsModel?.efdTabela435,
				porcentoBaseCalculo: tributConfiguraOfGtModel.tributCofinsModel?.porcentoBaseCalculo,
				aliquotaPorcento: tributConfiguraOfGtModel.tributCofinsModel?.aliquotaPorcento,
				aliquotaUnidade: tributConfiguraOfGtModel.tributCofinsModel?.aliquotaUnidade,
				valorPrecoMaximo: tributConfiguraOfGtModel.tributCofinsModel?.valorPrecoMaximo,
				valorPautaFiscal: tributConfiguraOfGtModel.tributCofinsModel?.valorPautaFiscal,
			),
			tributPis: TributPis(
				id: tributConfiguraOfGtModel.tributPisModel?.id,
				idTributConfiguraOfGt: tributConfiguraOfGtModel.tributPisModel?.idTributConfiguraOfGt,
				cstPis: TributPisDomain.setCstPis(tributConfiguraOfGtModel.tributPisModel?.cstPis),
				modalidadeBaseCalculo: TributPisDomain.setModalidadeBaseCalculo(tributConfiguraOfGtModel.tributPisModel?.modalidadeBaseCalculo),
				efdTabela435: tributConfiguraOfGtModel.tributPisModel?.efdTabela435,
				porcentoBaseCalculo: tributConfiguraOfGtModel.tributPisModel?.porcentoBaseCalculo,
				aliquotaPorcento: tributConfiguraOfGtModel.tributPisModel?.aliquotaPorcento,
				aliquotaUnidade: tributConfiguraOfGtModel.tributPisModel?.aliquotaUnidade,
				valorPrecoMaximo: tributConfiguraOfGtModel.tributPisModel?.valorPrecoMaximo,
				valorPautaFiscal: tributConfiguraOfGtModel.tributPisModel?.valorPautaFiscal,
			),
			tributIcmsUfGroupedList: tributIcmsUfModelToDrift(tributConfiguraOfGtModel.tributIcmsUfModelList),
		);
	}

	List<TributIcmsUfGrouped> tributIcmsUfModelToDrift(List<TributIcmsUfModel>? tributIcmsUfModelList) { 
		List<TributIcmsUfGrouped> tributIcmsUfGroupedList = [];
		if (tributIcmsUfModelList != null) {
			for (var tributIcmsUfModel in tributIcmsUfModelList) {
				tributIcmsUfGroupedList.add(
					TributIcmsUfGrouped(
						tributIcmsUf: TributIcmsUf(
							id: tributIcmsUfModel.id,
							idTributConfiguraOfGt: tributIcmsUfModel.idTributConfiguraOfGt,
							ufDestino: TributIcmsUfDomain.setUfDestino(tributIcmsUfModel.ufDestino),
							cst: TributIcmsUfDomain.setCst(tributIcmsUfModel.cst),
							csosn: TributIcmsUfDomain.setCsosn(tributIcmsUfModel.csosn),
							modalidadeBc: TributIcmsUfDomain.setModalidadeBc(tributIcmsUfModel.modalidadeBc),
							cfop: tributIcmsUfModel.cfop,
							aliquota: tributIcmsUfModel.aliquota,
							valorPauta: tributIcmsUfModel.valorPauta,
							valorPrecoMaximo: tributIcmsUfModel.valorPrecoMaximo,
							mva: tributIcmsUfModel.mva,
							porcentoBc: tributIcmsUfModel.porcentoBc,
							modalidadeBcSt: TributIcmsUfDomain.setModalidadeBcSt(tributIcmsUfModel.modalidadeBcSt),
							aliquotaInternaSt: tributIcmsUfModel.aliquotaInternaSt,
							aliquotaInterestadualSt: tributIcmsUfModel.aliquotaInterestadualSt,
							porcentoBcSt: tributIcmsUfModel.porcentoBcSt,
							aliquotaIcmsSt: tributIcmsUfModel.aliquotaIcmsSt,
							valorPautaSt: tributIcmsUfModel.valorPautaSt,
							valorPrecoMaximoSt: tributIcmsUfModel.valorPrecoMaximoSt,
						),
					),
				);
			}
			return tributIcmsUfGroupedList;
		}
		return [];
	}

		
}
