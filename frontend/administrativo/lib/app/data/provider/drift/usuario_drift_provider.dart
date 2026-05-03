import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/provider/provider_base.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class UsuarioDriftProvider extends ProviderBase {

	Future<List<UsuarioModel>?> getList({Filter? filter}) async {
		List<UsuarioGrouped> usuarioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				usuarioDriftList = await Session.database.usuarioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				usuarioDriftList = await Session.database.usuarioDao.getGroupedList(); 
			}
			if (usuarioDriftList.isNotEmpty) {
				return toListModel(usuarioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<UsuarioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.usuarioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<UsuarioModel?>? insert(UsuarioModel usuarioModel) async {
		try {
			final lastPk = await Session.database.usuarioDao.insertObject(toDrift(usuarioModel));
			usuarioModel.id = lastPk;
			return usuarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<UsuarioModel?>? update(UsuarioModel usuarioModel) async {
		try {
			await Session.database.usuarioDao.updateObject(toDrift(usuarioModel));
			return usuarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.usuarioDao.deleteObject(toDrift(UsuarioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<UsuarioModel> toListModel(List<UsuarioGrouped> usuarioDriftList) {
		List<UsuarioModel> listModel = [];
		for (var usuarioDrift in usuarioDriftList) {
			listModel.add(toModel(usuarioDrift)!);
		}
		return listModel;
	}	

	UsuarioModel? toModel(UsuarioGrouped? usuarioDrift) {
		if (usuarioDrift != null) {
			return UsuarioModel(
				id: usuarioDrift.usuario?.id,
				idColaborador: usuarioDrift.usuario?.idColaborador,
				idPapel: usuarioDrift.usuario?.idPapel,
				login: usuarioDrift.usuario?.login,
				senha: usuarioDrift.usuario?.senha,
				administrador: UsuarioDomain.getAdministrador(usuarioDrift.usuario?.administrador),
				dataCadastro: usuarioDrift.usuario?.dataCadastro,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: usuarioDrift.viewPessoaColaborador?.id,
					nome: usuarioDrift.viewPessoaColaborador?.nome,
					tipo: usuarioDrift.viewPessoaColaborador?.tipo,
					email: usuarioDrift.viewPessoaColaborador?.email,
					site: usuarioDrift.viewPessoaColaborador?.site,
					cpfCnpj: usuarioDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: usuarioDrift.viewPessoaColaborador?.rgIe,
					matricula: usuarioDrift.viewPessoaColaborador?.matricula,
					dataCadastro: usuarioDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: usuarioDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: usuarioDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: usuarioDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: usuarioDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: usuarioDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: usuarioDrift.viewPessoaColaborador?.ctpsUf,
					observacao: usuarioDrift.viewPessoaColaborador?.observacao,
					logradouro: usuarioDrift.viewPessoaColaborador?.logradouro,
					numero: usuarioDrift.viewPessoaColaborador?.numero,
					complemento: usuarioDrift.viewPessoaColaborador?.complemento,
					bairro: usuarioDrift.viewPessoaColaborador?.bairro,
					cidade: usuarioDrift.viewPessoaColaborador?.cidade,
					cep: usuarioDrift.viewPessoaColaborador?.cep,
					municipioIbge: usuarioDrift.viewPessoaColaborador?.municipioIbge,
					uf: usuarioDrift.viewPessoaColaborador?.uf,
					idPessoa: usuarioDrift.viewPessoaColaborador?.idPessoa,
					idCargo: usuarioDrift.viewPessoaColaborador?.idCargo,
					idSetor: usuarioDrift.viewPessoaColaborador?.idSetor,
				),
				papelModel: PapelModel(
					id: usuarioDrift.papel?.id,
					nome: usuarioDrift.papel?.nome,
					descricao: usuarioDrift.papel?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	UsuarioGrouped toDrift(UsuarioModel usuarioModel) {
		return UsuarioGrouped(
			usuario: Usuario(
				id: usuarioModel.id,
				idColaborador: usuarioModel.idColaborador,
				idPapel: usuarioModel.idPapel,
				login: usuarioModel.login,
				senha: usuarioModel.senha,
				administrador: UsuarioDomain.setAdministrador(usuarioModel.administrador),
				dataCadastro: usuarioModel.dataCadastro,
			),
		);
	}

		
}
