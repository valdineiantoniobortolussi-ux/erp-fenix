import 'package:ged/app/data/provider/drift/database/database_imports.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/provider/provider_base.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:ged/app/data/domain/domain_imports.dart';

class ViewPessoaTransportadoraDriftProvider extends ProviderBase {

	Future<List<ViewPessoaTransportadoraModel>?> getList({Filter? filter}) async {
		List<ViewPessoaTransportadoraGrouped> viewPessoaTransportadoraDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				viewPessoaTransportadoraDriftList = await Session.database.viewPessoaTransportadoraDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				viewPessoaTransportadoraDriftList = await Session.database.viewPessoaTransportadoraDao.getGroupedList(); 
			}
			if (viewPessoaTransportadoraDriftList.isNotEmpty) {
				return toListModel(viewPessoaTransportadoraDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ViewPessoaTransportadoraModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.viewPessoaTransportadoraDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaTransportadoraModel?>? insert(ViewPessoaTransportadoraModel viewPessoaTransportadoraModel) async {
		try {
			final lastPk = await Session.database.viewPessoaTransportadoraDao.insertObject(toDrift(viewPessoaTransportadoraModel));
			viewPessoaTransportadoraModel.id = lastPk;
			return viewPessoaTransportadoraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ViewPessoaTransportadoraModel?>? update(ViewPessoaTransportadoraModel viewPessoaTransportadoraModel) async {
		try {
			await Session.database.viewPessoaTransportadoraDao.updateObject(toDrift(viewPessoaTransportadoraModel));
			return viewPessoaTransportadoraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.viewPessoaTransportadoraDao.deleteObject(toDrift(ViewPessoaTransportadoraModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ViewPessoaTransportadoraModel> toListModel(List<ViewPessoaTransportadoraGrouped> viewPessoaTransportadoraDriftList) {
		List<ViewPessoaTransportadoraModel> listModel = [];
		for (var viewPessoaTransportadoraDrift in viewPessoaTransportadoraDriftList) {
			listModel.add(toModel(viewPessoaTransportadoraDrift)!);
		}
		return listModel;
	}	

	ViewPessoaTransportadoraModel? toModel(ViewPessoaTransportadoraGrouped? viewPessoaTransportadoraDrift) {
		if (viewPessoaTransportadoraDrift != null) {
			return ViewPessoaTransportadoraModel(
				id: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.id,
				nome: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.nome,
				tipo: ViewPessoaTransportadoraDomain.getTipo(viewPessoaTransportadoraDrift.viewPessoaTransportadora?.tipo),
				email: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.email,
				site: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.site,
				cpfCnpj: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.cpfCnpj,
				rgIe: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.rgIe,
				dataCadastro: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.dataCadastro,
				observacao: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.observacao,
				idPessoa: viewPessoaTransportadoraDrift.viewPessoaTransportadora?.idPessoa,
			);
		} else {
			return null;
		}
	}


	ViewPessoaTransportadoraGrouped toDrift(ViewPessoaTransportadoraModel viewPessoaTransportadoraModel) {
		return ViewPessoaTransportadoraGrouped(
			viewPessoaTransportadora: ViewPessoaTransportadora(
				id: viewPessoaTransportadoraModel.id,
				nome: viewPessoaTransportadoraModel.nome,
				tipo: ViewPessoaTransportadoraDomain.setTipo(viewPessoaTransportadoraModel.tipo),
				email: viewPessoaTransportadoraModel.email,
				site: viewPessoaTransportadoraModel.site,
				cpfCnpj: Util.removeMask(viewPessoaTransportadoraModel.cpfCnpj),
				rgIe: viewPessoaTransportadoraModel.rgIe,
				dataCadastro: viewPessoaTransportadoraModel.dataCadastro,
				observacao: viewPessoaTransportadoraModel.observacao,
				idPessoa: viewPessoaTransportadoraModel.idPessoa,
			),
		);
	}

		
}
