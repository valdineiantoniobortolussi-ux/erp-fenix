import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class GuiasAcumuladasDriftProvider extends ProviderBase {

	Future<List<GuiasAcumuladasModel>?> getList({Filter? filter}) async {
		List<GuiasAcumuladasGrouped> guiasAcumuladasDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				guiasAcumuladasDriftList = await Session.database.guiasAcumuladasDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				guiasAcumuladasDriftList = await Session.database.guiasAcumuladasDao.getGroupedList(); 
			}
			if (guiasAcumuladasDriftList.isNotEmpty) {
				return toListModel(guiasAcumuladasDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GuiasAcumuladasModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.guiasAcumuladasDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GuiasAcumuladasModel?>? insert(GuiasAcumuladasModel guiasAcumuladasModel) async {
		try {
			final lastPk = await Session.database.guiasAcumuladasDao.insertObject(toDrift(guiasAcumuladasModel));
			guiasAcumuladasModel.id = lastPk;
			return guiasAcumuladasModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GuiasAcumuladasModel?>? update(GuiasAcumuladasModel guiasAcumuladasModel) async {
		try {
			await Session.database.guiasAcumuladasDao.updateObject(toDrift(guiasAcumuladasModel));
			return guiasAcumuladasModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.guiasAcumuladasDao.deleteObject(toDrift(GuiasAcumuladasModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<GuiasAcumuladasModel> toListModel(List<GuiasAcumuladasGrouped> guiasAcumuladasDriftList) {
		List<GuiasAcumuladasModel> listModel = [];
		for (var guiasAcumuladasDrift in guiasAcumuladasDriftList) {
			listModel.add(toModel(guiasAcumuladasDrift)!);
		}
		return listModel;
	}	

	GuiasAcumuladasModel? toModel(GuiasAcumuladasGrouped? guiasAcumuladasDrift) {
		if (guiasAcumuladasDrift != null) {
			return GuiasAcumuladasModel(
				id: guiasAcumuladasDrift.guiasAcumuladas?.id,
				gpsTipo: GuiasAcumuladasDomain.getGpsTipo(guiasAcumuladasDrift.guiasAcumuladas?.gpsTipo),
				gpsCompetencia: guiasAcumuladasDrift.guiasAcumuladas?.gpsCompetencia,
				gpsValorInss: guiasAcumuladasDrift.guiasAcumuladas?.gpsValorInss,
				gpsValorOutrasEnt: guiasAcumuladasDrift.guiasAcumuladas?.gpsValorOutrasEnt,
				gpsDataPagamento: guiasAcumuladasDrift.guiasAcumuladas?.gpsDataPagamento,
				irrfCompetencia: guiasAcumuladasDrift.guiasAcumuladas?.irrfCompetencia,
				irrfCodigoRecolhimento: guiasAcumuladasDrift.guiasAcumuladas?.irrfCodigoRecolhimento,
				irrfValorAcumulado: guiasAcumuladasDrift.guiasAcumuladas?.irrfValorAcumulado,
				irrfDataPagamento: guiasAcumuladasDrift.guiasAcumuladas?.irrfDataPagamento,
				pisCompetencia: guiasAcumuladasDrift.guiasAcumuladas?.pisCompetencia,
				pisValorAcumulado: guiasAcumuladasDrift.guiasAcumuladas?.pisValorAcumulado,
				pisDataPagamento: guiasAcumuladasDrift.guiasAcumuladas?.pisDataPagamento,
			);
		} else {
			return null;
		}
	}


	GuiasAcumuladasGrouped toDrift(GuiasAcumuladasModel guiasAcumuladasModel) {
		return GuiasAcumuladasGrouped(
			guiasAcumuladas: GuiasAcumuladas(
				id: guiasAcumuladasModel.id,
				gpsTipo: GuiasAcumuladasDomain.setGpsTipo(guiasAcumuladasModel.gpsTipo),
				gpsCompetencia: Util.removeMask(guiasAcumuladasModel.gpsCompetencia),
				gpsValorInss: guiasAcumuladasModel.gpsValorInss,
				gpsValorOutrasEnt: guiasAcumuladasModel.gpsValorOutrasEnt,
				gpsDataPagamento: guiasAcumuladasModel.gpsDataPagamento,
				irrfCompetencia: Util.removeMask(guiasAcumuladasModel.irrfCompetencia),
				irrfCodigoRecolhimento: guiasAcumuladasModel.irrfCodigoRecolhimento,
				irrfValorAcumulado: guiasAcumuladasModel.irrfValorAcumulado,
				irrfDataPagamento: guiasAcumuladasModel.irrfDataPagamento,
				pisCompetencia: Util.removeMask(guiasAcumuladasModel.pisCompetencia),
				pisValorAcumulado: guiasAcumuladasModel.pisValorAcumulado,
				pisDataPagamento: guiasAcumuladasModel.pisDataPagamento,
			),
		);
	}

		
}
