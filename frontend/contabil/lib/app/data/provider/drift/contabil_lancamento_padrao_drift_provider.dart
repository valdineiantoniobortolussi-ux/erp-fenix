import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoPadraoDriftProvider extends ProviderBase {

	Future<List<ContabilLancamentoPadraoModel>?> getList({Filter? filter}) async {
		List<ContabilLancamentoPadraoGrouped> contabilLancamentoPadraoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilLancamentoPadraoDriftList = await Session.database.contabilLancamentoPadraoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilLancamentoPadraoDriftList = await Session.database.contabilLancamentoPadraoDao.getGroupedList(); 
			}
			if (contabilLancamentoPadraoDriftList.isNotEmpty) {
				return toListModel(contabilLancamentoPadraoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilLancamentoPadraoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilLancamentoPadraoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLancamentoPadraoModel?>? insert(ContabilLancamentoPadraoModel contabilLancamentoPadraoModel) async {
		try {
			final lastPk = await Session.database.contabilLancamentoPadraoDao.insertObject(toDrift(contabilLancamentoPadraoModel));
			contabilLancamentoPadraoModel.id = lastPk;
			return contabilLancamentoPadraoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLancamentoPadraoModel?>? update(ContabilLancamentoPadraoModel contabilLancamentoPadraoModel) async {
		try {
			await Session.database.contabilLancamentoPadraoDao.updateObject(toDrift(contabilLancamentoPadraoModel));
			return contabilLancamentoPadraoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilLancamentoPadraoDao.deleteObject(toDrift(ContabilLancamentoPadraoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilLancamentoPadraoModel> toListModel(List<ContabilLancamentoPadraoGrouped> contabilLancamentoPadraoDriftList) {
		List<ContabilLancamentoPadraoModel> listModel = [];
		for (var contabilLancamentoPadraoDrift in contabilLancamentoPadraoDriftList) {
			listModel.add(toModel(contabilLancamentoPadraoDrift)!);
		}
		return listModel;
	}	

	ContabilLancamentoPadraoModel? toModel(ContabilLancamentoPadraoGrouped? contabilLancamentoPadraoDrift) {
		if (contabilLancamentoPadraoDrift != null) {
			return ContabilLancamentoPadraoModel(
				id: contabilLancamentoPadraoDrift.contabilLancamentoPadrao?.id,
				descricao: contabilLancamentoPadraoDrift.contabilLancamentoPadrao?.descricao,
				historico: contabilLancamentoPadraoDrift.contabilLancamentoPadrao?.historico,
				idContaDebito: contabilLancamentoPadraoDrift.contabilLancamentoPadrao?.idContaDebito,
				idContaCredito: contabilLancamentoPadraoDrift.contabilLancamentoPadrao?.idContaCredito,
			);
		} else {
			return null;
		}
	}


	ContabilLancamentoPadraoGrouped toDrift(ContabilLancamentoPadraoModel contabilLancamentoPadraoModel) {
		return ContabilLancamentoPadraoGrouped(
			contabilLancamentoPadrao: ContabilLancamentoPadrao(
				id: contabilLancamentoPadraoModel.id,
				descricao: contabilLancamentoPadraoModel.descricao,
				historico: contabilLancamentoPadraoModel.historico,
				idContaDebito: contabilLancamentoPadraoModel.idContaDebito,
				idContaCredito: contabilLancamentoPadraoModel.idContaCredito,
			),
		);
	}

		
}
