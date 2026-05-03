import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstCofinsDriftProvider extends ProviderBase {

	Future<List<CstCofinsModel>?> getList({Filter? filter}) async {
		List<CstCofinsGrouped> cstCofinsDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cstCofinsDriftList = await Session.database.cstCofinsDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cstCofinsDriftList = await Session.database.cstCofinsDao.getGroupedList(); 
			}
			if (cstCofinsDriftList.isNotEmpty) {
				return toListModel(cstCofinsDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CstCofinsModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cstCofinsDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstCofinsModel?>? insert(CstCofinsModel cstCofinsModel) async {
		try {
			final lastPk = await Session.database.cstCofinsDao.insertObject(toDrift(cstCofinsModel));
			cstCofinsModel.id = lastPk;
			return cstCofinsModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstCofinsModel?>? update(CstCofinsModel cstCofinsModel) async {
		try {
			await Session.database.cstCofinsDao.updateObject(toDrift(cstCofinsModel));
			return cstCofinsModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cstCofinsDao.deleteObject(toDrift(CstCofinsModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CstCofinsModel> toListModel(List<CstCofinsGrouped> cstCofinsDriftList) {
		List<CstCofinsModel> listModel = [];
		for (var cstCofinsDrift in cstCofinsDriftList) {
			listModel.add(toModel(cstCofinsDrift)!);
		}
		return listModel;
	}	

	CstCofinsModel? toModel(CstCofinsGrouped? cstCofinsDrift) {
		if (cstCofinsDrift != null) {
			return CstCofinsModel(
				id: cstCofinsDrift.cstCofins?.id,
				codigo: cstCofinsDrift.cstCofins?.codigo,
				descricao: cstCofinsDrift.cstCofins?.descricao,
				observacao: cstCofinsDrift.cstCofins?.observacao,
			);
		} else {
			return null;
		}
	}


	CstCofinsGrouped toDrift(CstCofinsModel cstCofinsModel) {
		return CstCofinsGrouped(
			cstCofins: CstCofins(
				id: cstCofinsModel.id,
				codigo: cstCofinsModel.codigo,
				descricao: cstCofinsModel.descricao,
				observacao: cstCofinsModel.observacao,
			),
		);
	}

		
}
