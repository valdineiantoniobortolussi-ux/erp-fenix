import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class LancaCentroResultadoDriftProvider extends ProviderBase {

	Future<List<LancaCentroResultadoModel>?> getList({Filter? filter}) async {
		List<LancaCentroResultadoGrouped> lancaCentroResultadoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				lancaCentroResultadoDriftList = await Session.database.lancaCentroResultadoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				lancaCentroResultadoDriftList = await Session.database.lancaCentroResultadoDao.getGroupedList(); 
			}
			if (lancaCentroResultadoDriftList.isNotEmpty) {
				return toListModel(lancaCentroResultadoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<LancaCentroResultadoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.lancaCentroResultadoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<LancaCentroResultadoModel?>? insert(LancaCentroResultadoModel lancaCentroResultadoModel) async {
		try {
			final lastPk = await Session.database.lancaCentroResultadoDao.insertObject(toDrift(lancaCentroResultadoModel));
			lancaCentroResultadoModel.id = lastPk;
			return lancaCentroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<LancaCentroResultadoModel?>? update(LancaCentroResultadoModel lancaCentroResultadoModel) async {
		try {
			await Session.database.lancaCentroResultadoDao.updateObject(toDrift(lancaCentroResultadoModel));
			return lancaCentroResultadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.lancaCentroResultadoDao.deleteObject(toDrift(LancaCentroResultadoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<LancaCentroResultadoModel> toListModel(List<LancaCentroResultadoGrouped> lancaCentroResultadoDriftList) {
		List<LancaCentroResultadoModel> listModel = [];
		for (var lancaCentroResultadoDrift in lancaCentroResultadoDriftList) {
			listModel.add(toModel(lancaCentroResultadoDrift)!);
		}
		return listModel;
	}	

	LancaCentroResultadoModel? toModel(LancaCentroResultadoGrouped? lancaCentroResultadoDrift) {
		if (lancaCentroResultadoDrift != null) {
			return LancaCentroResultadoModel(
				id: lancaCentroResultadoDrift.lancaCentroResultado?.id,
				idCentroResultado: lancaCentroResultadoDrift.lancaCentroResultado?.idCentroResultado,
				valor: lancaCentroResultadoDrift.lancaCentroResultado?.valor,
				dataLancamento: lancaCentroResultadoDrift.lancaCentroResultado?.dataLancamento,
				dataInclusao: lancaCentroResultadoDrift.lancaCentroResultado?.dataInclusao,
				origemDeRateio: LancaCentroResultadoDomain.getOrigemDeRateio(lancaCentroResultadoDrift.lancaCentroResultado?.origemDeRateio),
				historico: lancaCentroResultadoDrift.lancaCentroResultado?.historico,
				centroResultadoModel: CentroResultadoModel(
					id: lancaCentroResultadoDrift.centroResultado?.id,
					idPlanoCentroResultado: lancaCentroResultadoDrift.centroResultado?.idPlanoCentroResultado,
					descricao: lancaCentroResultadoDrift.centroResultado?.descricao,
					classificacao: lancaCentroResultadoDrift.centroResultado?.classificacao,
					sofreRateiro: lancaCentroResultadoDrift.centroResultado?.sofreRateiro,
				),
			);
		} else {
			return null;
		}
	}


	LancaCentroResultadoGrouped toDrift(LancaCentroResultadoModel lancaCentroResultadoModel) {
		return LancaCentroResultadoGrouped(
			lancaCentroResultado: LancaCentroResultado(
				id: lancaCentroResultadoModel.id,
				idCentroResultado: lancaCentroResultadoModel.idCentroResultado,
				valor: lancaCentroResultadoModel.valor,
				dataLancamento: lancaCentroResultadoModel.dataLancamento,
				dataInclusao: lancaCentroResultadoModel.dataInclusao,
				origemDeRateio: LancaCentroResultadoDomain.setOrigemDeRateio(lancaCentroResultadoModel.origemDeRateio),
				historico: lancaCentroResultadoModel.historico,
			),
		);
	}

		
}
