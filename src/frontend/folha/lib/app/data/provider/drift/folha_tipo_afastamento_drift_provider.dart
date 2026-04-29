import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaTipoAfastamentoDriftProvider extends ProviderBase {

	Future<List<FolhaTipoAfastamentoModel>?> getList({Filter? filter}) async {
		List<FolhaTipoAfastamentoGrouped> folhaTipoAfastamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaTipoAfastamentoDriftList = await Session.database.folhaTipoAfastamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaTipoAfastamentoDriftList = await Session.database.folhaTipoAfastamentoDao.getGroupedList(); 
			}
			if (folhaTipoAfastamentoDriftList.isNotEmpty) {
				return toListModel(folhaTipoAfastamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaTipoAfastamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaTipoAfastamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaTipoAfastamentoModel?>? insert(FolhaTipoAfastamentoModel folhaTipoAfastamentoModel) async {
		try {
			final lastPk = await Session.database.folhaTipoAfastamentoDao.insertObject(toDrift(folhaTipoAfastamentoModel));
			folhaTipoAfastamentoModel.id = lastPk;
			return folhaTipoAfastamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaTipoAfastamentoModel?>? update(FolhaTipoAfastamentoModel folhaTipoAfastamentoModel) async {
		try {
			await Session.database.folhaTipoAfastamentoDao.updateObject(toDrift(folhaTipoAfastamentoModel));
			return folhaTipoAfastamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaTipoAfastamentoDao.deleteObject(toDrift(FolhaTipoAfastamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaTipoAfastamentoModel> toListModel(List<FolhaTipoAfastamentoGrouped> folhaTipoAfastamentoDriftList) {
		List<FolhaTipoAfastamentoModel> listModel = [];
		for (var folhaTipoAfastamentoDrift in folhaTipoAfastamentoDriftList) {
			listModel.add(toModel(folhaTipoAfastamentoDrift)!);
		}
		return listModel;
	}	

	FolhaTipoAfastamentoModel? toModel(FolhaTipoAfastamentoGrouped? folhaTipoAfastamentoDrift) {
		if (folhaTipoAfastamentoDrift != null) {
			return FolhaTipoAfastamentoModel(
				id: folhaTipoAfastamentoDrift.folhaTipoAfastamento?.id,
				codigo: folhaTipoAfastamentoDrift.folhaTipoAfastamento?.codigo,
				nome: folhaTipoAfastamentoDrift.folhaTipoAfastamento?.nome,
				codigoEsocial: folhaTipoAfastamentoDrift.folhaTipoAfastamento?.codigoEsocial,
				descricao: folhaTipoAfastamentoDrift.folhaTipoAfastamento?.descricao,
			);
		} else {
			return null;
		}
	}


	FolhaTipoAfastamentoGrouped toDrift(FolhaTipoAfastamentoModel folhaTipoAfastamentoModel) {
		return FolhaTipoAfastamentoGrouped(
			folhaTipoAfastamento: FolhaTipoAfastamento(
				id: folhaTipoAfastamentoModel.id,
				codigo: folhaTipoAfastamentoModel.codigo,
				nome: folhaTipoAfastamentoModel.nome,
				codigoEsocial: folhaTipoAfastamentoModel.codigoEsocial,
				descricao: folhaTipoAfastamentoModel.descricao,
			),
		);
	}

		
}
