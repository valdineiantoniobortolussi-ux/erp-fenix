import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaFeriasColetivasDriftProvider extends ProviderBase {

	Future<List<FolhaFeriasColetivasModel>?> getList({Filter? filter}) async {
		List<FolhaFeriasColetivasGrouped> folhaFeriasColetivasDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaFeriasColetivasDriftList = await Session.database.folhaFeriasColetivasDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaFeriasColetivasDriftList = await Session.database.folhaFeriasColetivasDao.getGroupedList(); 
			}
			if (folhaFeriasColetivasDriftList.isNotEmpty) {
				return toListModel(folhaFeriasColetivasDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaFeriasColetivasModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaFeriasColetivasDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaFeriasColetivasModel?>? insert(FolhaFeriasColetivasModel folhaFeriasColetivasModel) async {
		try {
			final lastPk = await Session.database.folhaFeriasColetivasDao.insertObject(toDrift(folhaFeriasColetivasModel));
			folhaFeriasColetivasModel.id = lastPk;
			return folhaFeriasColetivasModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaFeriasColetivasModel?>? update(FolhaFeriasColetivasModel folhaFeriasColetivasModel) async {
		try {
			await Session.database.folhaFeriasColetivasDao.updateObject(toDrift(folhaFeriasColetivasModel));
			return folhaFeriasColetivasModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaFeriasColetivasDao.deleteObject(toDrift(FolhaFeriasColetivasModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaFeriasColetivasModel> toListModel(List<FolhaFeriasColetivasGrouped> folhaFeriasColetivasDriftList) {
		List<FolhaFeriasColetivasModel> listModel = [];
		for (var folhaFeriasColetivasDrift in folhaFeriasColetivasDriftList) {
			listModel.add(toModel(folhaFeriasColetivasDrift)!);
		}
		return listModel;
	}	

	FolhaFeriasColetivasModel? toModel(FolhaFeriasColetivasGrouped? folhaFeriasColetivasDrift) {
		if (folhaFeriasColetivasDrift != null) {
			return FolhaFeriasColetivasModel(
				id: folhaFeriasColetivasDrift.folhaFeriasColetivas?.id,
				dataInicio: folhaFeriasColetivasDrift.folhaFeriasColetivas?.dataInicio,
				dataFim: folhaFeriasColetivasDrift.folhaFeriasColetivas?.dataFim,
				diasGozo: folhaFeriasColetivasDrift.folhaFeriasColetivas?.diasGozo,
				abonoPecuniarioInicio: folhaFeriasColetivasDrift.folhaFeriasColetivas?.abonoPecuniarioInicio,
				abonoPecuniarioFim: folhaFeriasColetivasDrift.folhaFeriasColetivas?.abonoPecuniarioFim,
				diasAbono: folhaFeriasColetivasDrift.folhaFeriasColetivas?.diasAbono,
				dataPagamento: folhaFeriasColetivasDrift.folhaFeriasColetivas?.dataPagamento,
			);
		} else {
			return null;
		}
	}


	FolhaFeriasColetivasGrouped toDrift(FolhaFeriasColetivasModel folhaFeriasColetivasModel) {
		return FolhaFeriasColetivasGrouped(
			folhaFeriasColetivas: FolhaFeriasColetivas(
				id: folhaFeriasColetivasModel.id,
				dataInicio: folhaFeriasColetivasModel.dataInicio,
				dataFim: folhaFeriasColetivasModel.dataFim,
				diasGozo: folhaFeriasColetivasModel.diasGozo,
				abonoPecuniarioInicio: folhaFeriasColetivasModel.abonoPecuniarioInicio,
				abonoPecuniarioFim: folhaFeriasColetivasModel.abonoPecuniarioFim,
				diasAbono: folhaFeriasColetivasModel.diasAbono,
				dataPagamento: folhaFeriasColetivasModel.dataPagamento,
			),
		);
	}

		
}
