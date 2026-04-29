import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class EncerraCentroResultadoDriftProvider extends ProviderBase {

	Future<List<EncerraCentroResultadoModel>?> getList({Filter? filter}) async {
		List<EncerraCentroResultadoGrouped> encerraCentroResultadoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				encerraCentroResultadoDriftList = await Session.database.encerraCentroResultadoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				encerraCentroResultadoDriftList = await Session.database.encerraCentroResultadoDao.getGroupedList(); 
			}
			if (encerraCentroResultadoDriftList.isNotEmpty) {
				return toListModel(encerraCentroResultadoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EncerraCentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.encerraCentroResultadoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EncerraCentroResultadoModel?>? insert(EncerraCentroResultadoModel encerraCentroResultadoModel) async {
		try {
			final lastPk = await Session.database.encerraCentroResultadoDao.insertObject(toDrift(encerraCentroResultadoModel));
			encerraCentroResultadoModel.id = lastPk;
			return encerraCentroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EncerraCentroResultadoModel?>? update(EncerraCentroResultadoModel encerraCentroResultadoModel) async {
		try {
			await Session.database.encerraCentroResultadoDao.updateObject(toDrift(encerraCentroResultadoModel));
			return encerraCentroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.encerraCentroResultadoDao.deleteObject(toDrift(EncerraCentroResultadoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EncerraCentroResultadoModel> toListModel(List<EncerraCentroResultadoGrouped> encerraCentroResultadoDriftList) {
		List<EncerraCentroResultadoModel> listModel = [];
		for (var encerraCentroResultadoDrift in encerraCentroResultadoDriftList) {
			listModel.add(toModel(encerraCentroResultadoDrift)!);
		}
		return listModel;
	}	

	EncerraCentroResultadoModel? toModel(EncerraCentroResultadoGrouped? encerraCentroResultadoDrift) {
		if (encerraCentroResultadoDrift != null) {
			return EncerraCentroResultadoModel(
				id: encerraCentroResultadoDrift.encerraCentroResultado?.id,
				idCentroResultado: encerraCentroResultadoDrift.encerraCentroResultado?.idCentroResultado,
				competencia: encerraCentroResultadoDrift.encerraCentroResultado?.competencia,
				valorTotal: encerraCentroResultadoDrift.encerraCentroResultado?.valorTotal,
				valorSubRateio: encerraCentroResultadoDrift.encerraCentroResultado?.valorSubRateio,
				centroResultadoModel: CentroResultadoModel(
					id: encerraCentroResultadoDrift.centroResultado?.id,
					idPlanoCentroResultado: encerraCentroResultadoDrift.centroResultado?.idPlanoCentroResultado,
					descricao: encerraCentroResultadoDrift.centroResultado?.descricao,
					classificacao: encerraCentroResultadoDrift.centroResultado?.classificacao,
					sofreRateiro: encerraCentroResultadoDrift.centroResultado?.sofreRateiro,
				),
			);
		} else {
			return null;
		}
	}


	EncerraCentroResultadoGrouped toDrift(EncerraCentroResultadoModel encerraCentroResultadoModel) {
		return EncerraCentroResultadoGrouped(
			encerraCentroResultado: EncerraCentroResultado(
				id: encerraCentroResultadoModel.id,
				idCentroResultado: encerraCentroResultadoModel.idCentroResultado,
				competencia: Util.removeMask(encerraCentroResultadoModel.competencia),
				valorTotal: encerraCentroResultadoModel.valorTotal,
				valorSubRateio: encerraCentroResultadoModel.valorSubRateio,
			),
		);
	}

		
}
