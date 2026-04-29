import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaFechamentoDriftProvider extends ProviderBase {

	Future<List<FolhaFechamentoModel>?> getList({Filter? filter}) async {
		List<FolhaFechamentoGrouped> folhaFechamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaFechamentoDriftList = await Session.database.folhaFechamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaFechamentoDriftList = await Session.database.folhaFechamentoDao.getGroupedList(); 
			}
			if (folhaFechamentoDriftList.isNotEmpty) {
				return toListModel(folhaFechamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaFechamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaFechamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaFechamentoModel?>? insert(FolhaFechamentoModel folhaFechamentoModel) async {
		try {
			final lastPk = await Session.database.folhaFechamentoDao.insertObject(toDrift(folhaFechamentoModel));
			folhaFechamentoModel.id = lastPk;
			return folhaFechamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaFechamentoModel?>? update(FolhaFechamentoModel folhaFechamentoModel) async {
		try {
			await Session.database.folhaFechamentoDao.updateObject(toDrift(folhaFechamentoModel));
			return folhaFechamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaFechamentoDao.deleteObject(toDrift(FolhaFechamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaFechamentoModel> toListModel(List<FolhaFechamentoGrouped> folhaFechamentoDriftList) {
		List<FolhaFechamentoModel> listModel = [];
		for (var folhaFechamentoDrift in folhaFechamentoDriftList) {
			listModel.add(toModel(folhaFechamentoDrift)!);
		}
		return listModel;
	}	

	FolhaFechamentoModel? toModel(FolhaFechamentoGrouped? folhaFechamentoDrift) {
		if (folhaFechamentoDrift != null) {
			return FolhaFechamentoModel(
				id: folhaFechamentoDrift.folhaFechamento?.id,
				fechamentoAtual: folhaFechamentoDrift.folhaFechamento?.fechamentoAtual,
				proximoFechamento: folhaFechamentoDrift.folhaFechamento?.proximoFechamento,
			);
		} else {
			return null;
		}
	}


	FolhaFechamentoGrouped toDrift(FolhaFechamentoModel folhaFechamentoModel) {
		return FolhaFechamentoGrouped(
			folhaFechamento: FolhaFechamento(
				id: folhaFechamentoModel.id,
				fechamentoAtual: Util.removeMask(folhaFechamentoModel.fechamentoAtual),
				proximoFechamento: Util.removeMask(folhaFechamentoModel.proximoFechamento),
			),
		);
	}

		
}
