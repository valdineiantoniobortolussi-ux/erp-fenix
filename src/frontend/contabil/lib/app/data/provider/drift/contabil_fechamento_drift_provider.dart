import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilFechamentoDriftProvider extends ProviderBase {

	Future<List<ContabilFechamentoModel>?> getList({Filter? filter}) async {
		List<ContabilFechamentoGrouped> contabilFechamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilFechamentoDriftList = await Session.database.contabilFechamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilFechamentoDriftList = await Session.database.contabilFechamentoDao.getGroupedList(); 
			}
			if (contabilFechamentoDriftList.isNotEmpty) {
				return toListModel(contabilFechamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilFechamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilFechamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilFechamentoModel?>? insert(ContabilFechamentoModel contabilFechamentoModel) async {
		try {
			final lastPk = await Session.database.contabilFechamentoDao.insertObject(toDrift(contabilFechamentoModel));
			contabilFechamentoModel.id = lastPk;
			return contabilFechamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilFechamentoModel?>? update(ContabilFechamentoModel contabilFechamentoModel) async {
		try {
			await Session.database.contabilFechamentoDao.updateObject(toDrift(contabilFechamentoModel));
			return contabilFechamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilFechamentoDao.deleteObject(toDrift(ContabilFechamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilFechamentoModel> toListModel(List<ContabilFechamentoGrouped> contabilFechamentoDriftList) {
		List<ContabilFechamentoModel> listModel = [];
		for (var contabilFechamentoDrift in contabilFechamentoDriftList) {
			listModel.add(toModel(contabilFechamentoDrift)!);
		}
		return listModel;
	}	

	ContabilFechamentoModel? toModel(ContabilFechamentoGrouped? contabilFechamentoDrift) {
		if (contabilFechamentoDrift != null) {
			return ContabilFechamentoModel(
				id: contabilFechamentoDrift.contabilFechamento?.id,
				dataInicio: contabilFechamentoDrift.contabilFechamento?.dataInicio,
				dataFim: contabilFechamentoDrift.contabilFechamento?.dataFim,
				criterioLancamento: ContabilFechamentoDomain.getCriterioLancamento(contabilFechamentoDrift.contabilFechamento?.criterioLancamento),
			);
		} else {
			return null;
		}
	}


	ContabilFechamentoGrouped toDrift(ContabilFechamentoModel contabilFechamentoModel) {
		return ContabilFechamentoGrouped(
			contabilFechamento: ContabilFechamento(
				id: contabilFechamentoModel.id,
				dataInicio: contabilFechamentoModel.dataInicio,
				dataFim: contabilFechamentoModel.dataFim,
				criterioLancamento: ContabilFechamentoDomain.setCriterioLancamento(contabilFechamentoModel.criterioLancamento),
			),
		);
	}

		
}
