import 'package:agenda/app/data/provider/drift/database/database_imports.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/provider/provider_base.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:agenda/app/data/domain/domain_imports.dart';

class AgendaCompromissoDriftProvider extends ProviderBase {

	Future<List<AgendaCompromissoModel>?> getList({Filter? filter}) async {
		List<AgendaCompromissoGrouped> agendaCompromissoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				agendaCompromissoDriftList = await Session.database.agendaCompromissoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				agendaCompromissoDriftList = await Session.database.agendaCompromissoDao.getGroupedList(); 
			}
			if (agendaCompromissoDriftList.isNotEmpty) {
				return toListModel(agendaCompromissoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<AgendaCompromissoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.agendaCompromissoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AgendaCompromissoModel?>? insert(AgendaCompromissoModel agendaCompromissoModel) async {
		try {
			final lastPk = await Session.database.agendaCompromissoDao.insertObject(toDrift(agendaCompromissoModel));
			agendaCompromissoModel.id = lastPk;
			return agendaCompromissoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AgendaCompromissoModel?>? update(AgendaCompromissoModel agendaCompromissoModel) async {
		try {
			await Session.database.agendaCompromissoDao.updateObject(toDrift(agendaCompromissoModel));
			return agendaCompromissoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.agendaCompromissoDao.deleteObject(toDrift(AgendaCompromissoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<AgendaCompromissoModel> toListModel(List<AgendaCompromissoGrouped> agendaCompromissoDriftList) {
		List<AgendaCompromissoModel> listModel = [];
		for (var agendaCompromissoDrift in agendaCompromissoDriftList) {
			listModel.add(toModel(agendaCompromissoDrift)!);
		}
		return listModel;
	}	

	AgendaCompromissoModel? toModel(AgendaCompromissoGrouped? agendaCompromissoDrift) {
		if (agendaCompromissoDrift != null) {
			return AgendaCompromissoModel(
				id: agendaCompromissoDrift.agendaCompromisso?.id,
				idAgendaCategoriaCompromisso: agendaCompromissoDrift.agendaCompromisso?.idAgendaCategoriaCompromisso,
				idColaborador: agendaCompromissoDrift.agendaCompromisso?.idColaborador,
				dataCompromisso: agendaCompromissoDrift.agendaCompromisso?.dataCompromisso,
				hora: agendaCompromissoDrift.agendaCompromisso?.hora,
				duracao: agendaCompromissoDrift.agendaCompromisso?.duracao,
				tipo: AgendaCompromissoDomain.getTipo(agendaCompromissoDrift.agendaCompromisso?.tipo),
				onde: agendaCompromissoDrift.agendaCompromisso?.onde,
				descricao: agendaCompromissoDrift.agendaCompromisso?.descricao,
				agendaNotificacaoModelList: agendaNotificacaoDriftToModel(agendaCompromissoDrift.agendaNotificacaoGroupedList),
				agendaCompromissoConvidadoModelList: agendaCompromissoConvidadoDriftToModel(agendaCompromissoDrift.agendaCompromissoConvidadoGroupedList),
				reuniaoSalaEventoModelList: reuniaoSalaEventoDriftToModel(agendaCompromissoDrift.reuniaoSalaEventoGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: agendaCompromissoDrift.viewPessoaColaborador?.id,
					nome: agendaCompromissoDrift.viewPessoaColaborador?.nome,
					tipo: agendaCompromissoDrift.viewPessoaColaborador?.tipo,
					email: agendaCompromissoDrift.viewPessoaColaborador?.email,
					site: agendaCompromissoDrift.viewPessoaColaborador?.site,
					cpfCnpj: agendaCompromissoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: agendaCompromissoDrift.viewPessoaColaborador?.rgIe,
					matricula: agendaCompromissoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: agendaCompromissoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: agendaCompromissoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: agendaCompromissoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: agendaCompromissoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: agendaCompromissoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: agendaCompromissoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: agendaCompromissoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: agendaCompromissoDrift.viewPessoaColaborador?.observacao,
					logradouro: agendaCompromissoDrift.viewPessoaColaborador?.logradouro,
					numero: agendaCompromissoDrift.viewPessoaColaborador?.numero,
					complemento: agendaCompromissoDrift.viewPessoaColaborador?.complemento,
					bairro: agendaCompromissoDrift.viewPessoaColaborador?.bairro,
					cidade: agendaCompromissoDrift.viewPessoaColaborador?.cidade,
					cep: agendaCompromissoDrift.viewPessoaColaborador?.cep,
					municipioIbge: agendaCompromissoDrift.viewPessoaColaborador?.municipioIbge,
					uf: agendaCompromissoDrift.viewPessoaColaborador?.uf,
					idPessoa: agendaCompromissoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: agendaCompromissoDrift.viewPessoaColaborador?.idCargo,
					idSetor: agendaCompromissoDrift.viewPessoaColaborador?.idSetor,
				),
				agendaCategoriaCompromissoModel: AgendaCategoriaCompromissoModel(
					id: agendaCompromissoDrift.agendaCategoriaCompromisso?.id,
					nome: agendaCompromissoDrift.agendaCategoriaCompromisso?.nome,
					cor: agendaCompromissoDrift.agendaCategoriaCompromisso?.cor,
				),
			);
		} else {
			return null;
		}
	}

	List<AgendaNotificacaoModel> agendaNotificacaoDriftToModel(List<AgendaNotificacaoGrouped>? agendaNotificacaoDriftList) { 
		List<AgendaNotificacaoModel> agendaNotificacaoModelList = [];
		if (agendaNotificacaoDriftList != null) {
			for (var agendaNotificacaoGrouped in agendaNotificacaoDriftList) {
				agendaNotificacaoModelList.add(
					AgendaNotificacaoModel(
						id: agendaNotificacaoGrouped.agendaNotificacao?.id,
						idAgendaCompromisso: agendaNotificacaoGrouped.agendaNotificacao?.idAgendaCompromisso,
						dataNotificacao: agendaNotificacaoGrouped.agendaNotificacao?.dataNotificacao,
						hora: agendaNotificacaoGrouped.agendaNotificacao?.hora,
						tipo: AgendaNotificacaoDomain.getTipo(agendaNotificacaoGrouped.agendaNotificacao?.tipo),
					)
				);
			}
			return agendaNotificacaoModelList;
		}
		return [];
	}

	List<AgendaCompromissoConvidadoModel> agendaCompromissoConvidadoDriftToModel(List<AgendaCompromissoConvidadoGrouped>? agendaCompromissoConvidadoDriftList) { 
		List<AgendaCompromissoConvidadoModel> agendaCompromissoConvidadoModelList = [];
		if (agendaCompromissoConvidadoDriftList != null) {
			for (var agendaCompromissoConvidadoGrouped in agendaCompromissoConvidadoDriftList) {
				agendaCompromissoConvidadoModelList.add(
					AgendaCompromissoConvidadoModel(
						id: agendaCompromissoConvidadoGrouped.agendaCompromissoConvidado?.id,
						idAgendaCompromisso: agendaCompromissoConvidadoGrouped.agendaCompromissoConvidado?.idAgendaCompromisso,
						idColaborador: agendaCompromissoConvidadoGrouped.agendaCompromissoConvidado?.idColaborador,
						viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
							id: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.id,
							nome: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.nome,
							tipo: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.tipo,
							email: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.email,
							site: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.site,
							cpfCnpj: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.cpfCnpj,
							rgIe: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.rgIe,
							matricula: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.matricula,
							dataCadastro: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.dataCadastro,
							dataAdmissao: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.dataAdmissao,
							dataDemissao: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.dataDemissao,
							ctpsNumero: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.ctpsNumero,
							ctpsSerie: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.ctpsSerie,
							ctpsDataExpedicao: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.ctpsDataExpedicao,
							ctpsUf: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.ctpsUf,
							observacao: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.observacao,
							logradouro: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.logradouro,
							numero: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.numero,
							complemento: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.complemento,
							bairro: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.bairro,
							cidade: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.cidade,
							cep: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.cep,
							municipioIbge: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.municipioIbge,
							uf: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.uf,
							idPessoa: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.idPessoa,
							idCargo: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.idCargo,
							idSetor: agendaCompromissoConvidadoGrouped.viewPessoaColaborador?.idSetor,
						),
					)
				);
			}
			return agendaCompromissoConvidadoModelList;
		}
		return [];
	}

	List<ReuniaoSalaEventoModel> reuniaoSalaEventoDriftToModel(List<ReuniaoSalaEventoGrouped>? reuniaoSalaEventoDriftList) { 
		List<ReuniaoSalaEventoModel> reuniaoSalaEventoModelList = [];
		if (reuniaoSalaEventoDriftList != null) {
			for (var reuniaoSalaEventoGrouped in reuniaoSalaEventoDriftList) {
				reuniaoSalaEventoModelList.add(
					ReuniaoSalaEventoModel(
						id: reuniaoSalaEventoGrouped.reuniaoSalaEvento?.id,
						idAgendaCompromisso: reuniaoSalaEventoGrouped.reuniaoSalaEvento?.idAgendaCompromisso,
						idReuniaoSala: reuniaoSalaEventoGrouped.reuniaoSalaEvento?.idReuniaoSala,
						reuniaoSalaModel: ReuniaoSalaModel(
							id: reuniaoSalaEventoGrouped.reuniaoSala?.id,
							predio: reuniaoSalaEventoGrouped.reuniaoSala?.predio,
							nome: reuniaoSalaEventoGrouped.reuniaoSala?.nome,
							andar: reuniaoSalaEventoGrouped.reuniaoSala?.andar,
							numero: reuniaoSalaEventoGrouped.reuniaoSala?.numero,
						),
						dataReserva: reuniaoSalaEventoGrouped.reuniaoSalaEvento?.dataReserva,
					)
				);
			}
			return reuniaoSalaEventoModelList;
		}
		return [];
	}


	AgendaCompromissoGrouped toDrift(AgendaCompromissoModel agendaCompromissoModel) {
		return AgendaCompromissoGrouped(
			agendaCompromisso: AgendaCompromisso(
				id: agendaCompromissoModel.id,
				idAgendaCategoriaCompromisso: agendaCompromissoModel.idAgendaCategoriaCompromisso,
				idColaborador: agendaCompromissoModel.idColaborador,
				dataCompromisso: agendaCompromissoModel.dataCompromisso,
				hora: agendaCompromissoModel.hora,
				duracao: agendaCompromissoModel.duracao,
				tipo: AgendaCompromissoDomain.setTipo(agendaCompromissoModel.tipo),
				onde: agendaCompromissoModel.onde,
				descricao: agendaCompromissoModel.descricao,
			),
			agendaNotificacaoGroupedList: agendaNotificacaoModelToDrift(agendaCompromissoModel.agendaNotificacaoModelList),
			agendaCompromissoConvidadoGroupedList: agendaCompromissoConvidadoModelToDrift(agendaCompromissoModel.agendaCompromissoConvidadoModelList),
			reuniaoSalaEventoGroupedList: reuniaoSalaEventoModelToDrift(agendaCompromissoModel.reuniaoSalaEventoModelList),
		);
	}

	List<AgendaNotificacaoGrouped> agendaNotificacaoModelToDrift(List<AgendaNotificacaoModel>? agendaNotificacaoModelList) { 
		List<AgendaNotificacaoGrouped> agendaNotificacaoGroupedList = [];
		if (agendaNotificacaoModelList != null) {
			for (var agendaNotificacaoModel in agendaNotificacaoModelList) {
				agendaNotificacaoGroupedList.add(
					AgendaNotificacaoGrouped(
						agendaNotificacao: AgendaNotificacao(
							id: agendaNotificacaoModel.id,
							idAgendaCompromisso: agendaNotificacaoModel.idAgendaCompromisso,
							dataNotificacao: agendaNotificacaoModel.dataNotificacao,
							hora: Util.removeMask(agendaNotificacaoModel.hora),
							tipo: AgendaNotificacaoDomain.setTipo(agendaNotificacaoModel.tipo),
						),
					),
				);
			}
			return agendaNotificacaoGroupedList;
		}
		return [];
	}

	List<AgendaCompromissoConvidadoGrouped> agendaCompromissoConvidadoModelToDrift(List<AgendaCompromissoConvidadoModel>? agendaCompromissoConvidadoModelList) { 
		List<AgendaCompromissoConvidadoGrouped> agendaCompromissoConvidadoGroupedList = [];
		if (agendaCompromissoConvidadoModelList != null) {
			for (var agendaCompromissoConvidadoModel in agendaCompromissoConvidadoModelList) {
				agendaCompromissoConvidadoGroupedList.add(
					AgendaCompromissoConvidadoGrouped(
						agendaCompromissoConvidado: AgendaCompromissoConvidado(
							id: agendaCompromissoConvidadoModel.id,
							idAgendaCompromisso: agendaCompromissoConvidadoModel.idAgendaCompromisso,
							idColaborador: agendaCompromissoConvidadoModel.idColaborador,
						),
					),
				);
			}
			return agendaCompromissoConvidadoGroupedList;
		}
		return [];
	}

	List<ReuniaoSalaEventoGrouped> reuniaoSalaEventoModelToDrift(List<ReuniaoSalaEventoModel>? reuniaoSalaEventoModelList) { 
		List<ReuniaoSalaEventoGrouped> reuniaoSalaEventoGroupedList = [];
		if (reuniaoSalaEventoModelList != null) {
			for (var reuniaoSalaEventoModel in reuniaoSalaEventoModelList) {
				reuniaoSalaEventoGroupedList.add(
					ReuniaoSalaEventoGrouped(
						reuniaoSalaEvento: ReuniaoSalaEvento(
							id: reuniaoSalaEventoModel.id,
							idAgendaCompromisso: reuniaoSalaEventoModel.idAgendaCompromisso,
							idReuniaoSala: reuniaoSalaEventoModel.idReuniaoSala,
							dataReserva: reuniaoSalaEventoModel.dataReserva,
						),
					),
				);
			}
			return reuniaoSalaEventoGroupedList;
		}
		return [];
	}

		
}
