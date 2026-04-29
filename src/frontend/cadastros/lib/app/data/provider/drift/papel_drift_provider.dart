import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

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
				descrica: papelDrift.papel?.descrica,
				papelFuncaoModelList: papelFuncaoDriftToModel(papelDrift.papelFuncaoGroupedList),
				usuarioModelList: usuarioDriftToModel(papelDrift.usuarioGroupedList),
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

	List<UsuarioModel> usuarioDriftToModel(List<UsuarioGrouped>? usuarioDriftList) { 
		List<UsuarioModel> usuarioModelList = [];
		if (usuarioDriftList != null) {
			for (var usuarioGrouped in usuarioDriftList) {
				usuarioModelList.add(
					UsuarioModel(
						id: usuarioGrouped.usuario?.id,
						idPapel: usuarioGrouped.usuario?.idPapel,
						idColaborador: usuarioGrouped.usuario?.idColaborador,
						login: usuarioGrouped.usuario?.login,
						senha: usuarioGrouped.usuario?.senha,
						administrador: UsuarioDomain.getAdministrador(usuarioGrouped.usuario?.administrador),
						dataCadastro: usuarioGrouped.usuario?.dataCadastro,
					)
				);
			}
			return usuarioModelList;
		}
		return [];
	}


	PapelGrouped toDrift(PapelModel papelModel) {
		return PapelGrouped(
			papel: Papel(
				id: papelModel.id,
				nome: papelModel.nome,
				descrica: papelModel.descrica,
			),
			papelFuncaoGroupedList: papelFuncaoModelToDrift(papelModel.papelFuncaoModelList),
			usuarioGroupedList: usuarioModelToDrift(papelModel.usuarioModelList),
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

	List<UsuarioGrouped> usuarioModelToDrift(List<UsuarioModel>? usuarioModelList) { 
		List<UsuarioGrouped> usuarioGroupedList = [];
		if (usuarioModelList != null) {
			for (var usuarioModel in usuarioModelList) {
				usuarioGroupedList.add(
					UsuarioGrouped(
						usuario: Usuario(
							id: usuarioModel.id,
							idPapel: usuarioModel.idPapel,
							idColaborador: usuarioModel.idColaborador,
							login: usuarioModel.login,
							senha: usuarioModel.senha,
							administrador: UsuarioDomain.setAdministrador(usuarioModel.administrador),
							dataCadastro: usuarioModel.dataCadastro,
						),
					),
				);
			}
			return usuarioGroupedList;
		}
		return [];
	}

		
}
