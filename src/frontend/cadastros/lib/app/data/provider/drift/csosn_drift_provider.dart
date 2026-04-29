import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CsosnDriftProvider extends ProviderBase {

	Future<List<CsosnModel>?> getList({Filter? filter}) async {
		List<CsosnGrouped> csosnDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				csosnDriftList = await Session.database.csosnDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				csosnDriftList = await Session.database.csosnDao.getGroupedList(); 
			}
			if (csosnDriftList.isNotEmpty) {
				return toListModel(csosnDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CsosnModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.csosnDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CsosnModel?>? insert(CsosnModel csosnModel) async {
		try {
			final lastPk = await Session.database.csosnDao.insertObject(toDrift(csosnModel));
			csosnModel.id = lastPk;
			return csosnModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CsosnModel?>? update(CsosnModel csosnModel) async {
		try {
			await Session.database.csosnDao.updateObject(toDrift(csosnModel));
			return csosnModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.csosnDao.deleteObject(toDrift(CsosnModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CsosnModel> toListModel(List<CsosnGrouped> csosnDriftList) {
		List<CsosnModel> listModel = [];
		for (var csosnDrift in csosnDriftList) {
			listModel.add(toModel(csosnDrift)!);
		}
		return listModel;
	}	

	CsosnModel? toModel(CsosnGrouped? csosnDrift) {
		if (csosnDrift != null) {
			return CsosnModel(
				id: csosnDrift.csosn?.id,
				codigo: csosnDrift.csosn?.codigo,
				descricao: csosnDrift.csosn?.descricao,
				observacao: csosnDrift.csosn?.observacao,
			);
		} else {
			return null;
		}
	}


	CsosnGrouped toDrift(CsosnModel csosnModel) {
		return CsosnGrouped(
			csosn: Csosn(
				id: csosnModel.id,
				codigo: csosnModel.codigo,
				descricao: csosnModel.descricao,
				observacao: csosnModel.observacao,
			),
		);
	}

		
}
