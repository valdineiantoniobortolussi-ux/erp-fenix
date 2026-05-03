import 'package:agenda/app/data/provider/drift/database/database_imports.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/provider/provider_base.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class RecadoRemetenteDriftProvider extends ProviderBase {

	Future<List<RecadoRemetenteModel>?> getList({Filter? filter}) async {
		List<RecadoRemetenteGrouped> recadoRemetenteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				recadoRemetenteDriftList = await Session.database.recadoRemetenteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				recadoRemetenteDriftList = await Session.database.recadoRemetenteDao.getGroupedList(); 
			}
			if (recadoRemetenteDriftList.isNotEmpty) {
				return toListModel(recadoRemetenteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<RecadoRemetenteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.recadoRemetenteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RecadoRemetenteModel?>? insert(RecadoRemetenteModel recadoRemetenteModel) async {
		try {
			final lastPk = await Session.database.recadoRemetenteDao.insertObject(toDrift(recadoRemetenteModel));
			recadoRemetenteModel.id = lastPk;
			return recadoRemetenteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RecadoRemetenteModel?>? update(RecadoRemetenteModel recadoRemetenteModel) async {
		try {
			await Session.database.recadoRemetenteDao.updateObject(toDrift(recadoRemetenteModel));
			return recadoRemetenteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.recadoRemetenteDao.deleteObject(toDrift(RecadoRemetenteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<RecadoRemetenteModel> toListModel(List<RecadoRemetenteGrouped> recadoRemetenteDriftList) {
		List<RecadoRemetenteModel> listModel = [];
		for (var recadoRemetenteDrift in recadoRemetenteDriftList) {
			listModel.add(toModel(recadoRemetenteDrift)!);
		}
		return listModel;
	}	

	RecadoRemetenteModel? toModel(RecadoRemetenteGrouped? recadoRemetenteDrift) {
		if (recadoRemetenteDrift != null) {
			return RecadoRemetenteModel(
				id: recadoRemetenteDrift.recadoRemetente?.id,
				idColaborador: recadoRemetenteDrift.recadoRemetente?.idColaborador,
				dataEnvio: recadoRemetenteDrift.recadoRemetente?.dataEnvio,
				horaEnvio: recadoRemetenteDrift.recadoRemetente?.horaEnvio,
				assunto: recadoRemetenteDrift.recadoRemetente?.assunto,
				texto: recadoRemetenteDrift.recadoRemetente?.texto,
				recadoDestinatarioModelList: recadoDestinatarioDriftToModel(recadoRemetenteDrift.recadoDestinatarioGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: recadoRemetenteDrift.viewPessoaColaborador?.id,
					nome: recadoRemetenteDrift.viewPessoaColaborador?.nome,
					tipo: recadoRemetenteDrift.viewPessoaColaborador?.tipo,
					email: recadoRemetenteDrift.viewPessoaColaborador?.email,
					site: recadoRemetenteDrift.viewPessoaColaborador?.site,
					cpfCnpj: recadoRemetenteDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: recadoRemetenteDrift.viewPessoaColaborador?.rgIe,
					matricula: recadoRemetenteDrift.viewPessoaColaborador?.matricula,
					dataCadastro: recadoRemetenteDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: recadoRemetenteDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: recadoRemetenteDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: recadoRemetenteDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: recadoRemetenteDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: recadoRemetenteDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: recadoRemetenteDrift.viewPessoaColaborador?.ctpsUf,
					observacao: recadoRemetenteDrift.viewPessoaColaborador?.observacao,
					logradouro: recadoRemetenteDrift.viewPessoaColaborador?.logradouro,
					numero: recadoRemetenteDrift.viewPessoaColaborador?.numero,
					complemento: recadoRemetenteDrift.viewPessoaColaborador?.complemento,
					bairro: recadoRemetenteDrift.viewPessoaColaborador?.bairro,
					cidade: recadoRemetenteDrift.viewPessoaColaborador?.cidade,
					cep: recadoRemetenteDrift.viewPessoaColaborador?.cep,
					municipioIbge: recadoRemetenteDrift.viewPessoaColaborador?.municipioIbge,
					uf: recadoRemetenteDrift.viewPessoaColaborador?.uf,
					idPessoa: recadoRemetenteDrift.viewPessoaColaborador?.idPessoa,
					idCargo: recadoRemetenteDrift.viewPessoaColaborador?.idCargo,
					idSetor: recadoRemetenteDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<RecadoDestinatarioModel> recadoDestinatarioDriftToModel(List<RecadoDestinatarioGrouped>? recadoDestinatarioDriftList) { 
		List<RecadoDestinatarioModel> recadoDestinatarioModelList = [];
		if (recadoDestinatarioDriftList != null) {
			for (var recadoDestinatarioGrouped in recadoDestinatarioDriftList) {
				recadoDestinatarioModelList.add(
					RecadoDestinatarioModel(
						id: recadoDestinatarioGrouped.recadoDestinatario?.id,
						idColaborador: recadoDestinatarioGrouped.recadoDestinatario?.idColaborador,
						viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
							id: recadoDestinatarioGrouped.viewPessoaColaborador?.id,
							nome: recadoDestinatarioGrouped.viewPessoaColaborador?.nome,
							tipo: recadoDestinatarioGrouped.viewPessoaColaborador?.tipo,
							email: recadoDestinatarioGrouped.viewPessoaColaborador?.email,
							site: recadoDestinatarioGrouped.viewPessoaColaborador?.site,
							cpfCnpj: recadoDestinatarioGrouped.viewPessoaColaborador?.cpfCnpj,
							rgIe: recadoDestinatarioGrouped.viewPessoaColaborador?.rgIe,
							matricula: recadoDestinatarioGrouped.viewPessoaColaborador?.matricula,
							dataCadastro: recadoDestinatarioGrouped.viewPessoaColaborador?.dataCadastro,
							dataAdmissao: recadoDestinatarioGrouped.viewPessoaColaborador?.dataAdmissao,
							dataDemissao: recadoDestinatarioGrouped.viewPessoaColaborador?.dataDemissao,
							ctpsNumero: recadoDestinatarioGrouped.viewPessoaColaborador?.ctpsNumero,
							ctpsSerie: recadoDestinatarioGrouped.viewPessoaColaborador?.ctpsSerie,
							ctpsDataExpedicao: recadoDestinatarioGrouped.viewPessoaColaborador?.ctpsDataExpedicao,
							ctpsUf: recadoDestinatarioGrouped.viewPessoaColaborador?.ctpsUf,
							observacao: recadoDestinatarioGrouped.viewPessoaColaborador?.observacao,
							logradouro: recadoDestinatarioGrouped.viewPessoaColaborador?.logradouro,
							numero: recadoDestinatarioGrouped.viewPessoaColaborador?.numero,
							complemento: recadoDestinatarioGrouped.viewPessoaColaborador?.complemento,
							bairro: recadoDestinatarioGrouped.viewPessoaColaborador?.bairro,
							cidade: recadoDestinatarioGrouped.viewPessoaColaborador?.cidade,
							cep: recadoDestinatarioGrouped.viewPessoaColaborador?.cep,
							municipioIbge: recadoDestinatarioGrouped.viewPessoaColaborador?.municipioIbge,
							uf: recadoDestinatarioGrouped.viewPessoaColaborador?.uf,
							idPessoa: recadoDestinatarioGrouped.viewPessoaColaborador?.idPessoa,
							idCargo: recadoDestinatarioGrouped.viewPessoaColaborador?.idCargo,
							idSetor: recadoDestinatarioGrouped.viewPessoaColaborador?.idSetor,
						),
						idRecadoRemetente: recadoDestinatarioGrouped.recadoDestinatario?.idRecadoRemetente,
					)
				);
			}
			return recadoDestinatarioModelList;
		}
		return [];
	}


	RecadoRemetenteGrouped toDrift(RecadoRemetenteModel recadoRemetenteModel) {
		return RecadoRemetenteGrouped(
			recadoRemetente: RecadoRemetente(
				id: recadoRemetenteModel.id,
				idColaborador: recadoRemetenteModel.idColaborador,
				dataEnvio: recadoRemetenteModel.dataEnvio,
				horaEnvio: Util.removeMask(recadoRemetenteModel.horaEnvio),
				assunto: recadoRemetenteModel.assunto,
				texto: recadoRemetenteModel.texto,
			),
			recadoDestinatarioGroupedList: recadoDestinatarioModelToDrift(recadoRemetenteModel.recadoDestinatarioModelList),
		);
	}

	List<RecadoDestinatarioGrouped> recadoDestinatarioModelToDrift(List<RecadoDestinatarioModel>? recadoDestinatarioModelList) { 
		List<RecadoDestinatarioGrouped> recadoDestinatarioGroupedList = [];
		if (recadoDestinatarioModelList != null) {
			for (var recadoDestinatarioModel in recadoDestinatarioModelList) {
				recadoDestinatarioGroupedList.add(
					RecadoDestinatarioGrouped(
						recadoDestinatario: RecadoDestinatario(
							id: recadoDestinatarioModel.id,
							idColaborador: recadoDestinatarioModel.idColaborador,
							idRecadoRemetente: recadoDestinatarioModel.idRecadoRemetente,
						),
					),
				);
			}
			return recadoDestinatarioGroupedList;
		}
		return [];
	}

		
}
