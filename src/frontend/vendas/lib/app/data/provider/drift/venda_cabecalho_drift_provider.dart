import 'package:vendas/app/data/provider/drift/database/database_imports.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/provider/provider_base.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaCabecalhoDriftProvider extends ProviderBase {

	Future<List<VendaCabecalhoModel>?> getList({Filter? filter}) async {
		List<VendaCabecalhoGrouped> vendaCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				vendaCabecalhoDriftList = await Session.database.vendaCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				vendaCabecalhoDriftList = await Session.database.vendaCabecalhoDao.getGroupedList(); 
			}
			if (vendaCabecalhoDriftList.isNotEmpty) {
				return toListModel(vendaCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<VendaCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.vendaCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCabecalhoModel?>? insert(VendaCabecalhoModel vendaCabecalhoModel) async {
		try {
			final lastPk = await Session.database.vendaCabecalhoDao.insertObject(toDrift(vendaCabecalhoModel));
			vendaCabecalhoModel.id = lastPk;
			return vendaCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaCabecalhoModel?>? update(VendaCabecalhoModel vendaCabecalhoModel) async {
		try {
			await Session.database.vendaCabecalhoDao.updateObject(toDrift(vendaCabecalhoModel));
			return vendaCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.vendaCabecalhoDao.deleteObject(toDrift(VendaCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<VendaCabecalhoModel> toListModel(List<VendaCabecalhoGrouped> vendaCabecalhoDriftList) {
		List<VendaCabecalhoModel> listModel = [];
		for (var vendaCabecalhoDrift in vendaCabecalhoDriftList) {
			listModel.add(toModel(vendaCabecalhoDrift)!);
		}
		return listModel;
	}	

	VendaCabecalhoModel? toModel(VendaCabecalhoGrouped? vendaCabecalhoDrift) {
		if (vendaCabecalhoDrift != null) {
			return VendaCabecalhoModel(
				id: vendaCabecalhoDrift.vendaCabecalho?.id,
				idVendaOrcamentoCabecalho: vendaCabecalhoDrift.vendaCabecalho?.idVendaOrcamentoCabecalho,
				idNotaFiscalTipo: vendaCabecalhoDrift.vendaCabecalho?.idNotaFiscalTipo,
				idVendedor: vendaCabecalhoDrift.vendaCabecalho?.idVendedor,
				idVendaCondicoesPagamento: vendaCabecalhoDrift.vendaCabecalho?.idVendaCondicoesPagamento,
				idTransportadora: vendaCabecalhoDrift.vendaCabecalho?.idTransportadora,
				idCliente: vendaCabecalhoDrift.vendaCabecalho?.idCliente,
				localEntrega: vendaCabecalhoDrift.vendaCabecalho?.localEntrega,
				localCobranca: vendaCabecalhoDrift.vendaCabecalho?.localCobranca,
				tipoFrete: VendaCabecalhoDomain.getTipoFrete(vendaCabecalhoDrift.vendaCabecalho?.tipoFrete),
				formaPagamento: VendaCabecalhoDomain.getFormaPagamento(vendaCabecalhoDrift.vendaCabecalho?.formaPagamento),
				dataVenda: vendaCabecalhoDrift.vendaCabecalho?.dataVenda,
				dataSaida: vendaCabecalhoDrift.vendaCabecalho?.dataSaida,
				horaSaida: vendaCabecalhoDrift.vendaCabecalho?.horaSaida,
				numeroFatura: vendaCabecalhoDrift.vendaCabecalho?.numeroFatura,
				valorFrete: vendaCabecalhoDrift.vendaCabecalho?.valorFrete,
				valorSeguro: vendaCabecalhoDrift.vendaCabecalho?.valorSeguro,
				valorSubtotal: vendaCabecalhoDrift.vendaCabecalho?.valorSubtotal,
				taxaComissao: vendaCabecalhoDrift.vendaCabecalho?.taxaComissao,
				valorComissao: vendaCabecalhoDrift.vendaCabecalho?.valorComissao,
				taxaDesconto: vendaCabecalhoDrift.vendaCabecalho?.taxaDesconto,
				valorDesconto: vendaCabecalhoDrift.vendaCabecalho?.valorDesconto,
				valorTotal: vendaCabecalhoDrift.vendaCabecalho?.valorTotal,
				situacao: VendaCabecalhoDomain.getSituacao(vendaCabecalhoDrift.vendaCabecalho?.situacao),
				diaFixoParcela: vendaCabecalhoDrift.vendaCabecalho?.diaFixoParcela,
				observacao: vendaCabecalhoDrift.vendaCabecalho?.observacao,
				vendaComissaoModel: VendaComissaoModel(
					id: vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.id,
					idVendaCabecalho: vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.idVendaCabecalho,
					idVendedor: vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.idVendedor,
					valorVenda: vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.valorVenda,
					tipoContabil: VendaComissaoDomain.getTipoContabil(vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.tipoContabil),
					valorComissao: vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.valorComissao,
					situacao: VendaComissaoDomain.getSituacao(vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.situacao),
					dataLancamento: vendaCabecalhoDrift.vendaComissaoGrouped?.vendaComissao?.dataLancamento,
					viewPessoaVendedorModel: ViewPessoaVendedorModel(
						id: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.id,
						nome: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.nome,
						tipo: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.tipo,
						email: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.email,
						site: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.site,
						cpfCnpj: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.cpfCnpj,
						rgIe: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.rgIe,
						matricula: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.matricula,
						dataCadastro: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.dataCadastro,
						dataAdmissao: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.dataAdmissao,
						dataDemissao: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.dataDemissao,
						ctpsNumero: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.ctpsNumero,
						ctpsSerie: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.ctpsSerie,
						ctpsDataExpedicao: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.ctpsDataExpedicao,
						ctpsUf: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.ctpsUf,
						observacao: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.observacao,
						logradouro: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.logradouro,
						numero: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.numero,
						complemento: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.complemento,
						bairro: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.bairro,
						cidade: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.cidade,
						cep: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.cep,
						municipioIbge: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.municipioIbge,
						uf: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.uf,
						idPessoa: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.idPessoa,
						idCargo: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.idCargo,
						idSetor: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.idSetor,
						comissao: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.comissao,
						metaVenda: vendaCabecalhoDrift.vendaComissaoGrouped?.viewPessoaVendedor?.metaVenda,
					),
				),
				vendaDetalheModelList: vendaDetalheDriftToModel(vendaCabecalhoDrift.vendaDetalheGroupedList),
				vendaFreteModelList: vendaFreteDriftToModel(vendaCabecalhoDrift.vendaFreteGroupedList),
				vendaCondicoesPagamentoModel: VendaCondicoesPagamentoModel(
					id: vendaCabecalhoDrift.vendaCondicoesPagamento?.id,
					nome: vendaCabecalhoDrift.vendaCondicoesPagamento?.nome,
					descricao: vendaCabecalhoDrift.vendaCondicoesPagamento?.descricao,
					faturamentoMinimo: vendaCabecalhoDrift.vendaCondicoesPagamento?.faturamentoMinimo,
					faturamentoMaximo: vendaCabecalhoDrift.vendaCondicoesPagamento?.faturamentoMaximo,
					indiceCorrecao: vendaCabecalhoDrift.vendaCondicoesPagamento?.indiceCorrecao,
					diasTolerancia: vendaCabecalhoDrift.vendaCondicoesPagamento?.diasTolerancia,
					valorTolerancia: vendaCabecalhoDrift.vendaCondicoesPagamento?.valorTolerancia,
					prazoMedio: vendaCabecalhoDrift.vendaCondicoesPagamento?.prazoMedio,
					vistaPrazo: vendaCabecalhoDrift.vendaCondicoesPagamento?.vistaPrazo,
				),
				viewPessoaVendedorModel: ViewPessoaVendedorModel(
					id: vendaCabecalhoDrift.viewPessoaVendedor?.id,
					nome: vendaCabecalhoDrift.viewPessoaVendedor?.nome,
					tipo: vendaCabecalhoDrift.viewPessoaVendedor?.tipo,
					email: vendaCabecalhoDrift.viewPessoaVendedor?.email,
					site: vendaCabecalhoDrift.viewPessoaVendedor?.site,
					cpfCnpj: vendaCabecalhoDrift.viewPessoaVendedor?.cpfCnpj,
					rgIe: vendaCabecalhoDrift.viewPessoaVendedor?.rgIe,
					matricula: vendaCabecalhoDrift.viewPessoaVendedor?.matricula,
					dataCadastro: vendaCabecalhoDrift.viewPessoaVendedor?.dataCadastro,
					dataAdmissao: vendaCabecalhoDrift.viewPessoaVendedor?.dataAdmissao,
					dataDemissao: vendaCabecalhoDrift.viewPessoaVendedor?.dataDemissao,
					ctpsNumero: vendaCabecalhoDrift.viewPessoaVendedor?.ctpsNumero,
					ctpsSerie: vendaCabecalhoDrift.viewPessoaVendedor?.ctpsSerie,
					ctpsDataExpedicao: vendaCabecalhoDrift.viewPessoaVendedor?.ctpsDataExpedicao,
					ctpsUf: vendaCabecalhoDrift.viewPessoaVendedor?.ctpsUf,
					observacao: vendaCabecalhoDrift.viewPessoaVendedor?.observacao,
					logradouro: vendaCabecalhoDrift.viewPessoaVendedor?.logradouro,
					numero: vendaCabecalhoDrift.viewPessoaVendedor?.numero,
					complemento: vendaCabecalhoDrift.viewPessoaVendedor?.complemento,
					bairro: vendaCabecalhoDrift.viewPessoaVendedor?.bairro,
					cidade: vendaCabecalhoDrift.viewPessoaVendedor?.cidade,
					cep: vendaCabecalhoDrift.viewPessoaVendedor?.cep,
					municipioIbge: vendaCabecalhoDrift.viewPessoaVendedor?.municipioIbge,
					uf: vendaCabecalhoDrift.viewPessoaVendedor?.uf,
					idPessoa: vendaCabecalhoDrift.viewPessoaVendedor?.idPessoa,
					idCargo: vendaCabecalhoDrift.viewPessoaVendedor?.idCargo,
					idSetor: vendaCabecalhoDrift.viewPessoaVendedor?.idSetor,
					comissao: vendaCabecalhoDrift.viewPessoaVendedor?.comissao,
					metaVenda: vendaCabecalhoDrift.viewPessoaVendedor?.metaVenda,
				),
				viewPessoaTransportadoraModel: ViewPessoaTransportadoraModel(
					id: vendaCabecalhoDrift.viewPessoaTransportadora?.id,
					nome: vendaCabecalhoDrift.viewPessoaTransportadora?.nome,
					tipo: vendaCabecalhoDrift.viewPessoaTransportadora?.tipo,
					email: vendaCabecalhoDrift.viewPessoaTransportadora?.email,
					site: vendaCabecalhoDrift.viewPessoaTransportadora?.site,
					cpfCnpj: vendaCabecalhoDrift.viewPessoaTransportadora?.cpfCnpj,
					rgIe: vendaCabecalhoDrift.viewPessoaTransportadora?.rgIe,
					dataCadastro: vendaCabecalhoDrift.viewPessoaTransportadora?.dataCadastro,
					observacao: vendaCabecalhoDrift.viewPessoaTransportadora?.observacao,
					idPessoa: vendaCabecalhoDrift.viewPessoaTransportadora?.idPessoa,
				),
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: vendaCabecalhoDrift.viewPessoaCliente?.id,
					nome: vendaCabecalhoDrift.viewPessoaCliente?.nome,
					tipo: vendaCabecalhoDrift.viewPessoaCliente?.tipo,
					email: vendaCabecalhoDrift.viewPessoaCliente?.email,
					site: vendaCabecalhoDrift.viewPessoaCliente?.site,
					cpfCnpj: vendaCabecalhoDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: vendaCabecalhoDrift.viewPessoaCliente?.rgIe,
					desde: vendaCabecalhoDrift.viewPessoaCliente?.desde,
					taxaDesconto: vendaCabecalhoDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: vendaCabecalhoDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: vendaCabecalhoDrift.viewPessoaCliente?.dataCadastro,
					observacao: vendaCabecalhoDrift.viewPessoaCliente?.observacao,
					idPessoa: vendaCabecalhoDrift.viewPessoaCliente?.idPessoa,
				),
				vendaOrcamentoCabecalhoModel: VendaOrcamentoCabecalhoModel(
					id: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.id,
					idVendedor: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.idVendedor,
					idCliente: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.idCliente,
					idVendaCondicoesPagamento: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.idVendaCondicoesPagamento,
					idTransportadora: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.idTransportadora,
					tipoFrete: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.tipoFrete,
					codigo: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.codigo,
					dataCadastro: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.dataCadastro,
					dataEntrega: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.dataEntrega,
					dataValidade: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.dataValidade,
					valorSubtotal: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.valorSubtotal,
					valorFrete: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.valorFrete,
					taxaComissao: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.taxaComissao,
					valorComissao: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.valorComissao,
					taxaDesconto: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.taxaDesconto,
					valorDesconto: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.valorDesconto,
					valorTotal: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.valorTotal,
					observacao: vendaCabecalhoDrift.vendaOrcamentoCabecalho?.observacao,
				),
				notaFiscalTipoModel: NotaFiscalTipoModel(
					id: vendaCabecalhoDrift.notaFiscalTipo?.id,
					idNotaFiscalModelo: vendaCabecalhoDrift.notaFiscalTipo?.idNotaFiscalModelo,
					nome: vendaCabecalhoDrift.notaFiscalTipo?.nome,
					descricao: vendaCabecalhoDrift.notaFiscalTipo?.descricao,
					serie: vendaCabecalhoDrift.notaFiscalTipo?.serie,
					serieScan: vendaCabecalhoDrift.notaFiscalTipo?.serieScan,
					ultimoNumero: vendaCabecalhoDrift.notaFiscalTipo?.ultimoNumero,
				),
			);
		} else {
			return null;
		}
	}

	List<VendaDetalheModel> vendaDetalheDriftToModel(List<VendaDetalheGrouped>? vendaDetalheDriftList) { 
		List<VendaDetalheModel> vendaDetalheModelList = [];
		if (vendaDetalheDriftList != null) {
			for (var vendaDetalheGrouped in vendaDetalheDriftList) {
				vendaDetalheModelList.add(
					VendaDetalheModel(
						id: vendaDetalheGrouped.vendaDetalhe?.id,
						idVendaCabecalho: vendaDetalheGrouped.vendaDetalhe?.idVendaCabecalho,
						idProduto: vendaDetalheGrouped.vendaDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: vendaDetalheGrouped.produto?.id,
							idProdutoSubgrupo: vendaDetalheGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: vendaDetalheGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: vendaDetalheGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: vendaDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: vendaDetalheGrouped.produto?.idTributGrupoTributario,
							nome: vendaDetalheGrouped.produto?.nome,
							descricao: vendaDetalheGrouped.produto?.descricao,
							gtin: vendaDetalheGrouped.produto?.gtin,
							codigoInterno: vendaDetalheGrouped.produto?.codigoInterno,
							valorCompra: vendaDetalheGrouped.produto?.valorCompra,
							valorVenda: vendaDetalheGrouped.produto?.valorVenda,
							codigoNcm: vendaDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: vendaDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: vendaDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: vendaDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: vendaDetalheGrouped.produto?.dataCadastro,
						),
						quantidade: vendaDetalheGrouped.vendaDetalhe?.quantidade,
						valorUnitario: vendaDetalheGrouped.vendaDetalhe?.valorUnitario,
						valorSubtotal: vendaDetalheGrouped.vendaDetalhe?.valorSubtotal,
						taxaDesconto: vendaDetalheGrouped.vendaDetalhe?.taxaDesconto,
						valorDesconto: vendaDetalheGrouped.vendaDetalhe?.valorDesconto,
						valorTotal: vendaDetalheGrouped.vendaDetalhe?.valorTotal,
					)
				);
			}
			return vendaDetalheModelList;
		}
		return [];
	}

	List<VendaFreteModel> vendaFreteDriftToModel(List<VendaFreteGrouped>? vendaFreteDriftList) { 
		List<VendaFreteModel> vendaFreteModelList = [];
		if (vendaFreteDriftList != null) {
			for (var vendaFreteGrouped in vendaFreteDriftList) {
				vendaFreteModelList.add(
					VendaFreteModel(
						id: vendaFreteGrouped.vendaFrete?.id,
						idVendaCabecalho: vendaFreteGrouped.vendaFrete?.idVendaCabecalho,
						idTransportadora: vendaFreteGrouped.vendaFrete?.idTransportadora,
						viewPessoaTransportadoraModel: ViewPessoaTransportadoraModel(
							id: vendaFreteGrouped.viewPessoaTransportadora?.id,
							nome: vendaFreteGrouped.viewPessoaTransportadora?.nome,
							tipo: vendaFreteGrouped.viewPessoaTransportadora?.tipo,
							email: vendaFreteGrouped.viewPessoaTransportadora?.email,
							site: vendaFreteGrouped.viewPessoaTransportadora?.site,
							cpfCnpj: vendaFreteGrouped.viewPessoaTransportadora?.cpfCnpj,
							rgIe: vendaFreteGrouped.viewPessoaTransportadora?.rgIe,
							dataCadastro: vendaFreteGrouped.viewPessoaTransportadora?.dataCadastro,
							observacao: vendaFreteGrouped.viewPessoaTransportadora?.observacao,
							idPessoa: vendaFreteGrouped.viewPessoaTransportadora?.idPessoa,
						),
						responsavel: VendaFreteDomain.getResponsavel(vendaFreteGrouped.vendaFrete?.responsavel),
						conhecimento: vendaFreteGrouped.vendaFrete?.conhecimento,
						placa: vendaFreteGrouped.vendaFrete?.placa,
						ufPlaca: VendaFreteDomain.getUfPlaca(vendaFreteGrouped.vendaFrete?.ufPlaca),
						seloFiscal: vendaFreteGrouped.vendaFrete?.seloFiscal,
						quantidadeVolume: vendaFreteGrouped.vendaFrete?.quantidadeVolume,
						marcaVolume: vendaFreteGrouped.vendaFrete?.marcaVolume,
						especieVolume: vendaFreteGrouped.vendaFrete?.especieVolume,
						pesoBruto: vendaFreteGrouped.vendaFrete?.pesoBruto,
						pesoLiquido: vendaFreteGrouped.vendaFrete?.pesoLiquido,
					)
				);
			}
			return vendaFreteModelList;
		}
		return [];
	}


	VendaCabecalhoGrouped toDrift(VendaCabecalhoModel vendaCabecalhoModel) {
		return VendaCabecalhoGrouped(
			vendaCabecalho: VendaCabecalho(
				id: vendaCabecalhoModel.id,
				idVendaOrcamentoCabecalho: vendaCabecalhoModel.idVendaOrcamentoCabecalho,
				idNotaFiscalTipo: vendaCabecalhoModel.idNotaFiscalTipo,
				idVendedor: vendaCabecalhoModel.idVendedor,
				idVendaCondicoesPagamento: vendaCabecalhoModel.idVendaCondicoesPagamento,
				idTransportadora: vendaCabecalhoModel.idTransportadora,
				idCliente: vendaCabecalhoModel.idCliente,
				localEntrega: vendaCabecalhoModel.localEntrega,
				localCobranca: vendaCabecalhoModel.localCobranca,
				tipoFrete: VendaCabecalhoDomain.setTipoFrete(vendaCabecalhoModel.tipoFrete),
				formaPagamento: VendaCabecalhoDomain.setFormaPagamento(vendaCabecalhoModel.formaPagamento),
				dataVenda: vendaCabecalhoModel.dataVenda,
				dataSaida: vendaCabecalhoModel.dataSaida,
				horaSaida: Util.removeMask(vendaCabecalhoModel.horaSaida),
				numeroFatura: vendaCabecalhoModel.numeroFatura,
				valorFrete: vendaCabecalhoModel.valorFrete,
				valorSeguro: vendaCabecalhoModel.valorSeguro,
				valorSubtotal: vendaCabecalhoModel.valorSubtotal,
				taxaComissao: vendaCabecalhoModel.taxaComissao,
				valorComissao: vendaCabecalhoModel.valorComissao,
				taxaDesconto: vendaCabecalhoModel.taxaDesconto,
				valorDesconto: vendaCabecalhoModel.valorDesconto,
				valorTotal: vendaCabecalhoModel.valorTotal,
				situacao: VendaCabecalhoDomain.setSituacao(vendaCabecalhoModel.situacao),
				diaFixoParcela: vendaCabecalhoModel.diaFixoParcela,
				observacao: vendaCabecalhoModel.observacao,
			),
			vendaComissaoGrouped: VendaComissaoGrouped(
				vendaComissao: VendaComissao(
					id: vendaCabecalhoModel.vendaComissaoModel?.id,
					idVendaCabecalho: vendaCabecalhoModel.vendaComissaoModel?.idVendaCabecalho,
					idVendedor: vendaCabecalhoModel.vendaComissaoModel?.idVendedor,
					valorVenda: vendaCabecalhoModel.vendaComissaoModel?.valorVenda,
					tipoContabil: VendaComissaoDomain.setTipoContabil(vendaCabecalhoModel.vendaComissaoModel?.tipoContabil),
					valorComissao: vendaCabecalhoModel.vendaComissaoModel?.valorComissao,
					situacao: VendaComissaoDomain.setSituacao(vendaCabecalhoModel.vendaComissaoModel?.situacao),
					dataLancamento: vendaCabecalhoModel.vendaComissaoModel?.dataLancamento,
				),
				viewPessoaVendedor: ViewPessoaVendedor(
					id: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.id,
					nome: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.nome,
					tipo: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.tipo,
					email: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.email,
					site: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.site,
					cpfCnpj: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.cpfCnpj,
					rgIe: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.rgIe,
					matricula: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.matricula,
					dataCadastro: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.dataCadastro,
					dataAdmissao: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.dataAdmissao,
					dataDemissao: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.dataDemissao,
					ctpsNumero: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.ctpsNumero,
					ctpsSerie: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.ctpsSerie,
					ctpsDataExpedicao: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.ctpsDataExpedicao,
					ctpsUf: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.ctpsUf,
					observacao: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.observacao,
					logradouro: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.logradouro,
					numero: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.numero,
					complemento: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.complemento,
					bairro: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.bairro,
					cidade: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.cidade,
					cep: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.cep,
					municipioIbge: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.municipioIbge,
					uf: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.uf,
					idPessoa: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.idPessoa,
					idCargo: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.idCargo,
					idSetor: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.idSetor,
					comissao: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.comissao,
					metaVenda: vendaCabecalhoModel.vendaComissaoModel?.viewPessoaVendedorModel?.metaVenda,
				),
			),
			vendaDetalheGroupedList: vendaDetalheModelToDrift(vendaCabecalhoModel.vendaDetalheModelList),
			vendaFreteGroupedList: vendaFreteModelToDrift(vendaCabecalhoModel.vendaFreteModelList),
		);
	}

	List<VendaDetalheGrouped> vendaDetalheModelToDrift(List<VendaDetalheModel>? vendaDetalheModelList) { 
		List<VendaDetalheGrouped> vendaDetalheGroupedList = [];
		if (vendaDetalheModelList != null) {
			for (var vendaDetalheModel in vendaDetalheModelList) {
				vendaDetalheGroupedList.add(
					VendaDetalheGrouped(
						vendaDetalhe: VendaDetalhe(
							id: vendaDetalheModel.id,
							idVendaCabecalho: vendaDetalheModel.idVendaCabecalho,
							idProduto: vendaDetalheModel.idProduto,
							quantidade: vendaDetalheModel.quantidade,
							valorUnitario: vendaDetalheModel.valorUnitario,
							valorSubtotal: vendaDetalheModel.valorSubtotal,
							taxaDesconto: vendaDetalheModel.taxaDesconto,
							valorDesconto: vendaDetalheModel.valorDesconto,
							valorTotal: vendaDetalheModel.valorTotal,
						),
					),
				);
			}
			return vendaDetalheGroupedList;
		}
		return [];
	}

	List<VendaFreteGrouped> vendaFreteModelToDrift(List<VendaFreteModel>? vendaFreteModelList) { 
		List<VendaFreteGrouped> vendaFreteGroupedList = [];
		if (vendaFreteModelList != null) {
			for (var vendaFreteModel in vendaFreteModelList) {
				vendaFreteGroupedList.add(
					VendaFreteGrouped(
						vendaFrete: VendaFrete(
							id: vendaFreteModel.id,
							idVendaCabecalho: vendaFreteModel.idVendaCabecalho,
							idTransportadora: vendaFreteModel.idTransportadora,
							responsavel: VendaFreteDomain.setResponsavel(vendaFreteModel.responsavel),
							conhecimento: vendaFreteModel.conhecimento,
							placa: vendaFreteModel.placa,
							ufPlaca: VendaFreteDomain.setUfPlaca(vendaFreteModel.ufPlaca),
							seloFiscal: vendaFreteModel.seloFiscal,
							quantidadeVolume: vendaFreteModel.quantidadeVolume,
							marcaVolume: vendaFreteModel.marcaVolume,
							especieVolume: vendaFreteModel.especieVolume,
							pesoBruto: vendaFreteModel.pesoBruto,
							pesoLiquido: vendaFreteModel.pesoLiquido,
						),
					),
				);
			}
			return vendaFreteGroupedList;
		}
		return [];
	}

		
}
