import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstPisDriftProvider extends ProviderBase {

	Future<List<CstPisModel>?> getList({Filter? filter}) async {
		List<CstPisGrouped> cstPisDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cstPisDriftList = await Session.database.cstPisDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cstPisDriftList = await Session.database.cstPisDao.getGroupedList(); 
			}
			if (cstPisDriftList.isNotEmpty) {
				return toListModel(cstPisDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CstPisModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cstPisDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstPisModel?>? insert(CstPisModel cstPisModel) async {
		try {
			final lastPk = await Session.database.cstPisDao.insertObject(toDrift(cstPisModel));
			cstPisModel.id = lastPk;
			return cstPisModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstPisModel?>? update(CstPisModel cstPisModel) async {
		try {
			await Session.database.cstPisDao.updateObject(toDrift(cstPisModel));
			return cstPisModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cstPisDao.deleteObject(toDrift(CstPisModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CstPisModel> toListModel(List<CstPisGrouped> cstPisDriftList) {
		List<CstPisModel> listModel = [];
		for (var cstPisDrift in cstPisDriftList) {
			listModel.add(toModel(cstPisDrift)!);
		}
		return listModel;
	}	

	CstPisModel? toModel(CstPisGrouped? cstPisDrift) {
		if (cstPisDrift != null) {
			return CstPisModel(
				id: cstPisDrift.cstPis?.id,
				codigo: cstPisDrift.cstPis?.codigo,
				descricao: cstPisDrift.cstPis?.descricao,
				observacao: cstPisDrift.cstPis?.observacao,
			);
		} else {
			return null;
		}
	}


	CstPisGrouped toDrift(CstPisModel cstPisModel) {
		return CstPisGrouped(
			cstPis: CstPis(
				id: cstPisModel.id,
				codigo: cstPisModel.codigo,
				descricao: cstPisModel.descricao,
				observacao: cstPisModel.observacao,
			),
		);
	}

		
}
