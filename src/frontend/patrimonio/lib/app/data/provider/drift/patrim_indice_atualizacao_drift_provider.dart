import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimIndiceAtualizacaoDriftProvider extends ProviderBase {

	Future<List<PatrimIndiceAtualizacaoModel>?> getList({Filter? filter}) async {
		List<PatrimIndiceAtualizacaoGrouped> patrimIndiceAtualizacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimIndiceAtualizacaoDriftList = await Session.database.patrimIndiceAtualizacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimIndiceAtualizacaoDriftList = await Session.database.patrimIndiceAtualizacaoDao.getGroupedList(); 
			}
			if (patrimIndiceAtualizacaoDriftList.isNotEmpty) {
				return toListModel(patrimIndiceAtualizacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimIndiceAtualizacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimIndiceAtualizacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimIndiceAtualizacaoModel?>? insert(PatrimIndiceAtualizacaoModel patrimIndiceAtualizacaoModel) async {
		try {
			final lastPk = await Session.database.patrimIndiceAtualizacaoDao.insertObject(toDrift(patrimIndiceAtualizacaoModel));
			patrimIndiceAtualizacaoModel.id = lastPk;
			return patrimIndiceAtualizacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimIndiceAtualizacaoModel?>? update(PatrimIndiceAtualizacaoModel patrimIndiceAtualizacaoModel) async {
		try {
			await Session.database.patrimIndiceAtualizacaoDao.updateObject(toDrift(patrimIndiceAtualizacaoModel));
			return patrimIndiceAtualizacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimIndiceAtualizacaoDao.deleteObject(toDrift(PatrimIndiceAtualizacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimIndiceAtualizacaoModel> toListModel(List<PatrimIndiceAtualizacaoGrouped> patrimIndiceAtualizacaoDriftList) {
		List<PatrimIndiceAtualizacaoModel> listModel = [];
		for (var patrimIndiceAtualizacaoDrift in patrimIndiceAtualizacaoDriftList) {
			listModel.add(toModel(patrimIndiceAtualizacaoDrift)!);
		}
		return listModel;
	}	

	PatrimIndiceAtualizacaoModel? toModel(PatrimIndiceAtualizacaoGrouped? patrimIndiceAtualizacaoDrift) {
		if (patrimIndiceAtualizacaoDrift != null) {
			return PatrimIndiceAtualizacaoModel(
				id: patrimIndiceAtualizacaoDrift.patrimIndiceAtualizacao?.id,
				dataIndice: patrimIndiceAtualizacaoDrift.patrimIndiceAtualizacao?.dataIndice,
				nome: patrimIndiceAtualizacaoDrift.patrimIndiceAtualizacao?.nome,
				valor: patrimIndiceAtualizacaoDrift.patrimIndiceAtualizacao?.valor,
				valorAlternativo: patrimIndiceAtualizacaoDrift.patrimIndiceAtualizacao?.valorAlternativo,
			);
		} else {
			return null;
		}
	}


	PatrimIndiceAtualizacaoGrouped toDrift(PatrimIndiceAtualizacaoModel patrimIndiceAtualizacaoModel) {
		return PatrimIndiceAtualizacaoGrouped(
			patrimIndiceAtualizacao: PatrimIndiceAtualizacao(
				id: patrimIndiceAtualizacaoModel.id,
				dataIndice: patrimIndiceAtualizacaoModel.dataIndice,
				nome: patrimIndiceAtualizacaoModel.nome,
				valor: patrimIndiceAtualizacaoModel.valor,
				valorAlternativo: patrimIndiceAtualizacaoModel.valorAlternativo,
			),
		);
	}

		
}
