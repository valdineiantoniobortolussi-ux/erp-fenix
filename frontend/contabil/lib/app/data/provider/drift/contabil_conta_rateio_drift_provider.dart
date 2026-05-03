import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilContaRateioDriftProvider extends ProviderBase {

	Future<List<ContabilContaRateioModel>?> getList({Filter? filter}) async {
		List<ContabilContaRateioGrouped> contabilContaRateioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilContaRateioDriftList = await Session.database.contabilContaRateioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilContaRateioDriftList = await Session.database.contabilContaRateioDao.getGroupedList(); 
			}
			if (contabilContaRateioDriftList.isNotEmpty) {
				return toListModel(contabilContaRateioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilContaRateioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilContaRateioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilContaRateioModel?>? insert(ContabilContaRateioModel contabilContaRateioModel) async {
		try {
			final lastPk = await Session.database.contabilContaRateioDao.insertObject(toDrift(contabilContaRateioModel));
			contabilContaRateioModel.id = lastPk;
			return contabilContaRateioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilContaRateioModel?>? update(ContabilContaRateioModel contabilContaRateioModel) async {
		try {
			await Session.database.contabilContaRateioDao.updateObject(toDrift(contabilContaRateioModel));
			return contabilContaRateioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilContaRateioDao.deleteObject(toDrift(ContabilContaRateioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilContaRateioModel> toListModel(List<ContabilContaRateioGrouped> contabilContaRateioDriftList) {
		List<ContabilContaRateioModel> listModel = [];
		for (var contabilContaRateioDrift in contabilContaRateioDriftList) {
			listModel.add(toModel(contabilContaRateioDrift)!);
		}
		return listModel;
	}	

	ContabilContaRateioModel? toModel(ContabilContaRateioGrouped? contabilContaRateioDrift) {
		if (contabilContaRateioDrift != null) {
			return ContabilContaRateioModel(
				id: contabilContaRateioDrift.contabilContaRateio?.id,
				idCentroResultado: contabilContaRateioDrift.contabilContaRateio?.idCentroResultado,
				idContabilConta: contabilContaRateioDrift.contabilContaRateio?.idContabilConta,
				porcentoRateio: contabilContaRateioDrift.contabilContaRateio?.porcentoRateio,
				contabilContaModel: ContabilContaModel(
					id: contabilContaRateioDrift.contabilConta?.id,
					idPlanoConta: contabilContaRateioDrift.contabilConta?.idPlanoConta,
					idPlanoContaRefSped: contabilContaRateioDrift.contabilConta?.idPlanoContaRefSped,
					idContabilConta: contabilContaRateioDrift.contabilConta?.idContabilConta,
					classificacao: contabilContaRateioDrift.contabilConta?.classificacao,
					tipo: contabilContaRateioDrift.contabilConta?.tipo,
					descricao: contabilContaRateioDrift.contabilConta?.descricao,
					dataInclusao: contabilContaRateioDrift.contabilConta?.dataInclusao,
					situacao: contabilContaRateioDrift.contabilConta?.situacao,
					natureza: contabilContaRateioDrift.contabilConta?.natureza,
					patrimonioResultado: contabilContaRateioDrift.contabilConta?.patrimonioResultado,
					livroCaixa: contabilContaRateioDrift.contabilConta?.livroCaixa,
					dfc: contabilContaRateioDrift.contabilConta?.dfc,
					codigoEfd: contabilContaRateioDrift.contabilConta?.codigoEfd,
					ordem: contabilContaRateioDrift.contabilConta?.ordem,
					codigoReduzido: contabilContaRateioDrift.contabilConta?.codigoReduzido,
				),
				centroResultadoModel: CentroResultadoModel(
					id: contabilContaRateioDrift.centroResultado?.id,
					idPlanoCentroResultado: contabilContaRateioDrift.centroResultado?.idPlanoCentroResultado,
					descricao: contabilContaRateioDrift.centroResultado?.descricao,
					classificacao: contabilContaRateioDrift.centroResultado?.classificacao,
					sofreRateiro: contabilContaRateioDrift.centroResultado?.sofreRateiro,
				),
			);
		} else {
			return null;
		}
	}


	ContabilContaRateioGrouped toDrift(ContabilContaRateioModel contabilContaRateioModel) {
		return ContabilContaRateioGrouped(
			contabilContaRateio: ContabilContaRateio(
				id: contabilContaRateioModel.id,
				idCentroResultado: contabilContaRateioModel.idCentroResultado,
				idContabilConta: contabilContaRateioModel.idContabilConta,
				porcentoRateio: contabilContaRateioModel.porcentoRateio,
			),
		);
	}

		
}
