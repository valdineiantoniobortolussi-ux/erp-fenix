import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class TributOperacaoFiscalDriftProvider extends ProviderBase {

	Future<List<TributOperacaoFiscalModel>?> getList({Filter? filter}) async {
		List<TributOperacaoFiscalGrouped> tributOperacaoFiscalDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tributOperacaoFiscalDriftList = await Session.database.tributOperacaoFiscalDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tributOperacaoFiscalDriftList = await Session.database.tributOperacaoFiscalDao.getGroupedList(); 
			}
			if (tributOperacaoFiscalDriftList.isNotEmpty) {
				return toListModel(tributOperacaoFiscalDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TributOperacaoFiscalModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tributOperacaoFiscalDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributOperacaoFiscalModel?>? insert(TributOperacaoFiscalModel tributOperacaoFiscalModel) async {
		try {
			final lastPk = await Session.database.tributOperacaoFiscalDao.insertObject(toDrift(tributOperacaoFiscalModel));
			tributOperacaoFiscalModel.id = lastPk;
			return tributOperacaoFiscalModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributOperacaoFiscalModel?>? update(TributOperacaoFiscalModel tributOperacaoFiscalModel) async {
		try {
			await Session.database.tributOperacaoFiscalDao.updateObject(toDrift(tributOperacaoFiscalModel));
			return tributOperacaoFiscalModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tributOperacaoFiscalDao.deleteObject(toDrift(TributOperacaoFiscalModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TributOperacaoFiscalModel> toListModel(List<TributOperacaoFiscalGrouped> tributOperacaoFiscalDriftList) {
		List<TributOperacaoFiscalModel> listModel = [];
		for (var tributOperacaoFiscalDrift in tributOperacaoFiscalDriftList) {
			listModel.add(toModel(tributOperacaoFiscalDrift)!);
		}
		return listModel;
	}	

	TributOperacaoFiscalModel? toModel(TributOperacaoFiscalGrouped? tributOperacaoFiscalDrift) {
		if (tributOperacaoFiscalDrift != null) {
			return TributOperacaoFiscalModel(
				id: tributOperacaoFiscalDrift.tributOperacaoFiscal?.id,
				descricao: tributOperacaoFiscalDrift.tributOperacaoFiscal?.descricao,
				descricaoNaNf: tributOperacaoFiscalDrift.tributOperacaoFiscal?.descricaoNaNf,
				cfop: tributOperacaoFiscalDrift.tributOperacaoFiscal?.cfop,
				observacao: tributOperacaoFiscalDrift.tributOperacaoFiscal?.observacao,
			);
		} else {
			return null;
		}
	}


	TributOperacaoFiscalGrouped toDrift(TributOperacaoFiscalModel tributOperacaoFiscalModel) {
		return TributOperacaoFiscalGrouped(
			tributOperacaoFiscal: TributOperacaoFiscal(
				id: tributOperacaoFiscalModel.id,
				descricao: tributOperacaoFiscalModel.descricao,
				descricaoNaNf: tributOperacaoFiscalModel.descricaoNaNf,
				cfop: tributOperacaoFiscalModel.cfop,
				observacao: tributOperacaoFiscalModel.observacao,
			),
		);
	}

		
}
