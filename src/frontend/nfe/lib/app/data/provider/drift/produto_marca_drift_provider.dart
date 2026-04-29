import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ProdutoMarcaDriftProvider extends ProviderBase {

	Future<List<ProdutoMarcaModel>?> getList({Filter? filter}) async {
		List<ProdutoMarcaGrouped> produtoMarcaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				produtoMarcaDriftList = await Session.database.produtoMarcaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				produtoMarcaDriftList = await Session.database.produtoMarcaDao.getGroupedList(); 
			}
			if (produtoMarcaDriftList.isNotEmpty) {
				return toListModel(produtoMarcaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ProdutoMarcaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.produtoMarcaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoMarcaModel?>? insert(ProdutoMarcaModel produtoMarcaModel) async {
		try {
			final lastPk = await Session.database.produtoMarcaDao.insertObject(toDrift(produtoMarcaModel));
			produtoMarcaModel.id = lastPk;
			return produtoMarcaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoMarcaModel?>? update(ProdutoMarcaModel produtoMarcaModel) async {
		try {
			await Session.database.produtoMarcaDao.updateObject(toDrift(produtoMarcaModel));
			return produtoMarcaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.produtoMarcaDao.deleteObject(toDrift(ProdutoMarcaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ProdutoMarcaModel> toListModel(List<ProdutoMarcaGrouped> produtoMarcaDriftList) {
		List<ProdutoMarcaModel> listModel = [];
		for (var produtoMarcaDrift in produtoMarcaDriftList) {
			listModel.add(toModel(produtoMarcaDrift)!);
		}
		return listModel;
	}	

	ProdutoMarcaModel? toModel(ProdutoMarcaGrouped? produtoMarcaDrift) {
		if (produtoMarcaDrift != null) {
			return ProdutoMarcaModel(
				id: produtoMarcaDrift.produtoMarca?.id,
				nome: produtoMarcaDrift.produtoMarca?.nome,
				descricao: produtoMarcaDrift.produtoMarca?.descricao,
				produtoModelList: produtoDriftToModel(produtoMarcaDrift.produtoGroupedList),
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


	ProdutoMarcaGrouped toDrift(ProdutoMarcaModel produtoMarcaModel) {
		return ProdutoMarcaGrouped(
			produtoMarca: ProdutoMarca(
				id: produtoMarcaModel.id,
				nome: produtoMarcaModel.nome,
				descricao: produtoMarcaModel.descricao,
			),
			produtoGroupedList: produtoModelToDrift(produtoMarcaModel.produtoModelList),
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
