import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalSaidaDriftProvider extends ProviderBase {

	Future<List<FiscalNotaFiscalSaidaModel>?> getList({Filter? filter}) async {
		List<FiscalNotaFiscalSaidaGrouped> fiscalNotaFiscalSaidaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalNotaFiscalSaidaDriftList = await Session.database.fiscalNotaFiscalSaidaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalNotaFiscalSaidaDriftList = await Session.database.fiscalNotaFiscalSaidaDao.getGroupedList(); 
			}
			if (fiscalNotaFiscalSaidaDriftList.isNotEmpty) {
				return toListModel(fiscalNotaFiscalSaidaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalNotaFiscalSaidaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalNotaFiscalSaidaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalNotaFiscalSaidaModel?>? insert(FiscalNotaFiscalSaidaModel fiscalNotaFiscalSaidaModel) async {
		try {
			final lastPk = await Session.database.fiscalNotaFiscalSaidaDao.insertObject(toDrift(fiscalNotaFiscalSaidaModel));
			fiscalNotaFiscalSaidaModel.id = lastPk;
			return fiscalNotaFiscalSaidaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalNotaFiscalSaidaModel?>? update(FiscalNotaFiscalSaidaModel fiscalNotaFiscalSaidaModel) async {
		try {
			await Session.database.fiscalNotaFiscalSaidaDao.updateObject(toDrift(fiscalNotaFiscalSaidaModel));
			return fiscalNotaFiscalSaidaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalNotaFiscalSaidaDao.deleteObject(toDrift(FiscalNotaFiscalSaidaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalNotaFiscalSaidaModel> toListModel(List<FiscalNotaFiscalSaidaGrouped> fiscalNotaFiscalSaidaDriftList) {
		List<FiscalNotaFiscalSaidaModel> listModel = [];
		for (var fiscalNotaFiscalSaidaDrift in fiscalNotaFiscalSaidaDriftList) {
			listModel.add(toModel(fiscalNotaFiscalSaidaDrift)!);
		}
		return listModel;
	}	

	FiscalNotaFiscalSaidaModel? toModel(FiscalNotaFiscalSaidaGrouped? fiscalNotaFiscalSaidaDrift) {
		if (fiscalNotaFiscalSaidaDrift != null) {
			return FiscalNotaFiscalSaidaModel(
				id: fiscalNotaFiscalSaidaDrift.fiscalNotaFiscalSaida?.id,
				idNfeCabecalho: fiscalNotaFiscalSaidaDrift.fiscalNotaFiscalSaida?.idNfeCabecalho,
				competencia: fiscalNotaFiscalSaidaDrift.fiscalNotaFiscalSaida?.competencia,
				nfeCabecalhoModel: NfeCabecalhoModel(
					id: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.id,
					idVendedor: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.idVendedor,
					ufEmitente: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.ufEmitente,
					codigoNumerico: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.codigoNumerico,
					naturezaOperacao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.naturezaOperacao,
					codigoModelo: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.codigoModelo,
					serie: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.serie,
					numero: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.numero,
					dataHoraEmissao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.dataHoraEmissao,
					dataHoraEntradaSaida: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.dataHoraEntradaSaida,
					tipoOperacao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.tipoOperacao,
					localDestino: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.localDestino,
					codigoMunicipio: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.codigoMunicipio,
					formatoImpressaoDanfe: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.formatoImpressaoDanfe,
					tipoEmissao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.tipoEmissao,
					chaveAcesso: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.chaveAcesso,
					digitoChaveAcesso: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.digitoChaveAcesso,
					ambiente: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.ambiente,
					finalidadeEmissao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.finalidadeEmissao,
					consumidorOperacao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.consumidorOperacao,
					consumidorPresenca: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.consumidorPresenca,
					processoEmissao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.processoEmissao,
					versaoProcessoEmissao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.versaoProcessoEmissao,
					dataEntradaContingencia: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.dataEntradaContingencia,
					justificativaContingencia: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.justificativaContingencia,
					baseCalculoIcms: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.baseCalculoIcms,
					valorIcms: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorIcms,
					valorIcmsDesonerado: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorIcmsDesonerado,
					totalIcmsFcpUfDestino: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.totalIcmsFcpUfDestino,
					totalIcmsInterestadualUfDestino: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.totalIcmsInterestadualUfDestino,
					totalIcmsInterestadualUfRemetente: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.totalIcmsInterestadualUfRemetente,
					valorTotalFcp: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorTotalFcp,
					baseCalculoIcmsSt: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.baseCalculoIcmsSt,
					valorIcmsSt: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorIcmsSt,
					valorTotalFcpSt: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorTotalFcpSt,
					valorTotalFcpStRetido: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorTotalFcpStRetido,
					valorTotalProdutos: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorTotalProdutos,
					valorFrete: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorFrete,
					valorSeguro: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorSeguro,
					valorDesconto: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorDesconto,
					valorImpostoImportacao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorImpostoImportacao,
					valorIpi: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorIpi,
					valorIpiDevolvido: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorIpiDevolvido,
					valorPis: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorPis,
					valorCofins: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorCofins,
					valorDespesasAcessorias: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorDespesasAcessorias,
					valorTotal: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorTotal,
					valorTotalTributos: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorTotalTributos,
					valorServicos: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorServicos,
					baseCalculoIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.baseCalculoIssqn,
					valorIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorIssqn,
					valorPisIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorPisIssqn,
					valorCofinsIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorCofinsIssqn,
					dataPrestacaoServico: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.dataPrestacaoServico,
					valorDeducaoIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorDeducaoIssqn,
					outrasRetencoesIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.outrasRetencoesIssqn,
					descontoIncondicionadoIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.descontoIncondicionadoIssqn,
					descontoCondicionadoIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.descontoCondicionadoIssqn,
					totalRetencaoIssqn: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.totalRetencaoIssqn,
					regimeEspecialTributacao: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.regimeEspecialTributacao,
					valorRetidoPis: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorRetidoPis,
					valorRetidoCofins: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorRetidoCofins,
					valorRetidoCsll: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorRetidoCsll,
					baseCalculoIrrf: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.baseCalculoIrrf,
					valorRetidoIrrf: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorRetidoIrrf,
					baseCalculoPrevidencia: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.baseCalculoPrevidencia,
					valorRetidoPrevidencia: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.valorRetidoPrevidencia,
					informacoesAddFisco: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.informacoesAddFisco,
					informacoesAddContribuinte: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.informacoesAddContribuinte,
					comexUfEmbarque: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.comexUfEmbarque,
					comexLocalEmbarque: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.comexLocalEmbarque,
					comexLocalDespacho: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.comexLocalDespacho,
					compraNotaEmpenho: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.compraNotaEmpenho,
					compraPedido: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.compraPedido,
					compraContrato: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.compraContrato,
					qrcode: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.qrcode,
					urlChave: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.urlChave,
					statusNota: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.statusNota,
					idFornecedor: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.idFornecedor,
					idNfceMovimento: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.idNfceMovimento,
					idVendaCabecalho: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.idVendaCabecalho,
					idTributOperacaoFiscal: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.idTributOperacaoFiscal,
					idCliente: fiscalNotaFiscalSaidaDrift.nfeCabecalho?.idCliente,
				),
			);
		} else {
			return null;
		}
	}


	FiscalNotaFiscalSaidaGrouped toDrift(FiscalNotaFiscalSaidaModel fiscalNotaFiscalSaidaModel) {
		return FiscalNotaFiscalSaidaGrouped(
			fiscalNotaFiscalSaida: FiscalNotaFiscalSaida(
				id: fiscalNotaFiscalSaidaModel.id,
				idNfeCabecalho: fiscalNotaFiscalSaidaModel.idNfeCabecalho,
				competencia: Util.removeMask(fiscalNotaFiscalSaidaModel.competencia),
			),
		);
	}

		
}
