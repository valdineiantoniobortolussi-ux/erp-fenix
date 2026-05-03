import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaInssDriftProvider extends ProviderBase {

	Future<List<FolhaInssModel>?> getList({Filter? filter}) async {
		List<FolhaInssGrouped> folhaInssDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaInssDriftList = await Session.database.folhaInssDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaInssDriftList = await Session.database.folhaInssDao.getGroupedList(); 
			}
			if (folhaInssDriftList.isNotEmpty) {
				return toListModel(folhaInssDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaInssModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaInssDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaInssModel?>? insert(FolhaInssModel folhaInssModel) async {
		try {
			final lastPk = await Session.database.folhaInssDao.insertObject(toDrift(folhaInssModel));
			folhaInssModel.id = lastPk;
			return folhaInssModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaInssModel?>? update(FolhaInssModel folhaInssModel) async {
		try {
			await Session.database.folhaInssDao.updateObject(toDrift(folhaInssModel));
			return folhaInssModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaInssDao.deleteObject(toDrift(FolhaInssModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaInssModel> toListModel(List<FolhaInssGrouped> folhaInssDriftList) {
		List<FolhaInssModel> listModel = [];
		for (var folhaInssDrift in folhaInssDriftList) {
			listModel.add(toModel(folhaInssDrift)!);
		}
		return listModel;
	}	

	FolhaInssModel? toModel(FolhaInssGrouped? folhaInssDrift) {
		if (folhaInssDrift != null) {
			return FolhaInssModel(
				id: folhaInssDrift.folhaInss?.id,
				competencia: folhaInssDrift.folhaInss?.competencia,
				folhaInssRetencaoModelList: folhaInssRetencaoDriftToModel(folhaInssDrift.folhaInssRetencaoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<FolhaInssRetencaoModel> folhaInssRetencaoDriftToModel(List<FolhaInssRetencaoGrouped>? folhaInssRetencaoDriftList) { 
		List<FolhaInssRetencaoModel> folhaInssRetencaoModelList = [];
		if (folhaInssRetencaoDriftList != null) {
			for (var folhaInssRetencaoGrouped in folhaInssRetencaoDriftList) {
				folhaInssRetencaoModelList.add(
					FolhaInssRetencaoModel(
						id: folhaInssRetencaoGrouped.folhaInssRetencao?.id,
						idFolhaInss: folhaInssRetencaoGrouped.folhaInssRetencao?.idFolhaInss,
						idFolhaInssServico: folhaInssRetencaoGrouped.folhaInssRetencao?.idFolhaInssServico,
						folhaInssServicoModel: FolhaInssServicoModel(
							id: folhaInssRetencaoGrouped.folhaInssServico?.id,
							codigo: folhaInssRetencaoGrouped.folhaInssServico?.codigo,
							nome: folhaInssRetencaoGrouped.folhaInssServico?.nome,
						),
						valorMensal: folhaInssRetencaoGrouped.folhaInssRetencao?.valorMensal,
						valor13: folhaInssRetencaoGrouped.folhaInssRetencao?.valor13,
					)
				);
			}
			return folhaInssRetencaoModelList;
		}
		return [];
	}


	FolhaInssGrouped toDrift(FolhaInssModel folhaInssModel) {
		return FolhaInssGrouped(
			folhaInss: FolhaInss(
				id: folhaInssModel.id,
				competencia: Util.removeMask(folhaInssModel.competencia),
			),
			folhaInssRetencaoGroupedList: folhaInssRetencaoModelToDrift(folhaInssModel.folhaInssRetencaoModelList),
		);
	}

	List<FolhaInssRetencaoGrouped> folhaInssRetencaoModelToDrift(List<FolhaInssRetencaoModel>? folhaInssRetencaoModelList) { 
		List<FolhaInssRetencaoGrouped> folhaInssRetencaoGroupedList = [];
		if (folhaInssRetencaoModelList != null) {
			for (var folhaInssRetencaoModel in folhaInssRetencaoModelList) {
				folhaInssRetencaoGroupedList.add(
					FolhaInssRetencaoGrouped(
						folhaInssRetencao: FolhaInssRetencao(
							id: folhaInssRetencaoModel.id,
							idFolhaInss: folhaInssRetencaoModel.idFolhaInss,
							idFolhaInssServico: folhaInssRetencaoModel.idFolhaInssServico,
							valorMensal: folhaInssRetencaoModel.valorMensal,
							valor13: folhaInssRetencaoModel.valor13,
						),
					),
				);
			}
			return folhaInssRetencaoGroupedList;
		}
		return [];
	}

		
}
