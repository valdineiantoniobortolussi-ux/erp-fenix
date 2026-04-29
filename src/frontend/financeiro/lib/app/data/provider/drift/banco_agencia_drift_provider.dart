import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class BancoAgenciaDriftProvider extends ProviderBase {

	Future<List<BancoAgenciaModel>?> getList({Filter? filter}) async {
		List<BancoAgenciaGrouped> bancoAgenciaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				bancoAgenciaDriftList = await Session.database.bancoAgenciaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				bancoAgenciaDriftList = await Session.database.bancoAgenciaDao.getGroupedList(); 
			}
			if (bancoAgenciaDriftList.isNotEmpty) {
				return toListModel(bancoAgenciaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<BancoAgenciaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.bancoAgenciaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<BancoAgenciaModel?>? insert(BancoAgenciaModel bancoAgenciaModel) async {
		try {
			final lastPk = await Session.database.bancoAgenciaDao.insertObject(toDrift(bancoAgenciaModel));
			bancoAgenciaModel.id = lastPk;
			return bancoAgenciaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<BancoAgenciaModel?>? update(BancoAgenciaModel bancoAgenciaModel) async {
		try {
			await Session.database.bancoAgenciaDao.updateObject(toDrift(bancoAgenciaModel));
			return bancoAgenciaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.bancoAgenciaDao.deleteObject(toDrift(BancoAgenciaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<BancoAgenciaModel> toListModel(List<BancoAgenciaGrouped> bancoAgenciaDriftList) {
		List<BancoAgenciaModel> listModel = [];
		for (var bancoAgenciaDrift in bancoAgenciaDriftList) {
			listModel.add(toModel(bancoAgenciaDrift)!);
		}
		return listModel;
	}	

	BancoAgenciaModel? toModel(BancoAgenciaGrouped? bancoAgenciaDrift) {
		if (bancoAgenciaDrift != null) {
			return BancoAgenciaModel(
				id: bancoAgenciaDrift.bancoAgencia?.id,
				idBanco: bancoAgenciaDrift.bancoAgencia?.idBanco,
				numero: bancoAgenciaDrift.bancoAgencia?.numero,
				digito: bancoAgenciaDrift.bancoAgencia?.digito,
				nome: bancoAgenciaDrift.bancoAgencia?.nome,
				telefone: bancoAgenciaDrift.bancoAgencia?.telefone,
				contato: bancoAgenciaDrift.bancoAgencia?.contato,
				gerente: bancoAgenciaDrift.bancoAgencia?.gerente,
				observacao: bancoAgenciaDrift.bancoAgencia?.observacao,
				bancoModel: BancoModel(
					id: bancoAgenciaDrift.banco?.id,
					codigo: bancoAgenciaDrift.banco?.codigo,
					nome: bancoAgenciaDrift.banco?.nome,
					url: bancoAgenciaDrift.banco?.url,
				),
			);
		} else {
			return null;
		}
	}


	BancoAgenciaGrouped toDrift(BancoAgenciaModel bancoAgenciaModel) {
		return BancoAgenciaGrouped(
			bancoAgencia: BancoAgencia(
				id: bancoAgenciaModel.id,
				idBanco: bancoAgenciaModel.idBanco,
				numero: bancoAgenciaModel.numero,
				digito: bancoAgenciaModel.digito,
				nome: bancoAgenciaModel.nome,
				telefone: bancoAgenciaModel.telefone,
				contato: bancoAgenciaModel.contato,
				gerente: bancoAgenciaModel.gerente,
				observacao: bancoAgenciaModel.observacao,
			),
		);
	}

		
}
