import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoEscalaDriftProvider extends ProviderBase {

	Future<List<PontoEscalaModel>?> getList({Filter? filter}) async {
		List<PontoEscalaGrouped> pontoEscalaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoEscalaDriftList = await Session.database.pontoEscalaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoEscalaDriftList = await Session.database.pontoEscalaDao.getGroupedList(); 
			}
			if (pontoEscalaDriftList.isNotEmpty) {
				return toListModel(pontoEscalaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoEscalaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoEscalaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoEscalaModel?>? insert(PontoEscalaModel pontoEscalaModel) async {
		try {
			final lastPk = await Session.database.pontoEscalaDao.insertObject(toDrift(pontoEscalaModel));
			pontoEscalaModel.id = lastPk;
			return pontoEscalaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoEscalaModel?>? update(PontoEscalaModel pontoEscalaModel) async {
		try {
			await Session.database.pontoEscalaDao.updateObject(toDrift(pontoEscalaModel));
			return pontoEscalaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoEscalaDao.deleteObject(toDrift(PontoEscalaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoEscalaModel> toListModel(List<PontoEscalaGrouped> pontoEscalaDriftList) {
		List<PontoEscalaModel> listModel = [];
		for (var pontoEscalaDrift in pontoEscalaDriftList) {
			listModel.add(toModel(pontoEscalaDrift)!);
		}
		return listModel;
	}	

	PontoEscalaModel? toModel(PontoEscalaGrouped? pontoEscalaDrift) {
		if (pontoEscalaDrift != null) {
			return PontoEscalaModel(
				id: pontoEscalaDrift.pontoEscala?.id,
				nome: pontoEscalaDrift.pontoEscala?.nome,
				descontoHoraDia: pontoEscalaDrift.pontoEscala?.descontoHoraDia,
				descontoDsr: pontoEscalaDrift.pontoEscala?.descontoDsr,
				codigoHorarioDomingo: pontoEscalaDrift.pontoEscala?.codigoHorarioDomingo,
				codigoHorarioSegunda: pontoEscalaDrift.pontoEscala?.codigoHorarioSegunda,
				codigoHorarioTerca: pontoEscalaDrift.pontoEscala?.codigoHorarioTerca,
				codigoHorarioQuarta: pontoEscalaDrift.pontoEscala?.codigoHorarioQuarta,
				codigoHorarioQuinta: pontoEscalaDrift.pontoEscala?.codigoHorarioQuinta,
				codigoHorarioSexta: pontoEscalaDrift.pontoEscala?.codigoHorarioSexta,
				codigoHorarioSabado: pontoEscalaDrift.pontoEscala?.codigoHorarioSabado,
				pontoTurmaModelList: pontoTurmaDriftToModel(pontoEscalaDrift.pontoTurmaGroupedList),
			);
		} else {
			return null;
		}
	}

	List<PontoTurmaModel> pontoTurmaDriftToModel(List<PontoTurmaGrouped>? pontoTurmaDriftList) { 
		List<PontoTurmaModel> pontoTurmaModelList = [];
		if (pontoTurmaDriftList != null) {
			for (var pontoTurmaGrouped in pontoTurmaDriftList) {
				pontoTurmaModelList.add(
					PontoTurmaModel(
						id: pontoTurmaGrouped.pontoTurma?.id,
						idPontoEscala: pontoTurmaGrouped.pontoTurma?.idPontoEscala,
						codigo: pontoTurmaGrouped.pontoTurma?.codigo,
						nome: pontoTurmaGrouped.pontoTurma?.nome,
					)
				);
			}
			return pontoTurmaModelList;
		}
		return [];
	}


	PontoEscalaGrouped toDrift(PontoEscalaModel pontoEscalaModel) {
		return PontoEscalaGrouped(
			pontoEscala: PontoEscala(
				id: pontoEscalaModel.id,
				nome: pontoEscalaModel.nome,
				descontoHoraDia: Util.removeMask(pontoEscalaModel.descontoHoraDia),
				descontoDsr: Util.removeMask(pontoEscalaModel.descontoDsr),
				codigoHorarioDomingo: pontoEscalaModel.codigoHorarioDomingo,
				codigoHorarioSegunda: pontoEscalaModel.codigoHorarioSegunda,
				codigoHorarioTerca: pontoEscalaModel.codigoHorarioTerca,
				codigoHorarioQuarta: pontoEscalaModel.codigoHorarioQuarta,
				codigoHorarioQuinta: pontoEscalaModel.codigoHorarioQuinta,
				codigoHorarioSexta: pontoEscalaModel.codigoHorarioSexta,
				codigoHorarioSabado: pontoEscalaModel.codigoHorarioSabado,
			),
			pontoTurmaGroupedList: pontoTurmaModelToDrift(pontoEscalaModel.pontoTurmaModelList),
		);
	}

	List<PontoTurmaGrouped> pontoTurmaModelToDrift(List<PontoTurmaModel>? pontoTurmaModelList) { 
		List<PontoTurmaGrouped> pontoTurmaGroupedList = [];
		if (pontoTurmaModelList != null) {
			for (var pontoTurmaModel in pontoTurmaModelList) {
				pontoTurmaGroupedList.add(
					PontoTurmaGrouped(
						pontoTurma: PontoTurma(
							id: pontoTurmaModel.id,
							idPontoEscala: pontoTurmaModel.idPontoEscala,
							codigo: pontoTurmaModel.codigo,
							nome: pontoTurmaModel.nome,
						),
					),
				);
			}
			return pontoTurmaGroupedList;
		}
		return [];
	}

		
}
