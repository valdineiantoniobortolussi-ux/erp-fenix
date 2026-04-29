import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class BancoContaCaixaDriftProvider extends ProviderBase {

	Future<List<BancoContaCaixaModel>?> getList({Filter? filter}) async {
		List<BancoContaCaixaGrouped> bancoContaCaixaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				bancoContaCaixaDriftList = await Session.database.bancoContaCaixaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				bancoContaCaixaDriftList = await Session.database.bancoContaCaixaDao.getGroupedList(); 
			}
			if (bancoContaCaixaDriftList.isNotEmpty) {
				return toListModel(bancoContaCaixaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<BancoContaCaixaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.bancoContaCaixaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<BancoContaCaixaModel?>? insert(BancoContaCaixaModel bancoContaCaixaModel) async {
		try {
			final lastPk = await Session.database.bancoContaCaixaDao.insertObject(toDrift(bancoContaCaixaModel));
			bancoContaCaixaModel.id = lastPk;
			return bancoContaCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<BancoContaCaixaModel?>? update(BancoContaCaixaModel bancoContaCaixaModel) async {
		try {
			await Session.database.bancoContaCaixaDao.updateObject(toDrift(bancoContaCaixaModel));
			return bancoContaCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.bancoContaCaixaDao.deleteObject(toDrift(BancoContaCaixaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<BancoContaCaixaModel> toListModel(List<BancoContaCaixaGrouped> bancoContaCaixaDriftList) {
		List<BancoContaCaixaModel> listModel = [];
		for (var bancoContaCaixaDrift in bancoContaCaixaDriftList) {
			listModel.add(toModel(bancoContaCaixaDrift)!);
		}
		return listModel;
	}	

	BancoContaCaixaModel? toModel(BancoContaCaixaGrouped? bancoContaCaixaDrift) {
		if (bancoContaCaixaDrift != null) {
			return BancoContaCaixaModel(
				id: bancoContaCaixaDrift.bancoContaCaixa?.id,
				idBancoAgencia: bancoContaCaixaDrift.bancoContaCaixa?.idBancoAgencia,
				numero: bancoContaCaixaDrift.bancoContaCaixa?.numero,
				digito: bancoContaCaixaDrift.bancoContaCaixa?.digito,
				nome: bancoContaCaixaDrift.bancoContaCaixa?.nome,
				tipo: BancoContaCaixaDomain.getTipo(bancoContaCaixaDrift.bancoContaCaixa?.tipo),
				descricao: bancoContaCaixaDrift.bancoContaCaixa?.descricao,
				bancoAgenciaModel: BancoAgenciaModel(
					id: bancoContaCaixaDrift.bancoAgencia?.id,
					idBanco: bancoContaCaixaDrift.bancoAgencia?.idBanco,
					numero: bancoContaCaixaDrift.bancoAgencia?.numero,
					digito: bancoContaCaixaDrift.bancoAgencia?.digito,
					nome: bancoContaCaixaDrift.bancoAgencia?.nome,
					telefone: bancoContaCaixaDrift.bancoAgencia?.telefone,
					contato: bancoContaCaixaDrift.bancoAgencia?.contato,
					gerente: bancoContaCaixaDrift.bancoAgencia?.gerente,
					observacao: bancoContaCaixaDrift.bancoAgencia?.observacao,
				),
			);
		} else {
			return null;
		}
	}


	BancoContaCaixaGrouped toDrift(BancoContaCaixaModel bancoContaCaixaModel) {
		return BancoContaCaixaGrouped(
			bancoContaCaixa: BancoContaCaixa(
				id: bancoContaCaixaModel.id,
				idBancoAgencia: bancoContaCaixaModel.idBancoAgencia,
				numero: bancoContaCaixaModel.numero,
				digito: bancoContaCaixaModel.digito,
				nome: bancoContaCaixaModel.nome,
				tipo: BancoContaCaixaDomain.setTipo(bancoContaCaixaModel.tipo),
				descricao: bancoContaCaixaModel.descricao,
			),
		);
	}

		
}
