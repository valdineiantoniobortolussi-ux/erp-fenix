import 'package:etiquetas/app/data/provider/drift/database/database_imports.dart';
import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/data/provider/provider_base.dart';
import 'package:etiquetas/app/data/provider/drift/database/database.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';

class EtiquetaFormatoPapelDriftProvider extends ProviderBase {

	Future<List<EtiquetaFormatoPapelModel>?> getList({Filter? filter}) async {
		List<EtiquetaFormatoPapelGrouped> etiquetaFormatoPapelDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				etiquetaFormatoPapelDriftList = await Session.database.etiquetaFormatoPapelDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				etiquetaFormatoPapelDriftList = await Session.database.etiquetaFormatoPapelDao.getGroupedList(); 
			}
			if (etiquetaFormatoPapelDriftList.isNotEmpty) {
				return toListModel(etiquetaFormatoPapelDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EtiquetaFormatoPapelModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.etiquetaFormatoPapelDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EtiquetaFormatoPapelModel?>? insert(EtiquetaFormatoPapelModel etiquetaFormatoPapelModel) async {
		try {
			final lastPk = await Session.database.etiquetaFormatoPapelDao.insertObject(toDrift(etiquetaFormatoPapelModel));
			etiquetaFormatoPapelModel.id = lastPk;
			return etiquetaFormatoPapelModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EtiquetaFormatoPapelModel?>? update(EtiquetaFormatoPapelModel etiquetaFormatoPapelModel) async {
		try {
			await Session.database.etiquetaFormatoPapelDao.updateObject(toDrift(etiquetaFormatoPapelModel));
			return etiquetaFormatoPapelModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.etiquetaFormatoPapelDao.deleteObject(toDrift(EtiquetaFormatoPapelModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EtiquetaFormatoPapelModel> toListModel(List<EtiquetaFormatoPapelGrouped> etiquetaFormatoPapelDriftList) {
		List<EtiquetaFormatoPapelModel> listModel = [];
		for (var etiquetaFormatoPapelDrift in etiquetaFormatoPapelDriftList) {
			listModel.add(toModel(etiquetaFormatoPapelDrift)!);
		}
		return listModel;
	}	

	EtiquetaFormatoPapelModel? toModel(EtiquetaFormatoPapelGrouped? etiquetaFormatoPapelDrift) {
		if (etiquetaFormatoPapelDrift != null) {
			return EtiquetaFormatoPapelModel(
				id: etiquetaFormatoPapelDrift.etiquetaFormatoPapel?.id,
				nome: etiquetaFormatoPapelDrift.etiquetaFormatoPapel?.nome,
				altura: etiquetaFormatoPapelDrift.etiquetaFormatoPapel?.altura,
				largura: etiquetaFormatoPapelDrift.etiquetaFormatoPapel?.largura,
			);
		} else {
			return null;
		}
	}


	EtiquetaFormatoPapelGrouped toDrift(EtiquetaFormatoPapelModel etiquetaFormatoPapelModel) {
		return EtiquetaFormatoPapelGrouped(
			etiquetaFormatoPapel: EtiquetaFormatoPapel(
				id: etiquetaFormatoPapelModel.id,
				nome: etiquetaFormatoPapelModel.nome,
				altura: etiquetaFormatoPapelModel.altura,
				largura: etiquetaFormatoPapelModel.largura,
			),
		);
	}

		
}
