import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

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
				podeFracionar: ProdutoUnidadeDomain.getPodeFracionar(produtoUnidadeDrift.produtoUnidade?.podeFracionar),
				descricao: produtoUnidadeDrift.produtoUnidade?.descricao,
			);
		} else {
			return null;
		}
	}


	ProdutoUnidadeGrouped toDrift(ProdutoUnidadeModel produtoUnidadeModel) {
		return ProdutoUnidadeGrouped(
			produtoUnidade: ProdutoUnidade(
				id: produtoUnidadeModel.id,
				sigla: produtoUnidadeModel.sigla,
				podeFracionar: ProdutoUnidadeDomain.setPodeFracionar(produtoUnidadeModel.podeFracionar),
				descricao: produtoUnidadeModel.descricao,
			),
		);
	}

		
}
