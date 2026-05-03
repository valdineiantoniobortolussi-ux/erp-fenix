import 'package:inventario/app/data/provider/drift/database/database_imports.dart';
import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/data/provider/provider_base.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:inventario/app/data/domain/domain_imports.dart';

class InventarioContagemCabDriftProvider extends ProviderBase {

	Future<List<InventarioContagemCabModel>?> getList({Filter? filter}) async {
		List<InventarioContagemCabGrouped> inventarioContagemCabDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				inventarioContagemCabDriftList = await Session.database.inventarioContagemCabDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				inventarioContagemCabDriftList = await Session.database.inventarioContagemCabDao.getGroupedList(); 
			}
			if (inventarioContagemCabDriftList.isNotEmpty) {
				return toListModel(inventarioContagemCabDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<InventarioContagemCabModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.inventarioContagemCabDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<InventarioContagemCabModel?>? insert(InventarioContagemCabModel inventarioContagemCabModel) async {
		try {
			final lastPk = await Session.database.inventarioContagemCabDao.insertObject(toDrift(inventarioContagemCabModel));
			inventarioContagemCabModel.id = lastPk;
			return inventarioContagemCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<InventarioContagemCabModel?>? update(InventarioContagemCabModel inventarioContagemCabModel) async {
		try {
			await Session.database.inventarioContagemCabDao.updateObject(toDrift(inventarioContagemCabModel));
			return inventarioContagemCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.inventarioContagemCabDao.deleteObject(toDrift(InventarioContagemCabModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<InventarioContagemCabModel> toListModel(List<InventarioContagemCabGrouped> inventarioContagemCabDriftList) {
		List<InventarioContagemCabModel> listModel = [];
		for (var inventarioContagemCabDrift in inventarioContagemCabDriftList) {
			listModel.add(toModel(inventarioContagemCabDrift)!);
		}
		return listModel;
	}	

	InventarioContagemCabModel? toModel(InventarioContagemCabGrouped? inventarioContagemCabDrift) {
		if (inventarioContagemCabDrift != null) {
			return InventarioContagemCabModel(
				id: inventarioContagemCabDrift.inventarioContagemCab?.id,
				dataContagem: inventarioContagemCabDrift.inventarioContagemCab?.dataContagem,
				estoqueAtualizado: InventarioContagemCabDomain.getEstoqueAtualizado(inventarioContagemCabDrift.inventarioContagemCab?.estoqueAtualizado),
				tipo: InventarioContagemCabDomain.getTipo(inventarioContagemCabDrift.inventarioContagemCab?.tipo),
				inventarioContagemDetModelList: inventarioContagemDetDriftToModel(inventarioContagemCabDrift.inventarioContagemDetGroupedList),
			);
		} else {
			return null;
		}
	}

	List<InventarioContagemDetModel> inventarioContagemDetDriftToModel(List<InventarioContagemDetGrouped>? inventarioContagemDetDriftList) { 
		List<InventarioContagemDetModel> inventarioContagemDetModelList = [];
		if (inventarioContagemDetDriftList != null) {
			for (var inventarioContagemDetGrouped in inventarioContagemDetDriftList) {
				inventarioContagemDetModelList.add(
					InventarioContagemDetModel(
						id: inventarioContagemDetGrouped.inventarioContagemDet?.id,
						idInventarioContagemCab: inventarioContagemDetGrouped.inventarioContagemDet?.idInventarioContagemCab,
						idProduto: inventarioContagemDetGrouped.inventarioContagemDet?.idProduto,
						produtoModel: ProdutoModel(
							id: inventarioContagemDetGrouped.produto?.id,
							idTributIcmsCustomCab: inventarioContagemDetGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: inventarioContagemDetGrouped.produto?.idTributGrupoTributario,
							nome: inventarioContagemDetGrouped.produto?.nome,
							descricao: inventarioContagemDetGrouped.produto?.descricao,
							gtin: inventarioContagemDetGrouped.produto?.gtin,
							codigoInterno: inventarioContagemDetGrouped.produto?.codigoInterno,
							valorCompra: inventarioContagemDetGrouped.produto?.valorCompra,
							valorVenda: inventarioContagemDetGrouped.produto?.valorVenda,
							codigoNcm: inventarioContagemDetGrouped.produto?.codigoNcm,
							estoqueMinimo: inventarioContagemDetGrouped.produto?.estoqueMinimo,
							estoqueMaximo: inventarioContagemDetGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: inventarioContagemDetGrouped.produto?.quantidadeEstoque,
							dataCadastro: inventarioContagemDetGrouped.produto?.dataCadastro,
						),
						contagem01: inventarioContagemDetGrouped.inventarioContagemDet?.contagem01,
						contagem02: inventarioContagemDetGrouped.inventarioContagemDet?.contagem02,
						contagem03: inventarioContagemDetGrouped.inventarioContagemDet?.contagem03,
						fechadoContagem: InventarioContagemDetDomain.getFechadoContagem(inventarioContagemDetGrouped.inventarioContagemDet?.fechadoContagem),
						quantidadeSistema: inventarioContagemDetGrouped.inventarioContagemDet?.quantidadeSistema,
						acuracidade: inventarioContagemDetGrouped.inventarioContagemDet?.acuracidade,
						divergencia: inventarioContagemDetGrouped.inventarioContagemDet?.divergencia,
					)
				);
			}
			return inventarioContagemDetModelList;
		}
		return [];
	}


	InventarioContagemCabGrouped toDrift(InventarioContagemCabModel inventarioContagemCabModel) {
		return InventarioContagemCabGrouped(
			inventarioContagemCab: InventarioContagemCab(
				id: inventarioContagemCabModel.id,
				dataContagem: inventarioContagemCabModel.dataContagem,
				estoqueAtualizado: InventarioContagemCabDomain.setEstoqueAtualizado(inventarioContagemCabModel.estoqueAtualizado),
				tipo: InventarioContagemCabDomain.setTipo(inventarioContagemCabModel.tipo),
			),
			inventarioContagemDetGroupedList: inventarioContagemDetModelToDrift(inventarioContagemCabModel.inventarioContagemDetModelList),
		);
	}

	List<InventarioContagemDetGrouped> inventarioContagemDetModelToDrift(List<InventarioContagemDetModel>? inventarioContagemDetModelList) { 
		List<InventarioContagemDetGrouped> inventarioContagemDetGroupedList = [];
		if (inventarioContagemDetModelList != null) {
			for (var inventarioContagemDetModel in inventarioContagemDetModelList) {
				inventarioContagemDetGroupedList.add(
					InventarioContagemDetGrouped(
						inventarioContagemDet: InventarioContagemDet(
							id: inventarioContagemDetModel.id,
							idInventarioContagemCab: inventarioContagemDetModel.idInventarioContagemCab,
							idProduto: inventarioContagemDetModel.idProduto,
							contagem01: inventarioContagemDetModel.contagem01,
							contagem02: inventarioContagemDetModel.contagem02,
							contagem03: inventarioContagemDetModel.contagem03,
							fechadoContagem: InventarioContagemDetDomain.setFechadoContagem(inventarioContagemDetModel.fechadoContagem),
							quantidadeSistema: inventarioContagemDetModel.quantidadeSistema,
							acuracidade: inventarioContagemDetModel.acuracidade,
							divergencia: inventarioContagemDetModel.divergencia,
						),
					),
				);
			}
			return inventarioContagemDetGroupedList;
		}
		return [];
	}

		
}
