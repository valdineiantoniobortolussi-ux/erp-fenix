import 'package:esocial/app/data/provider/drift/database/database_imports.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/data/provider/provider_base.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialRubricaDriftProvider extends ProviderBase {

	Future<List<EsocialRubricaModel>?> getList({Filter? filter}) async {
		List<EsocialRubricaGrouped> esocialRubricaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				esocialRubricaDriftList = await Session.database.esocialRubricaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				esocialRubricaDriftList = await Session.database.esocialRubricaDao.getGroupedList(); 
			}
			if (esocialRubricaDriftList.isNotEmpty) {
				return toListModel(esocialRubricaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EsocialRubricaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.esocialRubricaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialRubricaModel?>? insert(EsocialRubricaModel esocialRubricaModel) async {
		try {
			final lastPk = await Session.database.esocialRubricaDao.insertObject(toDrift(esocialRubricaModel));
			esocialRubricaModel.id = lastPk;
			return esocialRubricaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialRubricaModel?>? update(EsocialRubricaModel esocialRubricaModel) async {
		try {
			await Session.database.esocialRubricaDao.updateObject(toDrift(esocialRubricaModel));
			return esocialRubricaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.esocialRubricaDao.deleteObject(toDrift(EsocialRubricaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EsocialRubricaModel> toListModel(List<EsocialRubricaGrouped> esocialRubricaDriftList) {
		List<EsocialRubricaModel> listModel = [];
		for (var esocialRubricaDrift in esocialRubricaDriftList) {
			listModel.add(toModel(esocialRubricaDrift)!);
		}
		return listModel;
	}	

	EsocialRubricaModel? toModel(EsocialRubricaGrouped? esocialRubricaDrift) {
		if (esocialRubricaDrift != null) {
			return EsocialRubricaModel(
				id: esocialRubricaDrift.esocialRubrica?.id,
				codigo: esocialRubricaDrift.esocialRubrica?.codigo,
				nome: esocialRubricaDrift.esocialRubrica?.nome,
				descricao: esocialRubricaDrift.esocialRubrica?.descricao,
			);
		} else {
			return null;
		}
	}


	EsocialRubricaGrouped toDrift(EsocialRubricaModel esocialRubricaModel) {
		return EsocialRubricaGrouped(
			esocialRubrica: EsocialRubrica(
				id: esocialRubricaModel.id,
				codigo: esocialRubricaModel.codigo,
				nome: esocialRubricaModel.nome,
				descricao: esocialRubricaModel.descricao,
			),
		);
	}

		
}
