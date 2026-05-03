import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinStatusParcelaDriftProvider extends ProviderBase {

	Future<List<FinStatusParcelaModel>?> getList({Filter? filter}) async {
		List<FinStatusParcelaGrouped> finStatusParcelaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finStatusParcelaDriftList = await Session.database.finStatusParcelaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finStatusParcelaDriftList = await Session.database.finStatusParcelaDao.getGroupedList(); 
			}
			if (finStatusParcelaDriftList.isNotEmpty) {
				return toListModel(finStatusParcelaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinStatusParcelaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finStatusParcelaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinStatusParcelaModel?>? insert(FinStatusParcelaModel finStatusParcelaModel) async {
		try {
			final lastPk = await Session.database.finStatusParcelaDao.insertObject(toDrift(finStatusParcelaModel));
			finStatusParcelaModel.id = lastPk;
			return finStatusParcelaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinStatusParcelaModel?>? update(FinStatusParcelaModel finStatusParcelaModel) async {
		try {
			await Session.database.finStatusParcelaDao.updateObject(toDrift(finStatusParcelaModel));
			return finStatusParcelaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finStatusParcelaDao.deleteObject(toDrift(FinStatusParcelaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinStatusParcelaModel> toListModel(List<FinStatusParcelaGrouped> finStatusParcelaDriftList) {
		List<FinStatusParcelaModel> listModel = [];
		for (var finStatusParcelaDrift in finStatusParcelaDriftList) {
			listModel.add(toModel(finStatusParcelaDrift)!);
		}
		return listModel;
	}	

	FinStatusParcelaModel? toModel(FinStatusParcelaGrouped? finStatusParcelaDrift) {
		if (finStatusParcelaDrift != null) {
			return FinStatusParcelaModel(
				id: finStatusParcelaDrift.finStatusParcela?.id,
				situacao: FinStatusParcelaDomain.getSituacao(finStatusParcelaDrift.finStatusParcela?.situacao),
				descricao: finStatusParcelaDrift.finStatusParcela?.descricao,
				procedimento: finStatusParcelaDrift.finStatusParcela?.procedimento,
			);
		} else {
			return null;
		}
	}


	FinStatusParcelaGrouped toDrift(FinStatusParcelaModel finStatusParcelaModel) {
		return FinStatusParcelaGrouped(
			finStatusParcela: FinStatusParcela(
				id: finStatusParcelaModel.id,
				situacao: FinStatusParcelaDomain.setSituacao(finStatusParcelaModel.situacao),
				descricao: finStatusParcelaModel.descricao,
				procedimento: finStatusParcelaModel.procedimento,
			),
		);
	}

		
}
