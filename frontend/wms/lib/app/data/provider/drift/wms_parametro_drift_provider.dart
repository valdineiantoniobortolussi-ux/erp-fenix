import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/data/domain/domain_imports.dart';

class WmsParametroDriftProvider extends ProviderBase {

	Future<List<WmsParametroModel>?> getList({Filter? filter}) async {
		List<WmsParametroGrouped> wmsParametroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsParametroDriftList = await Session.database.wmsParametroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsParametroDriftList = await Session.database.wmsParametroDao.getGroupedList(); 
			}
			if (wmsParametroDriftList.isNotEmpty) {
				return toListModel(wmsParametroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsParametroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsParametroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsParametroModel?>? insert(WmsParametroModel wmsParametroModel) async {
		try {
			final lastPk = await Session.database.wmsParametroDao.insertObject(toDrift(wmsParametroModel));
			wmsParametroModel.id = lastPk;
			return wmsParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsParametroModel?>? update(WmsParametroModel wmsParametroModel) async {
		try {
			await Session.database.wmsParametroDao.updateObject(toDrift(wmsParametroModel));
			return wmsParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsParametroDao.deleteObject(toDrift(WmsParametroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsParametroModel> toListModel(List<WmsParametroGrouped> wmsParametroDriftList) {
		List<WmsParametroModel> listModel = [];
		for (var wmsParametroDrift in wmsParametroDriftList) {
			listModel.add(toModel(wmsParametroDrift)!);
		}
		return listModel;
	}	

	WmsParametroModel? toModel(WmsParametroGrouped? wmsParametroDrift) {
		if (wmsParametroDrift != null) {
			return WmsParametroModel(
				id: wmsParametroDrift.wmsParametro?.id,
				horaPorVolume: wmsParametroDrift.wmsParametro?.horaPorVolume,
				pessoaPorVolume: wmsParametroDrift.wmsParametro?.pessoaPorVolume,
				horaPorPeso: wmsParametroDrift.wmsParametro?.horaPorPeso,
				pessoaPorPeso: wmsParametroDrift.wmsParametro?.pessoaPorPeso,
				itemDiferenteCaixa: WmsParametroDomain.getItemDiferenteCaixa(wmsParametroDrift.wmsParametro?.itemDiferenteCaixa),
			);
		} else {
			return null;
		}
	}


	WmsParametroGrouped toDrift(WmsParametroModel wmsParametroModel) {
		return WmsParametroGrouped(
			wmsParametro: WmsParametro(
				id: wmsParametroModel.id,
				horaPorVolume: wmsParametroModel.horaPorVolume,
				pessoaPorVolume: wmsParametroModel.pessoaPorVolume,
				horaPorPeso: wmsParametroModel.horaPorPeso,
				pessoaPorPeso: wmsParametroModel.pessoaPorPeso,
				itemDiferenteCaixa: WmsParametroDomain.setItemDiferenteCaixa(wmsParametroModel.itemDiferenteCaixa),
			),
		);
	}

		
}
