import 'package:compras/app/data/provider/drift/database/database_imports.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/provider/provider_base.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:compras/app/data/domain/domain_imports.dart';

class ViewPessoaFornecedorDriftProvider extends ProviderBase {

	Future<List<ViewPessoaFornecedorModel>?> getList({Filter? filter}) async {
		List<ViewPessoaFornecedorGrouped> viewPessoaFornecedorDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				viewPessoaFornecedorDriftList = await Session.database.viewPessoaFornecedorDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				viewPessoaFornecedorDriftList = await Session.database.viewPessoaFornecedorDao.getGroupedList(); 
			}
			if (viewPessoaFornecedorDriftList.isNotEmpty) {
				return toListModel(viewPessoaFornecedorDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ViewPessoaFornecedorModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.viewPessoaFornecedorDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaFornecedorModel?>? insert(ViewPessoaFornecedorModel viewPessoaFornecedorModel) async {
		try {
			final lastPk = await Session.database.viewPessoaFornecedorDao.insertObject(toDrift(viewPessoaFornecedorModel));
			viewPessoaFornecedorModel.id = lastPk;
			return viewPessoaFornecedorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaFornecedorModel?>? update(ViewPessoaFornecedorModel viewPessoaFornecedorModel) async {
		try {
			await Session.database.viewPessoaFornecedorDao.updateObject(toDrift(viewPessoaFornecedorModel));
			return viewPessoaFornecedorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.viewPessoaFornecedorDao.deleteObject(toDrift(ViewPessoaFornecedorModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ViewPessoaFornecedorModel> toListModel(List<ViewPessoaFornecedorGrouped> viewPessoaFornecedorDriftList) {
		List<ViewPessoaFornecedorModel> listModel = [];
		for (var viewPessoaFornecedorDrift in viewPessoaFornecedorDriftList) {
			listModel.add(toModel(viewPessoaFornecedorDrift)!);
		}
		return listModel;
	}	

	ViewPessoaFornecedorModel? toModel(ViewPessoaFornecedorGrouped? viewPessoaFornecedorDrift) {
		if (viewPessoaFornecedorDrift != null) {
			return ViewPessoaFornecedorModel(
				id: viewPessoaFornecedorDrift.viewPessoaFornecedor?.id,
				nome: viewPessoaFornecedorDrift.viewPessoaFornecedor?.nome,
				tipo: ViewPessoaFornecedorDomain.getTipo(viewPessoaFornecedorDrift.viewPessoaFornecedor?.tipo),
				email: viewPessoaFornecedorDrift.viewPessoaFornecedor?.email,
				site: viewPessoaFornecedorDrift.viewPessoaFornecedor?.site,
				cpfCnpj: viewPessoaFornecedorDrift.viewPessoaFornecedor?.cpfCnpj,
				rgIe: viewPessoaFornecedorDrift.viewPessoaFornecedor?.rgIe,
				desde: viewPessoaFornecedorDrift.viewPessoaFornecedor?.desde,
				dataCadastro: viewPessoaFornecedorDrift.viewPessoaFornecedor?.dataCadastro,
				observacao: viewPessoaFornecedorDrift.viewPessoaFornecedor?.observacao,
				idPessoa: viewPessoaFornecedorDrift.viewPessoaFornecedor?.idPessoa,
			);
		} else {
			return null;
		}
	}


	ViewPessoaFornecedorGrouped toDrift(ViewPessoaFornecedorModel viewPessoaFornecedorModel) {
		return ViewPessoaFornecedorGrouped(
			viewPessoaFornecedor: ViewPessoaFornecedor(
				id: viewPessoaFornecedorModel.id,
				nome: viewPessoaFornecedorModel.nome,
				tipo: ViewPessoaFornecedorDomain.setTipo(viewPessoaFornecedorModel.tipo),
				email: viewPessoaFornecedorModel.email,
				site: viewPessoaFornecedorModel.site,
				cpfCnpj: Util.removeMask(viewPessoaFornecedorModel.cpfCnpj),
				rgIe: viewPessoaFornecedorModel.rgIe,
				desde: viewPessoaFornecedorModel.desde,
				dataCadastro: viewPessoaFornecedorModel.dataCadastro,
				observacao: viewPessoaFornecedorModel.observacao,
				idPessoa: viewPessoaFornecedorModel.idPessoa,
			),
		);
	}

		
}
