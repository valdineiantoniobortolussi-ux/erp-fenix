import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

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
			);
		} else {
			return null;
		}
	}


	ProdutoMarcaGrouped toDrift(ProdutoMarcaModel produtoMarcaModel) {
		return ProdutoMarcaGrouped(
			produtoMarca: ProdutoMarca(
				id: produtoMarcaModel.id,
				nome: produtoMarcaModel.nome,
				descricao: produtoMarcaModel.descricao,
			),
		);
	}

		
}
