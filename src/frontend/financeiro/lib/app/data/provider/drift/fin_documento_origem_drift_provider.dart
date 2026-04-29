import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinDocumentoOrigemDriftProvider extends ProviderBase {

	Future<List<FinDocumentoOrigemModel>?> getList({Filter? filter}) async {
		List<FinDocumentoOrigemGrouped> finDocumentoOrigemDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finDocumentoOrigemDriftList = await Session.database.finDocumentoOrigemDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finDocumentoOrigemDriftList = await Session.database.finDocumentoOrigemDao.getGroupedList(); 
			}
			if (finDocumentoOrigemDriftList.isNotEmpty) {
				return toListModel(finDocumentoOrigemDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinDocumentoOrigemModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finDocumentoOrigemDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinDocumentoOrigemModel?>? insert(FinDocumentoOrigemModel finDocumentoOrigemModel) async {
		try {
			final lastPk = await Session.database.finDocumentoOrigemDao.insertObject(toDrift(finDocumentoOrigemModel));
			finDocumentoOrigemModel.id = lastPk;
			return finDocumentoOrigemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinDocumentoOrigemModel?>? update(FinDocumentoOrigemModel finDocumentoOrigemModel) async {
		try {
			await Session.database.finDocumentoOrigemDao.updateObject(toDrift(finDocumentoOrigemModel));
			return finDocumentoOrigemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finDocumentoOrigemDao.deleteObject(toDrift(FinDocumentoOrigemModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinDocumentoOrigemModel> toListModel(List<FinDocumentoOrigemGrouped> finDocumentoOrigemDriftList) {
		List<FinDocumentoOrigemModel> listModel = [];
		for (var finDocumentoOrigemDrift in finDocumentoOrigemDriftList) {
			listModel.add(toModel(finDocumentoOrigemDrift)!);
		}
		return listModel;
	}	

	FinDocumentoOrigemModel? toModel(FinDocumentoOrigemGrouped? finDocumentoOrigemDrift) {
		if (finDocumentoOrigemDrift != null) {
			return FinDocumentoOrigemModel(
				id: finDocumentoOrigemDrift.finDocumentoOrigem?.id,
				codigo: finDocumentoOrigemDrift.finDocumentoOrigem?.codigo,
				sigla: finDocumentoOrigemDrift.finDocumentoOrigem?.sigla,
				descricao: finDocumentoOrigemDrift.finDocumentoOrigem?.descricao,
			);
		} else {
			return null;
		}
	}


	FinDocumentoOrigemGrouped toDrift(FinDocumentoOrigemModel finDocumentoOrigemModel) {
		return FinDocumentoOrigemGrouped(
			finDocumentoOrigem: FinDocumentoOrigem(
				id: finDocumentoOrigemModel.id,
				codigo: finDocumentoOrigemModel.codigo,
				sigla: finDocumentoOrigemModel.sigla,
				descricao: finDocumentoOrigemModel.descricao,
			),
		);
	}

		
}
