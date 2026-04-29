import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class PlanoCentroResultadoDriftProvider extends ProviderBase {

	Future<List<PlanoCentroResultadoModel>?> getList({Filter? filter}) async {
		List<PlanoCentroResultadoGrouped> planoCentroResultadoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				planoCentroResultadoDriftList = await Session.database.planoCentroResultadoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				planoCentroResultadoDriftList = await Session.database.planoCentroResultadoDao.getGroupedList(); 
			}
			if (planoCentroResultadoDriftList.isNotEmpty) {
				return toListModel(planoCentroResultadoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PlanoCentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.planoCentroResultadoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PlanoCentroResultadoModel?>? insert(PlanoCentroResultadoModel planoCentroResultadoModel) async {
		try {
			final lastPk = await Session.database.planoCentroResultadoDao.insertObject(toDrift(planoCentroResultadoModel));
			planoCentroResultadoModel.id = lastPk;
			return planoCentroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PlanoCentroResultadoModel?>? update(PlanoCentroResultadoModel planoCentroResultadoModel) async {
		try {
			await Session.database.planoCentroResultadoDao.updateObject(toDrift(planoCentroResultadoModel));
			return planoCentroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.planoCentroResultadoDao.deleteObject(toDrift(PlanoCentroResultadoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PlanoCentroResultadoModel> toListModel(List<PlanoCentroResultadoGrouped> planoCentroResultadoDriftList) {
		List<PlanoCentroResultadoModel> listModel = [];
		for (var planoCentroResultadoDrift in planoCentroResultadoDriftList) {
			listModel.add(toModel(planoCentroResultadoDrift)!);
		}
		return listModel;
	}	

	PlanoCentroResultadoModel? toModel(PlanoCentroResultadoGrouped? planoCentroResultadoDrift) {
		if (planoCentroResultadoDrift != null) {
			return PlanoCentroResultadoModel(
				id: planoCentroResultadoDrift.planoCentroResultado?.id,
				nome: planoCentroResultadoDrift.planoCentroResultado?.nome,
				mascara: planoCentroResultadoDrift.planoCentroResultado?.mascara,
				niveis: planoCentroResultadoDrift.planoCentroResultado?.niveis,
				dataInclusao: planoCentroResultadoDrift.planoCentroResultado?.dataInclusao,
			);
		} else {
			return null;
		}
	}


	PlanoCentroResultadoGrouped toDrift(PlanoCentroResultadoModel planoCentroResultadoModel) {
		return PlanoCentroResultadoGrouped(
			planoCentroResultado: PlanoCentroResultado(
				id: planoCentroResultadoModel.id,
				nome: planoCentroResultadoModel.nome,
				mascara: planoCentroResultadoModel.mascara,
				niveis: planoCentroResultadoModel.niveis,
				dataInclusao: planoCentroResultadoModel.dataInclusao,
			),
		);
	}

		
}
