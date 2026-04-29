import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinExtratoContaBancoDriftProvider extends ProviderBase {

	Future<List<FinExtratoContaBancoModel>?> getList({Filter? filter}) async {
		List<FinExtratoContaBancoGrouped> finExtratoContaBancoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finExtratoContaBancoDriftList = await Session.database.finExtratoContaBancoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finExtratoContaBancoDriftList = await Session.database.finExtratoContaBancoDao.getGroupedList(); 
			}
			if (finExtratoContaBancoDriftList.isNotEmpty) {
				return toListModel(finExtratoContaBancoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinExtratoContaBancoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finExtratoContaBancoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinExtratoContaBancoModel?>? insert(FinExtratoContaBancoModel finExtratoContaBancoModel) async {
		try {
			final lastPk = await Session.database.finExtratoContaBancoDao.insertObject(toDrift(finExtratoContaBancoModel));
			finExtratoContaBancoModel.id = lastPk;
			return finExtratoContaBancoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinExtratoContaBancoModel?>? update(FinExtratoContaBancoModel finExtratoContaBancoModel) async {
		try {
			await Session.database.finExtratoContaBancoDao.updateObject(toDrift(finExtratoContaBancoModel));
			return finExtratoContaBancoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finExtratoContaBancoDao.deleteObject(toDrift(FinExtratoContaBancoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinExtratoContaBancoModel> toListModel(List<FinExtratoContaBancoGrouped> finExtratoContaBancoDriftList) {
		List<FinExtratoContaBancoModel> listModel = [];
		for (var finExtratoContaBancoDrift in finExtratoContaBancoDriftList) {
			listModel.add(toModel(finExtratoContaBancoDrift)!);
		}
		return listModel;
	}	

	FinExtratoContaBancoModel? toModel(FinExtratoContaBancoGrouped? finExtratoContaBancoDrift) {
		if (finExtratoContaBancoDrift != null) {
			return FinExtratoContaBancoModel(
				id: finExtratoContaBancoDrift.finExtratoContaBanco?.id,
				idBancoContaCaixa: finExtratoContaBancoDrift.finExtratoContaBanco?.idBancoContaCaixa,
				mesAno: finExtratoContaBancoDrift.finExtratoContaBanco?.mesAno,
				mes: finExtratoContaBancoDrift.finExtratoContaBanco?.mes,
				ano: finExtratoContaBancoDrift.finExtratoContaBanco?.ano,
				dataMovimento: finExtratoContaBancoDrift.finExtratoContaBanco?.dataMovimento,
				dataBalancete: finExtratoContaBancoDrift.finExtratoContaBanco?.dataBalancete,
				historico: finExtratoContaBancoDrift.finExtratoContaBanco?.historico,
				documento: finExtratoContaBancoDrift.finExtratoContaBanco?.documento,
				valor: finExtratoContaBancoDrift.finExtratoContaBanco?.valor,
				conciliado: FinExtratoContaBancoDomain.getConciliado(finExtratoContaBancoDrift.finExtratoContaBanco?.conciliado),
				observacao: finExtratoContaBancoDrift.finExtratoContaBanco?.observacao,
				bancoContaCaixaModel: BancoContaCaixaModel(
					id: finExtratoContaBancoDrift.bancoContaCaixa?.id,
					idBancoAgencia: finExtratoContaBancoDrift.bancoContaCaixa?.idBancoAgencia,
					numero: finExtratoContaBancoDrift.bancoContaCaixa?.numero,
					digito: finExtratoContaBancoDrift.bancoContaCaixa?.digito,
					nome: finExtratoContaBancoDrift.bancoContaCaixa?.nome,
					tipo: finExtratoContaBancoDrift.bancoContaCaixa?.tipo,
					descricao: finExtratoContaBancoDrift.bancoContaCaixa?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	FinExtratoContaBancoGrouped toDrift(FinExtratoContaBancoModel finExtratoContaBancoModel) {
		return FinExtratoContaBancoGrouped(
			finExtratoContaBanco: FinExtratoContaBanco(
				id: finExtratoContaBancoModel.id,
				idBancoContaCaixa: finExtratoContaBancoModel.idBancoContaCaixa,
				mesAno: finExtratoContaBancoModel.mesAno,
				mes: finExtratoContaBancoModel.mes,
				ano: finExtratoContaBancoModel.ano,
				dataMovimento: finExtratoContaBancoModel.dataMovimento,
				dataBalancete: finExtratoContaBancoModel.dataBalancete,
				historico: finExtratoContaBancoModel.historico,
				documento: finExtratoContaBancoModel.documento,
				valor: finExtratoContaBancoModel.valor,
				conciliado: FinExtratoContaBancoDomain.setConciliado(finExtratoContaBancoModel.conciliado),
				observacao: finExtratoContaBancoModel.observacao,
			),
		);
	}

		
}
