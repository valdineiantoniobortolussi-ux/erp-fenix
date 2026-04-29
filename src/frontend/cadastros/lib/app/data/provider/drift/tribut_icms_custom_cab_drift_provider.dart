import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class TributIcmsCustomCabDriftProvider extends ProviderBase {

	Future<List<TributIcmsCustomCabModel>?> getList({Filter? filter}) async {
		List<TributIcmsCustomCabGrouped> tributIcmsCustomCabDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tributIcmsCustomCabDriftList = await Session.database.tributIcmsCustomCabDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tributIcmsCustomCabDriftList = await Session.database.tributIcmsCustomCabDao.getGroupedList(); 
			}
			if (tributIcmsCustomCabDriftList.isNotEmpty) {
				return toListModel(tributIcmsCustomCabDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TributIcmsCustomCabModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tributIcmsCustomCabDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributIcmsCustomCabModel?>? insert(TributIcmsCustomCabModel tributIcmsCustomCabModel) async {
		try {
			final lastPk = await Session.database.tributIcmsCustomCabDao.insertObject(toDrift(tributIcmsCustomCabModel));
			tributIcmsCustomCabModel.id = lastPk;
			return tributIcmsCustomCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributIcmsCustomCabModel?>? update(TributIcmsCustomCabModel tributIcmsCustomCabModel) async {
		try {
			await Session.database.tributIcmsCustomCabDao.updateObject(toDrift(tributIcmsCustomCabModel));
			return tributIcmsCustomCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tributIcmsCustomCabDao.deleteObject(toDrift(TributIcmsCustomCabModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TributIcmsCustomCabModel> toListModel(List<TributIcmsCustomCabGrouped> tributIcmsCustomCabDriftList) {
		List<TributIcmsCustomCabModel> listModel = [];
		for (var tributIcmsCustomCabDrift in tributIcmsCustomCabDriftList) {
			listModel.add(toModel(tributIcmsCustomCabDrift)!);
		}
		return listModel;
	}	

	TributIcmsCustomCabModel? toModel(TributIcmsCustomCabGrouped? tributIcmsCustomCabDrift) {
		if (tributIcmsCustomCabDrift != null) {
			return TributIcmsCustomCabModel(
				id: tributIcmsCustomCabDrift.tributIcmsCustomCab?.id,
				descricao: tributIcmsCustomCabDrift.tributIcmsCustomCab?.descricao,
				origemMercadoria: TributIcmsCustomCabDomain.getOrigemMercadoria(tributIcmsCustomCabDrift.tributIcmsCustomCab?.origemMercadoria),
			);
		} else {
			return null;
		}
	}


	TributIcmsCustomCabGrouped toDrift(TributIcmsCustomCabModel tributIcmsCustomCabModel) {
		return TributIcmsCustomCabGrouped(
			tributIcmsCustomCab: TributIcmsCustomCab(
				id: tributIcmsCustomCabModel.id,
				descricao: tributIcmsCustomCabModel.descricao,
				origemMercadoria: TributIcmsCustomCabDomain.setOrigemMercadoria(tributIcmsCustomCabModel.origemMercadoria),
			),
		);
	}

		
}
