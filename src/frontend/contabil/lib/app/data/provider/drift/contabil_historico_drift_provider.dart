import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilHistoricoDriftProvider extends ProviderBase {

	Future<List<ContabilHistoricoModel>?> getList({Filter? filter}) async {
		List<ContabilHistoricoGrouped> contabilHistoricoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilHistoricoDriftList = await Session.database.contabilHistoricoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilHistoricoDriftList = await Session.database.contabilHistoricoDao.getGroupedList(); 
			}
			if (contabilHistoricoDriftList.isNotEmpty) {
				return toListModel(contabilHistoricoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilHistoricoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilHistoricoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilHistoricoModel?>? insert(ContabilHistoricoModel contabilHistoricoModel) async {
		try {
			final lastPk = await Session.database.contabilHistoricoDao.insertObject(toDrift(contabilHistoricoModel));
			contabilHistoricoModel.id = lastPk;
			return contabilHistoricoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilHistoricoModel?>? update(ContabilHistoricoModel contabilHistoricoModel) async {
		try {
			await Session.database.contabilHistoricoDao.updateObject(toDrift(contabilHistoricoModel));
			return contabilHistoricoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilHistoricoDao.deleteObject(toDrift(ContabilHistoricoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilHistoricoModel> toListModel(List<ContabilHistoricoGrouped> contabilHistoricoDriftList) {
		List<ContabilHistoricoModel> listModel = [];
		for (var contabilHistoricoDrift in contabilHistoricoDriftList) {
			listModel.add(toModel(contabilHistoricoDrift)!);
		}
		return listModel;
	}	

	ContabilHistoricoModel? toModel(ContabilHistoricoGrouped? contabilHistoricoDrift) {
		if (contabilHistoricoDrift != null) {
			return ContabilHistoricoModel(
				id: contabilHistoricoDrift.contabilHistorico?.id,
				descricao: contabilHistoricoDrift.contabilHistorico?.descricao,
				pedeComplemento: ContabilHistoricoDomain.getPedeComplemento(contabilHistoricoDrift.contabilHistorico?.pedeComplemento),
				historico: contabilHistoricoDrift.contabilHistorico?.historico,
			);
		} else {
			return null;
		}
	}


	ContabilHistoricoGrouped toDrift(ContabilHistoricoModel contabilHistoricoModel) {
		return ContabilHistoricoGrouped(
			contabilHistorico: ContabilHistorico(
				id: contabilHistoricoModel.id,
				descricao: contabilHistoricoModel.descricao,
				pedeComplemento: ContabilHistoricoDomain.setPedeComplemento(contabilHistoricoModel.pedeComplemento),
				historico: contabilHistoricoModel.historico,
			),
		);
	}

		
}
