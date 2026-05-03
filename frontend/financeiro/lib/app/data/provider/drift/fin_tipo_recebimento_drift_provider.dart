import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinTipoRecebimentoDriftProvider extends ProviderBase {

	Future<List<FinTipoRecebimentoModel>?> getList({Filter? filter}) async {
		List<FinTipoRecebimentoGrouped> finTipoRecebimentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finTipoRecebimentoDriftList = await Session.database.finTipoRecebimentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finTipoRecebimentoDriftList = await Session.database.finTipoRecebimentoDao.getGroupedList(); 
			}
			if (finTipoRecebimentoDriftList.isNotEmpty) {
				return toListModel(finTipoRecebimentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinTipoRecebimentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finTipoRecebimentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinTipoRecebimentoModel?>? insert(FinTipoRecebimentoModel finTipoRecebimentoModel) async {
		try {
			final lastPk = await Session.database.finTipoRecebimentoDao.insertObject(toDrift(finTipoRecebimentoModel));
			finTipoRecebimentoModel.id = lastPk;
			return finTipoRecebimentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinTipoRecebimentoModel?>? update(FinTipoRecebimentoModel finTipoRecebimentoModel) async {
		try {
			await Session.database.finTipoRecebimentoDao.updateObject(toDrift(finTipoRecebimentoModel));
			return finTipoRecebimentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finTipoRecebimentoDao.deleteObject(toDrift(FinTipoRecebimentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinTipoRecebimentoModel> toListModel(List<FinTipoRecebimentoGrouped> finTipoRecebimentoDriftList) {
		List<FinTipoRecebimentoModel> listModel = [];
		for (var finTipoRecebimentoDrift in finTipoRecebimentoDriftList) {
			listModel.add(toModel(finTipoRecebimentoDrift)!);
		}
		return listModel;
	}	

	FinTipoRecebimentoModel? toModel(FinTipoRecebimentoGrouped? finTipoRecebimentoDrift) {
		if (finTipoRecebimentoDrift != null) {
			return FinTipoRecebimentoModel(
				id: finTipoRecebimentoDrift.finTipoRecebimento?.id,
				codigo: finTipoRecebimentoDrift.finTipoRecebimento?.codigo,
				descricao: finTipoRecebimentoDrift.finTipoRecebimento?.descricao,
			);
		} else {
			return null;
		}
	}


	FinTipoRecebimentoGrouped toDrift(FinTipoRecebimentoModel finTipoRecebimentoModel) {
		return FinTipoRecebimentoGrouped(
			finTipoRecebimento: FinTipoRecebimento(
				id: finTipoRecebimentoModel.id,
				codigo: finTipoRecebimentoModel.codigo,
				descricao: finTipoRecebimentoModel.descricao,
			),
		);
	}

		
}
