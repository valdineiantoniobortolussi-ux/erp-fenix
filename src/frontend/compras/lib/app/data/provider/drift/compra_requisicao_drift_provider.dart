import 'package:compras/app/data/provider/drift/database/database_imports.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/provider/provider_base.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraRequisicaoDriftProvider extends ProviderBase {

	Future<List<CompraRequisicaoModel>?> getList({Filter? filter}) async {
		List<CompraRequisicaoGrouped> compraRequisicaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				compraRequisicaoDriftList = await Session.database.compraRequisicaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				compraRequisicaoDriftList = await Session.database.compraRequisicaoDao.getGroupedList(); 
			}
			if (compraRequisicaoDriftList.isNotEmpty) {
				return toListModel(compraRequisicaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CompraRequisicaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.compraRequisicaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraRequisicaoModel?>? insert(CompraRequisicaoModel compraRequisicaoModel) async {
		try {
			final lastPk = await Session.database.compraRequisicaoDao.insertObject(toDrift(compraRequisicaoModel));
			compraRequisicaoModel.id = lastPk;
			return compraRequisicaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraRequisicaoModel?>? update(CompraRequisicaoModel compraRequisicaoModel) async {
		try {
			await Session.database.compraRequisicaoDao.updateObject(toDrift(compraRequisicaoModel));
			return compraRequisicaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.compraRequisicaoDao.deleteObject(toDrift(CompraRequisicaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CompraRequisicaoModel> toListModel(List<CompraRequisicaoGrouped> compraRequisicaoDriftList) {
		List<CompraRequisicaoModel> listModel = [];
		for (var compraRequisicaoDrift in compraRequisicaoDriftList) {
			listModel.add(toModel(compraRequisicaoDrift)!);
		}
		return listModel;
	}	

	CompraRequisicaoModel? toModel(CompraRequisicaoGrouped? compraRequisicaoDrift) {
		if (compraRequisicaoDrift != null) {
			return CompraRequisicaoModel(
				id: compraRequisicaoDrift.compraRequisicao?.id,
				idCompraTipoRequisicao: compraRequisicaoDrift.compraRequisicao?.idCompraTipoRequisicao,
				idColaborador: compraRequisicaoDrift.compraRequisicao?.idColaborador,
				descricao: compraRequisicaoDrift.compraRequisicao?.descricao,
				dataRequisicao: compraRequisicaoDrift.compraRequisicao?.dataRequisicao,
				observacao: compraRequisicaoDrift.compraRequisicao?.observacao,
				compraRequisicaoDetalheModelList: compraRequisicaoDetalheDriftToModel(compraRequisicaoDrift.compraRequisicaoDetalheGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: compraRequisicaoDrift.viewPessoaColaborador?.id,
					nome: compraRequisicaoDrift.viewPessoaColaborador?.nome,
					tipo: compraRequisicaoDrift.viewPessoaColaborador?.tipo,
					email: compraRequisicaoDrift.viewPessoaColaborador?.email,
					site: compraRequisicaoDrift.viewPessoaColaborador?.site,
					cpfCnpj: compraRequisicaoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: compraRequisicaoDrift.viewPessoaColaborador?.rgIe,
					matricula: compraRequisicaoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: compraRequisicaoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: compraRequisicaoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: compraRequisicaoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: compraRequisicaoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: compraRequisicaoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: compraRequisicaoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: compraRequisicaoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: compraRequisicaoDrift.viewPessoaColaborador?.observacao,
					logradouro: compraRequisicaoDrift.viewPessoaColaborador?.logradouro,
					numero: compraRequisicaoDrift.viewPessoaColaborador?.numero,
					complemento: compraRequisicaoDrift.viewPessoaColaborador?.complemento,
					bairro: compraRequisicaoDrift.viewPessoaColaborador?.bairro,
					cidade: compraRequisicaoDrift.viewPessoaColaborador?.cidade,
					cep: compraRequisicaoDrift.viewPessoaColaborador?.cep,
					municipioIbge: compraRequisicaoDrift.viewPessoaColaborador?.municipioIbge,
					uf: compraRequisicaoDrift.viewPessoaColaborador?.uf,
					idPessoa: compraRequisicaoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: compraRequisicaoDrift.viewPessoaColaborador?.idCargo,
					idSetor: compraRequisicaoDrift.viewPessoaColaborador?.idSetor,
				),
				compraTipoRequisicaoModel: CompraTipoRequisicaoModel(
					id: compraRequisicaoDrift.compraTipoRequisicao?.id,
					codigo: compraRequisicaoDrift.compraTipoRequisicao?.codigo,
					nome: compraRequisicaoDrift.compraTipoRequisicao?.nome,
					descricao: compraRequisicaoDrift.compraTipoRequisicao?.descricao,
				),
			);
		} else {
			return null;
		}
	}

	List<CompraRequisicaoDetalheModel> compraRequisicaoDetalheDriftToModel(List<CompraRequisicaoDetalheGrouped>? compraRequisicaoDetalheDriftList) { 
		List<CompraRequisicaoDetalheModel> compraRequisicaoDetalheModelList = [];
		if (compraRequisicaoDetalheDriftList != null) {
			for (var compraRequisicaoDetalheGrouped in compraRequisicaoDetalheDriftList) {
				compraRequisicaoDetalheModelList.add(
					CompraRequisicaoDetalheModel(
						id: compraRequisicaoDetalheGrouped.compraRequisicaoDetalhe?.id,
						idCompraRequisicao: compraRequisicaoDetalheGrouped.compraRequisicaoDetalhe?.idCompraRequisicao,
						idProduto: compraRequisicaoDetalheGrouped.compraRequisicaoDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: compraRequisicaoDetalheGrouped.produto?.id,
							idProdutoSubgrupo: compraRequisicaoDetalheGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: compraRequisicaoDetalheGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: compraRequisicaoDetalheGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: compraRequisicaoDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: compraRequisicaoDetalheGrouped.produto?.idTributGrupoTributario,
							nome: compraRequisicaoDetalheGrouped.produto?.nome,
							descricao: compraRequisicaoDetalheGrouped.produto?.descricao,
							gtin: compraRequisicaoDetalheGrouped.produto?.gtin,
							codigoInterno: compraRequisicaoDetalheGrouped.produto?.codigoInterno,
							valorCompra: compraRequisicaoDetalheGrouped.produto?.valorCompra,
							valorVenda: compraRequisicaoDetalheGrouped.produto?.valorVenda,
							codigoNcm: compraRequisicaoDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: compraRequisicaoDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: compraRequisicaoDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: compraRequisicaoDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: compraRequisicaoDetalheGrouped.produto?.dataCadastro,
						),
						quantidade: compraRequisicaoDetalheGrouped.compraRequisicaoDetalhe?.quantidade,
					)
				);
			}
			return compraRequisicaoDetalheModelList;
		}
		return [];
	}


	CompraRequisicaoGrouped toDrift(CompraRequisicaoModel compraRequisicaoModel) {
		return CompraRequisicaoGrouped(
			compraRequisicao: CompraRequisicao(
				id: compraRequisicaoModel.id,
				idCompraTipoRequisicao: compraRequisicaoModel.idCompraTipoRequisicao,
				idColaborador: compraRequisicaoModel.idColaborador,
				descricao: compraRequisicaoModel.descricao,
				dataRequisicao: compraRequisicaoModel.dataRequisicao,
				observacao: compraRequisicaoModel.observacao,
			),
			compraRequisicaoDetalheGroupedList: compraRequisicaoDetalheModelToDrift(compraRequisicaoModel.compraRequisicaoDetalheModelList),
		);
	}

	List<CompraRequisicaoDetalheGrouped> compraRequisicaoDetalheModelToDrift(List<CompraRequisicaoDetalheModel>? compraRequisicaoDetalheModelList) { 
		List<CompraRequisicaoDetalheGrouped> compraRequisicaoDetalheGroupedList = [];
		if (compraRequisicaoDetalheModelList != null) {
			for (var compraRequisicaoDetalheModel in compraRequisicaoDetalheModelList) {
				compraRequisicaoDetalheGroupedList.add(
					CompraRequisicaoDetalheGrouped(
						compraRequisicaoDetalhe: CompraRequisicaoDetalhe(
							id: compraRequisicaoDetalheModel.id,
							idCompraRequisicao: compraRequisicaoDetalheModel.idCompraRequisicao,
							idProduto: compraRequisicaoDetalheModel.idProduto,
							quantidade: compraRequisicaoDetalheModel.quantidade,
						),
					),
				);
			}
			return compraRequisicaoDetalheGroupedList;
		}
		return [];
	}

		
}
