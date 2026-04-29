import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/provider/provider_base.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class AuditoriaDriftProvider extends ProviderBase {

	Future<List<AuditoriaModel>?> getList({Filter? filter}) async {
		List<AuditoriaGrouped> auditoriaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				auditoriaDriftList = await Session.database.auditoriaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				auditoriaDriftList = await Session.database.auditoriaDao.getGroupedList(); 
			}
			if (auditoriaDriftList.isNotEmpty) {
				return toListModel(auditoriaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<AuditoriaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.auditoriaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AuditoriaModel?>? insert(AuditoriaModel auditoriaModel) async {
		try {
			final lastPk = await Session.database.auditoriaDao.insertObject(toDrift(auditoriaModel));
			auditoriaModel.id = lastPk;
			return auditoriaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AuditoriaModel?>? update(AuditoriaModel auditoriaModel) async {
		try {
			await Session.database.auditoriaDao.updateObject(toDrift(auditoriaModel));
			return auditoriaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.auditoriaDao.deleteObject(toDrift(AuditoriaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<AuditoriaModel> toListModel(List<AuditoriaGrouped> auditoriaDriftList) {
		List<AuditoriaModel> listModel = [];
		for (var auditoriaDrift in auditoriaDriftList) {
			listModel.add(toModel(auditoriaDrift)!);
		}
		return listModel;
	}	

	AuditoriaModel? toModel(AuditoriaGrouped? auditoriaDrift) {
		if (auditoriaDrift != null) {
			return AuditoriaModel(
				id: auditoriaDrift.auditoria?.id,
				dataRegistro: auditoriaDrift.auditoria?.dataRegistro,
				horaRegistro: auditoriaDrift.auditoria?.horaRegistro,
				janelaController: auditoriaDrift.auditoria?.janelaController,
				acao: auditoriaDrift.auditoria?.acao,
				conteudo: auditoriaDrift.auditoria?.conteudo,
				tokenJwt: auditoriaDrift.auditoria?.tokenJwt,
			);
		} else {
			return null;
		}
	}


	AuditoriaGrouped toDrift(AuditoriaModel auditoriaModel) {
		return AuditoriaGrouped(
			auditoria: Auditoria(
				id: auditoriaModel.id,
				dataRegistro: auditoriaModel.dataRegistro,
				horaRegistro: auditoriaModel.horaRegistro,
				janelaController: auditoriaModel.janelaController,
				acao: auditoriaModel.acao,
				conteudo: auditoriaModel.conteudo,
				tokenJwt: auditoriaModel.tokenJwt,
			),
		);
	}

		
}
