import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class ViewPessoaVendedorDriftProvider extends ProviderBase {

	Future<List<ViewPessoaVendedorModel>?> getList({Filter? filter}) async {
		List<ViewPessoaVendedorGrouped> viewPessoaVendedorDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				viewPessoaVendedorDriftList = await Session.database.viewPessoaVendedorDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				viewPessoaVendedorDriftList = await Session.database.viewPessoaVendedorDao.getGroupedList(); 
			}
			if (viewPessoaVendedorDriftList.isNotEmpty) {
				return toListModel(viewPessoaVendedorDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ViewPessoaVendedorModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.viewPessoaVendedorDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaVendedorModel?>? insert(ViewPessoaVendedorModel viewPessoaVendedorModel) async {
		try {
			final lastPk = await Session.database.viewPessoaVendedorDao.insertObject(toDrift(viewPessoaVendedorModel));
			viewPessoaVendedorModel.id = lastPk;
			return viewPessoaVendedorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaVendedorModel?>? update(ViewPessoaVendedorModel viewPessoaVendedorModel) async {
		try {
			await Session.database.viewPessoaVendedorDao.updateObject(toDrift(viewPessoaVendedorModel));
			return viewPessoaVendedorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.viewPessoaVendedorDao.deleteObject(toDrift(ViewPessoaVendedorModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ViewPessoaVendedorModel> toListModel(List<ViewPessoaVendedorGrouped> viewPessoaVendedorDriftList) {
		List<ViewPessoaVendedorModel> listModel = [];
		for (var viewPessoaVendedorDrift in viewPessoaVendedorDriftList) {
			listModel.add(toModel(viewPessoaVendedorDrift)!);
		}
		return listModel;
	}	

	ViewPessoaVendedorModel? toModel(ViewPessoaVendedorGrouped? viewPessoaVendedorDrift) {
		if (viewPessoaVendedorDrift != null) {
			return ViewPessoaVendedorModel(
				id: viewPessoaVendedorDrift.viewPessoaVendedor?.id,
				nome: viewPessoaVendedorDrift.viewPessoaVendedor?.nome,
				tipo: ViewPessoaVendedorDomain.getTipo(viewPessoaVendedorDrift.viewPessoaVendedor?.tipo),
				email: viewPessoaVendedorDrift.viewPessoaVendedor?.email,
				site: viewPessoaVendedorDrift.viewPessoaVendedor?.site,
				cpfCnpj: viewPessoaVendedorDrift.viewPessoaVendedor?.cpfCnpj,
				rgIe: viewPessoaVendedorDrift.viewPessoaVendedor?.rgIe,
				matricula: viewPessoaVendedorDrift.viewPessoaVendedor?.matricula,
				dataCadastro: viewPessoaVendedorDrift.viewPessoaVendedor?.dataCadastro,
				dataAdmissao: viewPessoaVendedorDrift.viewPessoaVendedor?.dataAdmissao,
				dataDemissao: viewPessoaVendedorDrift.viewPessoaVendedor?.dataDemissao,
				ctpsNumero: viewPessoaVendedorDrift.viewPessoaVendedor?.ctpsNumero,
				ctpsSerie: viewPessoaVendedorDrift.viewPessoaVendedor?.ctpsSerie,
				ctpsDataExpedicao: viewPessoaVendedorDrift.viewPessoaVendedor?.ctpsDataExpedicao,
				ctpsUf: ViewPessoaVendedorDomain.getCtpsUf(viewPessoaVendedorDrift.viewPessoaVendedor?.ctpsUf),
				observacao: viewPessoaVendedorDrift.viewPessoaVendedor?.observacao,
				logradouro: viewPessoaVendedorDrift.viewPessoaVendedor?.logradouro,
				numero: viewPessoaVendedorDrift.viewPessoaVendedor?.numero,
				complemento: viewPessoaVendedorDrift.viewPessoaVendedor?.complemento,
				bairro: viewPessoaVendedorDrift.viewPessoaVendedor?.bairro,
				cidade: viewPessoaVendedorDrift.viewPessoaVendedor?.cidade,
				cep: viewPessoaVendedorDrift.viewPessoaVendedor?.cep,
				municipioIbge: viewPessoaVendedorDrift.viewPessoaVendedor?.municipioIbge,
				uf: ViewPessoaVendedorDomain.getUf(viewPessoaVendedorDrift.viewPessoaVendedor?.uf),
				idPessoa: viewPessoaVendedorDrift.viewPessoaVendedor?.idPessoa,
				idCargo: viewPessoaVendedorDrift.viewPessoaVendedor?.idCargo,
				idSetor: viewPessoaVendedorDrift.viewPessoaVendedor?.idSetor,
				comissao: viewPessoaVendedorDrift.viewPessoaVendedor?.comissao,
				metaVenda: viewPessoaVendedorDrift.viewPessoaVendedor?.metaVenda,
			);
		} else {
			return null;
		}
	}


	ViewPessoaVendedorGrouped toDrift(ViewPessoaVendedorModel viewPessoaVendedorModel) {
		return ViewPessoaVendedorGrouped(
			viewPessoaVendedor: ViewPessoaVendedor(
				id: viewPessoaVendedorModel.id,
				nome: viewPessoaVendedorModel.nome,
				tipo: ViewPessoaVendedorDomain.setTipo(viewPessoaVendedorModel.tipo),
				email: viewPessoaVendedorModel.email,
				site: viewPessoaVendedorModel.site,
				cpfCnpj: Util.removeMask(viewPessoaVendedorModel.cpfCnpj),
				rgIe: viewPessoaVendedorModel.rgIe,
				matricula: viewPessoaVendedorModel.matricula,
				dataCadastro: viewPessoaVendedorModel.dataCadastro,
				dataAdmissao: viewPessoaVendedorModel.dataAdmissao,
				dataDemissao: viewPessoaVendedorModel.dataDemissao,
				ctpsNumero: viewPessoaVendedorModel.ctpsNumero,
				ctpsSerie: viewPessoaVendedorModel.ctpsSerie,
				ctpsDataExpedicao: viewPessoaVendedorModel.ctpsDataExpedicao,
				ctpsUf: ViewPessoaVendedorDomain.setCtpsUf(viewPessoaVendedorModel.ctpsUf),
				observacao: viewPessoaVendedorModel.observacao,
				logradouro: viewPessoaVendedorModel.logradouro,
				numero: viewPessoaVendedorModel.numero,
				complemento: viewPessoaVendedorModel.complemento,
				bairro: viewPessoaVendedorModel.bairro,
				cidade: viewPessoaVendedorModel.cidade,
				cep: Util.removeMask(viewPessoaVendedorModel.cep),
				municipioIbge: viewPessoaVendedorModel.municipioIbge,
				uf: ViewPessoaVendedorDomain.setUf(viewPessoaVendedorModel.uf),
				idPessoa: viewPessoaVendedorModel.idPessoa,
				idCargo: viewPessoaVendedorModel.idCargo,
				idSetor: viewPessoaVendedorModel.idSetor,
				comissao: viewPessoaVendedorModel.comissao,
				metaVenda: viewPessoaVendedorModel.metaVenda,
			),
		);
	}

		
}
