import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalEntradaDriftProvider extends ProviderBase {

	Future<List<FiscalNotaFiscalEntradaModel>?> getList({Filter? filter}) async {
		List<FiscalNotaFiscalEntradaGrouped> fiscalNotaFiscalEntradaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalNotaFiscalEntradaDriftList = await Session.database.fiscalNotaFiscalEntradaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalNotaFiscalEntradaDriftList = await Session.database.fiscalNotaFiscalEntradaDao.getGroupedList(); 
			}
			if (fiscalNotaFiscalEntradaDriftList.isNotEmpty) {
				return toListModel(fiscalNotaFiscalEntradaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalNotaFiscalEntradaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalNotaFiscalEntradaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalNotaFiscalEntradaModel?>? insert(FiscalNotaFiscalEntradaModel fiscalNotaFiscalEntradaModel) async {
		try {
			final lastPk = await Session.database.fiscalNotaFiscalEntradaDao.insertObject(toDrift(fiscalNotaFiscalEntradaModel));
			fiscalNotaFiscalEntradaModel.id = lastPk;
			return fiscalNotaFiscalEntradaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalNotaFiscalEntradaModel?>? update(FiscalNotaFiscalEntradaModel fiscalNotaFiscalEntradaModel) async {
		try {
			await Session.database.fiscalNotaFiscalEntradaDao.updateObject(toDrift(fiscalNotaFiscalEntradaModel));
			return fiscalNotaFiscalEntradaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalNotaFiscalEntradaDao.deleteObject(toDrift(FiscalNotaFiscalEntradaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalNotaFiscalEntradaModel> toListModel(List<FiscalNotaFiscalEntradaGrouped> fiscalNotaFiscalEntradaDriftList) {
		List<FiscalNotaFiscalEntradaModel> listModel = [];
		for (var fiscalNotaFiscalEntradaDrift in fiscalNotaFiscalEntradaDriftList) {
			listModel.add(toModel(fiscalNotaFiscalEntradaDrift)!);
		}
		return listModel;
	}	

	FiscalNotaFiscalEntradaModel? toModel(FiscalNotaFiscalEntradaGrouped? fiscalNotaFiscalEntradaDrift) {
		if (fiscalNotaFiscalEntradaDrift != null) {
			return FiscalNotaFiscalEntradaModel(
				id: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.id,
				idNfeCabecalho: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.idNfeCabecalho,
				competencia: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.competencia,
				cfopEntrada: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.cfopEntrada,
				valorRateioFrete: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorRateioFrete,
				valorCustoMedio: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorCustoMedio,
				valorIcmsAntecipado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorIcmsAntecipado,
				valorBcIcmsAntecipado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorBcIcmsAntecipado,
				valorBcIcmsCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorBcIcmsCreditado,
				valorBcPisCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorBcPisCreditado,
				valorBcCofinsCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorBcCofinsCreditado,
				valorBcIpiCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorBcIpiCreditado,
				cstCreditoIcms: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.cstCreditoIcms,
				cstCreditoPis: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.cstCreditoPis,
				cstCreditoCofins: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.cstCreditoCofins,
				cstCreditoIpi: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.cstCreditoIpi,
				valorIcmsCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorIcmsCreditado,
				valorPisCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorPisCreditado,
				valorCofinsCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorCofinsCreditado,
				valorIpiCreditado: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.valorIpiCreditado,
				qtdeParcelaCreditoPis: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.qtdeParcelaCreditoPis,
				qtdeParcelaCreditoCofins: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.qtdeParcelaCreditoCofins,
				qtdeParcelaCreditoIcms: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.qtdeParcelaCreditoIcms,
				qtdeParcelaCreditoIpi: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.qtdeParcelaCreditoIpi,
				aliquotaCreditoIcms: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.aliquotaCreditoIcms,
				aliquotaCreditoPis: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.aliquotaCreditoPis,
				aliquotaCreditoCofins: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.aliquotaCreditoCofins,
				aliquotaCreditoIpi: fiscalNotaFiscalEntradaDrift.fiscalNotaFiscalEntrada?.aliquotaCreditoIpi,
				nfeCabecalhoModel: NfeCabecalhoModel(
					id: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.id,
					idVendedor: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.idVendedor,
					ufEmitente: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.ufEmitente,
					codigoNumerico: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.codigoNumerico,
					naturezaOperacao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.naturezaOperacao,
					codigoModelo: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.codigoModelo,
					serie: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.serie,
					numero: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.numero,
					dataHoraEmissao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.dataHoraEmissao,
					dataHoraEntradaSaida: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.dataHoraEntradaSaida,
					tipoOperacao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.tipoOperacao,
					localDestino: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.localDestino,
					codigoMunicipio: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.codigoMunicipio,
					formatoImpressaoDanfe: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.formatoImpressaoDanfe,
					tipoEmissao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.tipoEmissao,
					chaveAcesso: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.chaveAcesso,
					digitoChaveAcesso: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.digitoChaveAcesso,
					ambiente: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.ambiente,
					finalidadeEmissao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.finalidadeEmissao,
					consumidorOperacao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.consumidorOperacao,
					consumidorPresenca: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.consumidorPresenca,
					processoEmissao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.processoEmissao,
					versaoProcessoEmissao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.versaoProcessoEmissao,
					dataEntradaContingencia: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.dataEntradaContingencia,
					justificativaContingencia: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.justificativaContingencia,
					baseCalculoIcms: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.baseCalculoIcms,
					valorIcms: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorIcms,
					valorIcmsDesonerado: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorIcmsDesonerado,
					totalIcmsFcpUfDestino: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.totalIcmsFcpUfDestino,
					totalIcmsInterestadualUfDestino: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.totalIcmsInterestadualUfDestino,
					totalIcmsInterestadualUfRemetente: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.totalIcmsInterestadualUfRemetente,
					valorTotalFcp: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorTotalFcp,
					baseCalculoIcmsSt: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.baseCalculoIcmsSt,
					valorIcmsSt: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorIcmsSt,
					valorTotalFcpSt: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorTotalFcpSt,
					valorTotalFcpStRetido: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorTotalFcpStRetido,
					valorTotalProdutos: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorTotalProdutos,
					valorFrete: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorFrete,
					valorSeguro: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorSeguro,
					valorDesconto: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorDesconto,
					valorImpostoImportacao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorImpostoImportacao,
					valorIpi: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorIpi,
					valorIpiDevolvido: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorIpiDevolvido,
					valorPis: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorPis,
					valorCofins: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorCofins,
					valorDespesasAcessorias: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorDespesasAcessorias,
					valorTotal: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorTotal,
					valorTotalTributos: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorTotalTributos,
					valorServicos: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorServicos,
					baseCalculoIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.baseCalculoIssqn,
					valorIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorIssqn,
					valorPisIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorPisIssqn,
					valorCofinsIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorCofinsIssqn,
					dataPrestacaoServico: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.dataPrestacaoServico,
					valorDeducaoIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorDeducaoIssqn,
					outrasRetencoesIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.outrasRetencoesIssqn,
					descontoIncondicionadoIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.descontoIncondicionadoIssqn,
					descontoCondicionadoIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.descontoCondicionadoIssqn,
					totalRetencaoIssqn: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.totalRetencaoIssqn,
					regimeEspecialTributacao: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.regimeEspecialTributacao,
					valorRetidoPis: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorRetidoPis,
					valorRetidoCofins: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorRetidoCofins,
					valorRetidoCsll: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorRetidoCsll,
					baseCalculoIrrf: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.baseCalculoIrrf,
					valorRetidoIrrf: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorRetidoIrrf,
					baseCalculoPrevidencia: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.baseCalculoPrevidencia,
					valorRetidoPrevidencia: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.valorRetidoPrevidencia,
					informacoesAddFisco: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.informacoesAddFisco,
					informacoesAddContribuinte: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.informacoesAddContribuinte,
					comexUfEmbarque: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.comexUfEmbarque,
					comexLocalEmbarque: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.comexLocalEmbarque,
					comexLocalDespacho: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.comexLocalDespacho,
					compraNotaEmpenho: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.compraNotaEmpenho,
					compraPedido: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.compraPedido,
					compraContrato: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.compraContrato,
					qrcode: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.qrcode,
					urlChave: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.urlChave,
					statusNota: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.statusNota,
					idFornecedor: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.idFornecedor,
					idNfceMovimento: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.idNfceMovimento,
					idVendaCabecalho: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.idVendaCabecalho,
					idTributOperacaoFiscal: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.idTributOperacaoFiscal,
					idCliente: fiscalNotaFiscalEntradaDrift.nfeCabecalho?.idCliente,
				),
			);
		} else {
			return null;
		}
	}


	FiscalNotaFiscalEntradaGrouped toDrift(FiscalNotaFiscalEntradaModel fiscalNotaFiscalEntradaModel) {
		return FiscalNotaFiscalEntradaGrouped(
			fiscalNotaFiscalEntrada: FiscalNotaFiscalEntrada(
				id: fiscalNotaFiscalEntradaModel.id,
				idNfeCabecalho: fiscalNotaFiscalEntradaModel.idNfeCabecalho,
				competencia: Util.removeMask(fiscalNotaFiscalEntradaModel.competencia),
				cfopEntrada: fiscalNotaFiscalEntradaModel.cfopEntrada,
				valorRateioFrete: fiscalNotaFiscalEntradaModel.valorRateioFrete,
				valorCustoMedio: fiscalNotaFiscalEntradaModel.valorCustoMedio,
				valorIcmsAntecipado: fiscalNotaFiscalEntradaModel.valorIcmsAntecipado,
				valorBcIcmsAntecipado: fiscalNotaFiscalEntradaModel.valorBcIcmsAntecipado,
				valorBcIcmsCreditado: fiscalNotaFiscalEntradaModel.valorBcIcmsCreditado,
				valorBcPisCreditado: fiscalNotaFiscalEntradaModel.valorBcPisCreditado,
				valorBcCofinsCreditado: fiscalNotaFiscalEntradaModel.valorBcCofinsCreditado,
				valorBcIpiCreditado: fiscalNotaFiscalEntradaModel.valorBcIpiCreditado,
				cstCreditoIcms: fiscalNotaFiscalEntradaModel.cstCreditoIcms,
				cstCreditoPis: fiscalNotaFiscalEntradaModel.cstCreditoPis,
				cstCreditoCofins: fiscalNotaFiscalEntradaModel.cstCreditoCofins,
				cstCreditoIpi: fiscalNotaFiscalEntradaModel.cstCreditoIpi,
				valorIcmsCreditado: fiscalNotaFiscalEntradaModel.valorIcmsCreditado,
				valorPisCreditado: fiscalNotaFiscalEntradaModel.valorPisCreditado,
				valorCofinsCreditado: fiscalNotaFiscalEntradaModel.valorCofinsCreditado,
				valorIpiCreditado: fiscalNotaFiscalEntradaModel.valorIpiCreditado,
				qtdeParcelaCreditoPis: fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoPis,
				qtdeParcelaCreditoCofins: fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoCofins,
				qtdeParcelaCreditoIcms: fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoIcms,
				qtdeParcelaCreditoIpi: fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoIpi,
				aliquotaCreditoIcms: fiscalNotaFiscalEntradaModel.aliquotaCreditoIcms,
				aliquotaCreditoPis: fiscalNotaFiscalEntradaModel.aliquotaCreditoPis,
				aliquotaCreditoCofins: fiscalNotaFiscalEntradaModel.aliquotaCreditoCofins,
				aliquotaCreditoIpi: fiscalNotaFiscalEntradaModel.aliquotaCreditoIpi,
			),
		);
	}

		
}
