import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/data/domain/domain_imports.dart';

class PatrimEstadoConservacaoDriftProvider extends ProviderBase {

	Future<List<PatrimEstadoConservacaoModel>?> getList({Filter? filter}) async {
		List<PatrimEstadoConservacaoGrouped> patrimEstadoConservacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimEstadoConservacaoDriftList = await Session.database.patrimEstadoConservacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimEstadoConservacaoDriftList = await Session.database.patrimEstadoConservacaoDao.getGroupedList(); 
			}
			if (patrimEstadoConservacaoDriftList.isNotEmpty) {
				return toListModel(patrimEstadoConservacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimEstadoConservacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimEstadoConservacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimEstadoConservacaoModel?>? insert(PatrimEstadoConservacaoModel patrimEstadoConservacaoModel) async {
		try {
			final lastPk = await Session.database.patrimEstadoConservacaoDao.insertObject(toDrift(patrimEstadoConservacaoModel));
			patrimEstadoConservacaoModel.id = lastPk;
			return patrimEstadoConservacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimEstadoConservacaoModel?>? update(PatrimEstadoConservacaoModel patrimEstadoConservacaoModel) async {
		try {
			await Session.database.patrimEstadoConservacaoDao.updateObject(toDrift(patrimEstadoConservacaoModel));
			return patrimEstadoConservacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimEstadoConservacaoDao.deleteObject(toDrift(PatrimEstadoConservacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimEstadoConservacaoModel> toListModel(List<PatrimEstadoConservacaoGrouped> patrimEstadoConservacaoDriftList) {
		List<PatrimEstadoConservacaoModel> listModel = [];
		for (var patrimEstadoConservacaoDrift in patrimEstadoConservacaoDriftList) {
			listModel.add(toModel(patrimEstadoConservacaoDrift)!);
		}
		return listModel;
	}	

	PatrimEstadoConservacaoModel? toModel(PatrimEstadoConservacaoGrouped? patrimEstadoConservacaoDrift) {
		if (patrimEstadoConservacaoDrift != null) {
			return PatrimEstadoConservacaoModel(
				id: patrimEstadoConservacaoDrift.patrimEstadoConservacao?.id,
				codigo: PatrimEstadoConservacaoDomain.getCodigo(patrimEstadoConservacaoDrift.patrimEstadoConservacao?.codigo),
				nome: patrimEstadoConservacaoDrift.patrimEstadoConservacao?.nome,
				descricao: patrimEstadoConservacaoDrift.patrimEstadoConservacao?.descricao,
			);
		} else {
			return null;
		}
	}


	PatrimEstadoConservacaoGrouped toDrift(PatrimEstadoConservacaoModel patrimEstadoConservacaoModel) {
		return PatrimEstadoConservacaoGrouped(
			patrimEstadoConservacao: PatrimEstadoConservacao(
				id: patrimEstadoConservacaoModel.id,
				codigo: PatrimEstadoConservacaoDomain.setCodigo(patrimEstadoConservacaoModel.codigo),
				nome: patrimEstadoConservacaoModel.nome,
				descricao: patrimEstadoConservacaoModel.descricao,
			),
		);
	}

		
}
