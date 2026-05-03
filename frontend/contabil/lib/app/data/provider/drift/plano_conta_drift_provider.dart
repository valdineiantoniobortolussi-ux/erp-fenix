import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class PlanoContaDriftProvider extends ProviderBase {

	Future<List<PlanoContaModel>?> getList({Filter? filter}) async {
		List<PlanoContaGrouped> planoContaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				planoContaDriftList = await Session.database.planoContaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				planoContaDriftList = await Session.database.planoContaDao.getGroupedList(); 
			}
			if (planoContaDriftList.isNotEmpty) {
				return toListModel(planoContaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PlanoContaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.planoContaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PlanoContaModel?>? insert(PlanoContaModel planoContaModel) async {
		try {
			final lastPk = await Session.database.planoContaDao.insertObject(toDrift(planoContaModel));
			planoContaModel.id = lastPk;
			return planoContaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PlanoContaModel?>? update(PlanoContaModel planoContaModel) async {
		try {
			await Session.database.planoContaDao.updateObject(toDrift(planoContaModel));
			return planoContaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.planoContaDao.deleteObject(toDrift(PlanoContaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PlanoContaModel> toListModel(List<PlanoContaGrouped> planoContaDriftList) {
		List<PlanoContaModel> listModel = [];
		for (var planoContaDrift in planoContaDriftList) {
			listModel.add(toModel(planoContaDrift)!);
		}
		return listModel;
	}	

	PlanoContaModel? toModel(PlanoContaGrouped? planoContaDrift) {
		if (planoContaDrift != null) {
			return PlanoContaModel(
				id: planoContaDrift.planoConta?.id,
				nome: planoContaDrift.planoConta?.nome,
				dataInclusao: planoContaDrift.planoConta?.dataInclusao,
				mascara: planoContaDrift.planoConta?.mascara,
				niveis: planoContaDrift.planoConta?.niveis,
			);
		} else {
			return null;
		}
	}


	PlanoContaGrouped toDrift(PlanoContaModel planoContaModel) {
		return PlanoContaGrouped(
			planoConta: PlanoConta(
				id: planoContaModel.id,
				nome: planoContaModel.nome,
				dataInclusao: planoContaModel.dataInclusao,
				mascara: planoContaModel.mascara,
				niveis: planoContaModel.niveis,
			),
		);
	}

		
}
