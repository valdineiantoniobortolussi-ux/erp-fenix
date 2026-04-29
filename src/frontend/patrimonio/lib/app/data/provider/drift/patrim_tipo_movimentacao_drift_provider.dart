import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/data/domain/domain_imports.dart';

class PatrimTipoMovimentacaoDriftProvider extends ProviderBase {

	Future<List<PatrimTipoMovimentacaoModel>?> getList({Filter? filter}) async {
		List<PatrimTipoMovimentacaoGrouped> patrimTipoMovimentacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimTipoMovimentacaoDriftList = await Session.database.patrimTipoMovimentacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimTipoMovimentacaoDriftList = await Session.database.patrimTipoMovimentacaoDao.getGroupedList(); 
			}
			if (patrimTipoMovimentacaoDriftList.isNotEmpty) {
				return toListModel(patrimTipoMovimentacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimTipoMovimentacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimTipoMovimentacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimTipoMovimentacaoModel?>? insert(PatrimTipoMovimentacaoModel patrimTipoMovimentacaoModel) async {
		try {
			final lastPk = await Session.database.patrimTipoMovimentacaoDao.insertObject(toDrift(patrimTipoMovimentacaoModel));
			patrimTipoMovimentacaoModel.id = lastPk;
			return patrimTipoMovimentacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimTipoMovimentacaoModel?>? update(PatrimTipoMovimentacaoModel patrimTipoMovimentacaoModel) async {
		try {
			await Session.database.patrimTipoMovimentacaoDao.updateObject(toDrift(patrimTipoMovimentacaoModel));
			return patrimTipoMovimentacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimTipoMovimentacaoDao.deleteObject(toDrift(PatrimTipoMovimentacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimTipoMovimentacaoModel> toListModel(List<PatrimTipoMovimentacaoGrouped> patrimTipoMovimentacaoDriftList) {
		List<PatrimTipoMovimentacaoModel> listModel = [];
		for (var patrimTipoMovimentacaoDrift in patrimTipoMovimentacaoDriftList) {
			listModel.add(toModel(patrimTipoMovimentacaoDrift)!);
		}
		return listModel;
	}	

	PatrimTipoMovimentacaoModel? toModel(PatrimTipoMovimentacaoGrouped? patrimTipoMovimentacaoDrift) {
		if (patrimTipoMovimentacaoDrift != null) {
			return PatrimTipoMovimentacaoModel(
				id: patrimTipoMovimentacaoDrift.patrimTipoMovimentacao?.id,
				tipo: PatrimTipoMovimentacaoDomain.getTipo(patrimTipoMovimentacaoDrift.patrimTipoMovimentacao?.tipo),
				nome: patrimTipoMovimentacaoDrift.patrimTipoMovimentacao?.nome,
				descricao: patrimTipoMovimentacaoDrift.patrimTipoMovimentacao?.descricao,
			);
		} else {
			return null;
		}
	}


	PatrimTipoMovimentacaoGrouped toDrift(PatrimTipoMovimentacaoModel patrimTipoMovimentacaoModel) {
		return PatrimTipoMovimentacaoGrouped(
			patrimTipoMovimentacao: PatrimTipoMovimentacao(
				id: patrimTipoMovimentacaoModel.id,
				tipo: PatrimTipoMovimentacaoDomain.setTipo(patrimTipoMovimentacaoModel.tipo),
				nome: patrimTipoMovimentacaoModel.nome,
				descricao: patrimTipoMovimentacaoModel.descricao,
			),
		);
	}

		
}
