import 'package:contratos/app/data/provider/drift/database/database_imports.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/provider/provider_base.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoDriftProvider extends ProviderBase {

	Future<List<ContratoModel>?> getList({Filter? filter}) async {
		List<ContratoGrouped> contratoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contratoDriftList = await Session.database.contratoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contratoDriftList = await Session.database.contratoDao.getGroupedList(); 
			}
			if (contratoDriftList.isNotEmpty) {
				return toListModel(contratoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContratoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contratoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoModel?>? insert(ContratoModel contratoModel) async {
		try {
			final lastPk = await Session.database.contratoDao.insertObject(toDrift(contratoModel));
			contratoModel.id = lastPk;
			return contratoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoModel?>? update(ContratoModel contratoModel) async {
		try {
			await Session.database.contratoDao.updateObject(toDrift(contratoModel));
			return contratoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contratoDao.deleteObject(toDrift(ContratoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContratoModel> toListModel(List<ContratoGrouped> contratoDriftList) {
		List<ContratoModel> listModel = [];
		for (var contratoDrift in contratoDriftList) {
			listModel.add(toModel(contratoDrift)!);
		}
		return listModel;
	}	

	ContratoModel? toModel(ContratoGrouped? contratoDrift) {
		if (contratoDrift != null) {
			return ContratoModel(
				id: contratoDrift.contrato?.id,
				idSolicitacaoServico: contratoDrift.contrato?.idSolicitacaoServico,
				idTipoContrato: contratoDrift.contrato?.idTipoContrato,
				numero: contratoDrift.contrato?.numero,
				nome: contratoDrift.contrato?.nome,
				descricao: contratoDrift.contrato?.descricao,
				dataCadastro: contratoDrift.contrato?.dataCadastro,
				dataInicioVigencia: contratoDrift.contrato?.dataInicioVigencia,
				dataFimVigencia: contratoDrift.contrato?.dataFimVigencia,
				diaFaturamento: contratoDrift.contrato?.diaFaturamento,
				valor: contratoDrift.contrato?.valor,
				quantidadeParcelas: contratoDrift.contrato?.quantidadeParcelas,
				intervaloEntreParcelas: contratoDrift.contrato?.intervaloEntreParcelas,
				classificacaoContabilConta: contratoDrift.contrato?.classificacaoContabilConta,
				observacao: contratoDrift.contrato?.observacao,
				contratoHistoricoReajusteModelList: contratoHistoricoReajusteDriftToModel(contratoDrift.contratoHistoricoReajusteGroupedList),
				contratoPrevFaturamentoModelList: contratoPrevFaturamentoDriftToModel(contratoDrift.contratoPrevFaturamentoGroupedList),
				contratoHistFaturamentoModelList: contratoHistFaturamentoDriftToModel(contratoDrift.contratoHistFaturamentoGroupedList),
				tipoContratoModel: TipoContratoModel(
					id: contratoDrift.tipoContrato?.id,
					nome: contratoDrift.tipoContrato?.nome,
					descricao: contratoDrift.tipoContrato?.descricao,
				),
				contratoSolicitacaoServicoModel: ContratoSolicitacaoServicoModel(
					id: contratoDrift.contratoSolicitacaoServico?.id,
					idContratoTipoServico: contratoDrift.contratoSolicitacaoServico?.idContratoTipoServico,
					idSetor: contratoDrift.contratoSolicitacaoServico?.idSetor,
					idColaborador: contratoDrift.contratoSolicitacaoServico?.idColaborador,
					idCliente: contratoDrift.contratoSolicitacaoServico?.idCliente,
					idFornecedor: contratoDrift.contratoSolicitacaoServico?.idFornecedor,
					dataSolicitacao: contratoDrift.contratoSolicitacaoServico?.dataSolicitacao,
					dataDesejadaInicio: contratoDrift.contratoSolicitacaoServico?.dataDesejadaInicio,
					urgente: contratoDrift.contratoSolicitacaoServico?.urgente,
					statusSolicitacao: contratoDrift.contratoSolicitacaoServico?.statusSolicitacao,
					descricao: contratoDrift.contratoSolicitacaoServico?.descricao,
				),
			);
		} else {
			return null;
		}
	}

	List<ContratoHistoricoReajusteModel> contratoHistoricoReajusteDriftToModel(List<ContratoHistoricoReajusteGrouped>? contratoHistoricoReajusteDriftList) { 
		List<ContratoHistoricoReajusteModel> contratoHistoricoReajusteModelList = [];
		if (contratoHistoricoReajusteDriftList != null) {
			for (var contratoHistoricoReajusteGrouped in contratoHistoricoReajusteDriftList) {
				contratoHistoricoReajusteModelList.add(
					ContratoHistoricoReajusteModel(
						id: contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.id,
						idContrato: contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.idContrato,
						indice: contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.indice,
						valorAnterior: contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.valorAnterior,
						valorAtual: contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.valorAtual,
						dataReajuste: contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.dataReajuste,
						observacao: contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.observacao,
					)
				);
			}
			return contratoHistoricoReajusteModelList;
		}
		return [];
	}

	List<ContratoPrevFaturamentoModel> contratoPrevFaturamentoDriftToModel(List<ContratoPrevFaturamentoGrouped>? contratoPrevFaturamentoDriftList) { 
		List<ContratoPrevFaturamentoModel> contratoPrevFaturamentoModelList = [];
		if (contratoPrevFaturamentoDriftList != null) {
			for (var contratoPrevFaturamentoGrouped in contratoPrevFaturamentoDriftList) {
				contratoPrevFaturamentoModelList.add(
					ContratoPrevFaturamentoModel(
						id: contratoPrevFaturamentoGrouped.contratoPrevFaturamento?.id,
						idContrato: contratoPrevFaturamentoGrouped.contratoPrevFaturamento?.idContrato,
						dataPrevista: contratoPrevFaturamentoGrouped.contratoPrevFaturamento?.dataPrevista,
						valor: contratoPrevFaturamentoGrouped.contratoPrevFaturamento?.valor,
					)
				);
			}
			return contratoPrevFaturamentoModelList;
		}
		return [];
	}

	List<ContratoHistFaturamentoModel> contratoHistFaturamentoDriftToModel(List<ContratoHistFaturamentoGrouped>? contratoHistFaturamentoDriftList) { 
		List<ContratoHistFaturamentoModel> contratoHistFaturamentoModelList = [];
		if (contratoHistFaturamentoDriftList != null) {
			for (var contratoHistFaturamentoGrouped in contratoHistFaturamentoDriftList) {
				contratoHistFaturamentoModelList.add(
					ContratoHistFaturamentoModel(
						id: contratoHistFaturamentoGrouped.contratoHistFaturamento?.id,
						idContrato: contratoHistFaturamentoGrouped.contratoHistFaturamento?.idContrato,
						dataFatura: contratoHistFaturamentoGrouped.contratoHistFaturamento?.dataFatura,
						valor: contratoHistFaturamentoGrouped.contratoHistFaturamento?.valor,
					)
				);
			}
			return contratoHistFaturamentoModelList;
		}
		return [];
	}


	ContratoGrouped toDrift(ContratoModel contratoModel) {
		return ContratoGrouped(
			contrato: Contrato(
				id: contratoModel.id,
				idSolicitacaoServico: contratoModel.idSolicitacaoServico,
				idTipoContrato: contratoModel.idTipoContrato,
				numero: contratoModel.numero,
				nome: contratoModel.nome,
				descricao: contratoModel.descricao,
				dataCadastro: contratoModel.dataCadastro,
				dataInicioVigencia: contratoModel.dataInicioVigencia,
				dataFimVigencia: contratoModel.dataFimVigencia,
				diaFaturamento: contratoModel.diaFaturamento,
				valor: contratoModel.valor,
				quantidadeParcelas: contratoModel.quantidadeParcelas,
				intervaloEntreParcelas: contratoModel.intervaloEntreParcelas,
				classificacaoContabilConta: contratoModel.classificacaoContabilConta,
				observacao: contratoModel.observacao,
			),
			contratoHistoricoReajusteGroupedList: contratoHistoricoReajusteModelToDrift(contratoModel.contratoHistoricoReajusteModelList),
			contratoPrevFaturamentoGroupedList: contratoPrevFaturamentoModelToDrift(contratoModel.contratoPrevFaturamentoModelList),
			contratoHistFaturamentoGroupedList: contratoHistFaturamentoModelToDrift(contratoModel.contratoHistFaturamentoModelList),
		);
	}

	List<ContratoHistoricoReajusteGrouped> contratoHistoricoReajusteModelToDrift(List<ContratoHistoricoReajusteModel>? contratoHistoricoReajusteModelList) { 
		List<ContratoHistoricoReajusteGrouped> contratoHistoricoReajusteGroupedList = [];
		if (contratoHistoricoReajusteModelList != null) {
			for (var contratoHistoricoReajusteModel in contratoHistoricoReajusteModelList) {
				contratoHistoricoReajusteGroupedList.add(
					ContratoHistoricoReajusteGrouped(
						contratoHistoricoReajuste: ContratoHistoricoReajuste(
							id: contratoHistoricoReajusteModel.id,
							idContrato: contratoHistoricoReajusteModel.idContrato,
							indice: contratoHistoricoReajusteModel.indice,
							valorAnterior: contratoHistoricoReajusteModel.valorAnterior,
							valorAtual: contratoHistoricoReajusteModel.valorAtual,
							dataReajuste: contratoHistoricoReajusteModel.dataReajuste,
							observacao: contratoHistoricoReajusteModel.observacao,
						),
					),
				);
			}
			return contratoHistoricoReajusteGroupedList;
		}
		return [];
	}

	List<ContratoPrevFaturamentoGrouped> contratoPrevFaturamentoModelToDrift(List<ContratoPrevFaturamentoModel>? contratoPrevFaturamentoModelList) { 
		List<ContratoPrevFaturamentoGrouped> contratoPrevFaturamentoGroupedList = [];
		if (contratoPrevFaturamentoModelList != null) {
			for (var contratoPrevFaturamentoModel in contratoPrevFaturamentoModelList) {
				contratoPrevFaturamentoGroupedList.add(
					ContratoPrevFaturamentoGrouped(
						contratoPrevFaturamento: ContratoPrevFaturamento(
							id: contratoPrevFaturamentoModel.id,
							idContrato: contratoPrevFaturamentoModel.idContrato,
							dataPrevista: contratoPrevFaturamentoModel.dataPrevista,
							valor: contratoPrevFaturamentoModel.valor,
						),
					),
				);
			}
			return contratoPrevFaturamentoGroupedList;
		}
		return [];
	}

	List<ContratoHistFaturamentoGrouped> contratoHistFaturamentoModelToDrift(List<ContratoHistFaturamentoModel>? contratoHistFaturamentoModelList) { 
		List<ContratoHistFaturamentoGrouped> contratoHistFaturamentoGroupedList = [];
		if (contratoHistFaturamentoModelList != null) {
			for (var contratoHistFaturamentoModel in contratoHistFaturamentoModelList) {
				contratoHistFaturamentoGroupedList.add(
					ContratoHistFaturamentoGrouped(
						contratoHistFaturamento: ContratoHistFaturamento(
							id: contratoHistFaturamentoModel.id,
							idContrato: contratoHistFaturamentoModel.idContrato,
							dataFatura: contratoHistFaturamentoModel.dataFatura,
							valor: contratoHistFaturamentoModel.valor,
						),
					),
				);
			}
			return contratoHistFaturamentoGroupedList;
		}
		return [];
	}

		
}
