import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinChequeEmitidoDriftProvider extends ProviderBase {

	Future<List<FinChequeEmitidoModel>?> getList({Filter? filter}) async {
		List<FinChequeEmitidoGrouped> finChequeEmitidoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finChequeEmitidoDriftList = await Session.database.finChequeEmitidoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finChequeEmitidoDriftList = await Session.database.finChequeEmitidoDao.getGroupedList(); 
			}
			if (finChequeEmitidoDriftList.isNotEmpty) {
				return toListModel(finChequeEmitidoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinChequeEmitidoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finChequeEmitidoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinChequeEmitidoModel?>? insert(FinChequeEmitidoModel finChequeEmitidoModel) async {
		try {
			final lastPk = await Session.database.finChequeEmitidoDao.insertObject(toDrift(finChequeEmitidoModel));
			finChequeEmitidoModel.id = lastPk;
			return finChequeEmitidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinChequeEmitidoModel?>? update(FinChequeEmitidoModel finChequeEmitidoModel) async {
		try {
			await Session.database.finChequeEmitidoDao.updateObject(toDrift(finChequeEmitidoModel));
			return finChequeEmitidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finChequeEmitidoDao.deleteObject(toDrift(FinChequeEmitidoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinChequeEmitidoModel> toListModel(List<FinChequeEmitidoGrouped> finChequeEmitidoDriftList) {
		List<FinChequeEmitidoModel> listModel = [];
		for (var finChequeEmitidoDrift in finChequeEmitidoDriftList) {
			listModel.add(toModel(finChequeEmitidoDrift)!);
		}
		return listModel;
	}	

	FinChequeEmitidoModel? toModel(FinChequeEmitidoGrouped? finChequeEmitidoDrift) {
		if (finChequeEmitidoDrift != null) {
			return FinChequeEmitidoModel(
				id: finChequeEmitidoDrift.finChequeEmitido?.id,
				idCheque: finChequeEmitidoDrift.finChequeEmitido?.idCheque,
				dataEmissao: finChequeEmitidoDrift.finChequeEmitido?.dataEmissao,
				bomPara: finChequeEmitidoDrift.finChequeEmitido?.bomPara,
				dataCompensacao: finChequeEmitidoDrift.finChequeEmitido?.dataCompensacao,
				valor: finChequeEmitidoDrift.finChequeEmitido?.valor,
				nominalA: finChequeEmitidoDrift.finChequeEmitido?.nominalA,
				chequeModel: ChequeModel(
					id: finChequeEmitidoDrift.cheque?.id,
					idTalonarioCheque: finChequeEmitidoDrift.cheque?.idTalonarioCheque,
					numero: finChequeEmitidoDrift.cheque?.numero,
					statusCheque: finChequeEmitidoDrift.cheque?.statusCheque,
					dataStatus: finChequeEmitidoDrift.cheque?.dataStatus,
				),
			);
		} else {
			return null;
		}
	}


	FinChequeEmitidoGrouped toDrift(FinChequeEmitidoModel finChequeEmitidoModel) {
		return FinChequeEmitidoGrouped(
			finChequeEmitido: FinChequeEmitido(
				id: finChequeEmitidoModel.id,
				idCheque: finChequeEmitidoModel.idCheque,
				dataEmissao: finChequeEmitidoModel.dataEmissao,
				bomPara: finChequeEmitidoModel.bomPara,
				dataCompensacao: finChequeEmitidoModel.dataCompensacao,
				valor: finChequeEmitidoModel.valor,
				nominalA: finChequeEmitidoModel.nominalA,
			),
		);
	}

		
}
