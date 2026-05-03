import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfCargaLacreDriftProvider extends ProviderBase {

	Future<List<CteInfNfCargaLacreModel>?> getList({Filter? filter}) async {
		List<CteInfNfCargaLacreGrouped> cteInfNfCargaLacreDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteInfNfCargaLacreDriftList = await Session.database.cteInfNfCargaLacreDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteInfNfCargaLacreDriftList = await Session.database.cteInfNfCargaLacreDao.getGroupedList(); 
			}
			if (cteInfNfCargaLacreDriftList.isNotEmpty) {
				return toListModel(cteInfNfCargaLacreDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteInfNfCargaLacreModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteInfNfCargaLacreDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInfNfCargaLacreModel?>? insert(CteInfNfCargaLacreModel cteInfNfCargaLacreModel) async {
		try {
			final lastPk = await Session.database.cteInfNfCargaLacreDao.insertObject(toDrift(cteInfNfCargaLacreModel));
			cteInfNfCargaLacreModel.id = lastPk;
			return cteInfNfCargaLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInfNfCargaLacreModel?>? update(CteInfNfCargaLacreModel cteInfNfCargaLacreModel) async {
		try {
			await Session.database.cteInfNfCargaLacreDao.updateObject(toDrift(cteInfNfCargaLacreModel));
			return cteInfNfCargaLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteInfNfCargaLacreDao.deleteObject(toDrift(CteInfNfCargaLacreModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteInfNfCargaLacreModel> toListModel(List<CteInfNfCargaLacreGrouped> cteInfNfCargaLacreDriftList) {
		List<CteInfNfCargaLacreModel> listModel = [];
		for (var cteInfNfCargaLacreDrift in cteInfNfCargaLacreDriftList) {
			listModel.add(toModel(cteInfNfCargaLacreDrift)!);
		}
		return listModel;
	}	

	CteInfNfCargaLacreModel? toModel(CteInfNfCargaLacreGrouped? cteInfNfCargaLacreDrift) {
		if (cteInfNfCargaLacreDrift != null) {
			return CteInfNfCargaLacreModel(
				id: cteInfNfCargaLacreDrift.cteInfNfCargaLacre?.id,
				idCteInformacaoNfCarga: cteInfNfCargaLacreDrift.cteInfNfCargaLacre?.idCteInformacaoNfCarga,
				numero: cteInfNfCargaLacreDrift.cteInfNfCargaLacre?.numero,
				quantidadeRateada: cteInfNfCargaLacreDrift.cteInfNfCargaLacre?.quantidadeRateada,
				cteInformacaoNfCargaModel: CteInformacaoNfCargaModel(
					id: cteInfNfCargaLacreDrift.cteInformacaoNfCarga?.id,
					idCteInformacaoNf: cteInfNfCargaLacreDrift.cteInformacaoNfCarga?.idCteInformacaoNf,
					tipoUnidadeCarga: cteInfNfCargaLacreDrift.cteInformacaoNfCarga?.tipoUnidadeCarga,
					idUnidadeCarga: cteInfNfCargaLacreDrift.cteInformacaoNfCarga?.idUnidadeCarga,
				),
			);
		} else {
			return null;
		}
	}


	CteInfNfCargaLacreGrouped toDrift(CteInfNfCargaLacreModel cteInfNfCargaLacreModel) {
		return CteInfNfCargaLacreGrouped(
			cteInfNfCargaLacre: CteInfNfCargaLacre(
				id: cteInfNfCargaLacreModel.id,
				idCteInformacaoNfCarga: cteInfNfCargaLacreModel.idCteInformacaoNfCarga,
				numero: cteInfNfCargaLacreModel.numero,
				quantidadeRateada: cteInfNfCargaLacreModel.quantidadeRateada,
			),
		);
	}

		
}
