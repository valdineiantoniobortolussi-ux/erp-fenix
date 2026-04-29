import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CfopDriftProvider extends ProviderBase {

	Future<List<CfopModel>?> getList({Filter? filter}) async {
		List<CfopGrouped> cfopDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cfopDriftList = await Session.database.cfopDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cfopDriftList = await Session.database.cfopDao.getGroupedList(); 
			}
			if (cfopDriftList.isNotEmpty) {
				return toListModel(cfopDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CfopModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cfopDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CfopModel?>? insert(CfopModel cfopModel) async {
		try {
			final lastPk = await Session.database.cfopDao.insertObject(toDrift(cfopModel));
			cfopModel.id = lastPk;
			return cfopModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CfopModel?>? update(CfopModel cfopModel) async {
		try {
			await Session.database.cfopDao.updateObject(toDrift(cfopModel));
			return cfopModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cfopDao.deleteObject(toDrift(CfopModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CfopModel> toListModel(List<CfopGrouped> cfopDriftList) {
		List<CfopModel> listModel = [];
		for (var cfopDrift in cfopDriftList) {
			listModel.add(toModel(cfopDrift)!);
		}
		return listModel;
	}	

	CfopModel? toModel(CfopGrouped? cfopDrift) {
		if (cfopDrift != null) {
			return CfopModel(
				id: cfopDrift.cfop?.id,
				codigo: cfopDrift.cfop?.codigo,
				descricao: cfopDrift.cfop?.descricao,
				aplicacao: cfopDrift.cfop?.aplicacao,
			);
		} else {
			return null;
		}
	}


	CfopGrouped toDrift(CfopModel cfopModel) {
		return CfopGrouped(
			cfop: Cfop(
				id: cfopModel.id,
				codigo: cfopModel.codigo,
				descricao: cfopModel.descricao,
				aplicacao: cfopModel.aplicacao,
			),
		);
	}

		
}
