import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoClassificacaoJornadaDriftProvider extends ProviderBase {

	Future<List<PontoClassificacaoJornadaModel>?> getList({Filter? filter}) async {
		List<PontoClassificacaoJornadaGrouped> pontoClassificacaoJornadaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoClassificacaoJornadaDriftList = await Session.database.pontoClassificacaoJornadaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoClassificacaoJornadaDriftList = await Session.database.pontoClassificacaoJornadaDao.getGroupedList(); 
			}
			if (pontoClassificacaoJornadaDriftList.isNotEmpty) {
				return toListModel(pontoClassificacaoJornadaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoClassificacaoJornadaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoClassificacaoJornadaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoClassificacaoJornadaModel?>? insert(PontoClassificacaoJornadaModel pontoClassificacaoJornadaModel) async {
		try {
			final lastPk = await Session.database.pontoClassificacaoJornadaDao.insertObject(toDrift(pontoClassificacaoJornadaModel));
			pontoClassificacaoJornadaModel.id = lastPk;
			return pontoClassificacaoJornadaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoClassificacaoJornadaModel?>? update(PontoClassificacaoJornadaModel pontoClassificacaoJornadaModel) async {
		try {
			await Session.database.pontoClassificacaoJornadaDao.updateObject(toDrift(pontoClassificacaoJornadaModel));
			return pontoClassificacaoJornadaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoClassificacaoJornadaDao.deleteObject(toDrift(PontoClassificacaoJornadaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoClassificacaoJornadaModel> toListModel(List<PontoClassificacaoJornadaGrouped> pontoClassificacaoJornadaDriftList) {
		List<PontoClassificacaoJornadaModel> listModel = [];
		for (var pontoClassificacaoJornadaDrift in pontoClassificacaoJornadaDriftList) {
			listModel.add(toModel(pontoClassificacaoJornadaDrift)!);
		}
		return listModel;
	}	

	PontoClassificacaoJornadaModel? toModel(PontoClassificacaoJornadaGrouped? pontoClassificacaoJornadaDrift) {
		if (pontoClassificacaoJornadaDrift != null) {
			return PontoClassificacaoJornadaModel(
				id: pontoClassificacaoJornadaDrift.pontoClassificacaoJornada?.id,
				codigo: pontoClassificacaoJornadaDrift.pontoClassificacaoJornada?.codigo,
				nome: pontoClassificacaoJornadaDrift.pontoClassificacaoJornada?.nome,
				descricao: pontoClassificacaoJornadaDrift.pontoClassificacaoJornada?.descricao,
				padrao: PontoClassificacaoJornadaDomain.getPadrao(pontoClassificacaoJornadaDrift.pontoClassificacaoJornada?.padrao),
				descontarHoras: PontoClassificacaoJornadaDomain.getDescontarHoras(pontoClassificacaoJornadaDrift.pontoClassificacaoJornada?.descontarHoras),
			);
		} else {
			return null;
		}
	}


	PontoClassificacaoJornadaGrouped toDrift(PontoClassificacaoJornadaModel pontoClassificacaoJornadaModel) {
		return PontoClassificacaoJornadaGrouped(
			pontoClassificacaoJornada: PontoClassificacaoJornada(
				id: pontoClassificacaoJornadaModel.id,
				codigo: pontoClassificacaoJornadaModel.codigo,
				nome: pontoClassificacaoJornadaModel.nome,
				descricao: pontoClassificacaoJornadaModel.descricao,
				padrao: PontoClassificacaoJornadaDomain.setPadrao(pontoClassificacaoJornadaModel.padrao),
				descontarHoras: PontoClassificacaoJornadaDomain.setDescontarHoras(pontoClassificacaoJornadaModel.descontarHoras),
			),
		);
	}

		
}
