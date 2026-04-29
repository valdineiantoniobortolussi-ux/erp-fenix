import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class SeguradoraDriftProvider extends ProviderBase {

	Future<List<SeguradoraModel>?> getList({Filter? filter}) async {
		List<SeguradoraGrouped> seguradoraDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				seguradoraDriftList = await Session.database.seguradoraDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				seguradoraDriftList = await Session.database.seguradoraDao.getGroupedList(); 
			}
			if (seguradoraDriftList.isNotEmpty) {
				return toListModel(seguradoraDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<SeguradoraModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.seguradoraDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SeguradoraModel?>? insert(SeguradoraModel seguradoraModel) async {
		try {
			final lastPk = await Session.database.seguradoraDao.insertObject(toDrift(seguradoraModel));
			seguradoraModel.id = lastPk;
			return seguradoraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SeguradoraModel?>? update(SeguradoraModel seguradoraModel) async {
		try {
			await Session.database.seguradoraDao.updateObject(toDrift(seguradoraModel));
			return seguradoraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.seguradoraDao.deleteObject(toDrift(SeguradoraModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<SeguradoraModel> toListModel(List<SeguradoraGrouped> seguradoraDriftList) {
		List<SeguradoraModel> listModel = [];
		for (var seguradoraDrift in seguradoraDriftList) {
			listModel.add(toModel(seguradoraDrift)!);
		}
		return listModel;
	}	

	SeguradoraModel? toModel(SeguradoraGrouped? seguradoraDrift) {
		if (seguradoraDrift != null) {
			return SeguradoraModel(
				id: seguradoraDrift.seguradora?.id,
				nome: seguradoraDrift.seguradora?.nome,
				contato: seguradoraDrift.seguradora?.contato,
				telefone: seguradoraDrift.seguradora?.telefone,
			);
		} else {
			return null;
		}
	}


	SeguradoraGrouped toDrift(SeguradoraModel seguradoraModel) {
		return SeguradoraGrouped(
			seguradora: Seguradora(
				id: seguradoraModel.id,
				nome: seguradoraModel.nome,
				contato: seguradoraModel.contato,
				telefone: Util.removeMask(seguradoraModel.telefone),
			),
		);
	}

		
}
