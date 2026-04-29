import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class OperadoraPlanoSaudeDriftProvider extends ProviderBase {

	Future<List<OperadoraPlanoSaudeModel>?> getList({Filter? filter}) async {
		List<OperadoraPlanoSaudeGrouped> operadoraPlanoSaudeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				operadoraPlanoSaudeDriftList = await Session.database.operadoraPlanoSaudeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				operadoraPlanoSaudeDriftList = await Session.database.operadoraPlanoSaudeDao.getGroupedList(); 
			}
			if (operadoraPlanoSaudeDriftList.isNotEmpty) {
				return toListModel(operadoraPlanoSaudeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OperadoraPlanoSaudeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.operadoraPlanoSaudeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OperadoraPlanoSaudeModel?>? insert(OperadoraPlanoSaudeModel operadoraPlanoSaudeModel) async {
		try {
			final lastPk = await Session.database.operadoraPlanoSaudeDao.insertObject(toDrift(operadoraPlanoSaudeModel));
			operadoraPlanoSaudeModel.id = lastPk;
			return operadoraPlanoSaudeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OperadoraPlanoSaudeModel?>? update(OperadoraPlanoSaudeModel operadoraPlanoSaudeModel) async {
		try {
			await Session.database.operadoraPlanoSaudeDao.updateObject(toDrift(operadoraPlanoSaudeModel));
			return operadoraPlanoSaudeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.operadoraPlanoSaudeDao.deleteObject(toDrift(OperadoraPlanoSaudeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OperadoraPlanoSaudeModel> toListModel(List<OperadoraPlanoSaudeGrouped> operadoraPlanoSaudeDriftList) {
		List<OperadoraPlanoSaudeModel> listModel = [];
		for (var operadoraPlanoSaudeDrift in operadoraPlanoSaudeDriftList) {
			listModel.add(toModel(operadoraPlanoSaudeDrift)!);
		}
		return listModel;
	}	

	OperadoraPlanoSaudeModel? toModel(OperadoraPlanoSaudeGrouped? operadoraPlanoSaudeDrift) {
		if (operadoraPlanoSaudeDrift != null) {
			return OperadoraPlanoSaudeModel(
				id: operadoraPlanoSaudeDrift.operadoraPlanoSaude?.id,
				nome: operadoraPlanoSaudeDrift.operadoraPlanoSaude?.nome,
				registroAns: operadoraPlanoSaudeDrift.operadoraPlanoSaude?.registroAns,
				classificacaoContabilConta: operadoraPlanoSaudeDrift.operadoraPlanoSaude?.classificacaoContabilConta,
			);
		} else {
			return null;
		}
	}


	OperadoraPlanoSaudeGrouped toDrift(OperadoraPlanoSaudeModel operadoraPlanoSaudeModel) {
		return OperadoraPlanoSaudeGrouped(
			operadoraPlanoSaude: OperadoraPlanoSaude(
				id: operadoraPlanoSaudeModel.id,
				nome: operadoraPlanoSaudeModel.nome,
				registroAns: operadoraPlanoSaudeModel.registroAns,
				classificacaoContabilConta: operadoraPlanoSaudeModel.classificacaoContabilConta,
			),
		);
	}

		
}
