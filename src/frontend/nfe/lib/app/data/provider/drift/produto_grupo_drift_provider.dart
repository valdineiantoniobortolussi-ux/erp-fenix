import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ProdutoGrupoDriftProvider extends ProviderBase {

	Future<List<ProdutoGrupoModel>?> getList({Filter? filter}) async {
		List<ProdutoGrupoGrouped> produtoGrupoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				produtoGrupoDriftList = await Session.database.produtoGrupoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				produtoGrupoDriftList = await Session.database.produtoGrupoDao.getGroupedList(); 
			}
			if (produtoGrupoDriftList.isNotEmpty) {
				return toListModel(produtoGrupoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ProdutoGrupoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.produtoGrupoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoGrupoModel?>? insert(ProdutoGrupoModel produtoGrupoModel) async {
		try {
			final lastPk = await Session.database.produtoGrupoDao.insertObject(toDrift(produtoGrupoModel));
			produtoGrupoModel.id = lastPk;
			return produtoGrupoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProdutoGrupoModel?>? update(ProdutoGrupoModel produtoGrupoModel) async {
		try {
			await Session.database.produtoGrupoDao.updateObject(toDrift(produtoGrupoModel));
			return produtoGrupoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.produtoGrupoDao.deleteObject(toDrift(ProdutoGrupoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ProdutoGrupoModel> toListModel(List<ProdutoGrupoGrouped> produtoGrupoDriftList) {
		List<ProdutoGrupoModel> listModel = [];
		for (var produtoGrupoDrift in produtoGrupoDriftList) {
			listModel.add(toModel(produtoGrupoDrift)!);
		}
		return listModel;
	}	

	ProdutoGrupoModel? toModel(ProdutoGrupoGrouped? produtoGrupoDrift) {
		if (produtoGrupoDrift != null) {
			return ProdutoGrupoModel(
				id: produtoGrupoDrift.produtoGrupo?.id,
				nome: produtoGrupoDrift.produtoGrupo?.nome,
				descricao: produtoGrupoDrift.produtoGrupo?.descricao,
				produtoSubgrupoModelList: produtoSubgrupoDriftToModel(produtoGrupoDrift.produtoSubgrupoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<ProdutoSubgrupoModel> produtoSubgrupoDriftToModel(List<ProdutoSubgrupoGrouped>? produtoSubgrupoDriftList) { 
		List<ProdutoSubgrupoModel> produtoSubgrupoModelList = [];
		if (produtoSubgrupoDriftList != null) {
			for (var produtoSubgrupoGrouped in produtoSubgrupoDriftList) {
				produtoSubgrupoModelList.add(
					ProdutoSubgrupoModel(
						id: produtoSubgrupoGrouped.produtoSubgrupo?.id,
						idProdutoGrupo: produtoSubgrupoGrouped.produtoSubgrupo?.idProdutoGrupo,
						nome: produtoSubgrupoGrouped.produtoSubgrupo?.nome,
						descricao: produtoSubgrupoGrouped.produtoSubgrupo?.descricao,
					)
				);
			}
			return produtoSubgrupoModelList;
		}
		return [];
	}


	ProdutoGrupoGrouped toDrift(ProdutoGrupoModel produtoGrupoModel) {
		return ProdutoGrupoGrouped(
			produtoGrupo: ProdutoGrupo(
				id: produtoGrupoModel.id,
				nome: produtoGrupoModel.nome,
				descricao: produtoGrupoModel.descricao,
			),
			produtoSubgrupoGroupedList: produtoSubgrupoModelToDrift(produtoGrupoModel.produtoSubgrupoModelList),
		);
	}

	List<ProdutoSubgrupoGrouped> produtoSubgrupoModelToDrift(List<ProdutoSubgrupoModel>? produtoSubgrupoModelList) { 
		List<ProdutoSubgrupoGrouped> produtoSubgrupoGroupedList = [];
		if (produtoSubgrupoModelList != null) {
			for (var produtoSubgrupoModel in produtoSubgrupoModelList) {
				produtoSubgrupoGroupedList.add(
					ProdutoSubgrupoGrouped(
						produtoSubgrupo: ProdutoSubgrupo(
							id: produtoSubgrupoModel.id,
							idProdutoGrupo: produtoSubgrupoModel.idProdutoGrupo,
							nome: produtoSubgrupoModel.nome,
							descricao: produtoSubgrupoModel.descricao,
						),
					),
				);
			}
			return produtoSubgrupoGroupedList;
		}
		return [];
	}

		
}
