import 'package:projetos/app/data/provider/drift/database/database_imports.dart';
import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/data/provider/provider_base.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';
import 'package:projetos/app/data/model/model_imports.dart';
import 'package:projetos/app/data/domain/domain_imports.dart';

class ViewPessoaColaboradorDriftProvider extends ProviderBase {

	Future<List<ViewPessoaColaboradorModel>?> getList({Filter? filter}) async {
		List<ViewPessoaColaboradorGrouped> viewPessoaColaboradorDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				viewPessoaColaboradorDriftList = await Session.database.viewPessoaColaboradorDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				viewPessoaColaboradorDriftList = await Session.database.viewPessoaColaboradorDao.getGroupedList(); 
			}
			if (viewPessoaColaboradorDriftList.isNotEmpty) {
				return toListModel(viewPessoaColaboradorDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ViewPessoaColaboradorModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.viewPessoaColaboradorDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaColaboradorModel?>? insert(ViewPessoaColaboradorModel viewPessoaColaboradorModel) async {
		try {
			final lastPk = await Session.database.viewPessoaColaboradorDao.insertObject(toDrift(viewPessoaColaboradorModel));
			viewPessoaColaboradorModel.id = lastPk;
			return viewPessoaColaboradorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaColaboradorModel?>? update(ViewPessoaColaboradorModel viewPessoaColaboradorModel) async {
		try {
			await Session.database.viewPessoaColaboradorDao.updateObject(toDrift(viewPessoaColaboradorModel));
			return viewPessoaColaboradorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.viewPessoaColaboradorDao.deleteObject(toDrift(ViewPessoaColaboradorModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ViewPessoaColaboradorModel> toListModel(List<ViewPessoaColaboradorGrouped> viewPessoaColaboradorDriftList) {
		List<ViewPessoaColaboradorModel> listModel = [];
		for (var viewPessoaColaboradorDrift in viewPessoaColaboradorDriftList) {
			listModel.add(toModel(viewPessoaColaboradorDrift)!);
		}
		return listModel;
	}	

	ViewPessoaColaboradorModel? toModel(ViewPessoaColaboradorGrouped? viewPessoaColaboradorDrift) {
		if (viewPessoaColaboradorDrift != null) {
			return ViewPessoaColaboradorModel(
				id: viewPessoaColaboradorDrift.viewPessoaColaborador?.id,
				nome: viewPessoaColaboradorDrift.viewPessoaColaborador?.nome,
				tipo: ViewPessoaColaboradorDomain.getTipo(viewPessoaColaboradorDrift.viewPessoaColaborador?.tipo),
				email: viewPessoaColaboradorDrift.viewPessoaColaborador?.email,
				site: viewPessoaColaboradorDrift.viewPessoaColaborador?.site,
				cpfCnpj: viewPessoaColaboradorDrift.viewPessoaColaborador?.cpfCnpj,
				rgIe: viewPessoaColaboradorDrift.viewPessoaColaborador?.rgIe,
				matricula: viewPessoaColaboradorDrift.viewPessoaColaborador?.matricula,
				dataCadastro: viewPessoaColaboradorDrift.viewPessoaColaborador?.dataCadastro,
				dataAdmissao: viewPessoaColaboradorDrift.viewPessoaColaborador?.dataAdmissao,
				dataDemissao: viewPessoaColaboradorDrift.viewPessoaColaborador?.dataDemissao,
				ctpsNumero: viewPessoaColaboradorDrift.viewPessoaColaborador?.ctpsNumero,
				ctpsSerie: viewPessoaColaboradorDrift.viewPessoaColaborador?.ctpsSerie,
				ctpsDataExpedicao: viewPessoaColaboradorDrift.viewPessoaColaborador?.ctpsDataExpedicao,
				ctpsUf: ViewPessoaColaboradorDomain.getCtpsUf(viewPessoaColaboradorDrift.viewPessoaColaborador?.ctpsUf),
				observacao: viewPessoaColaboradorDrift.viewPessoaColaborador?.observacao,
				logradouro: viewPessoaColaboradorDrift.viewPessoaColaborador?.logradouro,
				numero: viewPessoaColaboradorDrift.viewPessoaColaborador?.numero,
				complemento: viewPessoaColaboradorDrift.viewPessoaColaborador?.complemento,
				bairro: viewPessoaColaboradorDrift.viewPessoaColaborador?.bairro,
				cidade: viewPessoaColaboradorDrift.viewPessoaColaborador?.cidade,
				cep: viewPessoaColaboradorDrift.viewPessoaColaborador?.cep,
				municipioIbge: viewPessoaColaboradorDrift.viewPessoaColaborador?.municipioIbge,
				uf: ViewPessoaColaboradorDomain.getUf(viewPessoaColaboradorDrift.viewPessoaColaborador?.uf),
				idPessoa: viewPessoaColaboradorDrift.viewPessoaColaborador?.idPessoa,
				idCargo: viewPessoaColaboradorDrift.viewPessoaColaborador?.idCargo,
				idSetor: viewPessoaColaboradorDrift.viewPessoaColaborador?.idSetor,
			);
		} else {
			return null;
		}
	}


	ViewPessoaColaboradorGrouped toDrift(ViewPessoaColaboradorModel viewPessoaColaboradorModel) {
		return ViewPessoaColaboradorGrouped(
			viewPessoaColaborador: ViewPessoaColaborador(
				id: viewPessoaColaboradorModel.id,
				nome: viewPessoaColaboradorModel.nome,
				tipo: ViewPessoaColaboradorDomain.setTipo(viewPessoaColaboradorModel.tipo),
				email: viewPessoaColaboradorModel.email,
				site: viewPessoaColaboradorModel.site,
				cpfCnpj: Util.removeMask(viewPessoaColaboradorModel.cpfCnpj),
				rgIe: viewPessoaColaboradorModel.rgIe,
				matricula: viewPessoaColaboradorModel.matricula,
				dataCadastro: viewPessoaColaboradorModel.dataCadastro,
				dataAdmissao: viewPessoaColaboradorModel.dataAdmissao,
				dataDemissao: viewPessoaColaboradorModel.dataDemissao,
				ctpsNumero: viewPessoaColaboradorModel.ctpsNumero,
				ctpsSerie: viewPessoaColaboradorModel.ctpsSerie,
				ctpsDataExpedicao: viewPessoaColaboradorModel.ctpsDataExpedicao,
				ctpsUf: ViewPessoaColaboradorDomain.setCtpsUf(viewPessoaColaboradorModel.ctpsUf),
				observacao: viewPessoaColaboradorModel.observacao,
				logradouro: viewPessoaColaboradorModel.logradouro,
				numero: viewPessoaColaboradorModel.numero,
				complemento: viewPessoaColaboradorModel.complemento,
				bairro: viewPessoaColaboradorModel.bairro,
				cidade: viewPessoaColaboradorModel.cidade,
				cep: Util.removeMask(viewPessoaColaboradorModel.cep),
				municipioIbge: viewPessoaColaboradorModel.municipioIbge,
				uf: ViewPessoaColaboradorDomain.setUf(viewPessoaColaboradorModel.uf),
				idPessoa: viewPessoaColaboradorModel.idPessoa,
				idCargo: viewPessoaColaboradorModel.idCargo,
				idSetor: viewPessoaColaboradorModel.idSetor,
			),
		);
	}

		
}
