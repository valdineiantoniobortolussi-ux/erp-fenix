import 'package:ged/app/data/provider/drift/database/database_imports.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/provider/provider_base.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/model/model_imports.dart';

class GedTipoDocumentoDriftProvider extends ProviderBase {

	Future<List<GedTipoDocumentoModel>?> getList({Filter? filter}) async {
		List<GedTipoDocumentoGrouped> gedTipoDocumentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				gedTipoDocumentoDriftList = await Session.database.gedTipoDocumentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				gedTipoDocumentoDriftList = await Session.database.gedTipoDocumentoDao.getGroupedList(); 
			}
			if (gedTipoDocumentoDriftList.isNotEmpty) {
				return toListModel(gedTipoDocumentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GedTipoDocumentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.gedTipoDocumentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GedTipoDocumentoModel?>? insert(GedTipoDocumentoModel gedTipoDocumentoModel) async {
		try {
			final lastPk = await Session.database.gedTipoDocumentoDao.insertObject(toDrift(gedTipoDocumentoModel));
			gedTipoDocumentoModel.id = lastPk;
			return gedTipoDocumentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GedTipoDocumentoModel?>? update(GedTipoDocumentoModel gedTipoDocumentoModel) async {
		try {
			await Session.database.gedTipoDocumentoDao.updateObject(toDrift(gedTipoDocumentoModel));
			return gedTipoDocumentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.gedTipoDocumentoDao.deleteObject(toDrift(GedTipoDocumentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<GedTipoDocumentoModel> toListModel(List<GedTipoDocumentoGrouped> gedTipoDocumentoDriftList) {
		List<GedTipoDocumentoModel> listModel = [];
		for (var gedTipoDocumentoDrift in gedTipoDocumentoDriftList) {
			listModel.add(toModel(gedTipoDocumentoDrift)!);
		}
		return listModel;
	}	

	GedTipoDocumentoModel? toModel(GedTipoDocumentoGrouped? gedTipoDocumentoDrift) {
		if (gedTipoDocumentoDrift != null) {
			return GedTipoDocumentoModel(
				id: gedTipoDocumentoDrift.gedTipoDocumento?.id,
				nome: gedTipoDocumentoDrift.gedTipoDocumento?.nome,
				tamanhoMaximo: gedTipoDocumentoDrift.gedTipoDocumento?.tamanhoMaximo,
			);
		} else {
			return null;
		}
	}


	GedTipoDocumentoGrouped toDrift(GedTipoDocumentoModel gedTipoDocumentoModel) {
		return GedTipoDocumentoGrouped(
			gedTipoDocumento: GedTipoDocumento(
				id: gedTipoDocumentoModel.id,
				nome: gedTipoDocumentoModel.nome,
				tamanhoMaximo: gedTipoDocumentoModel.tamanhoMaximo,
			),
		);
	}

		
}
