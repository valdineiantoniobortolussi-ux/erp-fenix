import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/data/domain/domain_imports.dart';

class PatrimTipoAquisicaoBemDriftProvider extends ProviderBase {

	Future<List<PatrimTipoAquisicaoBemModel>?> getList({Filter? filter}) async {
		List<PatrimTipoAquisicaoBemGrouped> patrimTipoAquisicaoBemDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimTipoAquisicaoBemDriftList = await Session.database.patrimTipoAquisicaoBemDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimTipoAquisicaoBemDriftList = await Session.database.patrimTipoAquisicaoBemDao.getGroupedList(); 
			}
			if (patrimTipoAquisicaoBemDriftList.isNotEmpty) {
				return toListModel(patrimTipoAquisicaoBemDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimTipoAquisicaoBemModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimTipoAquisicaoBemDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimTipoAquisicaoBemModel?>? insert(PatrimTipoAquisicaoBemModel patrimTipoAquisicaoBemModel) async {
		try {
			final lastPk = await Session.database.patrimTipoAquisicaoBemDao.insertObject(toDrift(patrimTipoAquisicaoBemModel));
			patrimTipoAquisicaoBemModel.id = lastPk;
			return patrimTipoAquisicaoBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimTipoAquisicaoBemModel?>? update(PatrimTipoAquisicaoBemModel patrimTipoAquisicaoBemModel) async {
		try {
			await Session.database.patrimTipoAquisicaoBemDao.updateObject(toDrift(patrimTipoAquisicaoBemModel));
			return patrimTipoAquisicaoBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimTipoAquisicaoBemDao.deleteObject(toDrift(PatrimTipoAquisicaoBemModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimTipoAquisicaoBemModel> toListModel(List<PatrimTipoAquisicaoBemGrouped> patrimTipoAquisicaoBemDriftList) {
		List<PatrimTipoAquisicaoBemModel> listModel = [];
		for (var patrimTipoAquisicaoBemDrift in patrimTipoAquisicaoBemDriftList) {
			listModel.add(toModel(patrimTipoAquisicaoBemDrift)!);
		}
		return listModel;
	}	

	PatrimTipoAquisicaoBemModel? toModel(PatrimTipoAquisicaoBemGrouped? patrimTipoAquisicaoBemDrift) {
		if (patrimTipoAquisicaoBemDrift != null) {
			return PatrimTipoAquisicaoBemModel(
				id: patrimTipoAquisicaoBemDrift.patrimTipoAquisicaoBem?.id,
				tipo: PatrimTipoAquisicaoBemDomain.getTipo(patrimTipoAquisicaoBemDrift.patrimTipoAquisicaoBem?.tipo),
				nome: patrimTipoAquisicaoBemDrift.patrimTipoAquisicaoBem?.nome,
				descricao: patrimTipoAquisicaoBemDrift.patrimTipoAquisicaoBem?.descricao,
			);
		} else {
			return null;
		}
	}


	PatrimTipoAquisicaoBemGrouped toDrift(PatrimTipoAquisicaoBemModel patrimTipoAquisicaoBemModel) {
		return PatrimTipoAquisicaoBemGrouped(
			patrimTipoAquisicaoBem: PatrimTipoAquisicaoBem(
				id: patrimTipoAquisicaoBemModel.id,
				tipo: PatrimTipoAquisicaoBemDomain.setTipo(patrimTipoAquisicaoBemModel.tipo),
				nome: patrimTipoAquisicaoBemModel.nome,
				descricao: patrimTipoAquisicaoBemModel.descricao,
			),
		);
	}

		
}
