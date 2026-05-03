import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class FuncaoDriftProvider extends ProviderBase {

	Future<List<FuncaoModel>?> getList({Filter? filter}) async {
		List<FuncaoGrouped> funcaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				funcaoDriftList = await Session.database.funcaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				funcaoDriftList = await Session.database.funcaoDao.getGroupedList(); 
			}
			if (funcaoDriftList.isNotEmpty) {
				return toListModel(funcaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FuncaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.funcaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FuncaoModel?>? insert(FuncaoModel funcaoModel) async {
		try {
			final lastPk = await Session.database.funcaoDao.insertObject(toDrift(funcaoModel));
			funcaoModel.id = lastPk;
			return funcaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FuncaoModel?>? update(FuncaoModel funcaoModel) async {
		try {
			await Session.database.funcaoDao.updateObject(toDrift(funcaoModel));
			return funcaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.funcaoDao.deleteObject(toDrift(FuncaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FuncaoModel> toListModel(List<FuncaoGrouped> funcaoDriftList) {
		List<FuncaoModel> listModel = [];
		for (var funcaoDrift in funcaoDriftList) {
			listModel.add(toModel(funcaoDrift)!);
		}
		return listModel;
	}	

	FuncaoModel? toModel(FuncaoGrouped? funcaoDrift) {
		if (funcaoDrift != null) {
			return FuncaoModel(
				id: funcaoDrift.funcao?.id,
				nome: funcaoDrift.funcao?.nome,
				descricao: funcaoDrift.funcao?.descricao,
				papelFuncaoModelList: papelFuncaoDriftToModel(funcaoDrift.papelFuncaoGroupedList),
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


	FuncaoGrouped toDrift(FuncaoModel funcaoModel) {
		return FuncaoGrouped(
			funcao: Funcao(
				id: funcaoModel.id,
				nome: funcaoModel.nome,
				descricao: funcaoModel.descricao,
			),
			papelFuncaoGroupedList: papelFuncaoModelToDrift(funcaoModel.papelFuncaoModelList),
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
