import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoParametroDriftProvider extends ProviderBase {

	Future<List<PontoParametroModel>?> getList({Filter? filter}) async {
		List<PontoParametroGrouped> pontoParametroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoParametroDriftList = await Session.database.pontoParametroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoParametroDriftList = await Session.database.pontoParametroDao.getGroupedList(); 
			}
			if (pontoParametroDriftList.isNotEmpty) {
				return toListModel(pontoParametroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoParametroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoParametroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoParametroModel?>? insert(PontoParametroModel pontoParametroModel) async {
		try {
			final lastPk = await Session.database.pontoParametroDao.insertObject(toDrift(pontoParametroModel));
			pontoParametroModel.id = lastPk;
			return pontoParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoParametroModel?>? update(PontoParametroModel pontoParametroModel) async {
		try {
			await Session.database.pontoParametroDao.updateObject(toDrift(pontoParametroModel));
			return pontoParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoParametroDao.deleteObject(toDrift(PontoParametroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoParametroModel> toListModel(List<PontoParametroGrouped> pontoParametroDriftList) {
		List<PontoParametroModel> listModel = [];
		for (var pontoParametroDrift in pontoParametroDriftList) {
			listModel.add(toModel(pontoParametroDrift)!);
		}
		return listModel;
	}	

	PontoParametroModel? toModel(PontoParametroGrouped? pontoParametroDrift) {
		if (pontoParametroDrift != null) {
			return PontoParametroModel(
				id: pontoParametroDrift.pontoParametro?.id,
				mesAno: pontoParametroDrift.pontoParametro?.mesAno,
				diaInicialApuracao: pontoParametroDrift.pontoParametro?.diaInicialApuracao,
				horaNoturnaInicio: pontoParametroDrift.pontoParametro?.horaNoturnaInicio,
				horaNoturnaFim: pontoParametroDrift.pontoParametro?.horaNoturnaFim,
				periodoMinimoInterjornada: pontoParametroDrift.pontoParametro?.periodoMinimoInterjornada,
				percentualHeDiurna: pontoParametroDrift.pontoParametro?.percentualHeDiurna,
				percentualHeNoturna: pontoParametroDrift.pontoParametro?.percentualHeNoturna,
				duracaoHoraNoturna: pontoParametroDrift.pontoParametro?.duracaoHoraNoturna,
				tratamentoHoraMais: PontoParametroDomain.getTratamentoHoraMais(pontoParametroDrift.pontoParametro?.tratamentoHoraMais),
				tratamentoHoraMenos: PontoParametroDomain.getTratamentoHoraMenos(pontoParametroDrift.pontoParametro?.tratamentoHoraMenos),
			);
		} else {
			return null;
		}
	}


	PontoParametroGrouped toDrift(PontoParametroModel pontoParametroModel) {
		return PontoParametroGrouped(
			pontoParametro: PontoParametro(
				id: pontoParametroModel.id,
				mesAno: Util.removeMask(pontoParametroModel.mesAno),
				diaInicialApuracao: pontoParametroModel.diaInicialApuracao,
				horaNoturnaInicio: Util.removeMask(pontoParametroModel.horaNoturnaInicio),
				horaNoturnaFim: Util.removeMask(pontoParametroModel.horaNoturnaFim),
				periodoMinimoInterjornada: Util.removeMask(pontoParametroModel.periodoMinimoInterjornada),
				percentualHeDiurna: pontoParametroModel.percentualHeDiurna,
				percentualHeNoturna: pontoParametroModel.percentualHeNoturna,
				duracaoHoraNoturna: Util.removeMask(pontoParametroModel.duracaoHoraNoturna),
				tratamentoHoraMais: PontoParametroDomain.setTratamentoHoraMais(pontoParametroModel.tratamentoHoraMais),
				tratamentoHoraMenos: PontoParametroDomain.setTratamentoHoraMenos(pontoParametroModel.tratamentoHoraMenos),
			),
		);
	}

		
}
