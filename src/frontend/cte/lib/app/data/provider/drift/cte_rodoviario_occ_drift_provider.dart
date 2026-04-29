import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteRodoviarioOccDriftProvider extends ProviderBase {

	Future<List<CteRodoviarioOccModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioOccGrouped> cteRodoviarioOccDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteRodoviarioOccDriftList = await Session.database.cteRodoviarioOccDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteRodoviarioOccDriftList = await Session.database.cteRodoviarioOccDao.getGroupedList(); 
			}
			if (cteRodoviarioOccDriftList.isNotEmpty) {
				return toListModel(cteRodoviarioOccDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteRodoviarioOccModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteRodoviarioOccDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioOccModel?>? insert(CteRodoviarioOccModel cteRodoviarioOccModel) async {
		try {
			final lastPk = await Session.database.cteRodoviarioOccDao.insertObject(toDrift(cteRodoviarioOccModel));
			cteRodoviarioOccModel.id = lastPk;
			return cteRodoviarioOccModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioOccModel?>? update(CteRodoviarioOccModel cteRodoviarioOccModel) async {
		try {
			await Session.database.cteRodoviarioOccDao.updateObject(toDrift(cteRodoviarioOccModel));
			return cteRodoviarioOccModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteRodoviarioOccDao.deleteObject(toDrift(CteRodoviarioOccModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteRodoviarioOccModel> toListModel(List<CteRodoviarioOccGrouped> cteRodoviarioOccDriftList) {
		List<CteRodoviarioOccModel> listModel = [];
		for (var cteRodoviarioOccDrift in cteRodoviarioOccDriftList) {
			listModel.add(toModel(cteRodoviarioOccDrift)!);
		}
		return listModel;
	}	

	CteRodoviarioOccModel? toModel(CteRodoviarioOccGrouped? cteRodoviarioOccDrift) {
		if (cteRodoviarioOccDrift != null) {
			return CteRodoviarioOccModel(
				id: cteRodoviarioOccDrift.cteRodoviarioOcc?.id,
				idCteRodoviario: cteRodoviarioOccDrift.cteRodoviarioOcc?.idCteRodoviario,
				serie: CteRodoviarioOccDomain.getSerie(cteRodoviarioOccDrift.cteRodoviarioOcc?.serie),
				numero: cteRodoviarioOccDrift.cteRodoviarioOcc?.numero,
				dataEmissao: cteRodoviarioOccDrift.cteRodoviarioOcc?.dataEmissao,
				cnpj: cteRodoviarioOccDrift.cteRodoviarioOcc?.cnpj,
				codigoInterno: cteRodoviarioOccDrift.cteRodoviarioOcc?.codigoInterno,
				ie: cteRodoviarioOccDrift.cteRodoviarioOcc?.ie,
				uf: CteRodoviarioOccDomain.getUf(cteRodoviarioOccDrift.cteRodoviarioOcc?.uf),
				telefone: cteRodoviarioOccDrift.cteRodoviarioOcc?.telefone,
				cteRodoviarioModel: CteRodoviarioModel(
					id: cteRodoviarioOccDrift.cteRodoviario?.id,
					idCteCabecalho: cteRodoviarioOccDrift.cteRodoviario?.idCteCabecalho,
					rntrc: cteRodoviarioOccDrift.cteRodoviario?.rntrc,
					dataPrevistaEntrega: cteRodoviarioOccDrift.cteRodoviario?.dataPrevistaEntrega,
					indicadorLotacao: cteRodoviarioOccDrift.cteRodoviario?.indicadorLotacao,
					ciot: cteRodoviarioOccDrift.cteRodoviario?.ciot,
				),
			);
		} else {
			return null;
		}
	}


	CteRodoviarioOccGrouped toDrift(CteRodoviarioOccModel cteRodoviarioOccModel) {
		return CteRodoviarioOccGrouped(
			cteRodoviarioOcc: CteRodoviarioOcc(
				id: cteRodoviarioOccModel.id,
				idCteRodoviario: cteRodoviarioOccModel.idCteRodoviario,
				serie: CteRodoviarioOccDomain.setSerie(cteRodoviarioOccModel.serie),
				numero: cteRodoviarioOccModel.numero,
				dataEmissao: cteRodoviarioOccModel.dataEmissao,
				cnpj: Util.removeMask(cteRodoviarioOccModel.cnpj),
				codigoInterno: cteRodoviarioOccModel.codigoInterno,
				ie: cteRodoviarioOccModel.ie,
				uf: CteRodoviarioOccDomain.setUf(cteRodoviarioOccModel.uf),
				telefone: cteRodoviarioOccModel.telefone,
			),
		);
	}

		
}
