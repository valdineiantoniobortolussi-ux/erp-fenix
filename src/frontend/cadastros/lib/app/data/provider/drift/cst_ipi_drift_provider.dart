import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstIpiDriftProvider extends ProviderBase {

	Future<List<CstIpiModel>?> getList({Filter? filter}) async {
		List<CstIpiGrouped> cstIpiDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cstIpiDriftList = await Session.database.cstIpiDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cstIpiDriftList = await Session.database.cstIpiDao.getGroupedList(); 
			}
			if (cstIpiDriftList.isNotEmpty) {
				return toListModel(cstIpiDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CstIpiModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cstIpiDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstIpiModel?>? insert(CstIpiModel cstIpiModel) async {
		try {
			final lastPk = await Session.database.cstIpiDao.insertObject(toDrift(cstIpiModel));
			cstIpiModel.id = lastPk;
			return cstIpiModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstIpiModel?>? update(CstIpiModel cstIpiModel) async {
		try {
			await Session.database.cstIpiDao.updateObject(toDrift(cstIpiModel));
			return cstIpiModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cstIpiDao.deleteObject(toDrift(CstIpiModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CstIpiModel> toListModel(List<CstIpiGrouped> cstIpiDriftList) {
		List<CstIpiModel> listModel = [];
		for (var cstIpiDrift in cstIpiDriftList) {
			listModel.add(toModel(cstIpiDrift)!);
		}
		return listModel;
	}	

	CstIpiModel? toModel(CstIpiGrouped? cstIpiDrift) {
		if (cstIpiDrift != null) {
			return CstIpiModel(
				id: cstIpiDrift.cstIpi?.id,
				codigo: cstIpiDrift.cstIpi?.codigo,
				descricao: cstIpiDrift.cstIpi?.descricao,
				observacao: cstIpiDrift.cstIpi?.observacao,
			);
		} else {
			return null;
		}
	}


	CstIpiGrouped toDrift(CstIpiModel cstIpiModel) {
		return CstIpiGrouped(
			cstIpi: CstIpi(
				id: cstIpiModel.id,
				codigo: cstIpiModel.codigo,
				descricao: cstIpiModel.descricao,
				observacao: cstIpiModel.observacao,
			),
		);
	}

		
}
