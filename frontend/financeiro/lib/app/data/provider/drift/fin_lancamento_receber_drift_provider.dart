import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinLancamentoReceberDriftProvider extends ProviderBase {

	Future<List<FinLancamentoReceberModel>?> getList({Filter? filter}) async {
		List<FinLancamentoReceberGrouped> finLancamentoReceberDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finLancamentoReceberDriftList = await Session.database.finLancamentoReceberDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finLancamentoReceberDriftList = await Session.database.finLancamentoReceberDao.getGroupedList(); 
			}
			if (finLancamentoReceberDriftList.isNotEmpty) {
				return toListModel(finLancamentoReceberDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinLancamentoReceberModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finLancamentoReceberDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinLancamentoReceberModel?>? insert(FinLancamentoReceberModel finLancamentoReceberModel) async {
		try {
			final lastPk = await Session.database.finLancamentoReceberDao.insertObject(toDrift(finLancamentoReceberModel));
			finLancamentoReceberModel.id = lastPk;
			return finLancamentoReceberModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinLancamentoReceberModel?>? update(FinLancamentoReceberModel finLancamentoReceberModel) async {
		try {
			await Session.database.finLancamentoReceberDao.updateObject(toDrift(finLancamentoReceberModel));
			return finLancamentoReceberModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finLancamentoReceberDao.deleteObject(toDrift(FinLancamentoReceberModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinLancamentoReceberModel> toListModel(List<FinLancamentoReceberGrouped> finLancamentoReceberDriftList) {
		List<FinLancamentoReceberModel> listModel = [];
		for (var finLancamentoReceberDrift in finLancamentoReceberDriftList) {
			listModel.add(toModel(finLancamentoReceberDrift)!);
		}
		return listModel;
	}	

	FinLancamentoReceberModel? toModel(FinLancamentoReceberGrouped? finLancamentoReceberDrift) {
		if (finLancamentoReceberDrift != null) {
			return FinLancamentoReceberModel(
				id: finLancamentoReceberDrift.finLancamentoReceber?.id,
				idCliente: finLancamentoReceberDrift.finLancamentoReceber?.idCliente,
				idBancoContaCaixa: finLancamentoReceberDrift.finLancamentoReceber?.idBancoContaCaixa,
				idFinDocumentoOrigem: finLancamentoReceberDrift.finLancamentoReceber?.idFinDocumentoOrigem,
				idFinNaturezaFinanceira: finLancamentoReceberDrift.finLancamentoReceber?.idFinNaturezaFinanceira,
				quantidadeParcela: finLancamentoReceberDrift.finLancamentoReceber?.quantidadeParcela,
				valorAReceber: finLancamentoReceberDrift.finLancamentoReceber?.valorAReceber,
				dataLancamento: finLancamentoReceberDrift.finLancamentoReceber?.dataLancamento,
				numeroDocumento: finLancamentoReceberDrift.finLancamentoReceber?.numeroDocumento,
				primeiroVencimento: finLancamentoReceberDrift.finLancamentoReceber?.primeiroVencimento,
				taxaComissao: finLancamentoReceberDrift.finLancamentoReceber?.taxaComissao,
				valorComissao: finLancamentoReceberDrift.finLancamentoReceber?.valorComissao,
				intervaloEntreParcelas: finLancamentoReceberDrift.finLancamentoReceber?.intervaloEntreParcelas,
				diaFixo: finLancamentoReceberDrift.finLancamentoReceber?.diaFixo,
				finParcelaReceberModelList: finParcelaReceberDriftToModel(finLancamentoReceberDrift.finParcelaReceberGroupedList),
				finDocumentoOrigemModel: FinDocumentoOrigemModel(
					id: finLancamentoReceberDrift.finDocumentoOrigem?.id,
					codigo: finLancamentoReceberDrift.finDocumentoOrigem?.codigo,
					sigla: finLancamentoReceberDrift.finDocumentoOrigem?.sigla,
					descricao: finLancamentoReceberDrift.finDocumentoOrigem?.descricao,
				),
				bancoContaCaixaModel: BancoContaCaixaModel(
					id: finLancamentoReceberDrift.bancoContaCaixa?.id,
					idBancoAgencia: finLancamentoReceberDrift.bancoContaCaixa?.idBancoAgencia,
					numero: finLancamentoReceberDrift.bancoContaCaixa?.numero,
					digito: finLancamentoReceberDrift.bancoContaCaixa?.digito,
					nome: finLancamentoReceberDrift.bancoContaCaixa?.nome,
					tipo: finLancamentoReceberDrift.bancoContaCaixa?.tipo,
					descricao: finLancamentoReceberDrift.bancoContaCaixa?.descricao,
				),
				finNaturezaFinanceiraModel: FinNaturezaFinanceiraModel(
					id: finLancamentoReceberDrift.finNaturezaFinanceira?.id,
					codigo: finLancamentoReceberDrift.finNaturezaFinanceira?.codigo,
					tipo: finLancamentoReceberDrift.finNaturezaFinanceira?.tipo,
					descricao: finLancamentoReceberDrift.finNaturezaFinanceira?.descricao,
					aplicacao: finLancamentoReceberDrift.finNaturezaFinanceira?.aplicacao,
				),
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: finLancamentoReceberDrift.viewPessoaCliente?.id,
					nome: finLancamentoReceberDrift.viewPessoaCliente?.nome,
					tipo: finLancamentoReceberDrift.viewPessoaCliente?.tipo,
					email: finLancamentoReceberDrift.viewPessoaCliente?.email,
					site: finLancamentoReceberDrift.viewPessoaCliente?.site,
					cpfCnpj: finLancamentoReceberDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: finLancamentoReceberDrift.viewPessoaCliente?.rgIe,
					desde: finLancamentoReceberDrift.viewPessoaCliente?.desde,
					taxaDesconto: finLancamentoReceberDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: finLancamentoReceberDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: finLancamentoReceberDrift.viewPessoaCliente?.dataCadastro,
					observacao: finLancamentoReceberDrift.viewPessoaCliente?.observacao,
					idPessoa: finLancamentoReceberDrift.viewPessoaCliente?.idPessoa,
				),
			);
		} else {
			return null;
		}
	}

	List<FinParcelaReceberModel> finParcelaReceberDriftToModel(List<FinParcelaReceberGrouped>? finParcelaReceberDriftList) { 
		List<FinParcelaReceberModel> finParcelaReceberModelList = [];
		if (finParcelaReceberDriftList != null) {
			for (var finParcelaReceberGrouped in finParcelaReceberDriftList) {
				finParcelaReceberModelList.add(
					FinParcelaReceberModel(
						id: finParcelaReceberGrouped.finParcelaReceber?.id,
						idFinLancamentoReceber: finParcelaReceberGrouped.finParcelaReceber?.idFinLancamentoReceber,
						idFinChequeRecebido: finParcelaReceberGrouped.finParcelaReceber?.idFinChequeRecebido,
						idFinStatusParcela: finParcelaReceberGrouped.finParcelaReceber?.idFinStatusParcela,
						finStatusParcelaModel: FinStatusParcelaModel(
							id: finParcelaReceberGrouped.finStatusParcela?.id,
							situacao: finParcelaReceberGrouped.finStatusParcela?.situacao,
							descricao: finParcelaReceberGrouped.finStatusParcela?.descricao,
							procedimento: finParcelaReceberGrouped.finStatusParcela?.procedimento,
						),
						idFinTipoRecebimento: finParcelaReceberGrouped.finParcelaReceber?.idFinTipoRecebimento,
						finTipoRecebimentoModel: FinTipoRecebimentoModel(
							id: finParcelaReceberGrouped.finTipoRecebimento?.id,
							codigo: finParcelaReceberGrouped.finTipoRecebimento?.codigo,
							descricao: finParcelaReceberGrouped.finTipoRecebimento?.descricao,
						),
						numeroParcela: finParcelaReceberGrouped.finParcelaReceber?.numeroParcela,
						dataEmissao: finParcelaReceberGrouped.finParcelaReceber?.dataEmissao,
						dataVencimento: finParcelaReceberGrouped.finParcelaReceber?.dataVencimento,
						dataRecebimento: finParcelaReceberGrouped.finParcelaReceber?.dataRecebimento,
						descontoAte: finParcelaReceberGrouped.finParcelaReceber?.descontoAte,
						valor: finParcelaReceberGrouped.finParcelaReceber?.valor,
						taxaJuro: finParcelaReceberGrouped.finParcelaReceber?.taxaJuro,
						taxaMulta: finParcelaReceberGrouped.finParcelaReceber?.taxaMulta,
						taxaDesconto: finParcelaReceberGrouped.finParcelaReceber?.taxaDesconto,
						valorJuro: finParcelaReceberGrouped.finParcelaReceber?.valorJuro,
						valorMulta: finParcelaReceberGrouped.finParcelaReceber?.valorMulta,
						valorDesconto: finParcelaReceberGrouped.finParcelaReceber?.valorDesconto,
						emitiuBoleto: FinParcelaReceberDomain.getEmitiuBoleto(finParcelaReceberGrouped.finParcelaReceber?.emitiuBoleto),
						boletoNossoNumero: finParcelaReceberGrouped.finParcelaReceber?.boletoNossoNumero,
						valorRecebido: finParcelaReceberGrouped.finParcelaReceber?.valorRecebido,
						historico: finParcelaReceberGrouped.finParcelaReceber?.historico,
					)
				);
			}
			return finParcelaReceberModelList;
		}
		return [];
	}


	FinLancamentoReceberGrouped toDrift(FinLancamentoReceberModel finLancamentoReceberModel) {
		return FinLancamentoReceberGrouped(
			finLancamentoReceber: FinLancamentoReceber(
				id: finLancamentoReceberModel.id,
				idCliente: finLancamentoReceberModel.idCliente,
				idBancoContaCaixa: finLancamentoReceberModel.idBancoContaCaixa,
				idFinDocumentoOrigem: finLancamentoReceberModel.idFinDocumentoOrigem,
				idFinNaturezaFinanceira: finLancamentoReceberModel.idFinNaturezaFinanceira,
				quantidadeParcela: finLancamentoReceberModel.quantidadeParcela,
				valorAReceber: finLancamentoReceberModel.valorAReceber,
				dataLancamento: finLancamentoReceberModel.dataLancamento,
				numeroDocumento: finLancamentoReceberModel.numeroDocumento,
				primeiroVencimento: finLancamentoReceberModel.primeiroVencimento,
				taxaComissao: finLancamentoReceberModel.taxaComissao,
				valorComissao: finLancamentoReceberModel.valorComissao,
				intervaloEntreParcelas: finLancamentoReceberModel.intervaloEntreParcelas,
				diaFixo: finLancamentoReceberModel.diaFixo,
			),
			finParcelaReceberGroupedList: finParcelaReceberModelToDrift(finLancamentoReceberModel.finParcelaReceberModelList),
		);
	}

	List<FinParcelaReceberGrouped> finParcelaReceberModelToDrift(List<FinParcelaReceberModel>? finParcelaReceberModelList) { 
		List<FinParcelaReceberGrouped> finParcelaReceberGroupedList = [];
		if (finParcelaReceberModelList != null) {
			for (var finParcelaReceberModel in finParcelaReceberModelList) {
				finParcelaReceberGroupedList.add(
					FinParcelaReceberGrouped(
						finParcelaReceber: FinParcelaReceber(
							id: finParcelaReceberModel.id,
							idFinLancamentoReceber: finParcelaReceberModel.idFinLancamentoReceber,
							idFinChequeRecebido: finParcelaReceberModel.idFinChequeRecebido,
							idFinStatusParcela: finParcelaReceberModel.idFinStatusParcela,
							idFinTipoRecebimento: finParcelaReceberModel.idFinTipoRecebimento,
							numeroParcela: finParcelaReceberModel.numeroParcela,
							dataEmissao: finParcelaReceberModel.dataEmissao,
							dataVencimento: finParcelaReceberModel.dataVencimento,
							dataRecebimento: finParcelaReceberModel.dataRecebimento,
							descontoAte: finParcelaReceberModel.descontoAte,
							valor: finParcelaReceberModel.valor,
							taxaJuro: finParcelaReceberModel.taxaJuro,
							taxaMulta: finParcelaReceberModel.taxaMulta,
							taxaDesconto: finParcelaReceberModel.taxaDesconto,
							valorJuro: finParcelaReceberModel.valorJuro,
							valorMulta: finParcelaReceberModel.valorMulta,
							valorDesconto: finParcelaReceberModel.valorDesconto,
							emitiuBoleto: FinParcelaReceberDomain.setEmitiuBoleto(finParcelaReceberModel.emitiuBoleto),
							boletoNossoNumero: finParcelaReceberModel.boletoNossoNumero,
							valorRecebido: finParcelaReceberModel.valorRecebido,
							historico: finParcelaReceberModel.historico,
						),
					),
				);
			}
			return finParcelaReceberGroupedList;
		}
		return [];
	}

		
}
