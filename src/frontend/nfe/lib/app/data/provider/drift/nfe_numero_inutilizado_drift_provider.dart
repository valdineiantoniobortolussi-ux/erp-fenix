import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeNumeroInutilizadoDriftProvider extends ProviderBase {

	Future<List<NfeNumeroInutilizadoModel>?> getList({Filter? filter}) async {
		List<NfeNumeroInutilizadoGrouped> nfeNumeroInutilizadoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeNumeroInutilizadoDriftList = await Session.database.nfeNumeroInutilizadoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeNumeroInutilizadoDriftList = await Session.database.nfeNumeroInutilizadoDao.getGroupedList(); 
			}
			if (nfeNumeroInutilizadoDriftList.isNotEmpty) {
				return toListModel(nfeNumeroInutilizadoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeNumeroInutilizadoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeNumeroInutilizadoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeNumeroInutilizadoModel?>? insert(NfeNumeroInutilizadoModel nfeNumeroInutilizadoModel) async {
		try {
			final lastPk = await Session.database.nfeNumeroInutilizadoDao.insertObject(toDrift(nfeNumeroInutilizadoModel));
			nfeNumeroInutilizadoModel.id = lastPk;
			return nfeNumeroInutilizadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeNumeroInutilizadoModel?>? update(NfeNumeroInutilizadoModel nfeNumeroInutilizadoModel) async {
		try {
			await Session.database.nfeNumeroInutilizadoDao.updateObject(toDrift(nfeNumeroInutilizadoModel));
			return nfeNumeroInutilizadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeNumeroInutilizadoDao.deleteObject(toDrift(NfeNumeroInutilizadoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeNumeroInutilizadoModel> toListModel(List<NfeNumeroInutilizadoGrouped> nfeNumeroInutilizadoDriftList) {
		List<NfeNumeroInutilizadoModel> listModel = [];
		for (var nfeNumeroInutilizadoDrift in nfeNumeroInutilizadoDriftList) {
			listModel.add(toModel(nfeNumeroInutilizadoDrift)!);
		}
		return listModel;
	}	

	NfeNumeroInutilizadoModel? toModel(NfeNumeroInutilizadoGrouped? nfeNumeroInutilizadoDrift) {
		if (nfeNumeroInutilizadoDrift != null) {
			return NfeNumeroInutilizadoModel(
				id: nfeNumeroInutilizadoDrift.nfeNumeroInutilizado?.id,
				serie: nfeNumeroInutilizadoDrift.nfeNumeroInutilizado?.serie,
				numero: nfeNumeroInutilizadoDrift.nfeNumeroInutilizado?.numero,
				dataInutilizacao: nfeNumeroInutilizadoDrift.nfeNumeroInutilizado?.dataInutilizacao,
				observacao: nfeNumeroInutilizadoDrift.nfeNumeroInutilizado?.observacao,
			);
		} else {
			return null;
		}
	}


	NfeNumeroInutilizadoGrouped toDrift(NfeNumeroInutilizadoModel nfeNumeroInutilizadoModel) {
		return NfeNumeroInutilizadoGrouped(
			nfeNumeroInutilizado: NfeNumeroInutilizado(
				id: nfeNumeroInutilizadoModel.id,
				serie: nfeNumeroInutilizadoModel.serie,
				numero: nfeNumeroInutilizadoModel.numero,
				dataInutilizacao: nfeNumeroInutilizadoModel.dataInutilizacao,
				observacao: nfeNumeroInutilizadoModel.observacao,
			),
		);
	}

		
}
