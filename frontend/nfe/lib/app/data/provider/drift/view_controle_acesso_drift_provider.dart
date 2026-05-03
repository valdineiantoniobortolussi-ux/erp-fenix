import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewControleAcessoDriftProvider extends ProviderBase {

	Future<List<ViewControleAcessoModel>?> getList({Filter? filter}) async {
		List<ViewControleAcessoGrouped> viewControleAcessoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				viewControleAcessoDriftList = await Session.database.viewControleAcessoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				viewControleAcessoDriftList = await Session.database.viewControleAcessoDao.getGroupedList(); 
			}
			if (viewControleAcessoDriftList.isNotEmpty) {
				return toListModel(viewControleAcessoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ViewControleAcessoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.viewControleAcessoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewControleAcessoModel?>? insert(ViewControleAcessoModel viewControleAcessoModel) async {
		try {
			final lastPk = await Session.database.viewControleAcessoDao.insertObject(toDrift(viewControleAcessoModel));
			viewControleAcessoModel.id = lastPk;
			return viewControleAcessoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewControleAcessoModel?>? update(ViewControleAcessoModel viewControleAcessoModel) async {
		try {
			await Session.database.viewControleAcessoDao.updateObject(toDrift(viewControleAcessoModel));
			return viewControleAcessoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.viewControleAcessoDao.deleteObject(toDrift(ViewControleAcessoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ViewControleAcessoModel> toListModel(List<ViewControleAcessoGrouped> viewControleAcessoDriftList) {
		List<ViewControleAcessoModel> listModel = [];
		for (var viewControleAcessoDrift in viewControleAcessoDriftList) {
			listModel.add(toModel(viewControleAcessoDrift)!);
		}
		return listModel;
	}	

	ViewControleAcessoModel? toModel(ViewControleAcessoGrouped? viewControleAcessoDrift) {
		if (viewControleAcessoDrift != null) {
			return ViewControleAcessoModel(
				id: viewControleAcessoDrift.viewControleAcesso?.id,
				idPessoa: viewControleAcessoDrift.viewControleAcesso?.idPessoa,
				pessoaNome: viewControleAcessoDrift.viewControleAcesso?.pessoaNome,
				idColaborador: viewControleAcessoDrift.viewControleAcesso?.idColaborador,
				idUsuario: viewControleAcessoDrift.viewControleAcesso?.idUsuario,
				administrador: viewControleAcessoDrift.viewControleAcesso?.administrador,
				idPapel: viewControleAcessoDrift.viewControleAcesso?.idPapel,
				papelNome: viewControleAcessoDrift.viewControleAcesso?.papelNome,
				papelDescricao: viewControleAcessoDrift.viewControleAcesso?.papelDescricao,
				idFuncao: viewControleAcessoDrift.viewControleAcesso?.idFuncao,
				funcaoNome: viewControleAcessoDrift.viewControleAcesso?.funcaoNome,
				funcaoDescricao: viewControleAcessoDrift.viewControleAcesso?.funcaoDescricao,
				idPapelFuncao: viewControleAcessoDrift.viewControleAcesso?.idPapelFuncao,
				habilitado: viewControleAcessoDrift.viewControleAcesso?.habilitado,
				podeInserir: viewControleAcessoDrift.viewControleAcesso?.podeInserir,
				podeAlterar: viewControleAcessoDrift.viewControleAcesso?.podeAlterar,
				podeExcluir: viewControleAcessoDrift.viewControleAcesso?.podeExcluir,
			);
		} else {
			return null;
		}
	}


	ViewControleAcessoGrouped toDrift(ViewControleAcessoModel viewControleAcessoModel) {
		return ViewControleAcessoGrouped(
			viewControleAcesso: ViewControleAcesso(
				id: viewControleAcessoModel.id,
				idPessoa: viewControleAcessoModel.idPessoa,
				pessoaNome: viewControleAcessoModel.pessoaNome,
				idColaborador: viewControleAcessoModel.idColaborador,
				idUsuario: viewControleAcessoModel.idUsuario,
				administrador: viewControleAcessoModel.administrador,
				idPapel: viewControleAcessoModel.idPapel,
				papelNome: viewControleAcessoModel.papelNome,
				papelDescricao: viewControleAcessoModel.papelDescricao,
				idFuncao: viewControleAcessoModel.idFuncao,
				funcaoNome: viewControleAcessoModel.funcaoNome,
				funcaoDescricao: viewControleAcessoModel.funcaoDescricao,
				idPapelFuncao: viewControleAcessoModel.idPapelFuncao,
				habilitado: viewControleAcessoModel.habilitado,
				podeInserir: viewControleAcessoModel.podeInserir,
				podeAlterar: viewControleAcessoModel.podeAlterar,
				podeExcluir: viewControleAcessoModel.podeExcluir,
			),
		);
	}

		
}
