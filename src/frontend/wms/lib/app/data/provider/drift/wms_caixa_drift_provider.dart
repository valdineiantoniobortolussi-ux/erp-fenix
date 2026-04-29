import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsCaixaDriftProvider extends ProviderBase {

	Future<List<WmsCaixaModel>?> getList({Filter? filter}) async {
		List<WmsCaixaGrouped> wmsCaixaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsCaixaDriftList = await Session.database.wmsCaixaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsCaixaDriftList = await Session.database.wmsCaixaDao.getGroupedList(); 
			}
			if (wmsCaixaDriftList.isNotEmpty) {
				return toListModel(wmsCaixaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsCaixaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsCaixaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsCaixaModel?>? insert(WmsCaixaModel wmsCaixaModel) async {
		try {
			final lastPk = await Session.database.wmsCaixaDao.insertObject(toDrift(wmsCaixaModel));
			wmsCaixaModel.id = lastPk;
			return wmsCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsCaixaModel?>? update(WmsCaixaModel wmsCaixaModel) async {
		try {
			await Session.database.wmsCaixaDao.updateObject(toDrift(wmsCaixaModel));
			return wmsCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsCaixaDao.deleteObject(toDrift(WmsCaixaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsCaixaModel> toListModel(List<WmsCaixaGrouped> wmsCaixaDriftList) {
		List<WmsCaixaModel> listModel = [];
		for (var wmsCaixaDrift in wmsCaixaDriftList) {
			listModel.add(toModel(wmsCaixaDrift)!);
		}
		return listModel;
	}	

	WmsCaixaModel? toModel(WmsCaixaGrouped? wmsCaixaDrift) {
		if (wmsCaixaDrift != null) {
			return WmsCaixaModel(
				id: wmsCaixaDrift.wmsCaixa?.id,
				idWmsEstante: wmsCaixaDrift.wmsCaixa?.idWmsEstante,
				codigo: wmsCaixaDrift.wmsCaixa?.codigo,
				altura: wmsCaixaDrift.wmsCaixa?.altura,
				largura: wmsCaixaDrift.wmsCaixa?.largura,
				profundidade: wmsCaixaDrift.wmsCaixa?.profundidade,
				wmsArmazenamentoModelList: wmsArmazenamentoDriftToModel(wmsCaixaDrift.wmsArmazenamentoGroupedList),
				wmsEstanteModel: WmsEstanteModel(
					id: wmsCaixaDrift.wmsEstante?.id,
					idWmsRua: wmsCaixaDrift.wmsEstante?.idWmsRua,
					codigo: wmsCaixaDrift.wmsEstante?.codigo,
					quantidadeCaixa: wmsCaixaDrift.wmsEstante?.quantidadeCaixa,
				),
			);
		} else {
			return null;
		}
	}

	List<WmsArmazenamentoModel> wmsArmazenamentoDriftToModel(List<WmsArmazenamentoGrouped>? wmsArmazenamentoDriftList) { 
		List<WmsArmazenamentoModel> wmsArmazenamentoModelList = [];
		if (wmsArmazenamentoDriftList != null) {
			for (var wmsArmazenamentoGrouped in wmsArmazenamentoDriftList) {
				wmsArmazenamentoModelList.add(
					WmsArmazenamentoModel(
						id: wmsArmazenamentoGrouped.wmsArmazenamento?.id,
						idWmsCaixa: wmsArmazenamentoGrouped.wmsArmazenamento?.idWmsCaixa,
						idWmsRecebimentoDetalhe: wmsArmazenamentoGrouped.wmsArmazenamento?.idWmsRecebimentoDetalhe,
						wmsRecebimentoDetalheModel: WmsRecebimentoDetalheModel(
							id: wmsArmazenamentoGrouped.wmsRecebimentoDetalhe?.id,
							idWmsRecebimentoCabecalho: wmsArmazenamentoGrouped.wmsRecebimentoDetalhe?.idWmsRecebimentoCabecalho,
							idProduto: wmsArmazenamentoGrouped.wmsRecebimentoDetalhe?.idProduto,
							quantidadeVolume: wmsArmazenamentoGrouped.wmsRecebimentoDetalhe?.quantidadeVolume,
							quantidadeItemPorVolume: wmsArmazenamentoGrouped.wmsRecebimentoDetalhe?.quantidadeItemPorVolume,
							quantidadeRecebida: wmsArmazenamentoGrouped.wmsRecebimentoDetalhe?.quantidadeRecebida,
							destino: wmsArmazenamentoGrouped.wmsRecebimentoDetalhe?.destino,
						),
						quantidade: wmsArmazenamentoGrouped.wmsArmazenamento?.quantidade,
					)
				);
			}
			return wmsArmazenamentoModelList;
		}
		return [];
	}


	WmsCaixaGrouped toDrift(WmsCaixaModel wmsCaixaModel) {
		return WmsCaixaGrouped(
			wmsCaixa: WmsCaixa(
				id: wmsCaixaModel.id,
				idWmsEstante: wmsCaixaModel.idWmsEstante,
				codigo: wmsCaixaModel.codigo,
				altura: wmsCaixaModel.altura,
				largura: wmsCaixaModel.largura,
				profundidade: wmsCaixaModel.profundidade,
			),
			wmsArmazenamentoGroupedList: wmsArmazenamentoModelToDrift(wmsCaixaModel.wmsArmazenamentoModelList),
		);
	}

	List<WmsArmazenamentoGrouped> wmsArmazenamentoModelToDrift(List<WmsArmazenamentoModel>? wmsArmazenamentoModelList) { 
		List<WmsArmazenamentoGrouped> wmsArmazenamentoGroupedList = [];
		if (wmsArmazenamentoModelList != null) {
			for (var wmsArmazenamentoModel in wmsArmazenamentoModelList) {
				wmsArmazenamentoGroupedList.add(
					WmsArmazenamentoGrouped(
						wmsArmazenamento: WmsArmazenamento(
							id: wmsArmazenamentoModel.id,
							idWmsCaixa: wmsArmazenamentoModel.idWmsCaixa,
							idWmsRecebimentoDetalhe: wmsArmazenamentoModel.idWmsRecebimentoDetalhe,
							quantidade: wmsArmazenamentoModel.quantidade,
						),
					),
				);
			}
			return wmsArmazenamentoGroupedList;
		}
		return [];
	}

		
}
