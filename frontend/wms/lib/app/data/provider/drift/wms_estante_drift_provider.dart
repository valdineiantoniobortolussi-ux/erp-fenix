import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsEstanteDriftProvider extends ProviderBase {

	Future<List<WmsEstanteModel>?> getList({Filter? filter}) async {
		List<WmsEstanteGrouped> wmsEstanteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsEstanteDriftList = await Session.database.wmsEstanteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsEstanteDriftList = await Session.database.wmsEstanteDao.getGroupedList(); 
			}
			if (wmsEstanteDriftList.isNotEmpty) {
				return toListModel(wmsEstanteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsEstanteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsEstanteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsEstanteModel?>? insert(WmsEstanteModel wmsEstanteModel) async {
		try {
			final lastPk = await Session.database.wmsEstanteDao.insertObject(toDrift(wmsEstanteModel));
			wmsEstanteModel.id = lastPk;
			return wmsEstanteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsEstanteModel?>? update(WmsEstanteModel wmsEstanteModel) async {
		try {
			await Session.database.wmsEstanteDao.updateObject(toDrift(wmsEstanteModel));
			return wmsEstanteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsEstanteDao.deleteObject(toDrift(WmsEstanteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsEstanteModel> toListModel(List<WmsEstanteGrouped> wmsEstanteDriftList) {
		List<WmsEstanteModel> listModel = [];
		for (var wmsEstanteDrift in wmsEstanteDriftList) {
			listModel.add(toModel(wmsEstanteDrift)!);
		}
		return listModel;
	}	

	WmsEstanteModel? toModel(WmsEstanteGrouped? wmsEstanteDrift) {
		if (wmsEstanteDrift != null) {
			return WmsEstanteModel(
				id: wmsEstanteDrift.wmsEstante?.id,
				idWmsRua: wmsEstanteDrift.wmsEstante?.idWmsRua,
				codigo: wmsEstanteDrift.wmsEstante?.codigo,
				quantidadeCaixa: wmsEstanteDrift.wmsEstante?.quantidadeCaixa,
				wmsRuaModel: WmsRuaModel(
					id: wmsEstanteDrift.wmsRua?.id,
					codigo: wmsEstanteDrift.wmsRua?.codigo,
					quantidadeEstante: wmsEstanteDrift.wmsRua?.quantidadeEstante,
					nome: wmsEstanteDrift.wmsRua?.nome,
				),
			);
		} else {
			return null;
		}
	}


	WmsEstanteGrouped toDrift(WmsEstanteModel wmsEstanteModel) {
		return WmsEstanteGrouped(
			wmsEstante: WmsEstante(
				id: wmsEstanteModel.id,
				idWmsRua: wmsEstanteModel.idWmsRua,
				codigo: wmsEstanteModel.codigo,
				quantidadeCaixa: wmsEstanteModel.quantidadeCaixa,
			),
		);
	}

		
}
