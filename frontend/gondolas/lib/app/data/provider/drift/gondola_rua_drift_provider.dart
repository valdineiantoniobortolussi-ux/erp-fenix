import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';
import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/data/provider/provider_base.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaRuaDriftProvider extends ProviderBase {

	Future<List<GondolaRuaModel>?> getList({Filter? filter}) async {
		List<GondolaRuaGrouped> gondolaRuaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				gondolaRuaDriftList = await Session.database.gondolaRuaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				gondolaRuaDriftList = await Session.database.gondolaRuaDao.getGroupedList(); 
			}
			if (gondolaRuaDriftList.isNotEmpty) {
				return toListModel(gondolaRuaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GondolaRuaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.gondolaRuaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaRuaModel?>? insert(GondolaRuaModel gondolaRuaModel) async {
		try {
			final lastPk = await Session.database.gondolaRuaDao.insertObject(toDrift(gondolaRuaModel));
			gondolaRuaModel.id = lastPk;
			return gondolaRuaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaRuaModel?>? update(GondolaRuaModel gondolaRuaModel) async {
		try {
			await Session.database.gondolaRuaDao.updateObject(toDrift(gondolaRuaModel));
			return gondolaRuaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.gondolaRuaDao.deleteObject(toDrift(GondolaRuaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<GondolaRuaModel> toListModel(List<GondolaRuaGrouped> gondolaRuaDriftList) {
		List<GondolaRuaModel> listModel = [];
		for (var gondolaRuaDrift in gondolaRuaDriftList) {
			listModel.add(toModel(gondolaRuaDrift)!);
		}
		return listModel;
	}	

	GondolaRuaModel? toModel(GondolaRuaGrouped? gondolaRuaDrift) {
		if (gondolaRuaDrift != null) {
			return GondolaRuaModel(
				id: gondolaRuaDrift.gondolaRua?.id,
				codigo: gondolaRuaDrift.gondolaRua?.codigo,
				quantidadeEstante: gondolaRuaDrift.gondolaRua?.quantidadeEstante,
				nome: gondolaRuaDrift.gondolaRua?.nome,
			);
		} else {
			return null;
		}
	}


	GondolaRuaGrouped toDrift(GondolaRuaModel gondolaRuaModel) {
		return GondolaRuaGrouped(
			gondolaRua: GondolaRua(
				id: gondolaRuaModel.id,
				codigo: gondolaRuaModel.codigo,
				quantidadeEstante: gondolaRuaModel.quantidadeEstante,
				nome: gondolaRuaModel.nome,
			),
		);
	}

		
}
