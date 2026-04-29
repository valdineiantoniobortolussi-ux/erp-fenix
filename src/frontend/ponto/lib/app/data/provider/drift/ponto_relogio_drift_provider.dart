import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoRelogioDriftProvider extends ProviderBase {

	Future<List<PontoRelogioModel>?> getList({Filter? filter}) async {
		List<PontoRelogioGrouped> pontoRelogioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoRelogioDriftList = await Session.database.pontoRelogioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoRelogioDriftList = await Session.database.pontoRelogioDao.getGroupedList(); 
			}
			if (pontoRelogioDriftList.isNotEmpty) {
				return toListModel(pontoRelogioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoRelogioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoRelogioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoRelogioModel?>? insert(PontoRelogioModel pontoRelogioModel) async {
		try {
			final lastPk = await Session.database.pontoRelogioDao.insertObject(toDrift(pontoRelogioModel));
			pontoRelogioModel.id = lastPk;
			return pontoRelogioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoRelogioModel?>? update(PontoRelogioModel pontoRelogioModel) async {
		try {
			await Session.database.pontoRelogioDao.updateObject(toDrift(pontoRelogioModel));
			return pontoRelogioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoRelogioDao.deleteObject(toDrift(PontoRelogioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoRelogioModel> toListModel(List<PontoRelogioGrouped> pontoRelogioDriftList) {
		List<PontoRelogioModel> listModel = [];
		for (var pontoRelogioDrift in pontoRelogioDriftList) {
			listModel.add(toModel(pontoRelogioDrift)!);
		}
		return listModel;
	}	

	PontoRelogioModel? toModel(PontoRelogioGrouped? pontoRelogioDrift) {
		if (pontoRelogioDrift != null) {
			return PontoRelogioModel(
				id: pontoRelogioDrift.pontoRelogio?.id,
				localizacao: pontoRelogioDrift.pontoRelogio?.localizacao,
				marca: pontoRelogioDrift.pontoRelogio?.marca,
				fabricante: pontoRelogioDrift.pontoRelogio?.fabricante,
				numeroSerie: pontoRelogioDrift.pontoRelogio?.numeroSerie,
				utilizacao: PontoRelogioDomain.getUtilizacao(pontoRelogioDrift.pontoRelogio?.utilizacao),
			);
		} else {
			return null;
		}
	}


	PontoRelogioGrouped toDrift(PontoRelogioModel pontoRelogioModel) {
		return PontoRelogioGrouped(
			pontoRelogio: PontoRelogio(
				id: pontoRelogioModel.id,
				localizacao: pontoRelogioModel.localizacao,
				marca: pontoRelogioModel.marca,
				fabricante: pontoRelogioModel.fabricante,
				numeroSerie: pontoRelogioModel.numeroSerie,
				utilizacao: PontoRelogioDomain.setUtilizacao(pontoRelogioModel.utilizacao),
			),
		);
	}

		
}
