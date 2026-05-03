import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ProdutoSubgrupoDriftProvider extends ProviderBase {

	Future<List<ProdutoSubgrupoModel>?> getList({Filter? filter}) async {
		List<ProdutoSubgrupoGrouped> produtoSubgrupoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				produtoSubgrupoDriftList = await Session.database.produtoSubgrupoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				produtoSubgrupoDriftList = await Session.database.produtoSubgrupoDao.getGroupedList(); 
			}
			if (produtoSubgrupoDriftList.isNotEmpty) {
				return toListModel(produtoSubgrupoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ProdutoSubgrupoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.produtoSubgrupoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoSubgrupoModel?>? insert(ProdutoSubgrupoModel produtoSubgrupoModel) async {
		try {
			final lastPk = await Session.database.produtoSubgrupoDao.insertObject(toDrift(produtoSubgrupoModel));
			produtoSubgrupoModel.id = lastPk;
			return produtoSubgrupoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoSubgrupoModel?>? update(ProdutoSubgrupoModel produtoSubgrupoModel) async {
		try {
			await Session.database.produtoSubgrupoDao.updateObject(toDrift(produtoSubgrupoModel));
			return produtoSubgrupoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.produtoSubgrupoDao.deleteObject(toDrift(ProdutoSubgrupoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ProdutoSubgrupoModel> toListModel(List<ProdutoSubgrupoGrouped> produtoSubgrupoDriftList) {
		List<ProdutoSubgrupoModel> listModel = [];
		for (var produtoSubgrupoDrift in produtoSubgrupoDriftList) {
			listModel.add(toModel(produtoSubgrupoDrift)!);
		}
		return listModel;
	}	

	ProdutoSubgrupoModel? toModel(ProdutoSubgrupoGrouped? produtoSubgrupoDrift) {
		if (produtoSubgrupoDrift != null) {
			return ProdutoSubgrupoModel(
				id: produtoSubgrupoDrift.produtoSubgrupo?.id,
				idProdutoGrupo: produtoSubgrupoDrift.produtoSubgrupo?.idProdutoGrupo,
				nome: produtoSubgrupoDrift.produtoSubgrupo?.nome,
				descricao: produtoSubgrupoDrift.produtoSubgrupo?.descricao,
				produtoModelList: produtoDriftToModel(produtoSubgrupoDrift.produtoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<ProdutoModel> produtoDriftToModel(List<ProdutoGrouped>? produtoDriftList) { 
		List<ProdutoModel> produtoModelList = [];
		if (produtoDriftList != null) {
			for (var produtoGrouped in produtoDriftList) {
				produtoModelList.add(
					ProdutoModel(
						id: produtoGrouped.produto?.id,
						idProdutoSubgrupo: produtoGrouped.produto?.idProdutoSubgrupo,
						idProdutoMarca: produtoGrouped.produto?.idProdutoMarca,
						idProdutoUnidade: produtoGrouped.produto?.idProdutoUnidade,
						idTributIcmsCustomCab: produtoGrouped.produto?.idTributIcmsCustomCab,
						idTributGrupoTributario: produtoGrouped.produto?.idTributGrupoTributario,
						nome: produtoGrouped.produto?.nome,
						descricao: produtoGrouped.produto?.descricao,
						gtin: produtoGrouped.produto?.gtin,
						codigoInterno: produtoGrouped.produto?.codigoInterno,
						valorCompra: produtoGrouped.produto?.valorCompra,
						valorVenda: produtoGrouped.produto?.valorVenda,
						codigoNcm: produtoGrouped.produto?.codigoNcm,
						estoqueMinimo: produtoGrouped.produto?.estoqueMinimo,
						estoqueMaximo: produtoGrouped.produto?.estoqueMaximo,
						quantidadeEstoque: produtoGrouped.produto?.quantidadeEstoque,
						dataCadastro: produtoGrouped.produto?.dataCadastro,
					)
				);
			}
			return produtoModelList;
		}
		return [];
	}


	ProdutoSubgrupoGrouped toDrift(ProdutoSubgrupoModel produtoSubgrupoModel) {
		return ProdutoSubgrupoGrouped(
			produtoSubgrupo: ProdutoSubgrupo(
				id: produtoSubgrupoModel.id,
				idProdutoGrupo: produtoSubgrupoModel.idProdutoGrupo,
				nome: produtoSubgrupoModel.nome,
				descricao: produtoSubgrupoModel.descricao,
			),
			produtoGroupedList: produtoModelToDrift(produtoSubgrupoModel.produtoModelList),
		);
	}

	List<ProdutoGrouped> produtoModelToDrift(List<ProdutoModel>? produtoModelList) { 
		List<ProdutoGrouped> produtoGroupedList = [];
		if (produtoModelList != null) {
			for (var produtoModel in produtoModelList) {
				produtoGroupedList.add(
					ProdutoGrouped(
						produto: Produto(
							id: produtoModel.id,
							idProdutoSubgrupo: produtoModel.idProdutoSubgrupo,
							idProdutoMarca: produtoModel.idProdutoMarca,
							idProdutoUnidade: produtoModel.idProdutoUnidade,
							idTributIcmsCustomCab: produtoModel.idTributIcmsCustomCab,
							idTributGrupoTributario: produtoModel.idTributGrupoTributario,
							nome: produtoModel.nome,
							descricao: produtoModel.descricao,
							gtin: produtoModel.gtin,
							codigoInterno: produtoModel.codigoInterno,
							valorCompra: produtoModel.valorCompra,
							valorVenda: produtoModel.valorVenda,
							codigoNcm: produtoModel.codigoNcm,
							estoqueMinimo: produtoModel.estoqueMinimo,
							estoqueMaximo: produtoModel.estoqueMaximo,
							quantidadeEstoque: produtoModel.quantidadeEstoque,
							dataCadastro: produtoModel.dataCadastro,
						),
					),
				);
			}
			return produtoGroupedList;
		}
		return [];
	}

		
}
