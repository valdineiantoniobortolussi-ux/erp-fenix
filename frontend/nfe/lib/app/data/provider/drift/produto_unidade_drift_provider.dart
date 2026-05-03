import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class ProdutoUnidadeDriftProvider extends ProviderBase {

	Future<List<ProdutoUnidadeModel>?> getList({Filter? filter}) async {
		List<ProdutoUnidadeGrouped> produtoUnidadeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				produtoUnidadeDriftList = await Session.database.produtoUnidadeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				produtoUnidadeDriftList = await Session.database.produtoUnidadeDao.getGroupedList(); 
			}
			if (produtoUnidadeDriftList.isNotEmpty) {
				return toListModel(produtoUnidadeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ProdutoUnidadeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.produtoUnidadeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoUnidadeModel?>? insert(ProdutoUnidadeModel produtoUnidadeModel) async {
		try {
			final lastPk = await Session.database.produtoUnidadeDao.insertObject(toDrift(produtoUnidadeModel));
			produtoUnidadeModel.id = lastPk;
			return produtoUnidadeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoUnidadeModel?>? update(ProdutoUnidadeModel produtoUnidadeModel) async {
		try {
			await Session.database.produtoUnidadeDao.updateObject(toDrift(produtoUnidadeModel));
			return produtoUnidadeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.produtoUnidadeDao.deleteObject(toDrift(ProdutoUnidadeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ProdutoUnidadeModel> toListModel(List<ProdutoUnidadeGrouped> produtoUnidadeDriftList) {
		List<ProdutoUnidadeModel> listModel = [];
		for (var produtoUnidadeDrift in produtoUnidadeDriftList) {
			listModel.add(toModel(produtoUnidadeDrift)!);
		}
		return listModel;
	}	

	ProdutoUnidadeModel? toModel(ProdutoUnidadeGrouped? produtoUnidadeDrift) {
		if (produtoUnidadeDrift != null) {
			return ProdutoUnidadeModel(
				id: produtoUnidadeDrift.produtoUnidade?.id,
				sigla: produtoUnidadeDrift.produtoUnidade?.sigla,
				descricao: produtoUnidadeDrift.produtoUnidade?.descricao,
				podeFracionar: ProdutoUnidadeDomain.getPodeFracionar(produtoUnidadeDrift.produtoUnidade?.podeFracionar),
				produtoModelList: produtoDriftToModel(produtoUnidadeDrift.produtoGroupedList),
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


	ProdutoUnidadeGrouped toDrift(ProdutoUnidadeModel produtoUnidadeModel) {
		return ProdutoUnidadeGrouped(
			produtoUnidade: ProdutoUnidade(
				id: produtoUnidadeModel.id,
				sigla: produtoUnidadeModel.sigla,
				descricao: produtoUnidadeModel.descricao,
				podeFracionar: ProdutoUnidadeDomain.setPodeFracionar(produtoUnidadeModel.podeFracionar),
			),
			produtoGroupedList: produtoModelToDrift(produtoUnidadeModel.produtoModelList),
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
