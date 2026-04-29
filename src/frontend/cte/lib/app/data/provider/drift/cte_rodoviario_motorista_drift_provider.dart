import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioMotoristaDriftProvider extends ProviderBase {

	Future<List<CteRodoviarioMotoristaModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioMotoristaGrouped> cteRodoviarioMotoristaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteRodoviarioMotoristaDriftList = await Session.database.cteRodoviarioMotoristaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteRodoviarioMotoristaDriftList = await Session.database.cteRodoviarioMotoristaDao.getGroupedList(); 
			}
			if (cteRodoviarioMotoristaDriftList.isNotEmpty) {
				return toListModel(cteRodoviarioMotoristaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteRodoviarioMotoristaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteRodoviarioMotoristaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioMotoristaModel?>? insert(CteRodoviarioMotoristaModel cteRodoviarioMotoristaModel) async {
		try {
			final lastPk = await Session.database.cteRodoviarioMotoristaDao.insertObject(toDrift(cteRodoviarioMotoristaModel));
			cteRodoviarioMotoristaModel.id = lastPk;
			return cteRodoviarioMotoristaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioMotoristaModel?>? update(CteRodoviarioMotoristaModel cteRodoviarioMotoristaModel) async {
		try {
			await Session.database.cteRodoviarioMotoristaDao.updateObject(toDrift(cteRodoviarioMotoristaModel));
			return cteRodoviarioMotoristaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteRodoviarioMotoristaDao.deleteObject(toDrift(CteRodoviarioMotoristaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteRodoviarioMotoristaModel> toListModel(List<CteRodoviarioMotoristaGrouped> cteRodoviarioMotoristaDriftList) {
		List<CteRodoviarioMotoristaModel> listModel = [];
		for (var cteRodoviarioMotoristaDrift in cteRodoviarioMotoristaDriftList) {
			listModel.add(toModel(cteRodoviarioMotoristaDrift)!);
		}
		return listModel;
	}	

	CteRodoviarioMotoristaModel? toModel(CteRodoviarioMotoristaGrouped? cteRodoviarioMotoristaDrift) {
		if (cteRodoviarioMotoristaDrift != null) {
			return CteRodoviarioMotoristaModel(
				id: cteRodoviarioMotoristaDrift.cteRodoviarioMotorista?.id,
				idCteRodoviario: cteRodoviarioMotoristaDrift.cteRodoviarioMotorista?.idCteRodoviario,
				nome: cteRodoviarioMotoristaDrift.cteRodoviarioMotorista?.nome,
				cpf: cteRodoviarioMotoristaDrift.cteRodoviarioMotorista?.cpf,
				cteRodoviarioModel: CteRodoviarioModel(
					id: cteRodoviarioMotoristaDrift.cteRodoviario?.id,
					idCteCabecalho: cteRodoviarioMotoristaDrift.cteRodoviario?.idCteCabecalho,
					rntrc: cteRodoviarioMotoristaDrift.cteRodoviario?.rntrc,
					dataPrevistaEntrega: cteRodoviarioMotoristaDrift.cteRodoviario?.dataPrevistaEntrega,
					indicadorLotacao: cteRodoviarioMotoristaDrift.cteRodoviario?.indicadorLotacao,
					ciot: cteRodoviarioMotoristaDrift.cteRodoviario?.ciot,
				),
			);
		} else {
			return null;
		}
	}


	CteRodoviarioMotoristaGrouped toDrift(CteRodoviarioMotoristaModel cteRodoviarioMotoristaModel) {
		return CteRodoviarioMotoristaGrouped(
			cteRodoviarioMotorista: CteRodoviarioMotorista(
				id: cteRodoviarioMotoristaModel.id,
				idCteRodoviario: cteRodoviarioMotoristaModel.idCteRodoviario,
				nome: cteRodoviarioMotoristaModel.nome,
				cpf: Util.removeMask(cteRodoviarioMotoristaModel.cpf),
			),
		);
	}

		
}
