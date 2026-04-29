import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioLacreDriftProvider extends ProviderBase {

	Future<List<CteRodoviarioLacreModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioLacreGrouped> cteRodoviarioLacreDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteRodoviarioLacreDriftList = await Session.database.cteRodoviarioLacreDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteRodoviarioLacreDriftList = await Session.database.cteRodoviarioLacreDao.getGroupedList(); 
			}
			if (cteRodoviarioLacreDriftList.isNotEmpty) {
				return toListModel(cteRodoviarioLacreDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteRodoviarioLacreModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteRodoviarioLacreDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioLacreModel?>? insert(CteRodoviarioLacreModel cteRodoviarioLacreModel) async {
		try {
			final lastPk = await Session.database.cteRodoviarioLacreDao.insertObject(toDrift(cteRodoviarioLacreModel));
			cteRodoviarioLacreModel.id = lastPk;
			return cteRodoviarioLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioLacreModel?>? update(CteRodoviarioLacreModel cteRodoviarioLacreModel) async {
		try {
			await Session.database.cteRodoviarioLacreDao.updateObject(toDrift(cteRodoviarioLacreModel));
			return cteRodoviarioLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteRodoviarioLacreDao.deleteObject(toDrift(CteRodoviarioLacreModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteRodoviarioLacreModel> toListModel(List<CteRodoviarioLacreGrouped> cteRodoviarioLacreDriftList) {
		List<CteRodoviarioLacreModel> listModel = [];
		for (var cteRodoviarioLacreDrift in cteRodoviarioLacreDriftList) {
			listModel.add(toModel(cteRodoviarioLacreDrift)!);
		}
		return listModel;
	}	

	CteRodoviarioLacreModel? toModel(CteRodoviarioLacreGrouped? cteRodoviarioLacreDrift) {
		if (cteRodoviarioLacreDrift != null) {
			return CteRodoviarioLacreModel(
				id: cteRodoviarioLacreDrift.cteRodoviarioLacre?.id,
				idCteRodoviario: cteRodoviarioLacreDrift.cteRodoviarioLacre?.idCteRodoviario,
				numero: cteRodoviarioLacreDrift.cteRodoviarioLacre?.numero,
				cteRodoviarioModel: CteRodoviarioModel(
					id: cteRodoviarioLacreDrift.cteRodoviario?.id,
					idCteCabecalho: cteRodoviarioLacreDrift.cteRodoviario?.idCteCabecalho,
					rntrc: cteRodoviarioLacreDrift.cteRodoviario?.rntrc,
					dataPrevistaEntrega: cteRodoviarioLacreDrift.cteRodoviario?.dataPrevistaEntrega,
					indicadorLotacao: cteRodoviarioLacreDrift.cteRodoviario?.indicadorLotacao,
					ciot: cteRodoviarioLacreDrift.cteRodoviario?.ciot,
				),
			);
		} else {
			return null;
		}
	}


	CteRodoviarioLacreGrouped toDrift(CteRodoviarioLacreModel cteRodoviarioLacreModel) {
		return CteRodoviarioLacreGrouped(
			cteRodoviarioLacre: CteRodoviarioLacre(
				id: cteRodoviarioLacreModel.id,
				idCteRodoviario: cteRodoviarioLacreModel.idCteRodoviario,
				numero: cteRodoviarioLacreModel.numero,
			),
		);
	}

		
}
