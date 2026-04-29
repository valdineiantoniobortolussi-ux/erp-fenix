import 'package:ordem_servico/app/data/provider/drift/database/database_imports.dart';
import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/data/provider/provider_base.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/data/domain/domain_imports.dart';

class ViewPessoaClienteDriftProvider extends ProviderBase {

	Future<List<ViewPessoaClienteModel>?> getList({Filter? filter}) async {
		List<ViewPessoaClienteGrouped> viewPessoaClienteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				viewPessoaClienteDriftList = await Session.database.viewPessoaClienteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				viewPessoaClienteDriftList = await Session.database.viewPessoaClienteDao.getGroupedList(); 
			}
			if (viewPessoaClienteDriftList.isNotEmpty) {
				return toListModel(viewPessoaClienteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ViewPessoaClienteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.viewPessoaClienteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaClienteModel?>? insert(ViewPessoaClienteModel viewPessoaClienteModel) async {
		try {
			final lastPk = await Session.database.viewPessoaClienteDao.insertObject(toDrift(viewPessoaClienteModel));
			viewPessoaClienteModel.id = lastPk;
			return viewPessoaClienteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaClienteModel?>? update(ViewPessoaClienteModel viewPessoaClienteModel) async {
		try {
			await Session.database.viewPessoaClienteDao.updateObject(toDrift(viewPessoaClienteModel));
			return viewPessoaClienteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.viewPessoaClienteDao.deleteObject(toDrift(ViewPessoaClienteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ViewPessoaClienteModel> toListModel(List<ViewPessoaClienteGrouped> viewPessoaClienteDriftList) {
		List<ViewPessoaClienteModel> listModel = [];
		for (var viewPessoaClienteDrift in viewPessoaClienteDriftList) {
			listModel.add(toModel(viewPessoaClienteDrift)!);
		}
		return listModel;
	}	

	ViewPessoaClienteModel? toModel(ViewPessoaClienteGrouped? viewPessoaClienteDrift) {
		if (viewPessoaClienteDrift != null) {
			return ViewPessoaClienteModel(
				id: viewPessoaClienteDrift.viewPessoaCliente?.id,
				nome: viewPessoaClienteDrift.viewPessoaCliente?.nome,
				tipo: ViewPessoaClienteDomain.getTipo(viewPessoaClienteDrift.viewPessoaCliente?.tipo),
				email: viewPessoaClienteDrift.viewPessoaCliente?.email,
				site: viewPessoaClienteDrift.viewPessoaCliente?.site,
				cpfCnpj: viewPessoaClienteDrift.viewPessoaCliente?.cpfCnpj,
				rgIe: viewPessoaClienteDrift.viewPessoaCliente?.rgIe,
				desde: viewPessoaClienteDrift.viewPessoaCliente?.desde,
				taxaDesconto: viewPessoaClienteDrift.viewPessoaCliente?.taxaDesconto,
				limiteCredito: viewPessoaClienteDrift.viewPessoaCliente?.limiteCredito,
				dataCadastro: viewPessoaClienteDrift.viewPessoaCliente?.dataCadastro,
				observacao: viewPessoaClienteDrift.viewPessoaCliente?.observacao,
				idPessoa: viewPessoaClienteDrift.viewPessoaCliente?.idPessoa,
			);
		} else {
			return null;
		}
	}


	ViewPessoaClienteGrouped toDrift(ViewPessoaClienteModel viewPessoaClienteModel) {
		return ViewPessoaClienteGrouped(
			viewPessoaCliente: ViewPessoaCliente(
				id: viewPessoaClienteModel.id,
				nome: viewPessoaClienteModel.nome,
				tipo: ViewPessoaClienteDomain.setTipo(viewPessoaClienteModel.tipo),
				email: viewPessoaClienteModel.email,
				site: viewPessoaClienteModel.site,
				cpfCnpj: Util.removeMask(viewPessoaClienteModel.cpfCnpj),
				rgIe: viewPessoaClienteModel.rgIe,
				desde: viewPessoaClienteModel.desde,
				taxaDesconto: viewPessoaClienteModel.taxaDesconto,
				limiteCredito: viewPessoaClienteModel.limiteCredito,
				dataCadastro: viewPessoaClienteModel.dataCadastro,
				observacao: viewPessoaClienteModel.observacao,
				idPessoa: viewPessoaClienteModel.idPessoa,
			),
		);
	}

		
}
