import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CstIcmsDriftProvider extends ProviderBase {

	Future<List<CstIcmsModel>?> getList({Filter? filter}) async {
		List<CstIcmsGrouped> cstIcmsDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cstIcmsDriftList = await Session.database.cstIcmsDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cstIcmsDriftList = await Session.database.cstIcmsDao.getGroupedList(); 
			}
			if (cstIcmsDriftList.isNotEmpty) {
				return toListModel(cstIcmsDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CstIcmsModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cstIcmsDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstIcmsModel?>? insert(CstIcmsModel cstIcmsModel) async {
		try {
			final lastPk = await Session.database.cstIcmsDao.insertObject(toDrift(cstIcmsModel));
			cstIcmsModel.id = lastPk;
			return cstIcmsModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CstIcmsModel?>? update(CstIcmsModel cstIcmsModel) async {
		try {
			await Session.database.cstIcmsDao.updateObject(toDrift(cstIcmsModel));
			return cstIcmsModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cstIcmsDao.deleteObject(toDrift(CstIcmsModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CstIcmsModel> toListModel(List<CstIcmsGrouped> cstIcmsDriftList) {
		List<CstIcmsModel> listModel = [];
		for (var cstIcmsDrift in cstIcmsDriftList) {
			listModel.add(toModel(cstIcmsDrift)!);
		}
		return listModel;
	}	

	CstIcmsModel? toModel(CstIcmsGrouped? cstIcmsDrift) {
		if (cstIcmsDrift != null) {
			return CstIcmsModel(
				id: cstIcmsDrift.cstIcms?.id,
				codigo: cstIcmsDrift.cstIcms?.codigo,
				descricao: cstIcmsDrift.cstIcms?.descricao,
				observacao: cstIcmsDrift.cstIcms?.observacao,
			);
		} else {
			return null;
		}
	}


	CstIcmsGrouped toDrift(CstIcmsModel cstIcmsModel) {
		return CstIcmsGrouped(
			cstIcms: CstIcms(
				id: cstIcmsModel.id,
				codigo: cstIcmsModel.codigo,
				descricao: cstIcmsModel.descricao,
				observacao: cstIcmsModel.observacao,
			),
		);
	}

		
}
