import 'package:estoque/app/data/provider/drift/database/database_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueCorDriftProvider extends ProviderBase {

	Future<List<EstoqueCorModel>?> getList({Filter? filter}) async {
		List<EstoqueCorGrouped> estoqueCorDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				estoqueCorDriftList = await Session.database.estoqueCorDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				estoqueCorDriftList = await Session.database.estoqueCorDao.getGroupedList(); 
			}
			if (estoqueCorDriftList.isNotEmpty) {
				return toListModel(estoqueCorDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EstoqueCorModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.estoqueCorDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueCorModel?>? insert(EstoqueCorModel estoqueCorModel) async {
		try {
			final lastPk = await Session.database.estoqueCorDao.insertObject(toDrift(estoqueCorModel));
			estoqueCorModel.id = lastPk;
			return estoqueCorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueCorModel?>? update(EstoqueCorModel estoqueCorModel) async {
		try {
			await Session.database.estoqueCorDao.updateObject(toDrift(estoqueCorModel));
			return estoqueCorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.estoqueCorDao.deleteObject(toDrift(EstoqueCorModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EstoqueCorModel> toListModel(List<EstoqueCorGrouped> estoqueCorDriftList) {
		List<EstoqueCorModel> listModel = [];
		for (var estoqueCorDrift in estoqueCorDriftList) {
			listModel.add(toModel(estoqueCorDrift)!);
		}
		return listModel;
	}	

	EstoqueCorModel? toModel(EstoqueCorGrouped? estoqueCorDrift) {
		if (estoqueCorDrift != null) {
			return EstoqueCorModel(
				id: estoqueCorDrift.estoqueCor?.id,
				codigo: estoqueCorDrift.estoqueCor?.codigo,
				nome: estoqueCorDrift.estoqueCor?.nome,
			);
		} else {
			return null;
		}
	}


	EstoqueCorGrouped toDrift(EstoqueCorModel estoqueCorModel) {
		return EstoqueCorGrouped(
			estoqueCor: EstoqueCor(
				id: estoqueCorModel.id,
				codigo: estoqueCorModel.codigo,
				nome: estoqueCorModel.nome,
			),
		);
	}

		
}
