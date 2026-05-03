import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/provider/provider_base.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class CnaeDriftProvider extends ProviderBase {

	Future<List<CnaeModel>?> getList({Filter? filter}) async {
		List<CnaeGrouped> cnaeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cnaeDriftList = await Session.database.cnaeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cnaeDriftList = await Session.database.cnaeDao.getGroupedList(); 
			}
			if (cnaeDriftList.isNotEmpty) {
				return toListModel(cnaeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CnaeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cnaeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CnaeModel?>? insert(CnaeModel cnaeModel) async {
		try {
			final lastPk = await Session.database.cnaeDao.insertObject(toDrift(cnaeModel));
			cnaeModel.id = lastPk;
			return cnaeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CnaeModel?>? update(CnaeModel cnaeModel) async {
		try {
			await Session.database.cnaeDao.updateObject(toDrift(cnaeModel));
			return cnaeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cnaeDao.deleteObject(toDrift(CnaeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CnaeModel> toListModel(List<CnaeGrouped> cnaeDriftList) {
		List<CnaeModel> listModel = [];
		for (var cnaeDrift in cnaeDriftList) {
			listModel.add(toModel(cnaeDrift)!);
		}
		return listModel;
	}	

	CnaeModel? toModel(CnaeGrouped? cnaeDrift) {
		if (cnaeDrift != null) {
			return CnaeModel(
				id: cnaeDrift.cnae?.id,
				codigo: cnaeDrift.cnae?.codigo,
				denominacao: cnaeDrift.cnae?.denominacao,
			);
		} else {
			return null;
		}
	}


	CnaeGrouped toDrift(CnaeModel cnaeModel) {
		return CnaeGrouped(
			cnae: Cnae(
				id: cnaeModel.id,
				codigo: cnaeModel.codigo,
				denominacao: cnaeModel.denominacao,
			),
		);
	}

		
}
