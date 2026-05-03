import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteDocumentoAnteriorIdDriftProvider extends ProviderBase {

	Future<List<CteDocumentoAnteriorIdModel>?> getList({Filter? filter}) async {
		List<CteDocumentoAnteriorIdGrouped> cteDocumentoAnteriorIdDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteDocumentoAnteriorIdDriftList = await Session.database.cteDocumentoAnteriorIdDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteDocumentoAnteriorIdDriftList = await Session.database.cteDocumentoAnteriorIdDao.getGroupedList(); 
			}
			if (cteDocumentoAnteriorIdDriftList.isNotEmpty) {
				return toListModel(cteDocumentoAnteriorIdDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteDocumentoAnteriorIdModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteDocumentoAnteriorIdDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteDocumentoAnteriorIdModel?>? insert(CteDocumentoAnteriorIdModel cteDocumentoAnteriorIdModel) async {
		try {
			final lastPk = await Session.database.cteDocumentoAnteriorIdDao.insertObject(toDrift(cteDocumentoAnteriorIdModel));
			cteDocumentoAnteriorIdModel.id = lastPk;
			return cteDocumentoAnteriorIdModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteDocumentoAnteriorIdModel?>? update(CteDocumentoAnteriorIdModel cteDocumentoAnteriorIdModel) async {
		try {
			await Session.database.cteDocumentoAnteriorIdDao.updateObject(toDrift(cteDocumentoAnteriorIdModel));
			return cteDocumentoAnteriorIdModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteDocumentoAnteriorIdDao.deleteObject(toDrift(CteDocumentoAnteriorIdModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteDocumentoAnteriorIdModel> toListModel(List<CteDocumentoAnteriorIdGrouped> cteDocumentoAnteriorIdDriftList) {
		List<CteDocumentoAnteriorIdModel> listModel = [];
		for (var cteDocumentoAnteriorIdDrift in cteDocumentoAnteriorIdDriftList) {
			listModel.add(toModel(cteDocumentoAnteriorIdDrift)!);
		}
		return listModel;
	}	

	CteDocumentoAnteriorIdModel? toModel(CteDocumentoAnteriorIdGrouped? cteDocumentoAnteriorIdDrift) {
		if (cteDocumentoAnteriorIdDrift != null) {
			return CteDocumentoAnteriorIdModel(
				id: cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.id,
				idCteDocumentoAnterior: cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.idCteDocumentoAnterior,
				tipo: CteDocumentoAnteriorIdDomain.getTipo(cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.tipo),
				serie: CteDocumentoAnteriorIdDomain.getSerie(cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.serie),
				subserie: CteDocumentoAnteriorIdDomain.getSubserie(cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.subserie),
				numero: cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.numero,
				dataEmissao: cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.dataEmissao,
				chaveCte: cteDocumentoAnteriorIdDrift.cteDocumentoAnteriorId?.chaveCte,
			);
		} else {
			return null;
		}
	}


	CteDocumentoAnteriorIdGrouped toDrift(CteDocumentoAnteriorIdModel cteDocumentoAnteriorIdModel) {
		return CteDocumentoAnteriorIdGrouped(
			cteDocumentoAnteriorId: CteDocumentoAnteriorId(
				id: cteDocumentoAnteriorIdModel.id,
				idCteDocumentoAnterior: cteDocumentoAnteriorIdModel.idCteDocumentoAnterior,
				tipo: CteDocumentoAnteriorIdDomain.setTipo(cteDocumentoAnteriorIdModel.tipo),
				serie: CteDocumentoAnteriorIdDomain.setSerie(cteDocumentoAnteriorIdModel.serie),
				subserie: CteDocumentoAnteriorIdDomain.setSubserie(cteDocumentoAnteriorIdModel.subserie),
				numero: cteDocumentoAnteriorIdModel.numero,
				dataEmissao: cteDocumentoAnteriorIdModel.dataEmissao,
				chaveCte: cteDocumentoAnteriorIdModel.chaveCte,
			),
		);
	}

		
}
