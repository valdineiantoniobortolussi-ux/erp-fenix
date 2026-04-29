import 'package:tributacao/app/data/provider/drift/database/database_imports.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/provider/provider_base.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributIcmsCustomCabDriftProvider extends ProviderBase {

	Future<List<TributIcmsCustomCabModel>?> getList({Filter? filter}) async {
		List<TributIcmsCustomCabGrouped> tributIcmsCustomCabDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tributIcmsCustomCabDriftList = await Session.database.tributIcmsCustomCabDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tributIcmsCustomCabDriftList = await Session.database.tributIcmsCustomCabDao.getGroupedList(); 
			}
			if (tributIcmsCustomCabDriftList.isNotEmpty) {
				return toListModel(tributIcmsCustomCabDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TributIcmsCustomCabModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tributIcmsCustomCabDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributIcmsCustomCabModel?>? insert(TributIcmsCustomCabModel tributIcmsCustomCabModel) async {
		try {
			final lastPk = await Session.database.tributIcmsCustomCabDao.insertObject(toDrift(tributIcmsCustomCabModel));
			tributIcmsCustomCabModel.id = lastPk;
			return tributIcmsCustomCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributIcmsCustomCabModel?>? update(TributIcmsCustomCabModel tributIcmsCustomCabModel) async {
		try {
			await Session.database.tributIcmsCustomCabDao.updateObject(toDrift(tributIcmsCustomCabModel));
			return tributIcmsCustomCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tributIcmsCustomCabDao.deleteObject(toDrift(TributIcmsCustomCabModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TributIcmsCustomCabModel> toListModel(List<TributIcmsCustomCabGrouped> tributIcmsCustomCabDriftList) {
		List<TributIcmsCustomCabModel> listModel = [];
		for (var tributIcmsCustomCabDrift in tributIcmsCustomCabDriftList) {
			listModel.add(toModel(tributIcmsCustomCabDrift)!);
		}
		return listModel;
	}	

	TributIcmsCustomCabModel? toModel(TributIcmsCustomCabGrouped? tributIcmsCustomCabDrift) {
		if (tributIcmsCustomCabDrift != null) {
			return TributIcmsCustomCabModel(
				id: tributIcmsCustomCabDrift.tributIcmsCustomCab?.id,
				descricao: tributIcmsCustomCabDrift.tributIcmsCustomCab?.descricao,
				origemMercadoria: TributIcmsCustomCabDomain.getOrigemMercadoria(tributIcmsCustomCabDrift.tributIcmsCustomCab?.origemMercadoria),
				tributIcmsCustomDetModelList: tributIcmsCustomDetDriftToModel(tributIcmsCustomCabDrift.tributIcmsCustomDetGroupedList),
			);
		} else {
			return null;
		}
	}

	List<TributIcmsCustomDetModel> tributIcmsCustomDetDriftToModel(List<TributIcmsCustomDetGrouped>? tributIcmsCustomDetDriftList) { 
		List<TributIcmsCustomDetModel> tributIcmsCustomDetModelList = [];
		if (tributIcmsCustomDetDriftList != null) {
			for (var tributIcmsCustomDetGrouped in tributIcmsCustomDetDriftList) {
				tributIcmsCustomDetModelList.add(
					TributIcmsCustomDetModel(
						id: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.id,
						idTributIcmsCustomCab: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.idTributIcmsCustomCab,
						ufDestino: TributIcmsCustomDetDomain.getUfDestino(tributIcmsCustomDetGrouped.tributIcmsCustomDet?.ufDestino),
						cst: TributIcmsCustomDetDomain.getCst(tributIcmsCustomDetGrouped.tributIcmsCustomDet?.cst),
						csosn: TributIcmsCustomDetDomain.getCsosn(tributIcmsCustomDetGrouped.tributIcmsCustomDet?.csosn),
						modalidadeBc: TributIcmsCustomDetDomain.getModalidadeBc(tributIcmsCustomDetGrouped.tributIcmsCustomDet?.modalidadeBc),
						cfop: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.cfop,
						aliquota: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.aliquota,
						valorPauta: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.valorPauta,
						valorPrecoMaximo: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.valorPrecoMaximo,
						mva: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.mva,
						porcentoBc: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.porcentoBc,
						modalidadeBcSt: TributIcmsCustomDetDomain.getModalidadeBcSt(tributIcmsCustomDetGrouped.tributIcmsCustomDet?.modalidadeBcSt),
						aliquotaInternaSt: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.aliquotaInternaSt,
						aliquotaInterestadualSt: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.aliquotaInterestadualSt,
						porcentoBcSt: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.porcentoBcSt,
						aliquotaIcmsSt: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.aliquotaIcmsSt,
						valorPautaSt: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.valorPautaSt,
						valorPrecoMaximoSt: tributIcmsCustomDetGrouped.tributIcmsCustomDet?.valorPrecoMaximoSt,
					)
				);
			}
			return tributIcmsCustomDetModelList;
		}
		return [];
	}


	TributIcmsCustomCabGrouped toDrift(TributIcmsCustomCabModel tributIcmsCustomCabModel) {
		return TributIcmsCustomCabGrouped(
			tributIcmsCustomCab: TributIcmsCustomCab(
				id: tributIcmsCustomCabModel.id,
				descricao: tributIcmsCustomCabModel.descricao,
				origemMercadoria: TributIcmsCustomCabDomain.setOrigemMercadoria(tributIcmsCustomCabModel.origemMercadoria),
			),
			tributIcmsCustomDetGroupedList: tributIcmsCustomDetModelToDrift(tributIcmsCustomCabModel.tributIcmsCustomDetModelList),
		);
	}

	List<TributIcmsCustomDetGrouped> tributIcmsCustomDetModelToDrift(List<TributIcmsCustomDetModel>? tributIcmsCustomDetModelList) { 
		List<TributIcmsCustomDetGrouped> tributIcmsCustomDetGroupedList = [];
		if (tributIcmsCustomDetModelList != null) {
			for (var tributIcmsCustomDetModel in tributIcmsCustomDetModelList) {
				tributIcmsCustomDetGroupedList.add(
					TributIcmsCustomDetGrouped(
						tributIcmsCustomDet: TributIcmsCustomDet(
							id: tributIcmsCustomDetModel.id,
							idTributIcmsCustomCab: tributIcmsCustomDetModel.idTributIcmsCustomCab,
							ufDestino: TributIcmsCustomDetDomain.setUfDestino(tributIcmsCustomDetModel.ufDestino),
							cst: TributIcmsCustomDetDomain.setCst(tributIcmsCustomDetModel.cst),
							csosn: TributIcmsCustomDetDomain.setCsosn(tributIcmsCustomDetModel.csosn),
							modalidadeBc: TributIcmsCustomDetDomain.setModalidadeBc(tributIcmsCustomDetModel.modalidadeBc),
							cfop: tributIcmsCustomDetModel.cfop,
							aliquota: tributIcmsCustomDetModel.aliquota,
							valorPauta: tributIcmsCustomDetModel.valorPauta,
							valorPrecoMaximo: tributIcmsCustomDetModel.valorPrecoMaximo,
							mva: tributIcmsCustomDetModel.mva,
							porcentoBc: tributIcmsCustomDetModel.porcentoBc,
							modalidadeBcSt: TributIcmsCustomDetDomain.setModalidadeBcSt(tributIcmsCustomDetModel.modalidadeBcSt),
							aliquotaInternaSt: tributIcmsCustomDetModel.aliquotaInternaSt,
							aliquotaInterestadualSt: tributIcmsCustomDetModel.aliquotaInterestadualSt,
							porcentoBcSt: tributIcmsCustomDetModel.porcentoBcSt,
							aliquotaIcmsSt: tributIcmsCustomDetModel.aliquotaIcmsSt,
							valorPautaSt: tributIcmsCustomDetModel.valorPautaSt,
							valorPrecoMaximoSt: tributIcmsCustomDetModel.valorPrecoMaximoSt,
						),
					),
				);
			}
			return tributIcmsCustomDetGroupedList;
		}
		return [];
	}

		
}
