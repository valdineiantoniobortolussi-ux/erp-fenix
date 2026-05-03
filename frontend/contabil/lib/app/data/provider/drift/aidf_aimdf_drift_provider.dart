import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class AidfAimdfDriftProvider extends ProviderBase {

	Future<List<AidfAimdfModel>?> getList({Filter? filter}) async {
		List<AidfAimdfGrouped> aidfAimdfDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				aidfAimdfDriftList = await Session.database.aidfAimdfDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				aidfAimdfDriftList = await Session.database.aidfAimdfDao.getGroupedList(); 
			}
			if (aidfAimdfDriftList.isNotEmpty) {
				return toListModel(aidfAimdfDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<AidfAimdfModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.aidfAimdfDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AidfAimdfModel?>? insert(AidfAimdfModel aidfAimdfModel) async {
		try {
			final lastPk = await Session.database.aidfAimdfDao.insertObject(toDrift(aidfAimdfModel));
			aidfAimdfModel.id = lastPk;
			return aidfAimdfModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AidfAimdfModel?>? update(AidfAimdfModel aidfAimdfModel) async {
		try {
			await Session.database.aidfAimdfDao.updateObject(toDrift(aidfAimdfModel));
			return aidfAimdfModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.aidfAimdfDao.deleteObject(toDrift(AidfAimdfModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<AidfAimdfModel> toListModel(List<AidfAimdfGrouped> aidfAimdfDriftList) {
		List<AidfAimdfModel> listModel = [];
		for (var aidfAimdfDrift in aidfAimdfDriftList) {
			listModel.add(toModel(aidfAimdfDrift)!);
		}
		return listModel;
	}	

	AidfAimdfModel? toModel(AidfAimdfGrouped? aidfAimdfDrift) {
		if (aidfAimdfDrift != null) {
			return AidfAimdfModel(
				id: aidfAimdfDrift.aidfAimdf?.id,
				numero: aidfAimdfDrift.aidfAimdf?.numero,
				dataValidade: aidfAimdfDrift.aidfAimdf?.dataValidade,
				dataAutorizacao: aidfAimdfDrift.aidfAimdf?.dataAutorizacao,
				numeroAutorizacao: aidfAimdfDrift.aidfAimdf?.numeroAutorizacao,
				formularioDisponivel: AidfAimdfDomain.getFormularioDisponivel(aidfAimdfDrift.aidfAimdf?.formularioDisponivel),
			);
		} else {
			return null;
		}
	}


	AidfAimdfGrouped toDrift(AidfAimdfModel aidfAimdfModel) {
		return AidfAimdfGrouped(
			aidfAimdf: AidfAimdf(
				id: aidfAimdfModel.id,
				numero: aidfAimdfModel.numero,
				dataValidade: aidfAimdfModel.dataValidade,
				dataAutorizacao: aidfAimdfModel.dataAutorizacao,
				numeroAutorizacao: aidfAimdfModel.numeroAutorizacao,
				formularioDisponivel: AidfAimdfDomain.setFormularioDisponivel(aidfAimdfModel.formularioDisponivel),
			),
		);
	}

		
}
