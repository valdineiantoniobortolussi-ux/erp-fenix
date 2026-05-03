import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

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
				descricao: centroResultadoDrift.centroResultado?.descricao,
				classificacao: centroResultadoDrift.centroResultado?.classificacao,
				sofreRateiro: CentroResultadoDomain.getSofreRateiro(centroResultadoDrift.centroResultado?.sofreRateiro),
				planoCentroResultadoModel: PlanoCentroResultadoModel(
					id: centroResultadoDrift.planoCentroResultado?.id,
					nome: centroResultadoDrift.planoCentroResultado?.nome,
					mascara: centroResultadoDrift.planoCentroResultado?.mascara,
					niveis: centroResultadoDrift.planoCentroResultado?.niveis,
					dataInclusao: centroResultadoDrift.planoCentroResultado?.dataInclusao,
				),
				ctResultadoNtFinanceiraModelList: ctResultadoNtFinanceiraDriftToModel(centroResultadoDrift.ctResultadoNtFinanceiraGroupedList),
			);
		} else {
			return null;
		}
	}

	List<CtResultadoNtFinanceiraModel> ctResultadoNtFinanceiraDriftToModel(List<CtResultadoNtFinanceiraGrouped>? ctResultadoNtFinanceiraDriftList) { 
		List<CtResultadoNtFinanceiraModel> ctResultadoNtFinanceiraModelList = [];
		if (ctResultadoNtFinanceiraDriftList != null) {
			for (var ctResultadoNtFinanceiraGrouped in ctResultadoNtFinanceiraDriftList) {
				ctResultadoNtFinanceiraModelList.add(
					CtResultadoNtFinanceiraModel(
						id: ctResultadoNtFinanceiraGrouped.ctResultadoNtFinanceira?.id,
						idCentroResultado: ctResultadoNtFinanceiraGrouped.ctResultadoNtFinanceira?.idCentroResultado,
						idFinNaturezaFinanceira: ctResultadoNtFinanceiraGrouped.ctResultadoNtFinanceira?.idFinNaturezaFinanceira,
						finNaturezaFinanceiraModel: FinNaturezaFinanceiraModel(
							id: ctResultadoNtFinanceiraGrouped.finNaturezaFinanceira?.id,
							codigo: ctResultadoNtFinanceiraGrouped.finNaturezaFinanceira?.codigo,
							descricao: ctResultadoNtFinanceiraGrouped.finNaturezaFinanceira?.descricao,
							tipo: ctResultadoNtFinanceiraGrouped.finNaturezaFinanceira?.tipo,
							aplicacao: ctResultadoNtFinanceiraGrouped.finNaturezaFinanceira?.aplicacao,
						),
						percentualRateio: ctResultadoNtFinanceiraGrouped.ctResultadoNtFinanceira?.percentualRateio,
					)
				);
			}
			return ctResultadoNtFinanceiraModelList;
		}
		return [];
	}


	CentroResultadoGrouped toDrift(CentroResultadoModel centroResultadoModel) {
		return CentroResultadoGrouped(
			centroResultado: CentroResultado(
				id: centroResultadoModel.id,
				idPlanoCentroResultado: centroResultadoModel.idPlanoCentroResultado,
				descricao: centroResultadoModel.descricao,
				classificacao: centroResultadoModel.classificacao,
				sofreRateiro: CentroResultadoDomain.setSofreRateiro(centroResultadoModel.sofreRateiro),
			),
			ctResultadoNtFinanceiraGroupedList: ctResultadoNtFinanceiraModelToDrift(centroResultadoModel.ctResultadoNtFinanceiraModelList),
		);
	}

	List<CtResultadoNtFinanceiraGrouped> ctResultadoNtFinanceiraModelToDrift(List<CtResultadoNtFinanceiraModel>? ctResultadoNtFinanceiraModelList) { 
		List<CtResultadoNtFinanceiraGrouped> ctResultadoNtFinanceiraGroupedList = [];
		if (ctResultadoNtFinanceiraModelList != null) {
			for (var ctResultadoNtFinanceiraModel in ctResultadoNtFinanceiraModelList) {
				ctResultadoNtFinanceiraGroupedList.add(
					CtResultadoNtFinanceiraGrouped(
						ctResultadoNtFinanceira: CtResultadoNtFinanceira(
							id: ctResultadoNtFinanceiraModel.id,
							idCentroResultado: ctResultadoNtFinanceiraModel.idCentroResultado,
							idFinNaturezaFinanceira: ctResultadoNtFinanceiraModel.idFinNaturezaFinanceira,
							percentualRateio: ctResultadoNtFinanceiraModel.percentualRateio,
						),
					),
				);
			}
			return ctResultadoNtFinanceiraGroupedList;
		}
		return [];
	}

		
}
