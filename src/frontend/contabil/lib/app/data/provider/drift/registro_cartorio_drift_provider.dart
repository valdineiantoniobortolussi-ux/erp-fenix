import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class RegistroCartorioDriftProvider extends ProviderBase {

	Future<List<RegistroCartorioModel>?> getList({Filter? filter}) async {
		List<RegistroCartorioGrouped> registroCartorioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				registroCartorioDriftList = await Session.database.registroCartorioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				registroCartorioDriftList = await Session.database.registroCartorioDao.getGroupedList(); 
			}
			if (registroCartorioDriftList.isNotEmpty) {
				return toListModel(registroCartorioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<RegistroCartorioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.registroCartorioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RegistroCartorioModel?>? insert(RegistroCartorioModel registroCartorioModel) async {
		try {
			final lastPk = await Session.database.registroCartorioDao.insertObject(toDrift(registroCartorioModel));
			registroCartorioModel.id = lastPk;
			return registroCartorioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RegistroCartorioModel?>? update(RegistroCartorioModel registroCartorioModel) async {
		try {
			await Session.database.registroCartorioDao.updateObject(toDrift(registroCartorioModel));
			return registroCartorioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.registroCartorioDao.deleteObject(toDrift(RegistroCartorioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<RegistroCartorioModel> toListModel(List<RegistroCartorioGrouped> registroCartorioDriftList) {
		List<RegistroCartorioModel> listModel = [];
		for (var registroCartorioDrift in registroCartorioDriftList) {
			listModel.add(toModel(registroCartorioDrift)!);
		}
		return listModel;
	}	

	RegistroCartorioModel? toModel(RegistroCartorioGrouped? registroCartorioDrift) {
		if (registroCartorioDrift != null) {
			return RegistroCartorioModel(
				id: registroCartorioDrift.registroCartorio?.id,
				nomeCartorio: registroCartorioDrift.registroCartorio?.nomeCartorio,
				dataRegistro: registroCartorioDrift.registroCartorio?.dataRegistro,
				numero: registroCartorioDrift.registroCartorio?.numero,
				folha: registroCartorioDrift.registroCartorio?.folha,
				livro: registroCartorioDrift.registroCartorio?.livro,
				nire: registroCartorioDrift.registroCartorio?.nire,
			);
		} else {
			return null;
		}
	}


	RegistroCartorioGrouped toDrift(RegistroCartorioModel registroCartorioModel) {
		return RegistroCartorioGrouped(
			registroCartorio: RegistroCartorio(
				id: registroCartorioModel.id,
				nomeCartorio: registroCartorioModel.nomeCartorio,
				dataRegistro: registroCartorioModel.dataRegistro,
				numero: registroCartorioModel.numero,
				folha: registroCartorioModel.folha,
				livro: registroCartorioModel.livro,
				nire: registroCartorioModel.nire,
			),
		);
	}

		
}
