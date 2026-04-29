import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/provider/provider_base.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class FuncaoDriftProvider extends ProviderBase {

	Future<List<FuncaoModel>?> getList({Filter? filter}) async {
		List<FuncaoGrouped> funcaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				funcaoDriftList = await Session.database.funcaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				funcaoDriftList = await Session.database.funcaoDao.getGroupedList(); 
			}
			if (funcaoDriftList.isNotEmpty) {
				return toListModel(funcaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FuncaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.funcaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FuncaoModel?>? insert(FuncaoModel funcaoModel) async {
		try {
			final lastPk = await Session.database.funcaoDao.insertObject(toDrift(funcaoModel));
			funcaoModel.id = lastPk;
			return funcaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FuncaoModel?>? update(FuncaoModel funcaoModel) async {
		try {
			await Session.database.funcaoDao.updateObject(toDrift(funcaoModel));
			return funcaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.funcaoDao.deleteObject(toDrift(FuncaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FuncaoModel> toListModel(List<FuncaoGrouped> funcaoDriftList) {
		List<FuncaoModel> listModel = [];
		for (var funcaoDrift in funcaoDriftList) {
			listModel.add(toModel(funcaoDrift)!);
		}
		return listModel;
	}	

	FuncaoModel? toModel(FuncaoGrouped? funcaoDrift) {
		if (funcaoDrift != null) {
			return FuncaoModel(
				id: funcaoDrift.funcao?.id,
				nome: funcaoDrift.funcao?.nome,
				descricao: funcaoDrift.funcao?.descricao,
			);
		} else {
			return null;
		}
	}


	FuncaoGrouped toDrift(FuncaoModel funcaoModel) {
		return FuncaoGrouped(
			funcao: Funcao(
				id: funcaoModel.id,
				nome: funcaoModel.nome,
				descricao: funcaoModel.descricao,
			),
		);
	}

		
}
