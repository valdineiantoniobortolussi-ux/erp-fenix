import 'package:vendas/app/data/provider/drift/database/database_imports.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/provider/provider_base.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaOrcamentoCabecalhoDriftProvider extends ProviderBase {

	Future<List<VendaOrcamentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<VendaOrcamentoCabecalhoGrouped> vendaOrcamentoCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				vendaOrcamentoCabecalhoDriftList = await Session.database.vendaOrcamentoCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				vendaOrcamentoCabecalhoDriftList = await Session.database.vendaOrcamentoCabecalhoDao.getGroupedList(); 
			}
			if (vendaOrcamentoCabecalhoDriftList.isNotEmpty) {
				return toListModel(vendaOrcamentoCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<VendaOrcamentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.vendaOrcamentoCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaOrcamentoCabecalhoModel?>? insert(VendaOrcamentoCabecalhoModel vendaOrcamentoCabecalhoModel) async {
		try {
			final lastPk = await Session.database.vendaOrcamentoCabecalhoDao.insertObject(toDrift(vendaOrcamentoCabecalhoModel));
			vendaOrcamentoCabecalhoModel.id = lastPk;
			return vendaOrcamentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<VendaOrcamentoCabecalhoModel?>? update(VendaOrcamentoCabecalhoModel vendaOrcamentoCabecalhoModel) async {
		try {
			await Session.database.vendaOrcamentoCabecalhoDao.updateObject(toDrift(vendaOrcamentoCabecalhoModel));
			return vendaOrcamentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.vendaOrcamentoCabecalhoDao.deleteObject(toDrift(VendaOrcamentoCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<VendaOrcamentoCabecalhoModel> toListModel(List<VendaOrcamentoCabecalhoGrouped> vendaOrcamentoCabecalhoDriftList) {
		List<VendaOrcamentoCabecalhoModel> listModel = [];
		for (var vendaOrcamentoCabecalhoDrift in vendaOrcamentoCabecalhoDriftList) {
			listModel.add(toModel(vendaOrcamentoCabecalhoDrift)!);
		}
		return listModel;
	}	

	VendaOrcamentoCabecalhoModel? toModel(VendaOrcamentoCabecalhoGrouped? vendaOrcamentoCabecalhoDrift) {
		if (vendaOrcamentoCabecalhoDrift != null) {
			return VendaOrcamentoCabecalhoModel(
				id: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.id,
				idVendedor: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.idVendedor,
				idCliente: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.idCliente,
				idVendaCondicoesPagamento: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.idVendaCondicoesPagamento,
				idTransportadora: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.idTransportadora,
				tipoFrete: VendaOrcamentoCabecalhoDomain.getTipoFrete(vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.tipoFrete),
				codigo: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.codigo,
				dataCadastro: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.dataCadastro,
				dataEntrega: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.dataEntrega,
				dataValidade: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.dataValidade,
				valorSubtotal: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.valorSubtotal,
				valorFrete: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.valorFrete,
				taxaComissao: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.taxaComissao,
				valorComissao: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.valorComissao,
				taxaDesconto: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.taxaDesconto,
				valorDesconto: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.valorDesconto,
				valorTotal: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.valorTotal,
				observacao: vendaOrcamentoCabecalhoDrift.vendaOrcamentoCabecalho?.observacao,
				vendaOrcamentoDetalheModelList: vendaOrcamentoDetalheDriftToModel(vendaOrcamentoCabecalhoDrift.vendaOrcamentoDetalheGroupedList),
				vendaCondicoesPagamentoModel: VendaCondicoesPagamentoModel(
					id: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.id,
					nome: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.nome,
					descricao: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.descricao,
					faturamentoMinimo: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.faturamentoMinimo,
					faturamentoMaximo: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.faturamentoMaximo,
					indiceCorrecao: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.indiceCorrecao,
					diasTolerancia: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.diasTolerancia,
					valorTolerancia: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.valorTolerancia,
					prazoMedio: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.prazoMedio,
					vistaPrazo: vendaOrcamentoCabecalhoDrift.vendaCondicoesPagamento?.vistaPrazo,
				),
				viewPessoaVendedorModel: ViewPessoaVendedorModel(
					id: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.id,
					nome: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.nome,
					tipo: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.tipo,
					email: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.email,
					site: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.site,
					cpfCnpj: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.cpfCnpj,
					rgIe: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.rgIe,
					matricula: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.matricula,
					dataCadastro: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.dataCadastro,
					dataAdmissao: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.dataAdmissao,
					dataDemissao: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.dataDemissao,
					ctpsNumero: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.ctpsNumero,
					ctpsSerie: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.ctpsSerie,
					ctpsDataExpedicao: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.ctpsDataExpedicao,
					ctpsUf: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.ctpsUf,
					observacao: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.observacao,
					logradouro: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.logradouro,
					numero: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.numero,
					complemento: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.complemento,
					bairro: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.bairro,
					cidade: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.cidade,
					cep: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.cep,
					municipioIbge: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.municipioIbge,
					uf: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.uf,
					idPessoa: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.idPessoa,
					idCargo: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.idCargo,
					idSetor: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.idSetor,
					comissao: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.comissao,
					metaVenda: vendaOrcamentoCabecalhoDrift.viewPessoaVendedor?.metaVenda,
				),
				viewPessoaTransportadoraModel: ViewPessoaTransportadoraModel(
					id: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.id,
					nome: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.nome,
					tipo: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.tipo,
					email: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.email,
					site: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.site,
					cpfCnpj: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.cpfCnpj,
					rgIe: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.rgIe,
					dataCadastro: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.dataCadastro,
					observacao: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.observacao,
					idPessoa: vendaOrcamentoCabecalhoDrift.viewPessoaTransportadora?.idPessoa,
				),
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.id,
					nome: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.nome,
					tipo: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.tipo,
					email: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.email,
					site: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.site,
					cpfCnpj: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.rgIe,
					desde: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.desde,
					taxaDesconto: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.dataCadastro,
					observacao: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.observacao,
					idPessoa: vendaOrcamentoCabecalhoDrift.viewPessoaCliente?.idPessoa,
				),
			);
		} else {
			return null;
		}
	}

	List<VendaOrcamentoDetalheModel> vendaOrcamentoDetalheDriftToModel(List<VendaOrcamentoDetalheGrouped>? vendaOrcamentoDetalheDriftList) { 
		List<VendaOrcamentoDetalheModel> vendaOrcamentoDetalheModelList = [];
		if (vendaOrcamentoDetalheDriftList != null) {
			for (var vendaOrcamentoDetalheGrouped in vendaOrcamentoDetalheDriftList) {
				vendaOrcamentoDetalheModelList.add(
					VendaOrcamentoDetalheModel(
						id: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.id,
						idVendaOrcamentoCabecalho: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.idVendaOrcamentoCabecalho,
						idProduto: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: vendaOrcamentoDetalheGrouped.produto?.id,
							idProdutoSubgrupo: vendaOrcamentoDetalheGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: vendaOrcamentoDetalheGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: vendaOrcamentoDetalheGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: vendaOrcamentoDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: vendaOrcamentoDetalheGrouped.produto?.idTributGrupoTributario,
							nome: vendaOrcamentoDetalheGrouped.produto?.nome,
							descricao: vendaOrcamentoDetalheGrouped.produto?.descricao,
							gtin: vendaOrcamentoDetalheGrouped.produto?.gtin,
							codigoInterno: vendaOrcamentoDetalheGrouped.produto?.codigoInterno,
							valorCompra: vendaOrcamentoDetalheGrouped.produto?.valorCompra,
							valorVenda: vendaOrcamentoDetalheGrouped.produto?.valorVenda,
							codigoNcm: vendaOrcamentoDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: vendaOrcamentoDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: vendaOrcamentoDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: vendaOrcamentoDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: vendaOrcamentoDetalheGrouped.produto?.dataCadastro,
						),
						quantidade: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.quantidade,
						valorUnitario: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.valorUnitario,
						valorSubtotal: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.valorSubtotal,
						taxaDesconto: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.taxaDesconto,
						valorDesconto: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.valorDesconto,
						valorTotal: vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.valorTotal,
					)
				);
			}
			return vendaOrcamentoDetalheModelList;
		}
		return [];
	}


	VendaOrcamentoCabecalhoGrouped toDrift(VendaOrcamentoCabecalhoModel vendaOrcamentoCabecalhoModel) {
		return VendaOrcamentoCabecalhoGrouped(
			vendaOrcamentoCabecalho: VendaOrcamentoCabecalho(
				id: vendaOrcamentoCabecalhoModel.id,
				idVendedor: vendaOrcamentoCabecalhoModel.idVendedor,
				idCliente: vendaOrcamentoCabecalhoModel.idCliente,
				idVendaCondicoesPagamento: vendaOrcamentoCabecalhoModel.idVendaCondicoesPagamento,
				idTransportadora: vendaOrcamentoCabecalhoModel.idTransportadora,
				tipoFrete: VendaOrcamentoCabecalhoDomain.setTipoFrete(vendaOrcamentoCabecalhoModel.tipoFrete),
				codigo: vendaOrcamentoCabecalhoModel.codigo,
				dataCadastro: vendaOrcamentoCabecalhoModel.dataCadastro,
				dataEntrega: vendaOrcamentoCabecalhoModel.dataEntrega,
				dataValidade: vendaOrcamentoCabecalhoModel.dataValidade,
				valorSubtotal: vendaOrcamentoCabecalhoModel.valorSubtotal,
				valorFrete: vendaOrcamentoCabecalhoModel.valorFrete,
				taxaComissao: vendaOrcamentoCabecalhoModel.taxaComissao,
				valorComissao: vendaOrcamentoCabecalhoModel.valorComissao,
				taxaDesconto: vendaOrcamentoCabecalhoModel.taxaDesconto,
				valorDesconto: vendaOrcamentoCabecalhoModel.valorDesconto,
				valorTotal: vendaOrcamentoCabecalhoModel.valorTotal,
				observacao: vendaOrcamentoCabecalhoModel.observacao,
			),
			vendaOrcamentoDetalheGroupedList: vendaOrcamentoDetalheModelToDrift(vendaOrcamentoCabecalhoModel.vendaOrcamentoDetalheModelList),
		);
	}

	List<VendaOrcamentoDetalheGrouped> vendaOrcamentoDetalheModelToDrift(List<VendaOrcamentoDetalheModel>? vendaOrcamentoDetalheModelList) { 
		List<VendaOrcamentoDetalheGrouped> vendaOrcamentoDetalheGroupedList = [];
		if (vendaOrcamentoDetalheModelList != null) {
			for (var vendaOrcamentoDetalheModel in vendaOrcamentoDetalheModelList) {
				vendaOrcamentoDetalheGroupedList.add(
					VendaOrcamentoDetalheGrouped(
						vendaOrcamentoDetalhe: VendaOrcamentoDetalhe(
							id: vendaOrcamentoDetalheModel.id,
							idVendaOrcamentoCabecalho: vendaOrcamentoDetalheModel.idVendaOrcamentoCabecalho,
							idProduto: vendaOrcamentoDetalheModel.idProduto,
							quantidade: vendaOrcamentoDetalheModel.quantidade,
							valorUnitario: vendaOrcamentoDetalheModel.valorUnitario,
							valorSubtotal: vendaOrcamentoDetalheModel.valorSubtotal,
							taxaDesconto: vendaOrcamentoDetalheModel.taxaDesconto,
							valorDesconto: vendaOrcamentoDetalheModel.valorDesconto,
							valorTotal: vendaOrcamentoDetalheModel.valorTotal,
						),
					),
				);
			}
			return vendaOrcamentoDetalheGroupedList;
		}
		return [];
	}

		
}
