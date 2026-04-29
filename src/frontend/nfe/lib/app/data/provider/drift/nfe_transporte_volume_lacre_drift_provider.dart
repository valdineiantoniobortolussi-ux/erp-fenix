import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeLacreDriftProvider extends ProviderBase {

	Future<List<NfeTransporteVolumeLacreModel>?> getList({Filter? filter}) async {
		List<NfeTransporteVolumeLacreGrouped> nfeTransporteVolumeLacreDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeTransporteVolumeLacreDriftList = await Session.database.nfeTransporteVolumeLacreDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeTransporteVolumeLacreDriftList = await Session.database.nfeTransporteVolumeLacreDao.getGroupedList(); 
			}
			if (nfeTransporteVolumeLacreDriftList.isNotEmpty) {
				return toListModel(nfeTransporteVolumeLacreDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeTransporteVolumeLacreModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeTransporteVolumeLacreDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeTransporteVolumeLacreModel?>? insert(NfeTransporteVolumeLacreModel nfeTransporteVolumeLacreModel) async {
		try {
			final lastPk = await Session.database.nfeTransporteVolumeLacreDao.insertObject(toDrift(nfeTransporteVolumeLacreModel));
			nfeTransporteVolumeLacreModel.id = lastPk;
			return nfeTransporteVolumeLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeTransporteVolumeLacreModel?>? update(NfeTransporteVolumeLacreModel nfeTransporteVolumeLacreModel) async {
		try {
			await Session.database.nfeTransporteVolumeLacreDao.updateObject(toDrift(nfeTransporteVolumeLacreModel));
			return nfeTransporteVolumeLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeTransporteVolumeLacreDao.deleteObject(toDrift(NfeTransporteVolumeLacreModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeTransporteVolumeLacreModel> toListModel(List<NfeTransporteVolumeLacreGrouped> nfeTransporteVolumeLacreDriftList) {
		List<NfeTransporteVolumeLacreModel> listModel = [];
		for (var nfeTransporteVolumeLacreDrift in nfeTransporteVolumeLacreDriftList) {
			listModel.add(toModel(nfeTransporteVolumeLacreDrift)!);
		}
		return listModel;
	}	

	NfeTransporteVolumeLacreModel? toModel(NfeTransporteVolumeLacreGrouped? nfeTransporteVolumeLacreDrift) {
		if (nfeTransporteVolumeLacreDrift != null) {
			return NfeTransporteVolumeLacreModel(
				id: nfeTransporteVolumeLacreDrift.nfeTransporteVolumeLacre?.id,
				idNfeTransporteVolume: nfeTransporteVolumeLacreDrift.nfeTransporteVolumeLacre?.idNfeTransporteVolume,
				numero: nfeTransporteVolumeLacreDrift.nfeTransporteVolumeLacre?.numero,
				nfeTransporteVolumeModel: NfeTransporteVolumeModel(
					id: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.id,
					idNfeTransporte: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.idNfeTransporte,
					quantidade: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.quantidade,
					especie: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.especie,
					marca: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.marca,
					numeracao: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.numeracao,
					pesoLiquido: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.pesoLiquido,
					pesoBruto: nfeTransporteVolumeLacreDrift.nfeTransporteVolume?.pesoBruto,
				),
			);
		} else {
			return null;
		}
	}


	NfeTransporteVolumeLacreGrouped toDrift(NfeTransporteVolumeLacreModel nfeTransporteVolumeLacreModel) {
		return NfeTransporteVolumeLacreGrouped(
			nfeTransporteVolumeLacre: NfeTransporteVolumeLacre(
				id: nfeTransporteVolumeLacreModel.id,
				idNfeTransporteVolume: nfeTransporteVolumeLacreModel.idNfeTransporteVolume,
				numero: nfeTransporteVolumeLacreModel.numero,
			),
		);
	}

		
}
