import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ProdutoDriftProvider extends ProviderBase {

	Future<List<ProdutoModel>?> getList({Filter? filter}) async {
		List<ProdutoGrouped> produtoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				produtoDriftList = await Session.database.produtoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				produtoDriftList = await Session.database.produtoDao.getGroupedList(); 
			}
			if (produtoDriftList.isNotEmpty) {
				return toListModel(produtoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ProdutoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.produtoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoModel?>? insert(ProdutoModel produtoModel) async {
		try {
			final lastPk = await Session.database.produtoDao.insertObject(toDrift(produtoModel));
			produtoModel.id = lastPk;
			return produtoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoModel?>? update(ProdutoModel produtoModel) async {
		try {
			await Session.database.produtoDao.updateObject(toDrift(produtoModel));
			return produtoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.produtoDao.deleteObject(toDrift(ProdutoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ProdutoModel> toListModel(List<ProdutoGrouped> produtoDriftList) {
		List<ProdutoModel> listModel = [];
		for (var produtoDrift in produtoDriftList) {
			listModel.add(toModel(produtoDrift)!);
		}
		return listModel;
	}	

	ProdutoModel? toModel(ProdutoGrouped? produtoDrift) {
		if (produtoDrift != null) {
			return ProdutoModel(
				id: produtoDrift.produto?.id,
				idProdutoSubgrupo: produtoDrift.produto?.idProdutoSubgrupo,
				idProdutoMarca: produtoDrift.produto?.idProdutoMarca,
				idProdutoUnidade: produtoDrift.produto?.idProdutoUnidade,
				idTributIcmsCustomCab: produtoDrift.produto?.idTributIcmsCustomCab,
				idTributGrupoTributario: produtoDrift.produto?.idTributGrupoTributario,
				nome: produtoDrift.produto?.nome,
				descricao: produtoDrift.produto?.descricao,
				gtin: produtoDrift.produto?.gtin,
				codigoInterno: produtoDrift.produto?.codigoInterno,
				valorCompra: produtoDrift.produto?.valorCompra,
				valorVenda: produtoDrift.produto?.valorVenda,
				codigoNcm: produtoDrift.produto?.codigoNcm,
				dataCadastro: produtoDrift.produto?.dataCadastro,
				estoqueMinimo: produtoDrift.produto?.estoqueMinimo,
				estoqueMaximo: produtoDrift.produto?.estoqueMaximo,
				quantidadeEstoque: produtoDrift.produto?.quantidadeEstoque,
				produtoMarcaModel: ProdutoMarcaModel(
					id: produtoDrift.produtoMarca?.id,
					nome: produtoDrift.produtoMarca?.nome,
					descricao: produtoDrift.produtoMarca?.descricao,
				),
				produtoUnidadeModel: ProdutoUnidadeModel(
					id: produtoDrift.produtoUnidade?.id,
					sigla: produtoDrift.produtoUnidade?.sigla,
					podeFracionar: produtoDrift.produtoUnidade?.podeFracionar,
					descricao: produtoDrift.produtoUnidade?.descricao,
				),
				produtoSubgrupoModel: ProdutoSubgrupoModel(
					id: produtoDrift.produtoSubgrupo?.id,
					idProdutoGrupo: produtoDrift.produtoSubgrupo?.idProdutoGrupo,
					nome: produtoDrift.produtoSubgrupo?.nome,
					descricao: produtoDrift.produtoSubgrupo?.descricao,
				),
				tributIcmsCustomCabModel: TributIcmsCustomCabModel(
					id: produtoDrift.tributIcmsCustomCab?.id,
					descricao: produtoDrift.tributIcmsCustomCab?.descricao,
					origemMercadoria: produtoDrift.tributIcmsCustomCab?.origemMercadoria,
				),
				tributGrupoTributarioModel: TributGrupoTributarioModel(
					id: produtoDrift.tributGrupoTributario?.id,
					descricao: produtoDrift.tributGrupoTributario?.descricao,
					origemMercadoria: produtoDrift.tributGrupoTributario?.origemMercadoria,
					observacao: produtoDrift.tributGrupoTributario?.observacao,
				),
			);
		} else {
			return null;
		}
	}


	ProdutoGrouped toDrift(ProdutoModel produtoModel) {
		return ProdutoGrouped(
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
				dataCadastro: produtoModel.dataCadastro,
				estoqueMinimo: produtoModel.estoqueMinimo,
				estoqueMaximo: produtoModel.estoqueMaximo,
				quantidadeEstoque: produtoModel.quantidadeEstoque,
			),
		);
	}

		
}
