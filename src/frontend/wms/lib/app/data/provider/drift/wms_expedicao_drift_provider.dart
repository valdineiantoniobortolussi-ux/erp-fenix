import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsExpedicaoDriftProvider extends ProviderBase {

	Future<List<WmsExpedicaoModel>?> getList({Filter? filter}) async {
		List<WmsExpedicaoGrouped> wmsExpedicaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsExpedicaoDriftList = await Session.database.wmsExpedicaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsExpedicaoDriftList = await Session.database.wmsExpedicaoDao.getGroupedList(); 
			}
			if (wmsExpedicaoDriftList.isNotEmpty) {
				return toListModel(wmsExpedicaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsExpedicaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsExpedicaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsExpedicaoModel?>? insert(WmsExpedicaoModel wmsExpedicaoModel) async {
		try {
			final lastPk = await Session.database.wmsExpedicaoDao.insertObject(toDrift(wmsExpedicaoModel));
			wmsExpedicaoModel.id = lastPk;
			return wmsExpedicaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsExpedicaoModel?>? update(WmsExpedicaoModel wmsExpedicaoModel) async {
		try {
			await Session.database.wmsExpedicaoDao.updateObject(toDrift(wmsExpedicaoModel));
			return wmsExpedicaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsExpedicaoDao.deleteObject(toDrift(WmsExpedicaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsExpedicaoModel> toListModel(List<WmsExpedicaoGrouped> wmsExpedicaoDriftList) {
		List<WmsExpedicaoModel> listModel = [];
		for (var wmsExpedicaoDrift in wmsExpedicaoDriftList) {
			listModel.add(toModel(wmsExpedicaoDrift)!);
		}
		return listModel;
	}	

	WmsExpedicaoModel? toModel(WmsExpedicaoGrouped? wmsExpedicaoDrift) {
		if (wmsExpedicaoDrift != null) {
			return WmsExpedicaoModel(
				id: wmsExpedicaoDrift.wmsExpedicao?.id,
				idWmsOrdemSeparacaoDet: wmsExpedicaoDrift.wmsExpedicao?.idWmsOrdemSeparacaoDet,
				idWmsArmazenamento: wmsExpedicaoDrift.wmsExpedicao?.idWmsArmazenamento,
				quantidade: wmsExpedicaoDrift.wmsExpedicao?.quantidade,
				dataSaida: wmsExpedicaoDrift.wmsExpedicao?.dataSaida,
				wmsOrdemSeparacaoDetModel: WmsOrdemSeparacaoDetModel(
					id: wmsExpedicaoDrift.wmsOrdemSeparacaoDet?.id,
					idWmsOrdemSeparacaoCab: wmsExpedicaoDrift.wmsOrdemSeparacaoDet?.idWmsOrdemSeparacaoCab,
					idProduto: wmsExpedicaoDrift.wmsOrdemSeparacaoDet?.idProduto,
					quantidade: wmsExpedicaoDrift.wmsOrdemSeparacaoDet?.quantidade,
				),
				wmsArmazenamentoModel: WmsArmazenamentoModel(
					id: wmsExpedicaoDrift.wmsArmazenamento?.id,
					idWmsCaixa: wmsExpedicaoDrift.wmsArmazenamento?.idWmsCaixa,
					idWmsRecebimentoDetalhe: wmsExpedicaoDrift.wmsArmazenamento?.idWmsRecebimentoDetalhe,
					quantidade: wmsExpedicaoDrift.wmsArmazenamento?.quantidade,
				),
			);
		} else {
			return null;
		}
	}


	WmsExpedicaoGrouped toDrift(WmsExpedicaoModel wmsExpedicaoModel) {
		return WmsExpedicaoGrouped(
			wmsExpedicao: WmsExpedicao(
				id: wmsExpedicaoModel.id,
				idWmsOrdemSeparacaoDet: wmsExpedicaoModel.idWmsOrdemSeparacaoDet,
				idWmsArmazenamento: wmsExpedicaoModel.idWmsArmazenamento,
				quantidade: wmsExpedicaoModel.quantidade,
				dataSaida: wmsExpedicaoModel.dataSaida,
			),
		);
	}

		
}
