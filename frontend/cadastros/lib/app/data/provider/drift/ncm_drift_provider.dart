import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class NcmDriftProvider extends ProviderBase {

	Future<List<NcmModel>?> getList({Filter? filter}) async {
		List<NcmGrouped> ncmDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				ncmDriftList = await Session.database.ncmDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				ncmDriftList = await Session.database.ncmDao.getGroupedList(); 
			}
			if (ncmDriftList.isNotEmpty) {
				return toListModel(ncmDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NcmModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.ncmDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NcmModel?>? insert(NcmModel ncmModel) async {
		try {
			final lastPk = await Session.database.ncmDao.insertObject(toDrift(ncmModel));
			ncmModel.id = lastPk;
			return ncmModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NcmModel?>? update(NcmModel ncmModel) async {
		try {
			await Session.database.ncmDao.updateObject(toDrift(ncmModel));
			return ncmModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.ncmDao.deleteObject(toDrift(NcmModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NcmModel> toListModel(List<NcmGrouped> ncmDriftList) {
		List<NcmModel> listModel = [];
		for (var ncmDrift in ncmDriftList) {
			listModel.add(toModel(ncmDrift)!);
		}
		return listModel;
	}	

	NcmModel? toModel(NcmGrouped? ncmDrift) {
		if (ncmDrift != null) {
			return NcmModel(
				id: ncmDrift.ncm?.id,
				codigo: ncmDrift.ncm?.codigo,
				descricao: ncmDrift.ncm?.descricao,
				observacao: ncmDrift.ncm?.observacao,
			);
		} else {
			return null;
		}
	}


	NcmGrouped toDrift(NcmModel ncmModel) {
		return NcmGrouped(
			ncm: Ncm(
				id: ncmModel.id,
				codigo: ncmModel.codigo,
				descricao: ncmModel.descricao,
				observacao: ncmModel.observacao,
			),
		);
	}

		
}
