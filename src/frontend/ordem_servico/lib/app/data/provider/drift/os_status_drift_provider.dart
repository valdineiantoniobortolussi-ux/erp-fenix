import 'package:ordem_servico/app/data/provider/drift/database/database_imports.dart';
import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/data/provider/provider_base.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class OsStatusDriftProvider extends ProviderBase {

	Future<List<OsStatusModel>?> getList({Filter? filter}) async {
		List<OsStatusGrouped> osStatusDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				osStatusDriftList = await Session.database.osStatusDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				osStatusDriftList = await Session.database.osStatusDao.getGroupedList(); 
			}
			if (osStatusDriftList.isNotEmpty) {
				return toListModel(osStatusDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OsStatusModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.osStatusDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsStatusModel?>? insert(OsStatusModel osStatusModel) async {
		try {
			final lastPk = await Session.database.osStatusDao.insertObject(toDrift(osStatusModel));
			osStatusModel.id = lastPk;
			return osStatusModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsStatusModel?>? update(OsStatusModel osStatusModel) async {
		try {
			await Session.database.osStatusDao.updateObject(toDrift(osStatusModel));
			return osStatusModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.osStatusDao.deleteObject(toDrift(OsStatusModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OsStatusModel> toListModel(List<OsStatusGrouped> osStatusDriftList) {
		List<OsStatusModel> listModel = [];
		for (var osStatusDrift in osStatusDriftList) {
			listModel.add(toModel(osStatusDrift)!);
		}
		return listModel;
	}	

	OsStatusModel? toModel(OsStatusGrouped? osStatusDrift) {
		if (osStatusDrift != null) {
			return OsStatusModel(
				id: osStatusDrift.osStatus?.id,
				codigo: osStatusDrift.osStatus?.codigo,
				nome: osStatusDrift.osStatus?.nome,
			);
		} else {
			return null;
		}
	}


	OsStatusGrouped toDrift(OsStatusModel osStatusModel) {
		return OsStatusGrouped(
			osStatus: OsStatus(
				id: osStatusModel.id,
				codigo: osStatusModel.codigo,
				nome: osStatusModel.nome,
			),
		);
	}

		
}
