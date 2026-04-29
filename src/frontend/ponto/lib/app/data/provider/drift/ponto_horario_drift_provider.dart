import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoHorarioDriftProvider extends ProviderBase {

	Future<List<PontoHorarioModel>?> getList({Filter? filter}) async {
		List<PontoHorarioGrouped> pontoHorarioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoHorarioDriftList = await Session.database.pontoHorarioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoHorarioDriftList = await Session.database.pontoHorarioDao.getGroupedList(); 
			}
			if (pontoHorarioDriftList.isNotEmpty) {
				return toListModel(pontoHorarioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoHorarioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoHorarioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoHorarioModel?>? insert(PontoHorarioModel pontoHorarioModel) async {
		try {
			final lastPk = await Session.database.pontoHorarioDao.insertObject(toDrift(pontoHorarioModel));
			pontoHorarioModel.id = lastPk;
			return pontoHorarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoHorarioModel?>? update(PontoHorarioModel pontoHorarioModel) async {
		try {
			await Session.database.pontoHorarioDao.updateObject(toDrift(pontoHorarioModel));
			return pontoHorarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoHorarioDao.deleteObject(toDrift(PontoHorarioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoHorarioModel> toListModel(List<PontoHorarioGrouped> pontoHorarioDriftList) {
		List<PontoHorarioModel> listModel = [];
		for (var pontoHorarioDrift in pontoHorarioDriftList) {
			listModel.add(toModel(pontoHorarioDrift)!);
		}
		return listModel;
	}	

	PontoHorarioModel? toModel(PontoHorarioGrouped? pontoHorarioDrift) {
		if (pontoHorarioDrift != null) {
			return PontoHorarioModel(
				id: pontoHorarioDrift.pontoHorario?.id,
				tipo: PontoHorarioDomain.getTipo(pontoHorarioDrift.pontoHorario?.tipo),
				codigo: pontoHorarioDrift.pontoHorario?.codigo,
				nome: pontoHorarioDrift.pontoHorario?.nome,
				tipoTrabalho: PontoHorarioDomain.getTipoTrabalho(pontoHorarioDrift.pontoHorario?.tipoTrabalho),
				cargaHoraria: pontoHorarioDrift.pontoHorario?.cargaHoraria,
				entrada01: pontoHorarioDrift.pontoHorario?.entrada01,
				saida01: pontoHorarioDrift.pontoHorario?.saida01,
				entrada02: pontoHorarioDrift.pontoHorario?.entrada02,
				saida02: pontoHorarioDrift.pontoHorario?.saida02,
				entrada03: pontoHorarioDrift.pontoHorario?.entrada03,
				saida03: pontoHorarioDrift.pontoHorario?.saida03,
				entrada04: pontoHorarioDrift.pontoHorario?.entrada04,
				saida04: pontoHorarioDrift.pontoHorario?.saida04,
				entrada05: pontoHorarioDrift.pontoHorario?.entrada05,
				saida05: pontoHorarioDrift.pontoHorario?.saida05,
				horaInicioJornada: pontoHorarioDrift.pontoHorario?.horaInicioJornada,
				horaFimJornada: pontoHorarioDrift.pontoHorario?.horaFimJornada,
			);
		} else {
			return null;
		}
	}


	PontoHorarioGrouped toDrift(PontoHorarioModel pontoHorarioModel) {
		return PontoHorarioGrouped(
			pontoHorario: PontoHorario(
				id: pontoHorarioModel.id,
				tipo: PontoHorarioDomain.setTipo(pontoHorarioModel.tipo),
				codigo: pontoHorarioModel.codigo,
				nome: pontoHorarioModel.nome,
				tipoTrabalho: PontoHorarioDomain.setTipoTrabalho(pontoHorarioModel.tipoTrabalho),
				cargaHoraria: Util.removeMask(pontoHorarioModel.cargaHoraria),
				entrada01: Util.removeMask(pontoHorarioModel.entrada01),
				saida01: Util.removeMask(pontoHorarioModel.saida01),
				entrada02: Util.removeMask(pontoHorarioModel.entrada02),
				saida02: Util.removeMask(pontoHorarioModel.saida02),
				entrada03: Util.removeMask(pontoHorarioModel.entrada03),
				saida03: Util.removeMask(pontoHorarioModel.saida03),
				entrada04: Util.removeMask(pontoHorarioModel.entrada04),
				saida04: Util.removeMask(pontoHorarioModel.saida04),
				entrada05: Util.removeMask(pontoHorarioModel.entrada05),
				saida05: Util.removeMask(pontoHorarioModel.saida05),
				horaInicioJornada: Util.removeMask(pontoHorarioModel.horaInicioJornada),
				horaFimJornada: Util.removeMask(pontoHorarioModel.horaFimJornada),
			),
		);
	}

		
}
