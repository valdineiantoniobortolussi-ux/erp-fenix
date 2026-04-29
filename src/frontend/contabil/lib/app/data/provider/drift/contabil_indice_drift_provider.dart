import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilIndiceDriftProvider extends ProviderBase {

	Future<List<ContabilIndiceModel>?> getList({Filter? filter}) async {
		List<ContabilIndiceGrouped> contabilIndiceDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilIndiceDriftList = await Session.database.contabilIndiceDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilIndiceDriftList = await Session.database.contabilIndiceDao.getGroupedList(); 
			}
			if (contabilIndiceDriftList.isNotEmpty) {
				return toListModel(contabilIndiceDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilIndiceModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilIndiceDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilIndiceModel?>? insert(ContabilIndiceModel contabilIndiceModel) async {
		try {
			final lastPk = await Session.database.contabilIndiceDao.insertObject(toDrift(contabilIndiceModel));
			contabilIndiceModel.id = lastPk;
			return contabilIndiceModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilIndiceModel?>? update(ContabilIndiceModel contabilIndiceModel) async {
		try {
			await Session.database.contabilIndiceDao.updateObject(toDrift(contabilIndiceModel));
			return contabilIndiceModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilIndiceDao.deleteObject(toDrift(ContabilIndiceModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilIndiceModel> toListModel(List<ContabilIndiceGrouped> contabilIndiceDriftList) {
		List<ContabilIndiceModel> listModel = [];
		for (var contabilIndiceDrift in contabilIndiceDriftList) {
			listModel.add(toModel(contabilIndiceDrift)!);
		}
		return listModel;
	}	

	ContabilIndiceModel? toModel(ContabilIndiceGrouped? contabilIndiceDrift) {
		if (contabilIndiceDrift != null) {
			return ContabilIndiceModel(
				id: contabilIndiceDrift.contabilIndice?.id,
				indice: contabilIndiceDrift.contabilIndice?.indice,
				periodicidade: ContabilIndiceDomain.getPeriodicidade(contabilIndiceDrift.contabilIndice?.periodicidade),
				diarioAPartirDe: contabilIndiceDrift.contabilIndice?.diarioAPartirDe,
				mensalMesAno: contabilIndiceDrift.contabilIndice?.mensalMesAno,
				contabilIndiceValorModelList: contabilIndiceValorDriftToModel(contabilIndiceDrift.contabilIndiceValorGroupedList),
			);
		} else {
			return null;
		}
	}

	List<ContabilIndiceValorModel> contabilIndiceValorDriftToModel(List<ContabilIndiceValorGrouped>? contabilIndiceValorDriftList) { 
		List<ContabilIndiceValorModel> contabilIndiceValorModelList = [];
		if (contabilIndiceValorDriftList != null) {
			for (var contabilIndiceValorGrouped in contabilIndiceValorDriftList) {
				contabilIndiceValorModelList.add(
					ContabilIndiceValorModel(
						id: contabilIndiceValorGrouped.contabilIndiceValor?.id,
						idContabilIndice: contabilIndiceValorGrouped.contabilIndiceValor?.idContabilIndice,
						dataIndice: contabilIndiceValorGrouped.contabilIndiceValor?.dataIndice,
						valor: contabilIndiceValorGrouped.contabilIndiceValor?.valor,
					)
				);
			}
			return contabilIndiceValorModelList;
		}
		return [];
	}


	ContabilIndiceGrouped toDrift(ContabilIndiceModel contabilIndiceModel) {
		return ContabilIndiceGrouped(
			contabilIndice: ContabilIndice(
				id: contabilIndiceModel.id,
				indice: contabilIndiceModel.indice,
				periodicidade: ContabilIndiceDomain.setPeriodicidade(contabilIndiceModel.periodicidade),
				diarioAPartirDe: contabilIndiceModel.diarioAPartirDe,
				mensalMesAno: Util.removeMask(contabilIndiceModel.mensalMesAno),
			),
			contabilIndiceValorGroupedList: contabilIndiceValorModelToDrift(contabilIndiceModel.contabilIndiceValorModelList),
		);
	}

	List<ContabilIndiceValorGrouped> contabilIndiceValorModelToDrift(List<ContabilIndiceValorModel>? contabilIndiceValorModelList) { 
		List<ContabilIndiceValorGrouped> contabilIndiceValorGroupedList = [];
		if (contabilIndiceValorModelList != null) {
			for (var contabilIndiceValorModel in contabilIndiceValorModelList) {
				contabilIndiceValorGroupedList.add(
					ContabilIndiceValorGrouped(
						contabilIndiceValor: ContabilIndiceValor(
							id: contabilIndiceValorModel.id,
							idContabilIndice: contabilIndiceValorModel.idContabilIndice,
							dataIndice: contabilIndiceValorModel.dataIndice,
							valor: contabilIndiceValorModel.valor,
						),
					),
				);
			}
			return contabilIndiceValorGroupedList;
		}
		return [];
	}

		
}
