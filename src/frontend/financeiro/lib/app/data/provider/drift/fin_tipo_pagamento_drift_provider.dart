import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinTipoPagamentoDriftProvider extends ProviderBase {

	Future<List<FinTipoPagamentoModel>?> getList({Filter? filter}) async {
		List<FinTipoPagamentoGrouped> finTipoPagamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finTipoPagamentoDriftList = await Session.database.finTipoPagamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finTipoPagamentoDriftList = await Session.database.finTipoPagamentoDao.getGroupedList(); 
			}
			if (finTipoPagamentoDriftList.isNotEmpty) {
				return toListModel(finTipoPagamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinTipoPagamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finTipoPagamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinTipoPagamentoModel?>? insert(FinTipoPagamentoModel finTipoPagamentoModel) async {
		try {
			final lastPk = await Session.database.finTipoPagamentoDao.insertObject(toDrift(finTipoPagamentoModel));
			finTipoPagamentoModel.id = lastPk;
			return finTipoPagamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinTipoPagamentoModel?>? update(FinTipoPagamentoModel finTipoPagamentoModel) async {
		try {
			await Session.database.finTipoPagamentoDao.updateObject(toDrift(finTipoPagamentoModel));
			return finTipoPagamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finTipoPagamentoDao.deleteObject(toDrift(FinTipoPagamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinTipoPagamentoModel> toListModel(List<FinTipoPagamentoGrouped> finTipoPagamentoDriftList) {
		List<FinTipoPagamentoModel> listModel = [];
		for (var finTipoPagamentoDrift in finTipoPagamentoDriftList) {
			listModel.add(toModel(finTipoPagamentoDrift)!);
		}
		return listModel;
	}	

	FinTipoPagamentoModel? toModel(FinTipoPagamentoGrouped? finTipoPagamentoDrift) {
		if (finTipoPagamentoDrift != null) {
			return FinTipoPagamentoModel(
				id: finTipoPagamentoDrift.finTipoPagamento?.id,
				codigo: finTipoPagamentoDrift.finTipoPagamento?.codigo,
				descricao: finTipoPagamentoDrift.finTipoPagamento?.descricao,
			);
		} else {
			return null;
		}
	}


	FinTipoPagamentoGrouped toDrift(FinTipoPagamentoModel finTipoPagamentoModel) {
		return FinTipoPagamentoGrouped(
			finTipoPagamento: FinTipoPagamento(
				id: finTipoPagamentoModel.id,
				codigo: finTipoPagamentoModel.codigo,
				descricao: finTipoPagamentoModel.descricao,
			),
		);
	}

		
}
