import 'package:compras/app/data/provider/drift/database/database_imports.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/provider/provider_base.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraCotacaoDriftProvider extends ProviderBase {

	Future<List<CompraCotacaoModel>?> getList({Filter? filter}) async {
		List<CompraCotacaoGrouped> compraCotacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				compraCotacaoDriftList = await Session.database.compraCotacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				compraCotacaoDriftList = await Session.database.compraCotacaoDao.getGroupedList(); 
			}
			if (compraCotacaoDriftList.isNotEmpty) {
				return toListModel(compraCotacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CompraCotacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.compraCotacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraCotacaoModel?>? insert(CompraCotacaoModel compraCotacaoModel) async {
		try {
			final lastPk = await Session.database.compraCotacaoDao.insertObject(toDrift(compraCotacaoModel));
			compraCotacaoModel.id = lastPk;
			return compraCotacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraCotacaoModel?>? update(CompraCotacaoModel compraCotacaoModel) async {
		try {
			await Session.database.compraCotacaoDao.updateObject(toDrift(compraCotacaoModel));
			return compraCotacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.compraCotacaoDao.deleteObject(toDrift(CompraCotacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CompraCotacaoModel> toListModel(List<CompraCotacaoGrouped> compraCotacaoDriftList) {
		List<CompraCotacaoModel> listModel = [];
		for (var compraCotacaoDrift in compraCotacaoDriftList) {
			listModel.add(toModel(compraCotacaoDrift)!);
		}
		return listModel;
	}	

	CompraCotacaoModel? toModel(CompraCotacaoGrouped? compraCotacaoDrift) {
		if (compraCotacaoDrift != null) {
			return CompraCotacaoModel(
				id: compraCotacaoDrift.compraCotacao?.id,
				idCompraRequisicao: compraCotacaoDrift.compraCotacao?.idCompraRequisicao,
				dataCotacao: compraCotacaoDrift.compraCotacao?.dataCotacao,
				descricao: compraCotacaoDrift.compraCotacao?.descricao,
				compraFornecedorCotacaoModelList: compraFornecedorCotacaoDriftToModel(compraCotacaoDrift.compraFornecedorCotacaoGroupedList),
				compraRequisicaoModel: CompraRequisicaoModel(
					id: compraCotacaoDrift.compraRequisicao?.id,
					idCompraTipoRequisicao: compraCotacaoDrift.compraRequisicao?.idCompraTipoRequisicao,
					idColaborador: compraCotacaoDrift.compraRequisicao?.idColaborador,
					descricao: compraCotacaoDrift.compraRequisicao?.descricao,
					dataRequisicao: compraCotacaoDrift.compraRequisicao?.dataRequisicao,
					observacao: compraCotacaoDrift.compraRequisicao?.observacao,
				),
				compraCotacaoDetalheModelList: compraCotacaoDetalheDriftToModel(compraCotacaoDrift.compraCotacaoDetalheGroupedList),
			);
		} else {
			return null;
		}
	}

	List<CompraFornecedorCotacaoModel> compraFornecedorCotacaoDriftToModel(List<CompraFornecedorCotacaoGrouped>? compraFornecedorCotacaoDriftList) { 
		List<CompraFornecedorCotacaoModel> compraFornecedorCotacaoModelList = [];
		if (compraFornecedorCotacaoDriftList != null) {
			for (var compraFornecedorCotacaoGrouped in compraFornecedorCotacaoDriftList) {
				compraFornecedorCotacaoModelList.add(
					CompraFornecedorCotacaoModel(
						id: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.id,
						idCompraCotacao: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.idCompraCotacao,
						idFornecedor: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.idFornecedor,
						viewPessoaFornecedorModel: ViewPessoaFornecedorModel(
							id: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.id,
							nome: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.nome,
							tipo: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.tipo,
							email: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.email,
							site: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.site,
							cpfCnpj: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.cpfCnpj,
							rgIe: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.rgIe,
							desde: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.desde,
							dataCadastro: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.dataCadastro,
							observacao: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.observacao,
							idPessoa: compraFornecedorCotacaoGrouped.viewPessoaFornecedor?.idPessoa,
						),
						codigo: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.codigo,
						prazoEntrega: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.prazoEntrega,
						vendaCondicoesPagamento: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.vendaCondicoesPagamento,
						valorSubtotal: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.valorSubtotal,
						taxaDesconto: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.taxaDesconto,
						valorDesconto: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.valorDesconto,
						valorTotal: compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.valorTotal,
					)
				);
			}
			return compraFornecedorCotacaoModelList;
		}
		return [];
	}

	List<CompraCotacaoDetalheModel> compraCotacaoDetalheDriftToModel(List<CompraCotacaoDetalheGrouped>? compraCotacaoDetalheDriftList) { 
		List<CompraCotacaoDetalheModel> compraCotacaoDetalheModelList = [];
		if (compraCotacaoDetalheDriftList != null) {
			for (var compraCotacaoDetalheGrouped in compraCotacaoDetalheDriftList) {
				compraCotacaoDetalheModelList.add(
					CompraCotacaoDetalheModel(
						id: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.id,
						idProduto: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: compraCotacaoDetalheGrouped.produto?.id,
							idProdutoSubgrupo: compraCotacaoDetalheGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: compraCotacaoDetalheGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: compraCotacaoDetalheGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: compraCotacaoDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: compraCotacaoDetalheGrouped.produto?.idTributGrupoTributario,
							nome: compraCotacaoDetalheGrouped.produto?.nome,
							descricao: compraCotacaoDetalheGrouped.produto?.descricao,
							gtin: compraCotacaoDetalheGrouped.produto?.gtin,
							codigoInterno: compraCotacaoDetalheGrouped.produto?.codigoInterno,
							valorCompra: compraCotacaoDetalheGrouped.produto?.valorCompra,
							valorVenda: compraCotacaoDetalheGrouped.produto?.valorVenda,
							codigoNcm: compraCotacaoDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: compraCotacaoDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: compraCotacaoDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: compraCotacaoDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: compraCotacaoDetalheGrouped.produto?.dataCadastro,
						),
						idCompraCotacao: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.idCompraCotacao,
						quantidade: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.quantidade,
						valorUnitario: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.valorUnitario,
						valorSubtotal: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.valorSubtotal,
						taxaDesconto: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.taxaDesconto,
						valorDesconto: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.valorDesconto,
						valorTotal: compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.valorTotal,
					)
				);
			}
			return compraCotacaoDetalheModelList;
		}
		return [];
	}


	CompraCotacaoGrouped toDrift(CompraCotacaoModel compraCotacaoModel) {
		return CompraCotacaoGrouped(
			compraCotacao: CompraCotacao(
				id: compraCotacaoModel.id,
				idCompraRequisicao: compraCotacaoModel.idCompraRequisicao,
				dataCotacao: compraCotacaoModel.dataCotacao,
				descricao: compraCotacaoModel.descricao,
			),
			compraFornecedorCotacaoGroupedList: compraFornecedorCotacaoModelToDrift(compraCotacaoModel.compraFornecedorCotacaoModelList),
			compraCotacaoDetalheGroupedList: compraCotacaoDetalheModelToDrift(compraCotacaoModel.compraCotacaoDetalheModelList),
		);
	}

	List<CompraFornecedorCotacaoGrouped> compraFornecedorCotacaoModelToDrift(List<CompraFornecedorCotacaoModel>? compraFornecedorCotacaoModelList) { 
		List<CompraFornecedorCotacaoGrouped> compraFornecedorCotacaoGroupedList = [];
		if (compraFornecedorCotacaoModelList != null) {
			for (var compraFornecedorCotacaoModel in compraFornecedorCotacaoModelList) {
				compraFornecedorCotacaoGroupedList.add(
					CompraFornecedorCotacaoGrouped(
						compraFornecedorCotacao: CompraFornecedorCotacao(
							id: compraFornecedorCotacaoModel.id,
							idCompraCotacao: compraFornecedorCotacaoModel.idCompraCotacao,
							idFornecedor: compraFornecedorCotacaoModel.idFornecedor,
							codigo: compraFornecedorCotacaoModel.codigo,
							prazoEntrega: compraFornecedorCotacaoModel.prazoEntrega,
							vendaCondicoesPagamento: compraFornecedorCotacaoModel.vendaCondicoesPagamento,
							valorSubtotal: compraFornecedorCotacaoModel.valorSubtotal,
							taxaDesconto: compraFornecedorCotacaoModel.taxaDesconto,
							valorDesconto: compraFornecedorCotacaoModel.valorDesconto,
							valorTotal: compraFornecedorCotacaoModel.valorTotal,
						),
					),
				);
			}
			return compraFornecedorCotacaoGroupedList;
		}
		return [];
	}

	List<CompraCotacaoDetalheGrouped> compraCotacaoDetalheModelToDrift(List<CompraCotacaoDetalheModel>? compraCotacaoDetalheModelList) { 
		List<CompraCotacaoDetalheGrouped> compraCotacaoDetalheGroupedList = [];
		if (compraCotacaoDetalheModelList != null) {
			for (var compraCotacaoDetalheModel in compraCotacaoDetalheModelList) {
				compraCotacaoDetalheGroupedList.add(
					CompraCotacaoDetalheGrouped(
						compraCotacaoDetalhe: CompraCotacaoDetalhe(
							id: compraCotacaoDetalheModel.id,
							idProduto: compraCotacaoDetalheModel.idProduto,
							idCompraCotacao: compraCotacaoDetalheModel.idCompraCotacao,
							quantidade: compraCotacaoDetalheModel.quantidade,
							valorUnitario: compraCotacaoDetalheModel.valorUnitario,
							valorSubtotal: compraCotacaoDetalheModel.valorSubtotal,
							taxaDesconto: compraCotacaoDetalheModel.taxaDesconto,
							valorDesconto: compraCotacaoDetalheModel.valorDesconto,
							valorTotal: compraCotacaoDetalheModel.valorTotal,
						),
					),
				);
			}
			return compraCotacaoDetalheGroupedList;
		}
		return [];
	}

		
}
