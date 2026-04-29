import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoBancoHorasDriftProvider extends ProviderBase {

	Future<List<PontoBancoHorasModel>?> getList({Filter? filter}) async {
		List<PontoBancoHorasGrouped> pontoBancoHorasDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoBancoHorasDriftList = await Session.database.pontoBancoHorasDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoBancoHorasDriftList = await Session.database.pontoBancoHorasDao.getGroupedList(); 
			}
			if (pontoBancoHorasDriftList.isNotEmpty) {
				return toListModel(pontoBancoHorasDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoBancoHorasModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoBancoHorasDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoBancoHorasModel?>? insert(PontoBancoHorasModel pontoBancoHorasModel) async {
		try {
			final lastPk = await Session.database.pontoBancoHorasDao.insertObject(toDrift(pontoBancoHorasModel));
			pontoBancoHorasModel.id = lastPk;
			return pontoBancoHorasModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoBancoHorasModel?>? update(PontoBancoHorasModel pontoBancoHorasModel) async {
		try {
			await Session.database.pontoBancoHorasDao.updateObject(toDrift(pontoBancoHorasModel));
			return pontoBancoHorasModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoBancoHorasDao.deleteObject(toDrift(PontoBancoHorasModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoBancoHorasModel> toListModel(List<PontoBancoHorasGrouped> pontoBancoHorasDriftList) {
		List<PontoBancoHorasModel> listModel = [];
		for (var pontoBancoHorasDrift in pontoBancoHorasDriftList) {
			listModel.add(toModel(pontoBancoHorasDrift)!);
		}
		return listModel;
	}	

	PontoBancoHorasModel? toModel(PontoBancoHorasGrouped? pontoBancoHorasDrift) {
		if (pontoBancoHorasDrift != null) {
			return PontoBancoHorasModel(
				id: pontoBancoHorasDrift.pontoBancoHoras?.id,
				idColaborador: pontoBancoHorasDrift.pontoBancoHoras?.idColaborador,
				dataTrabalho: pontoBancoHorasDrift.pontoBancoHoras?.dataTrabalho,
				quantidade: pontoBancoHorasDrift.pontoBancoHoras?.quantidade,
				situacao: PontoBancoHorasDomain.getSituacao(pontoBancoHorasDrift.pontoBancoHoras?.situacao),
				pontoBancoHorasUtilizacaoModelList: pontoBancoHorasUtilizacaoDriftToModel(pontoBancoHorasDrift.pontoBancoHorasUtilizacaoGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: pontoBancoHorasDrift.viewPessoaColaborador?.id,
					nome: pontoBancoHorasDrift.viewPessoaColaborador?.nome,
					tipo: pontoBancoHorasDrift.viewPessoaColaborador?.tipo,
					email: pontoBancoHorasDrift.viewPessoaColaborador?.email,
					site: pontoBancoHorasDrift.viewPessoaColaborador?.site,
					cpfCnpj: pontoBancoHorasDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: pontoBancoHorasDrift.viewPessoaColaborador?.rgIe,
					matricula: pontoBancoHorasDrift.viewPessoaColaborador?.matricula,
					dataCadastro: pontoBancoHorasDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: pontoBancoHorasDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: pontoBancoHorasDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: pontoBancoHorasDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: pontoBancoHorasDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: pontoBancoHorasDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: pontoBancoHorasDrift.viewPessoaColaborador?.ctpsUf,
					observacao: pontoBancoHorasDrift.viewPessoaColaborador?.observacao,
					logradouro: pontoBancoHorasDrift.viewPessoaColaborador?.logradouro,
					numero: pontoBancoHorasDrift.viewPessoaColaborador?.numero,
					complemento: pontoBancoHorasDrift.viewPessoaColaborador?.complemento,
					bairro: pontoBancoHorasDrift.viewPessoaColaborador?.bairro,
					cidade: pontoBancoHorasDrift.viewPessoaColaborador?.cidade,
					cep: pontoBancoHorasDrift.viewPessoaColaborador?.cep,
					municipioIbge: pontoBancoHorasDrift.viewPessoaColaborador?.municipioIbge,
					uf: pontoBancoHorasDrift.viewPessoaColaborador?.uf,
					idPessoa: pontoBancoHorasDrift.viewPessoaColaborador?.idPessoa,
					idCargo: pontoBancoHorasDrift.viewPessoaColaborador?.idCargo,
					idSetor: pontoBancoHorasDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<PontoBancoHorasUtilizacaoModel> pontoBancoHorasUtilizacaoDriftToModel(List<PontoBancoHorasUtilizacaoGrouped>? pontoBancoHorasUtilizacaoDriftList) { 
		List<PontoBancoHorasUtilizacaoModel> pontoBancoHorasUtilizacaoModelList = [];
		if (pontoBancoHorasUtilizacaoDriftList != null) {
			for (var pontoBancoHorasUtilizacaoGrouped in pontoBancoHorasUtilizacaoDriftList) {
				pontoBancoHorasUtilizacaoModelList.add(
					PontoBancoHorasUtilizacaoModel(
						id: pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao?.id,
						idPontoBancoHoras: pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao?.idPontoBancoHoras,
						dataUtilizacao: pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao?.dataUtilizacao,
						quantidadeUtilizada: pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao?.quantidadeUtilizada,
						observacao: pontoBancoHorasUtilizacaoGrouped.pontoBancoHorasUtilizacao?.observacao,
					)
				);
			}
			return pontoBancoHorasUtilizacaoModelList;
		}
		return [];
	}


	PontoBancoHorasGrouped toDrift(PontoBancoHorasModel pontoBancoHorasModel) {
		return PontoBancoHorasGrouped(
			pontoBancoHoras: PontoBancoHoras(
				id: pontoBancoHorasModel.id,
				idColaborador: pontoBancoHorasModel.idColaborador,
				dataTrabalho: pontoBancoHorasModel.dataTrabalho,
				quantidade: pontoBancoHorasModel.quantidade,
				situacao: PontoBancoHorasDomain.setSituacao(pontoBancoHorasModel.situacao),
			),
			pontoBancoHorasUtilizacaoGroupedList: pontoBancoHorasUtilizacaoModelToDrift(pontoBancoHorasModel.pontoBancoHorasUtilizacaoModelList),
		);
	}

	List<PontoBancoHorasUtilizacaoGrouped> pontoBancoHorasUtilizacaoModelToDrift(List<PontoBancoHorasUtilizacaoModel>? pontoBancoHorasUtilizacaoModelList) { 
		List<PontoBancoHorasUtilizacaoGrouped> pontoBancoHorasUtilizacaoGroupedList = [];
		if (pontoBancoHorasUtilizacaoModelList != null) {
			for (var pontoBancoHorasUtilizacaoModel in pontoBancoHorasUtilizacaoModelList) {
				pontoBancoHorasUtilizacaoGroupedList.add(
					PontoBancoHorasUtilizacaoGrouped(
						pontoBancoHorasUtilizacao: PontoBancoHorasUtilizacao(
							id: pontoBancoHorasUtilizacaoModel.id,
							idPontoBancoHoras: pontoBancoHorasUtilizacaoModel.idPontoBancoHoras,
							dataUtilizacao: pontoBancoHorasUtilizacaoModel.dataUtilizacao,
							quantidadeUtilizada: Util.removeMask(pontoBancoHorasUtilizacaoModel.quantidadeUtilizada),
							observacao: pontoBancoHorasUtilizacaoModel.observacao,
						),
					),
				);
			}
			return pontoBancoHorasUtilizacaoGroupedList;
		}
		return [];
	}

		
}
