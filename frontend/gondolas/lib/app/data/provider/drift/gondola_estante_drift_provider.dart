import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';
import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/data/provider/provider_base.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaEstanteDriftProvider extends ProviderBase {

	Future<List<GondolaEstanteModel>?> getList({Filter? filter}) async {
		List<GondolaEstanteGrouped> gondolaEstanteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				gondolaEstanteDriftList = await Session.database.gondolaEstanteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				gondolaEstanteDriftList = await Session.database.gondolaEstanteDao.getGroupedList(); 
			}
			if (gondolaEstanteDriftList.isNotEmpty) {
				return toListModel(gondolaEstanteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GondolaEstanteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.gondolaEstanteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaEstanteModel?>? insert(GondolaEstanteModel gondolaEstanteModel) async {
		try {
			final lastPk = await Session.database.gondolaEstanteDao.insertObject(toDrift(gondolaEstanteModel));
			gondolaEstanteModel.id = lastPk;
			return gondolaEstanteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaEstanteModel?>? update(GondolaEstanteModel gondolaEstanteModel) async {
		try {
			await Session.database.gondolaEstanteDao.updateObject(toDrift(gondolaEstanteModel));
			return gondolaEstanteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.gondolaEstanteDao.deleteObject(toDrift(GondolaEstanteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<GondolaEstanteModel> toListModel(List<GondolaEstanteGrouped> gondolaEstanteDriftList) {
		List<GondolaEstanteModel> listModel = [];
		for (var gondolaEstanteDrift in gondolaEstanteDriftList) {
			listModel.add(toModel(gondolaEstanteDrift)!);
		}
		return listModel;
	}	

	GondolaEstanteModel? toModel(GondolaEstanteGrouped? gondolaEstanteDrift) {
		if (gondolaEstanteDrift != null) {
			return GondolaEstanteModel(
				id: gondolaEstanteDrift.gondolaEstante?.id,
				idGondolaRua: gondolaEstanteDrift.gondolaEstante?.idGondolaRua,
				codigo: gondolaEstanteDrift.gondolaEstante?.codigo,
				quantidadeCaixa: gondolaEstanteDrift.gondolaEstante?.quantidadeCaixa,
				gondolaRuaModel: GondolaRuaModel(
					id: gondolaEstanteDrift.gondolaRua?.id,
					codigo: gondolaEstanteDrift.gondolaRua?.codigo,
					quantidadeEstante: gondolaEstanteDrift.gondolaRua?.quantidadeEstante,
					nome: gondolaEstanteDrift.gondolaRua?.nome,
				),
			);
		} else {
			return null;
		}
	}


	GondolaEstanteGrouped toDrift(GondolaEstanteModel gondolaEstanteModel) {
		return GondolaEstanteGrouped(
			gondolaEstante: GondolaEstante(
				id: gondolaEstanteModel.id,
				idGondolaRua: gondolaEstanteModel.idGondolaRua,
				codigo: gondolaEstanteModel.codigo,
				quantidadeCaixa: gondolaEstanteModel.quantidadeCaixa,
			),
		);
	}

		
}
