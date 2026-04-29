import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class PaisDriftProvider extends ProviderBase {

	Future<List<PaisModel>?> getList({Filter? filter}) async {
		List<PaisGrouped> paisDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				paisDriftList = await Session.database.paisDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				paisDriftList = await Session.database.paisDao.getGroupedList(); 
			}
			if (paisDriftList.isNotEmpty) {
				return toListModel(paisDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PaisModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.paisDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PaisModel?>? insert(PaisModel paisModel) async {
		try {
			final lastPk = await Session.database.paisDao.insertObject(toDrift(paisModel));
			paisModel.id = lastPk;
			return paisModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PaisModel?>? update(PaisModel paisModel) async {
		try {
			await Session.database.paisDao.updateObject(toDrift(paisModel));
			return paisModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.paisDao.deleteObject(toDrift(PaisModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PaisModel> toListModel(List<PaisGrouped> paisDriftList) {
		List<PaisModel> listModel = [];
		for (var paisDrift in paisDriftList) {
			listModel.add(toModel(paisDrift)!);
		}
		return listModel;
	}	

	PaisModel? toModel(PaisGrouped? paisDrift) {
		if (paisDrift != null) {
			return PaisModel(
				id: paisDrift.pais?.id,
				nomePtbr: paisDrift.pais?.nomePtbr,
				nomeEn: paisDrift.pais?.nomeEn,
				codigo: paisDrift.pais?.codigo,
				sigla2: paisDrift.pais?.sigla2,
				sigla3: paisDrift.pais?.sigla3,
				codigoBacen: paisDrift.pais?.codigoBacen,
			);
		} else {
			return null;
		}
	}


	PaisGrouped toDrift(PaisModel paisModel) {
		return PaisGrouped(
			pais: Pais(
				id: paisModel.id,
				nomePtbr: paisModel.nomePtbr,
				nomeEn: paisModel.nomeEn,
				codigo: paisModel.codigo,
				sigla2: paisModel.sigla2,
				sigla3: paisModel.sigla3,
				codigoBacen: paisModel.codigoBacen,
			),
		);
	}

		
}
