import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/data/domain/domain_imports.dart';

class CentroResultadoDriftProvider extends ProviderBase {

	Future<List<CentroResultadoModel>?> getList({Filter? filter}) async {
		List<CentroResultadoGrouped> centroResultadoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				centroResultadoDriftList = await Session.database.centroResultadoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				centroResultadoDriftList = await Session.database.centroResultadoDao.getGroupedList(); 
			}
			if (centroResultadoDriftList.isNotEmpty) {
				return toListModel(centroResultadoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.centroResultadoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CentroResultadoModel?>? insert(CentroResultadoModel centroResultadoModel) async {
		try {
			final lastPk = await Session.database.centroResultadoDao.insertObject(toDrift(centroResultadoModel));
			centroResultadoModel.id = lastPk;
			return centroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CentroResultadoModel?>? update(CentroResultadoModel centroResultadoModel) async {
		try {
			await Session.database.centroResultadoDao.updateObject(toDrift(centroResultadoModel));
			return centroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.centroResultadoDao.deleteObject(toDrift(CentroResultadoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CentroResultadoModel> toListModel(List<CentroResultadoGrouped> centroResultadoDriftList) {
		List<CentroResultadoModel> listModel = [];
		for (var centroResultadoDrift in centroResultadoDriftList) {
			listModel.add(toModel(centroResultadoDrift)!);
		}
		return listModel;
	}	

	CentroResultadoModel? toModel(CentroResultadoGrouped? centroResultadoDrift) {
		if (centroResultadoDrift != null) {
			return CentroResultadoModel(
				id: centroResultadoDrift.centroResultado?.id,
				idPlanoCentroResultado: centroResultadoDrift.centroResultado?.idPlanoCentroResultado,
				classificacao: centroResultadoDrift.centroResultado?.classificacao,
				descricao: centroResultadoDrift.centroResultado?.descricao,
				sofreRateiro: CentroResultadoDomain.getSofreRateiro(centroResultadoDrift.centroResultado?.sofreRateiro),
			);
		} else {
			return null;
		}
	}


	CentroResultadoGrouped toDrift(CentroResultadoModel centroResultadoModel) {
		return CentroResultadoGrouped(
			centroResultado: CentroResultado(
				id: centroResultadoModel.id,
				idPlanoCentroResultado: centroResultadoModel.idPlanoCentroResultado,
				classificacao: centroResultadoModel.classificacao,
				descricao: centroResultadoModel.descricao,
				sofreRateiro: CentroResultadoDomain.setSofreRateiro(centroResultadoModel.sofreRateiro),
			),
		);
	}

		
}
