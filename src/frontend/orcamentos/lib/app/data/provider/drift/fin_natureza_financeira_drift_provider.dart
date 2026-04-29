import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/provider/provider_base.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/data/domain/domain_imports.dart';

class FinNaturezaFinanceiraDriftProvider extends ProviderBase {

	Future<List<FinNaturezaFinanceiraModel>?> getList({Filter? filter}) async {
		List<FinNaturezaFinanceiraGrouped> finNaturezaFinanceiraDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finNaturezaFinanceiraDriftList = await Session.database.finNaturezaFinanceiraDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finNaturezaFinanceiraDriftList = await Session.database.finNaturezaFinanceiraDao.getGroupedList(); 
			}
			if (finNaturezaFinanceiraDriftList.isNotEmpty) {
				return toListModel(finNaturezaFinanceiraDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinNaturezaFinanceiraModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finNaturezaFinanceiraDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinNaturezaFinanceiraModel?>? insert(FinNaturezaFinanceiraModel finNaturezaFinanceiraModel) async {
		try {
			final lastPk = await Session.database.finNaturezaFinanceiraDao.insertObject(toDrift(finNaturezaFinanceiraModel));
			finNaturezaFinanceiraModel.id = lastPk;
			return finNaturezaFinanceiraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinNaturezaFinanceiraModel?>? update(FinNaturezaFinanceiraModel finNaturezaFinanceiraModel) async {
		try {
			await Session.database.finNaturezaFinanceiraDao.updateObject(toDrift(finNaturezaFinanceiraModel));
			return finNaturezaFinanceiraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finNaturezaFinanceiraDao.deleteObject(toDrift(FinNaturezaFinanceiraModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinNaturezaFinanceiraModel> toListModel(List<FinNaturezaFinanceiraGrouped> finNaturezaFinanceiraDriftList) {
		List<FinNaturezaFinanceiraModel> listModel = [];
		for (var finNaturezaFinanceiraDrift in finNaturezaFinanceiraDriftList) {
			listModel.add(toModel(finNaturezaFinanceiraDrift)!);
		}
		return listModel;
	}	

	FinNaturezaFinanceiraModel? toModel(FinNaturezaFinanceiraGrouped? finNaturezaFinanceiraDrift) {
		if (finNaturezaFinanceiraDrift != null) {
			return FinNaturezaFinanceiraModel(
				id: finNaturezaFinanceiraDrift.finNaturezaFinanceira?.id,
				codigo: FinNaturezaFinanceiraDomain.getCodigo(finNaturezaFinanceiraDrift.finNaturezaFinanceira?.codigo),
				descricao: finNaturezaFinanceiraDrift.finNaturezaFinanceira?.descricao,
				tipo: FinNaturezaFinanceiraDomain.getTipo(finNaturezaFinanceiraDrift.finNaturezaFinanceira?.tipo),
				aplicacao: finNaturezaFinanceiraDrift.finNaturezaFinanceira?.aplicacao,
			);
		} else {
			return null;
		}
	}


	FinNaturezaFinanceiraGrouped toDrift(FinNaturezaFinanceiraModel finNaturezaFinanceiraModel) {
		return FinNaturezaFinanceiraGrouped(
			finNaturezaFinanceira: FinNaturezaFinanceira(
				id: finNaturezaFinanceiraModel.id,
				codigo: FinNaturezaFinanceiraDomain.setCodigo(finNaturezaFinanceiraModel.codigo),
				descricao: finNaturezaFinanceiraModel.descricao,
				tipo: FinNaturezaFinanceiraDomain.setTipo(finNaturezaFinanceiraModel.tipo),
				aplicacao: finNaturezaFinanceiraModel.aplicacao,
			),
		);
	}

		
}
