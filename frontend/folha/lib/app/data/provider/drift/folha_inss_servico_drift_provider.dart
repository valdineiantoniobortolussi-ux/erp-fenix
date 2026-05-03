import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaInssServicoDriftProvider extends ProviderBase {

	Future<List<FolhaInssServicoModel>?> getList({Filter? filter}) async {
		List<FolhaInssServicoGrouped> folhaInssServicoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaInssServicoDriftList = await Session.database.folhaInssServicoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaInssServicoDriftList = await Session.database.folhaInssServicoDao.getGroupedList(); 
			}
			if (folhaInssServicoDriftList.isNotEmpty) {
				return toListModel(folhaInssServicoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaInssServicoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaInssServicoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaInssServicoModel?>? insert(FolhaInssServicoModel folhaInssServicoModel) async {
		try {
			final lastPk = await Session.database.folhaInssServicoDao.insertObject(toDrift(folhaInssServicoModel));
			folhaInssServicoModel.id = lastPk;
			return folhaInssServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaInssServicoModel?>? update(FolhaInssServicoModel folhaInssServicoModel) async {
		try {
			await Session.database.folhaInssServicoDao.updateObject(toDrift(folhaInssServicoModel));
			return folhaInssServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaInssServicoDao.deleteObject(toDrift(FolhaInssServicoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaInssServicoModel> toListModel(List<FolhaInssServicoGrouped> folhaInssServicoDriftList) {
		List<FolhaInssServicoModel> listModel = [];
		for (var folhaInssServicoDrift in folhaInssServicoDriftList) {
			listModel.add(toModel(folhaInssServicoDrift)!);
		}
		return listModel;
	}	

	FolhaInssServicoModel? toModel(FolhaInssServicoGrouped? folhaInssServicoDrift) {
		if (folhaInssServicoDrift != null) {
			return FolhaInssServicoModel(
				id: folhaInssServicoDrift.folhaInssServico?.id,
				codigo: folhaInssServicoDrift.folhaInssServico?.codigo,
				nome: folhaInssServicoDrift.folhaInssServico?.nome,
			);
		} else {
			return null;
		}
	}


	FolhaInssServicoGrouped toDrift(FolhaInssServicoModel folhaInssServicoModel) {
		return FolhaInssServicoGrouped(
			folhaInssServico: FolhaInssServico(
				id: folhaInssServicoModel.id,
				codigo: folhaInssServicoModel.codigo,
				nome: folhaInssServicoModel.nome,
			),
		);
	}

		
}
