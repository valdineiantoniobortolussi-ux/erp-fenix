import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/data/domain/domain_imports.dart';

class WmsOrdemSeparacaoCabDriftProvider extends ProviderBase {

	Future<List<WmsOrdemSeparacaoCabModel>?> getList({Filter? filter}) async {
		List<WmsOrdemSeparacaoCabGrouped> wmsOrdemSeparacaoCabDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsOrdemSeparacaoCabDriftList = await Session.database.wmsOrdemSeparacaoCabDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsOrdemSeparacaoCabDriftList = await Session.database.wmsOrdemSeparacaoCabDao.getGroupedList(); 
			}
			if (wmsOrdemSeparacaoCabDriftList.isNotEmpty) {
				return toListModel(wmsOrdemSeparacaoCabDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsOrdemSeparacaoCabModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsOrdemSeparacaoCabDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsOrdemSeparacaoCabModel?>? insert(WmsOrdemSeparacaoCabModel wmsOrdemSeparacaoCabModel) async {
		try {
			final lastPk = await Session.database.wmsOrdemSeparacaoCabDao.insertObject(toDrift(wmsOrdemSeparacaoCabModel));
			wmsOrdemSeparacaoCabModel.id = lastPk;
			return wmsOrdemSeparacaoCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsOrdemSeparacaoCabModel?>? update(WmsOrdemSeparacaoCabModel wmsOrdemSeparacaoCabModel) async {
		try {
			await Session.database.wmsOrdemSeparacaoCabDao.updateObject(toDrift(wmsOrdemSeparacaoCabModel));
			return wmsOrdemSeparacaoCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsOrdemSeparacaoCabDao.deleteObject(toDrift(WmsOrdemSeparacaoCabModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsOrdemSeparacaoCabModel> toListModel(List<WmsOrdemSeparacaoCabGrouped> wmsOrdemSeparacaoCabDriftList) {
		List<WmsOrdemSeparacaoCabModel> listModel = [];
		for (var wmsOrdemSeparacaoCabDrift in wmsOrdemSeparacaoCabDriftList) {
			listModel.add(toModel(wmsOrdemSeparacaoCabDrift)!);
		}
		return listModel;
	}	

	WmsOrdemSeparacaoCabModel? toModel(WmsOrdemSeparacaoCabGrouped? wmsOrdemSeparacaoCabDrift) {
		if (wmsOrdemSeparacaoCabDrift != null) {
			return WmsOrdemSeparacaoCabModel(
				id: wmsOrdemSeparacaoCabDrift.wmsOrdemSeparacaoCab?.id,
				origem: WmsOrdemSeparacaoCabDomain.getOrigem(wmsOrdemSeparacaoCabDrift.wmsOrdemSeparacaoCab?.origem),
				dataSolicitacao: wmsOrdemSeparacaoCabDrift.wmsOrdemSeparacaoCab?.dataSolicitacao,
				dataLimite: wmsOrdemSeparacaoCabDrift.wmsOrdemSeparacaoCab?.dataLimite,
				wmsOrdemSeparacaoDetModelList: wmsOrdemSeparacaoDetDriftToModel(wmsOrdemSeparacaoCabDrift.wmsOrdemSeparacaoDetGroupedList),
			);
		} else {
			return null;
		}
	}

	List<WmsOrdemSeparacaoDetModel> wmsOrdemSeparacaoDetDriftToModel(List<WmsOrdemSeparacaoDetGrouped>? wmsOrdemSeparacaoDetDriftList) { 
		List<WmsOrdemSeparacaoDetModel> wmsOrdemSeparacaoDetModelList = [];
		if (wmsOrdemSeparacaoDetDriftList != null) {
			for (var wmsOrdemSeparacaoDetGrouped in wmsOrdemSeparacaoDetDriftList) {
				wmsOrdemSeparacaoDetModelList.add(
					WmsOrdemSeparacaoDetModel(
						id: wmsOrdemSeparacaoDetGrouped.wmsOrdemSeparacaoDet?.id,
						idWmsOrdemSeparacaoCab: wmsOrdemSeparacaoDetGrouped.wmsOrdemSeparacaoDet?.idWmsOrdemSeparacaoCab,
						idProduto: wmsOrdemSeparacaoDetGrouped.wmsOrdemSeparacaoDet?.idProduto,
						produtoModel: ProdutoModel(
							id: wmsOrdemSeparacaoDetGrouped.produto?.id,
							idTributIcmsCustomCab: wmsOrdemSeparacaoDetGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: wmsOrdemSeparacaoDetGrouped.produto?.idTributGrupoTributario,
							nome: wmsOrdemSeparacaoDetGrouped.produto?.nome,
							descricao: wmsOrdemSeparacaoDetGrouped.produto?.descricao,
							gtin: wmsOrdemSeparacaoDetGrouped.produto?.gtin,
							codigoInterno: wmsOrdemSeparacaoDetGrouped.produto?.codigoInterno,
							valorCompra: wmsOrdemSeparacaoDetGrouped.produto?.valorCompra,
							valorVenda: wmsOrdemSeparacaoDetGrouped.produto?.valorVenda,
							codigoNcm: wmsOrdemSeparacaoDetGrouped.produto?.codigoNcm,
							estoqueMinimo: wmsOrdemSeparacaoDetGrouped.produto?.estoqueMinimo,
							estoqueMaximo: wmsOrdemSeparacaoDetGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: wmsOrdemSeparacaoDetGrouped.produto?.quantidadeEstoque,
							dataCadastro: wmsOrdemSeparacaoDetGrouped.produto?.dataCadastro,
						),
						quantidade: wmsOrdemSeparacaoDetGrouped.wmsOrdemSeparacaoDet?.quantidade,
					)
				);
			}
			return wmsOrdemSeparacaoDetModelList;
		}
		return [];
	}


	WmsOrdemSeparacaoCabGrouped toDrift(WmsOrdemSeparacaoCabModel wmsOrdemSeparacaoCabModel) {
		return WmsOrdemSeparacaoCabGrouped(
			wmsOrdemSeparacaoCab: WmsOrdemSeparacaoCab(
				id: wmsOrdemSeparacaoCabModel.id,
				origem: WmsOrdemSeparacaoCabDomain.setOrigem(wmsOrdemSeparacaoCabModel.origem),
				dataSolicitacao: wmsOrdemSeparacaoCabModel.dataSolicitacao,
				dataLimite: wmsOrdemSeparacaoCabModel.dataLimite,
			),
			wmsOrdemSeparacaoDetGroupedList: wmsOrdemSeparacaoDetModelToDrift(wmsOrdemSeparacaoCabModel.wmsOrdemSeparacaoDetModelList),
		);
	}

	List<WmsOrdemSeparacaoDetGrouped> wmsOrdemSeparacaoDetModelToDrift(List<WmsOrdemSeparacaoDetModel>? wmsOrdemSeparacaoDetModelList) { 
		List<WmsOrdemSeparacaoDetGrouped> wmsOrdemSeparacaoDetGroupedList = [];
		if (wmsOrdemSeparacaoDetModelList != null) {
			for (var wmsOrdemSeparacaoDetModel in wmsOrdemSeparacaoDetModelList) {
				wmsOrdemSeparacaoDetGroupedList.add(
					WmsOrdemSeparacaoDetGrouped(
						wmsOrdemSeparacaoDet: WmsOrdemSeparacaoDet(
							id: wmsOrdemSeparacaoDetModel.id,
							idWmsOrdemSeparacaoCab: wmsOrdemSeparacaoDetModel.idWmsOrdemSeparacaoCab,
							idProduto: wmsOrdemSeparacaoDetModel.idProduto,
							quantidade: wmsOrdemSeparacaoDetModel.quantidade,
						),
					),
				);
			}
			return wmsOrdemSeparacaoDetGroupedList;
		}
		return [];
	}

		
}
