import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilEncerramentoExeCabDriftProvider extends ProviderBase {

	Future<List<ContabilEncerramentoExeCabModel>?> getList({Filter? filter}) async {
		List<ContabilEncerramentoExeCabGrouped> contabilEncerramentoExeCabDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilEncerramentoExeCabDriftList = await Session.database.contabilEncerramentoExeCabDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilEncerramentoExeCabDriftList = await Session.database.contabilEncerramentoExeCabDao.getGroupedList(); 
			}
			if (contabilEncerramentoExeCabDriftList.isNotEmpty) {
				return toListModel(contabilEncerramentoExeCabDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilEncerramentoExeCabModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilEncerramentoExeCabDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilEncerramentoExeCabModel?>? insert(ContabilEncerramentoExeCabModel contabilEncerramentoExeCabModel) async {
		try {
			final lastPk = await Session.database.contabilEncerramentoExeCabDao.insertObject(toDrift(contabilEncerramentoExeCabModel));
			contabilEncerramentoExeCabModel.id = lastPk;
			return contabilEncerramentoExeCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilEncerramentoExeCabModel?>? update(ContabilEncerramentoExeCabModel contabilEncerramentoExeCabModel) async {
		try {
			await Session.database.contabilEncerramentoExeCabDao.updateObject(toDrift(contabilEncerramentoExeCabModel));
			return contabilEncerramentoExeCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilEncerramentoExeCabDao.deleteObject(toDrift(ContabilEncerramentoExeCabModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilEncerramentoExeCabModel> toListModel(List<ContabilEncerramentoExeCabGrouped> contabilEncerramentoExeCabDriftList) {
		List<ContabilEncerramentoExeCabModel> listModel = [];
		for (var contabilEncerramentoExeCabDrift in contabilEncerramentoExeCabDriftList) {
			listModel.add(toModel(contabilEncerramentoExeCabDrift)!);
		}
		return listModel;
	}	

	ContabilEncerramentoExeCabModel? toModel(ContabilEncerramentoExeCabGrouped? contabilEncerramentoExeCabDrift) {
		if (contabilEncerramentoExeCabDrift != null) {
			return ContabilEncerramentoExeCabModel(
				id: contabilEncerramentoExeCabDrift.contabilEncerramentoExeCab?.id,
				dataInicio: contabilEncerramentoExeCabDrift.contabilEncerramentoExeCab?.dataInicio,
				dataFim: contabilEncerramentoExeCabDrift.contabilEncerramentoExeCab?.dataFim,
				dataInclusao: contabilEncerramentoExeCabDrift.contabilEncerramentoExeCab?.dataInclusao,
				motivo: contabilEncerramentoExeCabDrift.contabilEncerramentoExeCab?.motivo,
				contabilEncerramentoExeDetModelList: contabilEncerramentoExeDetDriftToModel(contabilEncerramentoExeCabDrift.contabilEncerramentoExeDetGroupedList),
			);
		} else {
			return null;
		}
	}

	List<ContabilEncerramentoExeDetModel> contabilEncerramentoExeDetDriftToModel(List<ContabilEncerramentoExeDetGrouped>? contabilEncerramentoExeDetDriftList) { 
		List<ContabilEncerramentoExeDetModel> contabilEncerramentoExeDetModelList = [];
		if (contabilEncerramentoExeDetDriftList != null) {
			for (var contabilEncerramentoExeDetGrouped in contabilEncerramentoExeDetDriftList) {
				contabilEncerramentoExeDetModelList.add(
					ContabilEncerramentoExeDetModel(
						id: contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.id,
						idContabilEncerramentoExe: contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.idContabilEncerramentoExe,
						idContabilConta: contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.idContabilConta,
						contabilContaModel: ContabilContaModel(
							id: contabilEncerramentoExeDetGrouped.contabilConta?.id,
							idPlanoConta: contabilEncerramentoExeDetGrouped.contabilConta?.idPlanoConta,
							idPlanoContaRefSped: contabilEncerramentoExeDetGrouped.contabilConta?.idPlanoContaRefSped,
							idContabilConta: contabilEncerramentoExeDetGrouped.contabilConta?.idContabilConta,
							classificacao: contabilEncerramentoExeDetGrouped.contabilConta?.classificacao,
							tipo: contabilEncerramentoExeDetGrouped.contabilConta?.tipo,
							descricao: contabilEncerramentoExeDetGrouped.contabilConta?.descricao,
							dataInclusao: contabilEncerramentoExeDetGrouped.contabilConta?.dataInclusao,
							situacao: contabilEncerramentoExeDetGrouped.contabilConta?.situacao,
							natureza: contabilEncerramentoExeDetGrouped.contabilConta?.natureza,
							patrimonioResultado: contabilEncerramentoExeDetGrouped.contabilConta?.patrimonioResultado,
							livroCaixa: contabilEncerramentoExeDetGrouped.contabilConta?.livroCaixa,
							dfc: contabilEncerramentoExeDetGrouped.contabilConta?.dfc,
							codigoEfd: contabilEncerramentoExeDetGrouped.contabilConta?.codigoEfd,
							ordem: contabilEncerramentoExeDetGrouped.contabilConta?.ordem,
							codigoReduzido: contabilEncerramentoExeDetGrouped.contabilConta?.codigoReduzido,
						),
						saldoAnterior: contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.saldoAnterior,
						valorDebito: contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.valorDebito,
						valorCredito: contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.valorCredito,
						saldo: contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.saldo,
					)
				);
			}
			return contabilEncerramentoExeDetModelList;
		}
		return [];
	}


	ContabilEncerramentoExeCabGrouped toDrift(ContabilEncerramentoExeCabModel contabilEncerramentoExeCabModel) {
		return ContabilEncerramentoExeCabGrouped(
			contabilEncerramentoExeCab: ContabilEncerramentoExeCab(
				id: contabilEncerramentoExeCabModel.id,
				dataInicio: contabilEncerramentoExeCabModel.dataInicio,
				dataFim: contabilEncerramentoExeCabModel.dataFim,
				dataInclusao: contabilEncerramentoExeCabModel.dataInclusao,
				motivo: contabilEncerramentoExeCabModel.motivo,
			),
			contabilEncerramentoExeDetGroupedList: contabilEncerramentoExeDetModelToDrift(contabilEncerramentoExeCabModel.contabilEncerramentoExeDetModelList),
		);
	}

	List<ContabilEncerramentoExeDetGrouped> contabilEncerramentoExeDetModelToDrift(List<ContabilEncerramentoExeDetModel>? contabilEncerramentoExeDetModelList) { 
		List<ContabilEncerramentoExeDetGrouped> contabilEncerramentoExeDetGroupedList = [];
		if (contabilEncerramentoExeDetModelList != null) {
			for (var contabilEncerramentoExeDetModel in contabilEncerramentoExeDetModelList) {
				contabilEncerramentoExeDetGroupedList.add(
					ContabilEncerramentoExeDetGrouped(
						contabilEncerramentoExeDet: ContabilEncerramentoExeDet(
							id: contabilEncerramentoExeDetModel.id,
							idContabilEncerramentoExe: contabilEncerramentoExeDetModel.idContabilEncerramentoExe,
							idContabilConta: contabilEncerramentoExeDetModel.idContabilConta,
							saldoAnterior: contabilEncerramentoExeDetModel.saldoAnterior,
							valorDebito: contabilEncerramentoExeDetModel.valorDebito,
							valorCredito: contabilEncerramentoExeDetModel.valorCredito,
							saldo: contabilEncerramentoExeDetModel.saldo,
						),
					),
				);
			}
			return contabilEncerramentoExeDetGroupedList;
		}
		return [];
	}

		
}
