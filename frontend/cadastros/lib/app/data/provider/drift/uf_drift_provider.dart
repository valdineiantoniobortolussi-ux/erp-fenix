import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class UfDriftProvider extends ProviderBase {

	Future<List<UfModel>?> getList({Filter? filter}) async {
		List<UfGrouped> ufDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				ufDriftList = await Session.database.ufDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				ufDriftList = await Session.database.ufDao.getGroupedList(); 
			}
			if (ufDriftList.isNotEmpty) {
				return toListModel(ufDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<UfModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.ufDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<UfModel?>? insert(UfModel ufModel) async {
		try {
			final lastPk = await Session.database.ufDao.insertObject(toDrift(ufModel));
			ufModel.id = lastPk;
			return ufModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<UfModel?>? update(UfModel ufModel) async {
		try {
			await Session.database.ufDao.updateObject(toDrift(ufModel));
			return ufModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.ufDao.deleteObject(toDrift(UfModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<UfModel> toListModel(List<UfGrouped> ufDriftList) {
		List<UfModel> listModel = [];
		for (var ufDrift in ufDriftList) {
			listModel.add(toModel(ufDrift)!);
		}
		return listModel;
	}	

	UfModel? toModel(UfGrouped? ufDrift) {
		if (ufDrift != null) {
			return UfModel(
				id: ufDrift.uf?.id,
				nome: ufDrift.uf?.nome,
				sigla: ufDrift.uf?.sigla,
				codigoIbge: ufDrift.uf?.codigoIbge,
			);
		} else {
			return null;
		}
	}


	UfGrouped toDrift(UfModel ufModel) {
		return UfGrouped(
			uf: Uf(
				id: ufModel.id,
				nome: ufModel.nome,
				sigla: ufModel.sigla,
				codigoIbge: ufModel.codigoIbge,
			),
		);
	}

		
}
