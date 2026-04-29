import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ViewPessoaUsuarioDriftProvider extends ProviderBase {

	Future<List<ViewPessoaUsuarioModel>?> getList({Filter? filter}) async {
		List<ViewPessoaUsuarioGrouped> viewPessoaUsuarioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				viewPessoaUsuarioDriftList = await Session.database.viewPessoaUsuarioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				viewPessoaUsuarioDriftList = await Session.database.viewPessoaUsuarioDao.getGroupedList(); 
			}
			if (viewPessoaUsuarioDriftList.isNotEmpty) {
				return toListModel(viewPessoaUsuarioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ViewPessoaUsuarioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.viewPessoaUsuarioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaUsuarioModel?>? insert(ViewPessoaUsuarioModel viewPessoaUsuarioModel) async {
		try {
			final lastPk = await Session.database.viewPessoaUsuarioDao.insertObject(toDrift(viewPessoaUsuarioModel));
			viewPessoaUsuarioModel.id = lastPk;
			return viewPessoaUsuarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaUsuarioModel?>? update(ViewPessoaUsuarioModel viewPessoaUsuarioModel) async {
		try {
			await Session.database.viewPessoaUsuarioDao.updateObject(toDrift(viewPessoaUsuarioModel));
			return viewPessoaUsuarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.viewPessoaUsuarioDao.deleteObject(toDrift(ViewPessoaUsuarioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ViewPessoaUsuarioModel> toListModel(List<ViewPessoaUsuarioGrouped> viewPessoaUsuarioDriftList) {
		List<ViewPessoaUsuarioModel> listModel = [];
		for (var viewPessoaUsuarioDrift in viewPessoaUsuarioDriftList) {
			listModel.add(toModel(viewPessoaUsuarioDrift)!);
		}
		return listModel;
	}	

	ViewPessoaUsuarioModel? toModel(ViewPessoaUsuarioGrouped? viewPessoaUsuarioDrift) {
		if (viewPessoaUsuarioDrift != null) {
			return ViewPessoaUsuarioModel(
				id: viewPessoaUsuarioDrift.viewPessoaUsuario?.id,
				idPessoa: viewPessoaUsuarioDrift.viewPessoaUsuario?.idPessoa,
				pessoaNome: viewPessoaUsuarioDrift.viewPessoaUsuario?.pessoaNome,
				tipo: viewPessoaUsuarioDrift.viewPessoaUsuario?.tipo,
				email: viewPessoaUsuarioDrift.viewPessoaUsuario?.email,
				idColaborador: viewPessoaUsuarioDrift.viewPessoaUsuario?.idColaborador,
				idUsuario: viewPessoaUsuarioDrift.viewPessoaUsuario?.idUsuario,
				login: viewPessoaUsuarioDrift.viewPessoaUsuario?.login,
				senha: viewPessoaUsuarioDrift.viewPessoaUsuario?.senha,
				dataCadastro: viewPessoaUsuarioDrift.viewPessoaUsuario?.dataCadastro,
				administrador: viewPessoaUsuarioDrift.viewPessoaUsuario?.administrador,
			);
		} else {
			return null;
		}
	}


	ViewPessoaUsuarioGrouped toDrift(ViewPessoaUsuarioModel viewPessoaUsuarioModel) {
		return ViewPessoaUsuarioGrouped(
			viewPessoaUsuario: ViewPessoaUsuario(
				id: viewPessoaUsuarioModel.id,
				idPessoa: viewPessoaUsuarioModel.idPessoa,
				pessoaNome: viewPessoaUsuarioModel.pessoaNome,
				tipo: viewPessoaUsuarioModel.tipo,
				email: viewPessoaUsuarioModel.email,
				idColaborador: viewPessoaUsuarioModel.idColaborador,
				idUsuario: viewPessoaUsuarioModel.idUsuario,
				login: viewPessoaUsuarioModel.login,
				senha: viewPessoaUsuarioModel.senha,
				dataCadastro: viewPessoaUsuarioModel.dataCadastro,
				administrador: viewPessoaUsuarioModel.administrador,
			),
		);
	}

		
}
