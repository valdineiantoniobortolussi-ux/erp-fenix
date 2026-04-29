import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class RateioCentroResultadoCabDriftProvider extends ProviderBase {

	Future<List<RateioCentroResultadoCabModel>?> getList({Filter? filter}) async {
		List<RateioCentroResultadoCabGrouped> rateioCentroResultadoCabDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				rateioCentroResultadoCabDriftList = await Session.database.rateioCentroResultadoCabDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				rateioCentroResultadoCabDriftList = await Session.database.rateioCentroResultadoCabDao.getGroupedList(); 
			}
			if (rateioCentroResultadoCabDriftList.isNotEmpty) {
				return toListModel(rateioCentroResultadoCabDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<RateioCentroResultadoCabModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.rateioCentroResultadoCabDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RateioCentroResultadoCabModel?>? insert(RateioCentroResultadoCabModel rateioCentroResultadoCabModel) async {
		try {
			final lastPk = await Session.database.rateioCentroResultadoCabDao.insertObject(toDrift(rateioCentroResultadoCabModel));
			rateioCentroResultadoCabModel.id = lastPk;
			return rateioCentroResultadoCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RateioCentroResultadoCabModel?>? update(RateioCentroResultadoCabModel rateioCentroResultadoCabModel) async {
		try {
			await Session.database.rateioCentroResultadoCabDao.updateObject(toDrift(rateioCentroResultadoCabModel));
			return rateioCentroResultadoCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.rateioCentroResultadoCabDao.deleteObject(toDrift(RateioCentroResultadoCabModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<RateioCentroResultadoCabModel> toListModel(List<RateioCentroResultadoCabGrouped> rateioCentroResultadoCabDriftList) {
		List<RateioCentroResultadoCabModel> listModel = [];
		for (var rateioCentroResultadoCabDrift in rateioCentroResultadoCabDriftList) {
			listModel.add(toModel(rateioCentroResultadoCabDrift)!);
		}
		return listModel;
	}	

	RateioCentroResultadoCabModel? toModel(RateioCentroResultadoCabGrouped? rateioCentroResultadoCabDrift) {
		if (rateioCentroResultadoCabDrift != null) {
			return RateioCentroResultadoCabModel(
				id: rateioCentroResultadoCabDrift.rateioCentroResultadoCab?.id,
				idCentroResultado: rateioCentroResultadoCabDrift.rateioCentroResultadoCab?.idCentroResultado,
				descricao: rateioCentroResultadoCabDrift.rateioCentroResultadoCab?.descricao,
				rateioCentroResultadoDetModelList: rateioCentroResultadoDetDriftToModel(rateioCentroResultadoCabDrift.rateioCentroResultadoDetGroupedList),
				centroResultadoModel: CentroResultadoModel(
					id: rateioCentroResultadoCabDrift.centroResultado?.id,
					idPlanoCentroResultado: rateioCentroResultadoCabDrift.centroResultado?.idPlanoCentroResultado,
					descricao: rateioCentroResultadoCabDrift.centroResultado?.descricao,
					classificacao: rateioCentroResultadoCabDrift.centroResultado?.classificacao,
					sofreRateiro: rateioCentroResultadoCabDrift.centroResultado?.sofreRateiro,
				),
			);
		} else {
			return null;
		}
	}

	List<RateioCentroResultadoDetModel> rateioCentroResultadoDetDriftToModel(List<RateioCentroResultadoDetGrouped>? rateioCentroResultadoDetDriftList) { 
		List<RateioCentroResultadoDetModel> rateioCentroResultadoDetModelList = [];
		if (rateioCentroResultadoDetDriftList != null) {
			for (var rateioCentroResultadoDetGrouped in rateioCentroResultadoDetDriftList) {
				rateioCentroResultadoDetModelList.add(
					RateioCentroResultadoDetModel(
						id: rateioCentroResultadoDetGrouped.rateioCentroResultadoDet?.id,
						idCentroResultadoDestino: rateioCentroResultadoDetGrouped.rateioCentroResultadoDet?.idCentroResultadoDestino,
						centroResultadoModel: CentroResultadoModel(
							id: rateioCentroResultadoDetGrouped.centroResultado?.id,
							idPlanoCentroResultado: rateioCentroResultadoDetGrouped.centroResultado?.idPlanoCentroResultado,
							descricao: rateioCentroResultadoDetGrouped.centroResultado?.descricao,
							classificacao: rateioCentroResultadoDetGrouped.centroResultado?.classificacao,
							sofreRateiro: rateioCentroResultadoDetGrouped.centroResultado?.sofreRateiro,
						),
						idRateioCentroResulCab: rateioCentroResultadoDetGrouped.rateioCentroResultadoDet?.idRateioCentroResulCab,
						porcentoRateio: rateioCentroResultadoDetGrouped.rateioCentroResultadoDet?.porcentoRateio,
					)
				);
			}
			return rateioCentroResultadoDetModelList;
		}
		return [];
	}


	RateioCentroResultadoCabGrouped toDrift(RateioCentroResultadoCabModel rateioCentroResultadoCabModel) {
		return RateioCentroResultadoCabGrouped(
			rateioCentroResultadoCab: RateioCentroResultadoCab(
				id: rateioCentroResultadoCabModel.id,
				idCentroResultado: rateioCentroResultadoCabModel.idCentroResultado,
				descricao: rateioCentroResultadoCabModel.descricao,
			),
			rateioCentroResultadoDetGroupedList: rateioCentroResultadoDetModelToDrift(rateioCentroResultadoCabModel.rateioCentroResultadoDetModelList),
		);
	}

	List<RateioCentroResultadoDetGrouped> rateioCentroResultadoDetModelToDrift(List<RateioCentroResultadoDetModel>? rateioCentroResultadoDetModelList) { 
		List<RateioCentroResultadoDetGrouped> rateioCentroResultadoDetGroupedList = [];
		if (rateioCentroResultadoDetModelList != null) {
			for (var rateioCentroResultadoDetModel in rateioCentroResultadoDetModelList) {
				rateioCentroResultadoDetGroupedList.add(
					RateioCentroResultadoDetGrouped(
						rateioCentroResultadoDet: RateioCentroResultadoDet(
							id: rateioCentroResultadoDetModel.id,
							idCentroResultadoDestino: rateioCentroResultadoDetModel.idCentroResultadoDestino,
							idRateioCentroResulCab: rateioCentroResultadoDetModel.idRateioCentroResulCab,
							porcentoRateio: rateioCentroResultadoDetModel.porcentoRateio,
						),
					),
				);
			}
			return rateioCentroResultadoDetGroupedList;
		}
		return [];
	}

		
}
