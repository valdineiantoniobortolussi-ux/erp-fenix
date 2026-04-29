import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinLancamentoPagarDriftProvider extends ProviderBase {

	Future<List<FinLancamentoPagarModel>?> getList({Filter? filter}) async {
		List<FinLancamentoPagarGrouped> finLancamentoPagarDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finLancamentoPagarDriftList = await Session.database.finLancamentoPagarDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finLancamentoPagarDriftList = await Session.database.finLancamentoPagarDao.getGroupedList(); 
			}
			if (finLancamentoPagarDriftList.isNotEmpty) {
				return toListModel(finLancamentoPagarDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinLancamentoPagarModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finLancamentoPagarDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinLancamentoPagarModel?>? insert(FinLancamentoPagarModel finLancamentoPagarModel) async {
		try {
			final lastPk = await Session.database.finLancamentoPagarDao.insertObject(toDrift(finLancamentoPagarModel));
			finLancamentoPagarModel.id = lastPk;
			return finLancamentoPagarModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinLancamentoPagarModel?>? update(FinLancamentoPagarModel finLancamentoPagarModel) async {
		try {
			await Session.database.finLancamentoPagarDao.updateObject(toDrift(finLancamentoPagarModel));
			return finLancamentoPagarModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finLancamentoPagarDao.deleteObject(toDrift(FinLancamentoPagarModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinLancamentoPagarModel> toListModel(List<FinLancamentoPagarGrouped> finLancamentoPagarDriftList) {
		List<FinLancamentoPagarModel> listModel = [];
		for (var finLancamentoPagarDrift in finLancamentoPagarDriftList) {
			listModel.add(toModel(finLancamentoPagarDrift)!);
		}
		return listModel;
	}	

	FinLancamentoPagarModel? toModel(FinLancamentoPagarGrouped? finLancamentoPagarDrift) {
		if (finLancamentoPagarDrift != null) {
			return FinLancamentoPagarModel(
				id: finLancamentoPagarDrift.finLancamentoPagar?.id,
				imagemDocumento: finLancamentoPagarDrift.finLancamentoPagar?.imagemDocumento,
				idFornecedor: finLancamentoPagarDrift.finLancamentoPagar?.idFornecedor,
				idBancoContaCaixa: finLancamentoPagarDrift.finLancamentoPagar?.idBancoContaCaixa,
				idFinDocumentoOrigem: finLancamentoPagarDrift.finLancamentoPagar?.idFinDocumentoOrigem,
				idFinNaturezaFinanceira: finLancamentoPagarDrift.finLancamentoPagar?.idFinNaturezaFinanceira,
				quantidadeParcela: finLancamentoPagarDrift.finLancamentoPagar?.quantidadeParcela,
				valorAPagar: finLancamentoPagarDrift.finLancamentoPagar?.valorAPagar,
				dataLancamento: finLancamentoPagarDrift.finLancamentoPagar?.dataLancamento,
				numeroDocumento: finLancamentoPagarDrift.finLancamentoPagar?.numeroDocumento,
				primeiroVencimento: finLancamentoPagarDrift.finLancamentoPagar?.primeiroVencimento,
				intervaloEntreParcelas: finLancamentoPagarDrift.finLancamentoPagar?.intervaloEntreParcelas,
				diaFixo: finLancamentoPagarDrift.finLancamentoPagar?.diaFixo,
				finParcelaPagarModelList: finParcelaPagarDriftToModel(finLancamentoPagarDrift.finParcelaPagarGroupedList),
				finDocumentoOrigemModel: FinDocumentoOrigemModel(
					id: finLancamentoPagarDrift.finDocumentoOrigem?.id,
					codigo: finLancamentoPagarDrift.finDocumentoOrigem?.codigo,
					sigla: finLancamentoPagarDrift.finDocumentoOrigem?.sigla,
					descricao: finLancamentoPagarDrift.finDocumentoOrigem?.descricao,
				),
				bancoContaCaixaModel: BancoContaCaixaModel(
					id: finLancamentoPagarDrift.bancoContaCaixa?.id,
					idBancoAgencia: finLancamentoPagarDrift.bancoContaCaixa?.idBancoAgencia,
					numero: finLancamentoPagarDrift.bancoContaCaixa?.numero,
					digito: finLancamentoPagarDrift.bancoContaCaixa?.digito,
					nome: finLancamentoPagarDrift.bancoContaCaixa?.nome,
					tipo: finLancamentoPagarDrift.bancoContaCaixa?.tipo,
					descricao: finLancamentoPagarDrift.bancoContaCaixa?.descricao,
				),
				finNaturezaFinanceiraModel: FinNaturezaFinanceiraModel(
					id: finLancamentoPagarDrift.finNaturezaFinanceira?.id,
					codigo: finLancamentoPagarDrift.finNaturezaFinanceira?.codigo,
					tipo: finLancamentoPagarDrift.finNaturezaFinanceira?.tipo,
					descricao: finLancamentoPagarDrift.finNaturezaFinanceira?.descricao,
					aplicacao: finLancamentoPagarDrift.finNaturezaFinanceira?.aplicacao,
				),
				viewPessoaFornecedorModel: ViewPessoaFornecedorModel(
					id: finLancamentoPagarDrift.viewPessoaFornecedor?.id,
					nome: finLancamentoPagarDrift.viewPessoaFornecedor?.nome,
					tipo: finLancamentoPagarDrift.viewPessoaFornecedor?.tipo,
					email: finLancamentoPagarDrift.viewPessoaFornecedor?.email,
					site: finLancamentoPagarDrift.viewPessoaFornecedor?.site,
					cpfCnpj: finLancamentoPagarDrift.viewPessoaFornecedor?.cpfCnpj,
					rgIe: finLancamentoPagarDrift.viewPessoaFornecedor?.rgIe,
					desde: finLancamentoPagarDrift.viewPessoaFornecedor?.desde,
					dataCadastro: finLancamentoPagarDrift.viewPessoaFornecedor?.dataCadastro,
					observacao: finLancamentoPagarDrift.viewPessoaFornecedor?.observacao,
					idPessoa: finLancamentoPagarDrift.viewPessoaFornecedor?.idPessoa,
				),
			);
		} else {
			return null;
		}
	}

	List<FinParcelaPagarModel> finParcelaPagarDriftToModel(List<FinParcelaPagarGrouped>? finParcelaPagarDriftList) { 
		List<FinParcelaPagarModel> finParcelaPagarModelList = [];
		if (finParcelaPagarDriftList != null) {
			for (var finParcelaPagarGrouped in finParcelaPagarDriftList) {
				finParcelaPagarModelList.add(
					FinParcelaPagarModel(
						id: finParcelaPagarGrouped.finParcelaPagar?.id,
						idFinLancamentoPagar: finParcelaPagarGrouped.finParcelaPagar?.idFinLancamentoPagar,
						idFinChequeEmitido: finParcelaPagarGrouped.finParcelaPagar?.idFinChequeEmitido,
						idFinStatusParcela: finParcelaPagarGrouped.finParcelaPagar?.idFinStatusParcela,
						finStatusParcelaModel: FinStatusParcelaModel(
							id: finParcelaPagarGrouped.finStatusParcela?.id,
							situacao: finParcelaPagarGrouped.finStatusParcela?.situacao,
							descricao: finParcelaPagarGrouped.finStatusParcela?.descricao,
							procedimento: finParcelaPagarGrouped.finStatusParcela?.procedimento,
						),
						idFinTipoPagamento: finParcelaPagarGrouped.finParcelaPagar?.idFinTipoPagamento,
						finTipoPagamentoModel: FinTipoPagamentoModel(
							id: finParcelaPagarGrouped.finTipoPagamento?.id,
							codigo: finParcelaPagarGrouped.finTipoPagamento?.codigo,
							descricao: finParcelaPagarGrouped.finTipoPagamento?.descricao,
						),
						numeroParcela: finParcelaPagarGrouped.finParcelaPagar?.numeroParcela,
						dataEmissao: finParcelaPagarGrouped.finParcelaPagar?.dataEmissao,
						dataVencimento: finParcelaPagarGrouped.finParcelaPagar?.dataVencimento,
						dataPagamento: finParcelaPagarGrouped.finParcelaPagar?.dataPagamento,
						descontoAte: finParcelaPagarGrouped.finParcelaPagar?.descontoAte,
						valor: finParcelaPagarGrouped.finParcelaPagar?.valor,
						taxaJuro: finParcelaPagarGrouped.finParcelaPagar?.taxaJuro,
						taxaMulta: finParcelaPagarGrouped.finParcelaPagar?.taxaMulta,
						taxaDesconto: finParcelaPagarGrouped.finParcelaPagar?.taxaDesconto,
						valorJuro: finParcelaPagarGrouped.finParcelaPagar?.valorJuro,
						valorMulta: finParcelaPagarGrouped.finParcelaPagar?.valorMulta,
						valorDesconto: finParcelaPagarGrouped.finParcelaPagar?.valorDesconto,
						valorPago: finParcelaPagarGrouped.finParcelaPagar?.valorPago,
						historico: finParcelaPagarGrouped.finParcelaPagar?.historico,
					)
				);
			}
			return finParcelaPagarModelList;
		}
		return [];
	}


	FinLancamentoPagarGrouped toDrift(FinLancamentoPagarModel finLancamentoPagarModel) {
		return FinLancamentoPagarGrouped(
			finLancamentoPagar: FinLancamentoPagar(
				id: finLancamentoPagarModel.id,
				imagemDocumento: finLancamentoPagarModel.imagemDocumento,
				idFornecedor: finLancamentoPagarModel.idFornecedor,
				idBancoContaCaixa: finLancamentoPagarModel.idBancoContaCaixa,
				idFinDocumentoOrigem: finLancamentoPagarModel.idFinDocumentoOrigem,
				idFinNaturezaFinanceira: finLancamentoPagarModel.idFinNaturezaFinanceira,
				quantidadeParcela: finLancamentoPagarModel.quantidadeParcela,
				valorAPagar: finLancamentoPagarModel.valorAPagar,
				dataLancamento: finLancamentoPagarModel.dataLancamento,
				numeroDocumento: finLancamentoPagarModel.numeroDocumento,
				primeiroVencimento: finLancamentoPagarModel.primeiroVencimento,
				intervaloEntreParcelas: finLancamentoPagarModel.intervaloEntreParcelas,
				diaFixo: finLancamentoPagarModel.diaFixo,
			),
			finParcelaPagarGroupedList: finParcelaPagarModelToDrift(finLancamentoPagarModel.finParcelaPagarModelList),
		);
	}

	List<FinParcelaPagarGrouped> finParcelaPagarModelToDrift(List<FinParcelaPagarModel>? finParcelaPagarModelList) { 
		List<FinParcelaPagarGrouped> finParcelaPagarGroupedList = [];
		if (finParcelaPagarModelList != null) {
			for (var finParcelaPagarModel in finParcelaPagarModelList) {
				finParcelaPagarGroupedList.add(
					FinParcelaPagarGrouped(
						finParcelaPagar: FinParcelaPagar(
							id: finParcelaPagarModel.id,
							idFinLancamentoPagar: finParcelaPagarModel.idFinLancamentoPagar,
							idFinChequeEmitido: finParcelaPagarModel.idFinChequeEmitido,
							idFinStatusParcela: finParcelaPagarModel.idFinStatusParcela,
							idFinTipoPagamento: finParcelaPagarModel.idFinTipoPagamento,
							numeroParcela: finParcelaPagarModel.numeroParcela,
							dataEmissao: finParcelaPagarModel.dataEmissao,
							dataVencimento: finParcelaPagarModel.dataVencimento,
							dataPagamento: finParcelaPagarModel.dataPagamento,
							descontoAte: finParcelaPagarModel.descontoAte,
							valor: finParcelaPagarModel.valor,
							taxaJuro: finParcelaPagarModel.taxaJuro,
							taxaMulta: finParcelaPagarModel.taxaMulta,
							taxaDesconto: finParcelaPagarModel.taxaDesconto,
							valorJuro: finParcelaPagarModel.valorJuro,
							valorMulta: finParcelaPagarModel.valorMulta,
							valorDesconto: finParcelaPagarModel.valorDesconto,
							valorPago: finParcelaPagarModel.valorPago,
							historico: finParcelaPagarModel.historico,
						),
					),
				);
			}
			return finParcelaPagarGroupedList;
		}
		return [];
	}

		
}
