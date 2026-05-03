import 'package:estoque/app/data/provider/drift/database/database_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueSaborDriftProvider extends ProviderBase {

	Future<List<EstoqueSaborModel>?> getList({Filter? filter}) async {
		List<EstoqueSaborGrouped> estoqueSaborDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				estoqueSaborDriftList = await Session.database.estoqueSaborDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				estoqueSaborDriftList = await Session.database.estoqueSaborDao.getGroupedList(); 
			}
			if (estoqueSaborDriftList.isNotEmpty) {
				return toListModel(estoqueSaborDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EstoqueSaborModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.estoqueSaborDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueSaborModel?>? insert(EstoqueSaborModel estoqueSaborModel) async {
		try {
			final lastPk = await Session.database.estoqueSaborDao.insertObject(toDrift(estoqueSaborModel));
			estoqueSaborModel.id = lastPk;
			return estoqueSaborModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueSaborModel?>? update(EstoqueSaborModel estoqueSaborModel) async {
		try {
			await Session.database.estoqueSaborDao.updateObject(toDrift(estoqueSaborModel));
			return estoqueSaborModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.estoqueSaborDao.deleteObject(toDrift(EstoqueSaborModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EstoqueSaborModel> toListModel(List<EstoqueSaborGrouped> estoqueSaborDriftList) {
		List<EstoqueSaborModel> listModel = [];
		for (var estoqueSaborDrift in estoqueSaborDriftList) {
			listModel.add(toModel(estoqueSaborDrift)!);
		}
		return listModel;
	}	

	EstoqueSaborModel? toModel(EstoqueSaborGrouped? estoqueSaborDrift) {
		if (estoqueSaborDrift != null) {
			return EstoqueSaborModel(
				id: estoqueSaborDrift.estoqueSabor?.id,
				codigo: estoqueSaborDrift.estoqueSabor?.codigo,
				nome: estoqueSaborDrift.estoqueSabor?.nome,
			);
		} else {
			return null;
		}
	}


	EstoqueSaborGrouped toDrift(EstoqueSaborModel estoqueSaborModel) {
		return EstoqueSaborGrouped(
			estoqueSabor: EstoqueSabor(
				id: estoqueSaborModel.id,
				codigo: estoqueSaborModel.codigo,
				nome: estoqueSaborModel.nome,
			),
		);
	}

		
}
