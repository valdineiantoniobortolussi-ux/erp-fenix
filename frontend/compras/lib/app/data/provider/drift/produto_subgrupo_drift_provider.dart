import 'package:compras/app/data/provider/drift/database/database_imports.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/provider/provider_base.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/model/model_imports.dart';

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
				produtoGrupoModel: ProdutoGrupoModel(
					id: produtoSubgrupoDrift.produtoGrupo?.id,
					nome: produtoSubgrupoDrift.produtoGrupo?.nome,
					descricao: produtoSubgrupoDrift.produtoGrupo?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	ProdutoSubgrupoGrouped toDrift(ProdutoSubgrupoModel produtoSubgrupoModel) {
		return ProdutoSubgrupoGrouped(
			produtoSubgrupo: ProdutoSubgrupo(
				id: produtoSubgrupoModel.id,
				idProdutoGrupo: produtoSubgrupoModel.idProdutoGrupo,
				nome: produtoSubgrupoModel.nome,
				descricao: produtoSubgrupoModel.descricao,
			),
		);
	}

		
}
