import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class PlanoContaRefSpedDriftProvider extends ProviderBase {

	Future<List<PlanoContaRefSpedModel>?> getList({Filter? filter}) async {
		List<PlanoContaRefSpedGrouped> planoContaRefSpedDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				planoContaRefSpedDriftList = await Session.database.planoContaRefSpedDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				planoContaRefSpedDriftList = await Session.database.planoContaRefSpedDao.getGroupedList(); 
			}
			if (planoContaRefSpedDriftList.isNotEmpty) {
				return toListModel(planoContaRefSpedDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PlanoContaRefSpedModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.planoContaRefSpedDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PlanoContaRefSpedModel?>? insert(PlanoContaRefSpedModel planoContaRefSpedModel) async {
		try {
			final lastPk = await Session.database.planoContaRefSpedDao.insertObject(toDrift(planoContaRefSpedModel));
			planoContaRefSpedModel.id = lastPk;
			return planoContaRefSpedModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PlanoContaRefSpedModel?>? update(PlanoContaRefSpedModel planoContaRefSpedModel) async {
		try {
			await Session.database.planoContaRefSpedDao.updateObject(toDrift(planoContaRefSpedModel));
			return planoContaRefSpedModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.planoContaRefSpedDao.deleteObject(toDrift(PlanoContaRefSpedModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PlanoContaRefSpedModel> toListModel(List<PlanoContaRefSpedGrouped> planoContaRefSpedDriftList) {
		List<PlanoContaRefSpedModel> listModel = [];
		for (var planoContaRefSpedDrift in planoContaRefSpedDriftList) {
			listModel.add(toModel(planoContaRefSpedDrift)!);
		}
		return listModel;
	}	

	PlanoContaRefSpedModel? toModel(PlanoContaRefSpedGrouped? planoContaRefSpedDrift) {
		if (planoContaRefSpedDrift != null) {
			return PlanoContaRefSpedModel(
				id: planoContaRefSpedDrift.planoContaRefSped?.id,
				codCtaRef: planoContaRefSpedDrift.planoContaRefSped?.codCtaRef,
				inicioValidade: planoContaRefSpedDrift.planoContaRefSped?.inicioValidade,
				fimValidade: planoContaRefSpedDrift.planoContaRefSped?.fimValidade,
				tipo: PlanoContaRefSpedDomain.getTipo(planoContaRefSpedDrift.planoContaRefSped?.tipo),
				descricao: planoContaRefSpedDrift.planoContaRefSped?.descricao,
				orientacoes: planoContaRefSpedDrift.planoContaRefSped?.orientacoes,
			);
		} else {
			return null;
		}
	}


	PlanoContaRefSpedGrouped toDrift(PlanoContaRefSpedModel planoContaRefSpedModel) {
		return PlanoContaRefSpedGrouped(
			planoContaRefSped: PlanoContaRefSped(
				id: planoContaRefSpedModel.id,
				codCtaRef: planoContaRefSpedModel.codCtaRef,
				inicioValidade: planoContaRefSpedModel.inicioValidade,
				fimValidade: planoContaRefSpedModel.fimValidade,
				tipo: PlanoContaRefSpedDomain.setTipo(planoContaRefSpedModel.tipo),
				descricao: planoContaRefSpedModel.descricao,
				orientacoes: planoContaRefSpedModel.orientacoes,
			),
		);
	}

		
}
