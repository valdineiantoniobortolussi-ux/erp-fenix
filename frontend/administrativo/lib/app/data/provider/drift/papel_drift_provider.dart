import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/provider/provider_base.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class PapelDriftProvider extends ProviderBase {

	Future<List<PapelModel>?> getList({Filter? filter}) async {
		List<PapelGrouped> papelDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				papelDriftList = await Session.database.papelDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				papelDriftList = await Session.database.papelDao.getGroupedList(); 
			}
			if (papelDriftList.isNotEmpty) {
				return toListModel(papelDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PapelModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.papelDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PapelModel?>? insert(PapelModel papelModel) async {
		try {
			final lastPk = await Session.database.papelDao.insertObject(toDrift(papelModel));
			papelModel.id = lastPk;
			return papelModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PapelModel?>? update(PapelModel papelModel) async {
		try {
			await Session.database.papelDao.updateObject(toDrift(papelModel));
			return papelModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.papelDao.deleteObject(toDrift(PapelModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PapelModel> toListModel(List<PapelGrouped> papelDriftList) {
		List<PapelModel> listModel = [];
		for (var papelDrift in papelDriftList) {
			listModel.add(toModel(papelDrift)!);
		}
		return listModel;
	}	

	PapelModel? toModel(PapelGrouped? papelDrift) {
		if (papelDrift != null) {
			return PapelModel(
				id: papelDrift.papel?.id,
				nome: papelDrift.papel?.nome,
				descricao: papelDrift.papel?.descricao,
				papelFuncaoModelList: papelFuncaoDriftToModel(papelDrift.papelFuncaoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<PapelFuncaoModel> papelFuncaoDriftToModel(List<PapelFuncaoGrouped>? papelFuncaoDriftList) { 
		List<PapelFuncaoModel> papelFuncaoModelList = [];
		if (papelFuncaoDriftList != null) {
			for (var papelFuncaoGrouped in papelFuncaoDriftList) {
				papelFuncaoModelList.add(
					PapelFuncaoModel(
						id: papelFuncaoGrouped.papelFuncao?.id,
						idPapel: papelFuncaoGrouped.papelFuncao?.idPapel,
						idFuncao: papelFuncaoGrouped.papelFuncao?.idFuncao,
						funcaoModel: FuncaoModel(
							id: papelFuncaoGrouped.funcao?.id,
							nome: papelFuncaoGrouped.funcao?.nome,
							descricao: papelFuncaoGrouped.funcao?.descricao,
						),
						habilitado: PapelFuncaoDomain.getHabilitado(papelFuncaoGrouped.papelFuncao?.habilitado),
						podeInserir: PapelFuncaoDomain.getPodeInserir(papelFuncaoGrouped.papelFuncao?.podeInserir),
						podeAlterar: PapelFuncaoDomain.getPodeAlterar(papelFuncaoGrouped.papelFuncao?.podeAlterar),
						podeExcluir: PapelFuncaoDomain.getPodeExcluir(papelFuncaoGrouped.papelFuncao?.podeExcluir),
					)
				);
			}
			return papelFuncaoModelList;
		}
		return [];
	}


	PapelGrouped toDrift(PapelModel papelModel) {
		return PapelGrouped(
			papel: Papel(
				id: papelModel.id,
				nome: papelModel.nome,
				descricao: papelModel.descricao,
			),
			papelFuncaoGroupedList: papelFuncaoModelToDrift(papelModel.papelFuncaoModelList),
		);
	}

	List<PapelFuncaoGrouped> papelFuncaoModelToDrift(List<PapelFuncaoModel>? papelFuncaoModelList) { 
		List<PapelFuncaoGrouped> papelFuncaoGroupedList = [];
		if (papelFuncaoModelList != null) {
			for (var papelFuncaoModel in papelFuncaoModelList) {
				papelFuncaoGroupedList.add(
					PapelFuncaoGrouped(
						papelFuncao: PapelFuncao(
							id: papelFuncaoModel.id,
							idPapel: papelFuncaoModel.idPapel,
							idFuncao: papelFuncaoModel.idFuncao,
							habilitado: PapelFuncaoDomain.setHabilitado(papelFuncaoModel.habilitado),
							podeInserir: PapelFuncaoDomain.setPodeInserir(papelFuncaoModel.podeInserir),
							podeAlterar: PapelFuncaoDomain.setPodeAlterar(papelFuncaoModel.podeAlterar),
							podeExcluir: PapelFuncaoDomain.setPodeExcluir(papelFuncaoModel.podeExcluir),
						),
					),
				);
			}
			return papelFuncaoGroupedList;
		}
		return [];
	}

		
}
