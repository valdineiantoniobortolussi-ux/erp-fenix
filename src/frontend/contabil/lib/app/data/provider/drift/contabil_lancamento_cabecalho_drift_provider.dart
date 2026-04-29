import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilLancamentoCabecalhoDriftProvider extends ProviderBase {

	Future<List<ContabilLancamentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<ContabilLancamentoCabecalhoGrouped> contabilLancamentoCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilLancamentoCabecalhoDriftList = await Session.database.contabilLancamentoCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilLancamentoCabecalhoDriftList = await Session.database.contabilLancamentoCabecalhoDao.getGroupedList(); 
			}
			if (contabilLancamentoCabecalhoDriftList.isNotEmpty) {
				return toListModel(contabilLancamentoCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilLancamentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilLancamentoCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLancamentoCabecalhoModel?>? insert(ContabilLancamentoCabecalhoModel contabilLancamentoCabecalhoModel) async {
		try {
			final lastPk = await Session.database.contabilLancamentoCabecalhoDao.insertObject(toDrift(contabilLancamentoCabecalhoModel));
			contabilLancamentoCabecalhoModel.id = lastPk;
			return contabilLancamentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLancamentoCabecalhoModel?>? update(ContabilLancamentoCabecalhoModel contabilLancamentoCabecalhoModel) async {
		try {
			await Session.database.contabilLancamentoCabecalhoDao.updateObject(toDrift(contabilLancamentoCabecalhoModel));
			return contabilLancamentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilLancamentoCabecalhoDao.deleteObject(toDrift(ContabilLancamentoCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilLancamentoCabecalhoModel> toListModel(List<ContabilLancamentoCabecalhoGrouped> contabilLancamentoCabecalhoDriftList) {
		List<ContabilLancamentoCabecalhoModel> listModel = [];
		for (var contabilLancamentoCabecalhoDrift in contabilLancamentoCabecalhoDriftList) {
			listModel.add(toModel(contabilLancamentoCabecalhoDrift)!);
		}
		return listModel;
	}	

	ContabilLancamentoCabecalhoModel? toModel(ContabilLancamentoCabecalhoGrouped? contabilLancamentoCabecalhoDrift) {
		if (contabilLancamentoCabecalhoDrift != null) {
			return ContabilLancamentoCabecalhoModel(
				id: contabilLancamentoCabecalhoDrift.contabilLancamentoCabecalho?.id,
				idContabilLote: contabilLancamentoCabecalhoDrift.contabilLancamentoCabecalho?.idContabilLote,
				dataLancamento: contabilLancamentoCabecalhoDrift.contabilLancamentoCabecalho?.dataLancamento,
				dataInclusao: contabilLancamentoCabecalhoDrift.contabilLancamentoCabecalho?.dataInclusao,
				tipo: ContabilLancamentoCabecalhoDomain.getTipo(contabilLancamentoCabecalhoDrift.contabilLancamentoCabecalho?.tipo),
				liberado: ContabilLancamentoCabecalhoDomain.getLiberado(contabilLancamentoCabecalhoDrift.contabilLancamentoCabecalho?.liberado),
				valor: contabilLancamentoCabecalhoDrift.contabilLancamentoCabecalho?.valor,
				contabilLancamentoDetalheModelList: contabilLancamentoDetalheDriftToModel(contabilLancamentoCabecalhoDrift.contabilLancamentoDetalheGroupedList),
				contabilLoteModel: ContabilLoteModel(
					id: contabilLancamentoCabecalhoDrift.contabilLote?.id,
					descricao: contabilLancamentoCabecalhoDrift.contabilLote?.descricao,
					dataInclusao: contabilLancamentoCabecalhoDrift.contabilLote?.dataInclusao,
					dataLiberacao: contabilLancamentoCabecalhoDrift.contabilLote?.dataLiberacao,
					liberado: contabilLancamentoCabecalhoDrift.contabilLote?.liberado,
					programado: contabilLancamentoCabecalhoDrift.contabilLote?.programado,
					valor: contabilLancamentoCabecalhoDrift.contabilLote?.valor,
				),
			);
		} else {
			return null;
		}
	}

	List<ContabilLancamentoDetalheModel> contabilLancamentoDetalheDriftToModel(List<ContabilLancamentoDetalheGrouped>? contabilLancamentoDetalheDriftList) { 
		List<ContabilLancamentoDetalheModel> contabilLancamentoDetalheModelList = [];
		if (contabilLancamentoDetalheDriftList != null) {
			for (var contabilLancamentoDetalheGrouped in contabilLancamentoDetalheDriftList) {
				contabilLancamentoDetalheModelList.add(
					ContabilLancamentoDetalheModel(
						id: contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.id,
						idContabilLancamentoCab: contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.idContabilLancamentoCab,
						idContabilConta: contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.idContabilConta,
						contabilContaModel: ContabilContaModel(
							id: contabilLancamentoDetalheGrouped.contabilConta?.id,
							idPlanoConta: contabilLancamentoDetalheGrouped.contabilConta?.idPlanoConta,
							idPlanoContaRefSped: contabilLancamentoDetalheGrouped.contabilConta?.idPlanoContaRefSped,
							idContabilConta: contabilLancamentoDetalheGrouped.contabilConta?.idContabilConta,
							classificacao: contabilLancamentoDetalheGrouped.contabilConta?.classificacao,
							tipo: contabilLancamentoDetalheGrouped.contabilConta?.tipo,
							descricao: contabilLancamentoDetalheGrouped.contabilConta?.descricao,
							dataInclusao: contabilLancamentoDetalheGrouped.contabilConta?.dataInclusao,
							situacao: contabilLancamentoDetalheGrouped.contabilConta?.situacao,
							natureza: contabilLancamentoDetalheGrouped.contabilConta?.natureza,
							patrimonioResultado: contabilLancamentoDetalheGrouped.contabilConta?.patrimonioResultado,
							livroCaixa: contabilLancamentoDetalheGrouped.contabilConta?.livroCaixa,
							dfc: contabilLancamentoDetalheGrouped.contabilConta?.dfc,
							codigoEfd: contabilLancamentoDetalheGrouped.contabilConta?.codigoEfd,
							ordem: contabilLancamentoDetalheGrouped.contabilConta?.ordem,
							codigoReduzido: contabilLancamentoDetalheGrouped.contabilConta?.codigoReduzido,
						),
						idContabilHistorico: contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.idContabilHistorico,
						contabilHistoricoModel: ContabilHistoricoModel(
							id: contabilLancamentoDetalheGrouped.contabilHistorico?.id,
							descricao: contabilLancamentoDetalheGrouped.contabilHistorico?.descricao,
							pedeComplemento: contabilLancamentoDetalheGrouped.contabilHistorico?.pedeComplemento,
							historico: contabilLancamentoDetalheGrouped.contabilHistorico?.historico,
						),
						tipo: ContabilLancamentoDetalheDomain.getTipo(contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.tipo),
						valor: contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.valor,
						historico: contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.historico,
					)
				);
			}
			return contabilLancamentoDetalheModelList;
		}
		return [];
	}


	ContabilLancamentoCabecalhoGrouped toDrift(ContabilLancamentoCabecalhoModel contabilLancamentoCabecalhoModel) {
		return ContabilLancamentoCabecalhoGrouped(
			contabilLancamentoCabecalho: ContabilLancamentoCabecalho(
				id: contabilLancamentoCabecalhoModel.id,
				idContabilLote: contabilLancamentoCabecalhoModel.idContabilLote,
				dataLancamento: contabilLancamentoCabecalhoModel.dataLancamento,
				dataInclusao: contabilLancamentoCabecalhoModel.dataInclusao,
				tipo: ContabilLancamentoCabecalhoDomain.setTipo(contabilLancamentoCabecalhoModel.tipo),
				liberado: ContabilLancamentoCabecalhoDomain.setLiberado(contabilLancamentoCabecalhoModel.liberado),
				valor: contabilLancamentoCabecalhoModel.valor,
			),
			contabilLancamentoDetalheGroupedList: contabilLancamentoDetalheModelToDrift(contabilLancamentoCabecalhoModel.contabilLancamentoDetalheModelList),
		);
	}

	List<ContabilLancamentoDetalheGrouped> contabilLancamentoDetalheModelToDrift(List<ContabilLancamentoDetalheModel>? contabilLancamentoDetalheModelList) { 
		List<ContabilLancamentoDetalheGrouped> contabilLancamentoDetalheGroupedList = [];
		if (contabilLancamentoDetalheModelList != null) {
			for (var contabilLancamentoDetalheModel in contabilLancamentoDetalheModelList) {
				contabilLancamentoDetalheGroupedList.add(
					ContabilLancamentoDetalheGrouped(
						contabilLancamentoDetalhe: ContabilLancamentoDetalhe(
							id: contabilLancamentoDetalheModel.id,
							idContabilLancamentoCab: contabilLancamentoDetalheModel.idContabilLancamentoCab,
							idContabilConta: contabilLancamentoDetalheModel.idContabilConta,
							idContabilHistorico: contabilLancamentoDetalheModel.idContabilHistorico,
							tipo: ContabilLancamentoDetalheDomain.setTipo(contabilLancamentoDetalheModel.tipo),
							valor: contabilLancamentoDetalheModel.valor,
							historico: contabilLancamentoDetalheModel.historico,
						),
					),
				);
			}
			return contabilLancamentoDetalheGroupedList;
		}
		return [];
	}

		
}
