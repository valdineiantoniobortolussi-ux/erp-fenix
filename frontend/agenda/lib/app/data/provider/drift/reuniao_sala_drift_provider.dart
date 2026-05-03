import 'package:agenda/app/data/provider/drift/database/database_imports.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/provider/provider_base.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class ReuniaoSalaDriftProvider extends ProviderBase {

	Future<List<ReuniaoSalaModel>?> getList({Filter? filter}) async {
		List<ReuniaoSalaGrouped> reuniaoSalaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				reuniaoSalaDriftList = await Session.database.reuniaoSalaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				reuniaoSalaDriftList = await Session.database.reuniaoSalaDao.getGroupedList(); 
			}
			if (reuniaoSalaDriftList.isNotEmpty) {
				return toListModel(reuniaoSalaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ReuniaoSalaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.reuniaoSalaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ReuniaoSalaModel?>? insert(ReuniaoSalaModel reuniaoSalaModel) async {
		try {
			final lastPk = await Session.database.reuniaoSalaDao.insertObject(toDrift(reuniaoSalaModel));
			reuniaoSalaModel.id = lastPk;
			return reuniaoSalaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ReuniaoSalaModel?>? update(ReuniaoSalaModel reuniaoSalaModel) async {
		try {
			await Session.database.reuniaoSalaDao.updateObject(toDrift(reuniaoSalaModel));
			return reuniaoSalaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.reuniaoSalaDao.deleteObject(toDrift(ReuniaoSalaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ReuniaoSalaModel> toListModel(List<ReuniaoSalaGrouped> reuniaoSalaDriftList) {
		List<ReuniaoSalaModel> listModel = [];
		for (var reuniaoSalaDrift in reuniaoSalaDriftList) {
			listModel.add(toModel(reuniaoSalaDrift)!);
		}
		return listModel;
	}	

	ReuniaoSalaModel? toModel(ReuniaoSalaGrouped? reuniaoSalaDrift) {
		if (reuniaoSalaDrift != null) {
			return ReuniaoSalaModel(
				id: reuniaoSalaDrift.reuniaoSala?.id,
				predio: reuniaoSalaDrift.reuniaoSala?.predio,
				nome: reuniaoSalaDrift.reuniaoSala?.nome,
				andar: reuniaoSalaDrift.reuniaoSala?.andar,
				numero: reuniaoSalaDrift.reuniaoSala?.numero,
			);
		} else {
			return null;
		}
	}


	ReuniaoSalaGrouped toDrift(ReuniaoSalaModel reuniaoSalaModel) {
		return ReuniaoSalaGrouped(
			reuniaoSala: ReuniaoSala(
				id: reuniaoSalaModel.id,
				predio: reuniaoSalaModel.predio,
				nome: reuniaoSalaModel.nome,
				andar: reuniaoSalaModel.andar,
				numero: reuniaoSalaModel.numero,
			),
		);
	}

		
}
