import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilLoteDriftProvider extends ProviderBase {

	Future<List<ContabilLoteModel>?> getList({Filter? filter}) async {
		List<ContabilLoteGrouped> contabilLoteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilLoteDriftList = await Session.database.contabilLoteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilLoteDriftList = await Session.database.contabilLoteDao.getGroupedList(); 
			}
			if (contabilLoteDriftList.isNotEmpty) {
				return toListModel(contabilLoteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilLoteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilLoteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLoteModel?>? insert(ContabilLoteModel contabilLoteModel) async {
		try {
			final lastPk = await Session.database.contabilLoteDao.insertObject(toDrift(contabilLoteModel));
			contabilLoteModel.id = lastPk;
			return contabilLoteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLoteModel?>? update(ContabilLoteModel contabilLoteModel) async {
		try {
			await Session.database.contabilLoteDao.updateObject(toDrift(contabilLoteModel));
			return contabilLoteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilLoteDao.deleteObject(toDrift(ContabilLoteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilLoteModel> toListModel(List<ContabilLoteGrouped> contabilLoteDriftList) {
		List<ContabilLoteModel> listModel = [];
		for (var contabilLoteDrift in contabilLoteDriftList) {
			listModel.add(toModel(contabilLoteDrift)!);
		}
		return listModel;
	}	

	ContabilLoteModel? toModel(ContabilLoteGrouped? contabilLoteDrift) {
		if (contabilLoteDrift != null) {
			return ContabilLoteModel(
				id: contabilLoteDrift.contabilLote?.id,
				descricao: contabilLoteDrift.contabilLote?.descricao,
				dataInclusao: contabilLoteDrift.contabilLote?.dataInclusao,
				dataLiberacao: contabilLoteDrift.contabilLote?.dataLiberacao,
				liberado: ContabilLoteDomain.getLiberado(contabilLoteDrift.contabilLote?.liberado),
				programado: ContabilLoteDomain.getProgramado(contabilLoteDrift.contabilLote?.programado),
				valor: contabilLoteDrift.contabilLote?.valor,
			);
		} else {
			return null;
		}
	}


	ContabilLoteGrouped toDrift(ContabilLoteModel contabilLoteModel) {
		return ContabilLoteGrouped(
			contabilLote: ContabilLote(
				id: contabilLoteModel.id,
				descricao: contabilLoteModel.descricao,
				dataInclusao: contabilLoteModel.dataInclusao,
				dataLiberacao: contabilLoteModel.dataLiberacao,
				liberado: ContabilLoteDomain.setLiberado(contabilLoteModel.liberado),
				programado: ContabilLoteDomain.setProgramado(contabilLoteModel.programado),
				valor: contabilLoteModel.valor,
			),
		);
	}

		
}
