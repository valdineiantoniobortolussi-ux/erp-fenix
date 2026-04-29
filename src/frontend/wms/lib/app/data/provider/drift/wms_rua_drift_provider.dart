import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsRuaDriftProvider extends ProviderBase {

	Future<List<WmsRuaModel>?> getList({Filter? filter}) async {
		List<WmsRuaGrouped> wmsRuaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsRuaDriftList = await Session.database.wmsRuaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsRuaDriftList = await Session.database.wmsRuaDao.getGroupedList(); 
			}
			if (wmsRuaDriftList.isNotEmpty) {
				return toListModel(wmsRuaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsRuaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsRuaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsRuaModel?>? insert(WmsRuaModel wmsRuaModel) async {
		try {
			final lastPk = await Session.database.wmsRuaDao.insertObject(toDrift(wmsRuaModel));
			wmsRuaModel.id = lastPk;
			return wmsRuaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsRuaModel?>? update(WmsRuaModel wmsRuaModel) async {
		try {
			await Session.database.wmsRuaDao.updateObject(toDrift(wmsRuaModel));
			return wmsRuaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsRuaDao.deleteObject(toDrift(WmsRuaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsRuaModel> toListModel(List<WmsRuaGrouped> wmsRuaDriftList) {
		List<WmsRuaModel> listModel = [];
		for (var wmsRuaDrift in wmsRuaDriftList) {
			listModel.add(toModel(wmsRuaDrift)!);
		}
		return listModel;
	}	

	WmsRuaModel? toModel(WmsRuaGrouped? wmsRuaDrift) {
		if (wmsRuaDrift != null) {
			return WmsRuaModel(
				id: wmsRuaDrift.wmsRua?.id,
				codigo: wmsRuaDrift.wmsRua?.codigo,
				quantidadeEstante: wmsRuaDrift.wmsRua?.quantidadeEstante,
				nome: wmsRuaDrift.wmsRua?.nome,
			);
		} else {
			return null;
		}
	}


	WmsRuaGrouped toDrift(WmsRuaModel wmsRuaModel) {
		return WmsRuaGrouped(
			wmsRua: WmsRua(
				id: wmsRuaModel.id,
				codigo: wmsRuaModel.codigo,
				quantidadeEstante: wmsRuaModel.quantidadeEstante,
				nome: wmsRuaModel.nome,
			),
		);
	}

		
}
