import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeNumeroDriftProvider extends ProviderBase {

	Future<List<NfeNumeroModel>?> getList({Filter? filter}) async {
		List<NfeNumeroGrouped> nfeNumeroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeNumeroDriftList = await Session.database.nfeNumeroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeNumeroDriftList = await Session.database.nfeNumeroDao.getGroupedList(); 
			}
			if (nfeNumeroDriftList.isNotEmpty) {
				return toListModel(nfeNumeroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeNumeroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeNumeroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeNumeroModel?>? insert(NfeNumeroModel nfeNumeroModel) async {
		try {
			final lastPk = await Session.database.nfeNumeroDao.insertObject(toDrift(nfeNumeroModel));
			nfeNumeroModel.id = lastPk;
			return nfeNumeroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeNumeroModel?>? update(NfeNumeroModel nfeNumeroModel) async {
		try {
			await Session.database.nfeNumeroDao.updateObject(toDrift(nfeNumeroModel));
			return nfeNumeroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeNumeroDao.deleteObject(toDrift(NfeNumeroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeNumeroModel> toListModel(List<NfeNumeroGrouped> nfeNumeroDriftList) {
		List<NfeNumeroModel> listModel = [];
		for (var nfeNumeroDrift in nfeNumeroDriftList) {
			listModel.add(toModel(nfeNumeroDrift)!);
		}
		return listModel;
	}	

	NfeNumeroModel? toModel(NfeNumeroGrouped? nfeNumeroDrift) {
		if (nfeNumeroDrift != null) {
			return NfeNumeroModel(
				id: nfeNumeroDrift.nfeNumero?.id,
				serie: NfeNumeroDomain.getSerie(nfeNumeroDrift.nfeNumero?.serie),
				numero: nfeNumeroDrift.nfeNumero?.numero,
			);
		} else {
			return null;
		}
	}


	NfeNumeroGrouped toDrift(NfeNumeroModel nfeNumeroModel) {
		return NfeNumeroGrouped(
			nfeNumero: NfeNumero(
				id: nfeNumeroModel.id,
				serie: NfeNumeroDomain.setSerie(nfeNumeroModel.serie),
				numero: nfeNumeroModel.numero,
			),
		);
	}

		
}
