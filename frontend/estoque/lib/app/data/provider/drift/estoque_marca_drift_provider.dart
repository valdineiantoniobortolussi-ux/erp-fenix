import 'package:estoque/app/data/provider/drift/database/database_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueMarcaDriftProvider extends ProviderBase {

	Future<List<EstoqueMarcaModel>?> getList({Filter? filter}) async {
		List<EstoqueMarcaGrouped> estoqueMarcaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				estoqueMarcaDriftList = await Session.database.estoqueMarcaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				estoqueMarcaDriftList = await Session.database.estoqueMarcaDao.getGroupedList(); 
			}
			if (estoqueMarcaDriftList.isNotEmpty) {
				return toListModel(estoqueMarcaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EstoqueMarcaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.estoqueMarcaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueMarcaModel?>? insert(EstoqueMarcaModel estoqueMarcaModel) async {
		try {
			final lastPk = await Session.database.estoqueMarcaDao.insertObject(toDrift(estoqueMarcaModel));
			estoqueMarcaModel.id = lastPk;
			return estoqueMarcaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueMarcaModel?>? update(EstoqueMarcaModel estoqueMarcaModel) async {
		try {
			await Session.database.estoqueMarcaDao.updateObject(toDrift(estoqueMarcaModel));
			return estoqueMarcaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.estoqueMarcaDao.deleteObject(toDrift(EstoqueMarcaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EstoqueMarcaModel> toListModel(List<EstoqueMarcaGrouped> estoqueMarcaDriftList) {
		List<EstoqueMarcaModel> listModel = [];
		for (var estoqueMarcaDrift in estoqueMarcaDriftList) {
			listModel.add(toModel(estoqueMarcaDrift)!);
		}
		return listModel;
	}	

	EstoqueMarcaModel? toModel(EstoqueMarcaGrouped? estoqueMarcaDrift) {
		if (estoqueMarcaDrift != null) {
			return EstoqueMarcaModel(
				id: estoqueMarcaDrift.estoqueMarca?.id,
				codigo: estoqueMarcaDrift.estoqueMarca?.codigo,
				nome: estoqueMarcaDrift.estoqueMarca?.nome,
			);
		} else {
			return null;
		}
	}


	EstoqueMarcaGrouped toDrift(EstoqueMarcaModel estoqueMarcaModel) {
		return EstoqueMarcaGrouped(
			estoqueMarca: EstoqueMarca(
				id: estoqueMarcaModel.id,
				codigo: estoqueMarcaModel.codigo,
				nome: estoqueMarcaModel.nome,
			),
		);
	}

		
}
