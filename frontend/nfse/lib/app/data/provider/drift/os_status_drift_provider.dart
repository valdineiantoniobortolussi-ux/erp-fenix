import 'package:nfse/app/data/provider/drift/database/database_imports.dart';
import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/data/provider/provider_base.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';
import 'package:nfse/app/data/model/model_imports.dart';
import 'package:nfse/app/data/domain/domain_imports.dart';

class OsStatusDriftProvider extends ProviderBase {

	Future<List<OsStatusModel>?> getList({Filter? filter}) async {
		List<OsStatusGrouped> osStatusDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				osStatusDriftList = await Session.database.osStatusDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				osStatusDriftList = await Session.database.osStatusDao.getGroupedList(); 
			}
			if (osStatusDriftList.isNotEmpty) {
				return toListModel(osStatusDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OsStatusModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.osStatusDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsStatusModel?>? insert(OsStatusModel osStatusModel) async {
		try {
			final lastPk = await Session.database.osStatusDao.insertObject(toDrift(osStatusModel));
			osStatusModel.id = lastPk;
			return osStatusModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsStatusModel?>? update(OsStatusModel osStatusModel) async {
		try {
			await Session.database.osStatusDao.updateObject(toDrift(osStatusModel));
			return osStatusModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.osStatusDao.deleteObject(toDrift(OsStatusModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OsStatusModel> toListModel(List<OsStatusGrouped> osStatusDriftList) {
		List<OsStatusModel> listModel = [];
		for (var osStatusDrift in osStatusDriftList) {
			listModel.add(toModel(osStatusDrift)!);
		}
		return listModel;
	}	

	OsStatusModel? toModel(OsStatusGrouped? osStatusDrift) {
		if (osStatusDrift != null) {
			return OsStatusModel(
				id: osStatusDrift.osStatus?.id,
				codigo: OsStatusDomain.getCodigo(osStatusDrift.osStatus?.codigo),
				nome: osStatusDrift.osStatus?.nome,
				osAberturaModelList: osAberturaDriftToModel(osStatusDrift.osAberturaGroupedList),
			);
		} else {
			return null;
		}
	}

	List<OsAberturaModel> osAberturaDriftToModel(List<OsAberturaGrouped>? osAberturaDriftList) { 
		List<OsAberturaModel> osAberturaModelList = [];
		if (osAberturaDriftList != null) {
			for (var osAberturaGrouped in osAberturaDriftList) {
				osAberturaModelList.add(
					OsAberturaModel(
						id: osAberturaGrouped.osAbertura?.id,
						idOsStatus: osAberturaGrouped.osAbertura?.idOsStatus,
						idColaborador: osAberturaGrouped.osAbertura?.idColaborador,
						viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
							id: osAberturaGrouped.viewPessoaColaborador?.id,
							nome: osAberturaGrouped.viewPessoaColaborador?.nome,
							tipo: osAberturaGrouped.viewPessoaColaborador?.tipo,
							email: osAberturaGrouped.viewPessoaColaborador?.email,
							site: osAberturaGrouped.viewPessoaColaborador?.site,
							cpfCnpj: osAberturaGrouped.viewPessoaColaborador?.cpfCnpj,
							rgIe: osAberturaGrouped.viewPessoaColaborador?.rgIe,
							matricula: osAberturaGrouped.viewPessoaColaborador?.matricula,
							dataCadastro: osAberturaGrouped.viewPessoaColaborador?.dataCadastro,
							dataAdmissao: osAberturaGrouped.viewPessoaColaborador?.dataAdmissao,
							dataDemissao: osAberturaGrouped.viewPessoaColaborador?.dataDemissao,
							ctpsNumero: osAberturaGrouped.viewPessoaColaborador?.ctpsNumero,
							ctpsSerie: osAberturaGrouped.viewPessoaColaborador?.ctpsSerie,
							ctpsDataExpedicao: osAberturaGrouped.viewPessoaColaborador?.ctpsDataExpedicao,
							ctpsUf: osAberturaGrouped.viewPessoaColaborador?.ctpsUf,
							observacao: osAberturaGrouped.viewPessoaColaborador?.observacao,
							logradouro: osAberturaGrouped.viewPessoaColaborador?.logradouro,
							numero: osAberturaGrouped.viewPessoaColaborador?.numero,
							complemento: osAberturaGrouped.viewPessoaColaborador?.complemento,
							bairro: osAberturaGrouped.viewPessoaColaborador?.bairro,
							cidade: osAberturaGrouped.viewPessoaColaborador?.cidade,
							cep: osAberturaGrouped.viewPessoaColaborador?.cep,
							municipioIbge: osAberturaGrouped.viewPessoaColaborador?.municipioIbge,
							uf: osAberturaGrouped.viewPessoaColaborador?.uf,
							idPessoa: osAberturaGrouped.viewPessoaColaborador?.idPessoa,
							idCargo: osAberturaGrouped.viewPessoaColaborador?.idCargo,
							idSetor: osAberturaGrouped.viewPessoaColaborador?.idSetor,
						),
						idCliente: osAberturaGrouped.osAbertura?.idCliente,
						viewPessoaClienteModel: ViewPessoaClienteModel(
							id: osAberturaGrouped.viewPessoaCliente?.id,
							nome: osAberturaGrouped.viewPessoaCliente?.nome,
							tipo: osAberturaGrouped.viewPessoaCliente?.tipo,
							email: osAberturaGrouped.viewPessoaCliente?.email,
							site: osAberturaGrouped.viewPessoaCliente?.site,
							cpfCnpj: osAberturaGrouped.viewPessoaCliente?.cpfCnpj,
							rgIe: osAberturaGrouped.viewPessoaCliente?.rgIe,
							desde: osAberturaGrouped.viewPessoaCliente?.desde,
							taxaDesconto: osAberturaGrouped.viewPessoaCliente?.taxaDesconto,
							limiteCredito: osAberturaGrouped.viewPessoaCliente?.limiteCredito,
							dataCadastro: osAberturaGrouped.viewPessoaCliente?.dataCadastro,
							observacao: osAberturaGrouped.viewPessoaCliente?.observacao,
							idPessoa: osAberturaGrouped.viewPessoaCliente?.idPessoa,
						),
						numero: osAberturaGrouped.osAbertura?.numero,
						dataInicio: osAberturaGrouped.osAbertura?.dataInicio,
						horaInicio: osAberturaGrouped.osAbertura?.horaInicio,
						dataPrevisao: osAberturaGrouped.osAbertura?.dataPrevisao,
						horaPrevisao: osAberturaGrouped.osAbertura?.horaPrevisao,
						dataFim: osAberturaGrouped.osAbertura?.dataFim,
						horaFim: osAberturaGrouped.osAbertura?.horaFim,
						nomeContato: osAberturaGrouped.osAbertura?.nomeContato,
						foneContato: osAberturaGrouped.osAbertura?.foneContato,
						observacaoCliente: osAberturaGrouped.osAbertura?.observacaoCliente,
						observacaoAbertura: osAberturaGrouped.osAbertura?.observacaoAbertura,
					)
				);
			}
			return osAberturaModelList;
		}
		return [];
	}


	OsStatusGrouped toDrift(OsStatusModel osStatusModel) {
		return OsStatusGrouped(
			osStatus: OsStatus(
				id: osStatusModel.id,
				codigo: OsStatusDomain.setCodigo(osStatusModel.codigo),
				nome: osStatusModel.nome,
			),
			osAberturaGroupedList: osAberturaModelToDrift(osStatusModel.osAberturaModelList),
		);
	}

	List<OsAberturaGrouped> osAberturaModelToDrift(List<OsAberturaModel>? osAberturaModelList) { 
		List<OsAberturaGrouped> osAberturaGroupedList = [];
		if (osAberturaModelList != null) {
			for (var osAberturaModel in osAberturaModelList) {
				osAberturaGroupedList.add(
					OsAberturaGrouped(
						osAbertura: OsAbertura(
							id: osAberturaModel.id,
							idOsStatus: osAberturaModel.idOsStatus,
							idColaborador: osAberturaModel.idColaborador,
							idCliente: osAberturaModel.idCliente,
							numero: osAberturaModel.numero,
							dataInicio: osAberturaModel.dataInicio,
							horaInicio: osAberturaModel.horaInicio,
							dataPrevisao: osAberturaModel.dataPrevisao,
							horaPrevisao: osAberturaModel.horaPrevisao,
							dataFim: osAberturaModel.dataFim,
							horaFim: osAberturaModel.horaFim,
							nomeContato: osAberturaModel.nomeContato,
							foneContato: osAberturaModel.foneContato,
							observacaoCliente: osAberturaModel.observacaoCliente,
							observacaoAbertura: osAberturaModel.observacaoAbertura,
						),
					),
				);
			}
			return osAberturaGroupedList;
		}
		return [];
	}

		
}
