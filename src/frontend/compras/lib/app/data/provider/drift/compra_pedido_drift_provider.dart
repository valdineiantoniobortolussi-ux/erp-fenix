import 'package:compras/app/data/provider/drift/database/database_imports.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/provider/provider_base.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:compras/app/data/domain/domain_imports.dart';

class CompraPedidoDriftProvider extends ProviderBase {

	Future<List<CompraPedidoModel>?> getList({Filter? filter}) async {
		List<CompraPedidoGrouped> compraPedidoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				compraPedidoDriftList = await Session.database.compraPedidoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				compraPedidoDriftList = await Session.database.compraPedidoDao.getGroupedList(); 
			}
			if (compraPedidoDriftList.isNotEmpty) {
				return toListModel(compraPedidoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CompraPedidoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.compraPedidoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraPedidoModel?>? insert(CompraPedidoModel compraPedidoModel) async {
		try {
			final lastPk = await Session.database.compraPedidoDao.insertObject(toDrift(compraPedidoModel));
			compraPedidoModel.id = lastPk;
			return compraPedidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraPedidoModel?>? update(CompraPedidoModel compraPedidoModel) async {
		try {
			await Session.database.compraPedidoDao.updateObject(toDrift(compraPedidoModel));
			return compraPedidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.compraPedidoDao.deleteObject(toDrift(CompraPedidoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CompraPedidoModel> toListModel(List<CompraPedidoGrouped> compraPedidoDriftList) {
		List<CompraPedidoModel> listModel = [];
		for (var compraPedidoDrift in compraPedidoDriftList) {
			listModel.add(toModel(compraPedidoDrift)!);
		}
		return listModel;
	}	

	CompraPedidoModel? toModel(CompraPedidoGrouped? compraPedidoDrift) {
		if (compraPedidoDrift != null) {
			return CompraPedidoModel(
				id: compraPedidoDrift.compraPedido?.id,
				idCompraTipoPedido: compraPedidoDrift.compraPedido?.idCompraTipoPedido,
				idColaborador: compraPedidoDrift.compraPedido?.idColaborador,
				idFornecedor: compraPedidoDrift.compraPedido?.idFornecedor,
				codigoCotacao: compraPedidoDrift.compraPedido?.codigoCotacao,
				dataPedido: compraPedidoDrift.compraPedido?.dataPedido,
				dataPrevistaEntrega: compraPedidoDrift.compraPedido?.dataPrevistaEntrega,
				dataPrevisaoPagamento: compraPedidoDrift.compraPedido?.dataPrevisaoPagamento,
				localEntrega: compraPedidoDrift.compraPedido?.localEntrega,
				localCobranca: compraPedidoDrift.compraPedido?.localCobranca,
				contato: compraPedidoDrift.compraPedido?.contato,
				valorSubtotal: compraPedidoDrift.compraPedido?.valorSubtotal,
				taxaDesconto: compraPedidoDrift.compraPedido?.taxaDesconto,
				valorDesconto: compraPedidoDrift.compraPedido?.valorDesconto,
				valorTotal: compraPedidoDrift.compraPedido?.valorTotal,
				tipoFrete: CompraPedidoDomain.getTipoFrete(compraPedidoDrift.compraPedido?.tipoFrete),
				formaPagamento: CompraPedidoDomain.getFormaPagamento(compraPedidoDrift.compraPedido?.formaPagamento),
				baseCalculoIcms: compraPedidoDrift.compraPedido?.baseCalculoIcms,
				valorIcms: compraPedidoDrift.compraPedido?.valorIcms,
				baseCalculoIcmsSt: compraPedidoDrift.compraPedido?.baseCalculoIcmsSt,
				valorIcmsSt: compraPedidoDrift.compraPedido?.valorIcmsSt,
				valorTotalProdutos: compraPedidoDrift.compraPedido?.valorTotalProdutos,
				valorFrete: compraPedidoDrift.compraPedido?.valorFrete,
				valorSeguro: compraPedidoDrift.compraPedido?.valorSeguro,
				valorOutrasDespesas: compraPedidoDrift.compraPedido?.valorOutrasDespesas,
				valorIpi: compraPedidoDrift.compraPedido?.valorIpi,
				valorTotalNf: compraPedidoDrift.compraPedido?.valorTotalNf,
				quantidadeParcelas: compraPedidoDrift.compraPedido?.quantidadeParcelas,
				diaPrimeiroVencimento: compraPedidoDrift.compraPedido?.diaPrimeiroVencimento,
				intervaloEntreParcelas: compraPedidoDrift.compraPedido?.intervaloEntreParcelas,
				diaFixoParcela: compraPedidoDrift.compraPedido?.diaFixoParcela,
				compraPedidoDetalheModelList: compraPedidoDetalheDriftToModel(compraPedidoDrift.compraPedidoDetalheGroupedList),
				compraTipoPedidoModel: CompraTipoPedidoModel(
					id: compraPedidoDrift.compraTipoPedido?.id,
					codigo: compraPedidoDrift.compraTipoPedido?.codigo,
					nome: compraPedidoDrift.compraTipoPedido?.nome,
					descricao: compraPedidoDrift.compraTipoPedido?.descricao,
				),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: compraPedidoDrift.viewPessoaColaborador?.id,
					nome: compraPedidoDrift.viewPessoaColaborador?.nome,
					tipo: compraPedidoDrift.viewPessoaColaborador?.tipo,
					email: compraPedidoDrift.viewPessoaColaborador?.email,
					site: compraPedidoDrift.viewPessoaColaborador?.site,
					cpfCnpj: compraPedidoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: compraPedidoDrift.viewPessoaColaborador?.rgIe,
					matricula: compraPedidoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: compraPedidoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: compraPedidoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: compraPedidoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: compraPedidoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: compraPedidoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: compraPedidoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: compraPedidoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: compraPedidoDrift.viewPessoaColaborador?.observacao,
					logradouro: compraPedidoDrift.viewPessoaColaborador?.logradouro,
					numero: compraPedidoDrift.viewPessoaColaborador?.numero,
					complemento: compraPedidoDrift.viewPessoaColaborador?.complemento,
					bairro: compraPedidoDrift.viewPessoaColaborador?.bairro,
					cidade: compraPedidoDrift.viewPessoaColaborador?.cidade,
					cep: compraPedidoDrift.viewPessoaColaborador?.cep,
					municipioIbge: compraPedidoDrift.viewPessoaColaborador?.municipioIbge,
					uf: compraPedidoDrift.viewPessoaColaborador?.uf,
					idPessoa: compraPedidoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: compraPedidoDrift.viewPessoaColaborador?.idCargo,
					idSetor: compraPedidoDrift.viewPessoaColaborador?.idSetor,
				),
				viewPessoaFornecedorModel: ViewPessoaFornecedorModel(
					id: compraPedidoDrift.viewPessoaFornecedor?.id,
					nome: compraPedidoDrift.viewPessoaFornecedor?.nome,
					tipo: compraPedidoDrift.viewPessoaFornecedor?.tipo,
					email: compraPedidoDrift.viewPessoaFornecedor?.email,
					site: compraPedidoDrift.viewPessoaFornecedor?.site,
					cpfCnpj: compraPedidoDrift.viewPessoaFornecedor?.cpfCnpj,
					rgIe: compraPedidoDrift.viewPessoaFornecedor?.rgIe,
					desde: compraPedidoDrift.viewPessoaFornecedor?.desde,
					dataCadastro: compraPedidoDrift.viewPessoaFornecedor?.dataCadastro,
					observacao: compraPedidoDrift.viewPessoaFornecedor?.observacao,
					idPessoa: compraPedidoDrift.viewPessoaFornecedor?.idPessoa,
				),
			);
		} else {
			return null;
		}
	}

	List<CompraPedidoDetalheModel> compraPedidoDetalheDriftToModel(List<CompraPedidoDetalheGrouped>? compraPedidoDetalheDriftList) { 
		List<CompraPedidoDetalheModel> compraPedidoDetalheModelList = [];
		if (compraPedidoDetalheDriftList != null) {
			for (var compraPedidoDetalheGrouped in compraPedidoDetalheDriftList) {
				compraPedidoDetalheModelList.add(
					CompraPedidoDetalheModel(
						id: compraPedidoDetalheGrouped.compraPedidoDetalhe?.id,
						idCompraPedido: compraPedidoDetalheGrouped.compraPedidoDetalhe?.idCompraPedido,
						idProduto: compraPedidoDetalheGrouped.compraPedidoDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: compraPedidoDetalheGrouped.produto?.id,
							idProdutoSubgrupo: compraPedidoDetalheGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: compraPedidoDetalheGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: compraPedidoDetalheGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: compraPedidoDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: compraPedidoDetalheGrouped.produto?.idTributGrupoTributario,
							nome: compraPedidoDetalheGrouped.produto?.nome,
							descricao: compraPedidoDetalheGrouped.produto?.descricao,
							gtin: compraPedidoDetalheGrouped.produto?.gtin,
							codigoInterno: compraPedidoDetalheGrouped.produto?.codigoInterno,
							valorCompra: compraPedidoDetalheGrouped.produto?.valorCompra,
							valorVenda: compraPedidoDetalheGrouped.produto?.valorVenda,
							codigoNcm: compraPedidoDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: compraPedidoDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: compraPedidoDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: compraPedidoDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: compraPedidoDetalheGrouped.produto?.dataCadastro,
						),
						quantidade: compraPedidoDetalheGrouped.compraPedidoDetalhe?.quantidade,
						valorUnitario: compraPedidoDetalheGrouped.compraPedidoDetalhe?.valorUnitario,
						valorSubtotal: compraPedidoDetalheGrouped.compraPedidoDetalhe?.valorSubtotal,
						taxaDesconto: compraPedidoDetalheGrouped.compraPedidoDetalhe?.taxaDesconto,
						valorDesconto: compraPedidoDetalheGrouped.compraPedidoDetalhe?.valorDesconto,
						valorTotal: compraPedidoDetalheGrouped.compraPedidoDetalhe?.valorTotal,
						cst: compraPedidoDetalheGrouped.compraPedidoDetalhe?.cst,
						csosn: compraPedidoDetalheGrouped.compraPedidoDetalhe?.csosn,
						cfop: compraPedidoDetalheGrouped.compraPedidoDetalhe?.cfop,
						baseCalculoIcms: compraPedidoDetalheGrouped.compraPedidoDetalhe?.baseCalculoIcms,
						valorIcms: compraPedidoDetalheGrouped.compraPedidoDetalhe?.valorIcms,
						valorIpi: compraPedidoDetalheGrouped.compraPedidoDetalhe?.valorIpi,
						aliquotaIcms: compraPedidoDetalheGrouped.compraPedidoDetalhe?.aliquotaIcms,
						aliquotaIpi: compraPedidoDetalheGrouped.compraPedidoDetalhe?.aliquotaIpi,
					)
				);
			}
			return compraPedidoDetalheModelList;
		}
		return [];
	}


	CompraPedidoGrouped toDrift(CompraPedidoModel compraPedidoModel) {
		return CompraPedidoGrouped(
			compraPedido: CompraPedido(
				id: compraPedidoModel.id,
				idCompraTipoPedido: compraPedidoModel.idCompraTipoPedido,
				idColaborador: compraPedidoModel.idColaborador,
				idFornecedor: compraPedidoModel.idFornecedor,
				codigoCotacao: compraPedidoModel.codigoCotacao,
				dataPedido: compraPedidoModel.dataPedido,
				dataPrevistaEntrega: compraPedidoModel.dataPrevistaEntrega,
				dataPrevisaoPagamento: compraPedidoModel.dataPrevisaoPagamento,
				localEntrega: compraPedidoModel.localEntrega,
				localCobranca: compraPedidoModel.localCobranca,
				contato: compraPedidoModel.contato,
				valorSubtotal: compraPedidoModel.valorSubtotal,
				taxaDesconto: compraPedidoModel.taxaDesconto,
				valorDesconto: compraPedidoModel.valorDesconto,
				valorTotal: compraPedidoModel.valorTotal,
				tipoFrete: CompraPedidoDomain.setTipoFrete(compraPedidoModel.tipoFrete),
				formaPagamento: CompraPedidoDomain.setFormaPagamento(compraPedidoModel.formaPagamento),
				baseCalculoIcms: compraPedidoModel.baseCalculoIcms,
				valorIcms: compraPedidoModel.valorIcms,
				baseCalculoIcmsSt: compraPedidoModel.baseCalculoIcmsSt,
				valorIcmsSt: compraPedidoModel.valorIcmsSt,
				valorTotalProdutos: compraPedidoModel.valorTotalProdutos,
				valorFrete: compraPedidoModel.valorFrete,
				valorSeguro: compraPedidoModel.valorSeguro,
				valorOutrasDespesas: compraPedidoModel.valorOutrasDespesas,
				valorIpi: compraPedidoModel.valorIpi,
				valorTotalNf: compraPedidoModel.valorTotalNf,
				quantidadeParcelas: compraPedidoModel.quantidadeParcelas,
				diaPrimeiroVencimento: compraPedidoModel.diaPrimeiroVencimento,
				intervaloEntreParcelas: compraPedidoModel.intervaloEntreParcelas,
				diaFixoParcela: compraPedidoModel.diaFixoParcela,
			),
			compraPedidoDetalheGroupedList: compraPedidoDetalheModelToDrift(compraPedidoModel.compraPedidoDetalheModelList),
		);
	}

	List<CompraPedidoDetalheGrouped> compraPedidoDetalheModelToDrift(List<CompraPedidoDetalheModel>? compraPedidoDetalheModelList) { 
		List<CompraPedidoDetalheGrouped> compraPedidoDetalheGroupedList = [];
		if (compraPedidoDetalheModelList != null) {
			for (var compraPedidoDetalheModel in compraPedidoDetalheModelList) {
				compraPedidoDetalheGroupedList.add(
					CompraPedidoDetalheGrouped(
						compraPedidoDetalhe: CompraPedidoDetalhe(
							id: compraPedidoDetalheModel.id,
							idCompraPedido: compraPedidoDetalheModel.idCompraPedido,
							idProduto: compraPedidoDetalheModel.idProduto,
							quantidade: compraPedidoDetalheModel.quantidade,
							valorUnitario: compraPedidoDetalheModel.valorUnitario,
							valorSubtotal: compraPedidoDetalheModel.valorSubtotal,
							taxaDesconto: compraPedidoDetalheModel.taxaDesconto,
							valorDesconto: compraPedidoDetalheModel.valorDesconto,
							valorTotal: compraPedidoDetalheModel.valorTotal,
							cst: compraPedidoDetalheModel.cst,
							csosn: compraPedidoDetalheModel.csosn,
							cfop: compraPedidoDetalheModel.cfop,
							baseCalculoIcms: compraPedidoDetalheModel.baseCalculoIcms,
							valorIcms: compraPedidoDetalheModel.valorIcms,
							valorIpi: compraPedidoDetalheModel.valorIpi,
							aliquotaIcms: compraPedidoDetalheModel.aliquotaIcms,
							aliquotaIpi: compraPedidoDetalheModel.aliquotaIpi,
						),
					),
				);
			}
			return compraPedidoDetalheGroupedList;
		}
		return [];
	}

		
}
