import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class FapDriftProvider extends ProviderBase {

	Future<List<FapModel>?> getList({Filter? filter}) async {
		List<FapGrouped> fapDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fapDriftList = await Session.database.fapDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fapDriftList = await Session.database.fapDao.getGroupedList(); 
			}
			if (fapDriftList.isNotEmpty) {
				return toListModel(fapDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FapModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fapDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FapModel?>? insert(FapModel fapModel) async {
		try {
			final lastPk = await Session.database.fapDao.insertObject(toDrift(fapModel));
			fapModel.id = lastPk;
			return fapModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FapModel?>? update(FapModel fapModel) async {
		try {
			await Session.database.fapDao.updateObject(toDrift(fapModel));
			return fapModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fapDao.deleteObject(toDrift(FapModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FapModel> toListModel(List<FapGrouped> fapDriftList) {
		List<FapModel> listModel = [];
		for (var fapDrift in fapDriftList) {
			listModel.add(toModel(fapDrift)!);
		}
		return listModel;
	}	

	FapModel? toModel(FapGrouped? fapDrift) {
		if (fapDrift != null) {
			return FapModel(
				id: fapDrift.fap?.id,
				fap: fapDrift.fap?.fap,
				dataInicial: fapDrift.fap?.dataInicial,
				dataFinal: fapDrift.fap?.dataFinal,
			);
		} else {
			return null;
		}
	}


	FapGrouped toDrift(FapModel fapModel) {
		return FapGrouped(
			fap: Fap(
				id: fapModel.id,
				fap: fapModel.fap,
				dataInicial: fapModel.dataInicial,
				dataFinal: fapModel.dataFinal,
			),
		);
	}

		
}
