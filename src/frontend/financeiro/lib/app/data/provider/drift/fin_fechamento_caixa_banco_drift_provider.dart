import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinFechamentoCaixaBancoDriftProvider extends ProviderBase {

	Future<List<FinFechamentoCaixaBancoModel>?> getList({Filter? filter}) async {
		List<FinFechamentoCaixaBancoGrouped> finFechamentoCaixaBancoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finFechamentoCaixaBancoDriftList = await Session.database.finFechamentoCaixaBancoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finFechamentoCaixaBancoDriftList = await Session.database.finFechamentoCaixaBancoDao.getGroupedList(); 
			}
			if (finFechamentoCaixaBancoDriftList.isNotEmpty) {
				return toListModel(finFechamentoCaixaBancoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinFechamentoCaixaBancoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finFechamentoCaixaBancoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinFechamentoCaixaBancoModel?>? insert(FinFechamentoCaixaBancoModel finFechamentoCaixaBancoModel) async {
		try {
			final lastPk = await Session.database.finFechamentoCaixaBancoDao.insertObject(toDrift(finFechamentoCaixaBancoModel));
			finFechamentoCaixaBancoModel.id = lastPk;
			return finFechamentoCaixaBancoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinFechamentoCaixaBancoModel?>? update(FinFechamentoCaixaBancoModel finFechamentoCaixaBancoModel) async {
		try {
			await Session.database.finFechamentoCaixaBancoDao.updateObject(toDrift(finFechamentoCaixaBancoModel));
			return finFechamentoCaixaBancoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finFechamentoCaixaBancoDao.deleteObject(toDrift(FinFechamentoCaixaBancoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinFechamentoCaixaBancoModel> toListModel(List<FinFechamentoCaixaBancoGrouped> finFechamentoCaixaBancoDriftList) {
		List<FinFechamentoCaixaBancoModel> listModel = [];
		for (var finFechamentoCaixaBancoDrift in finFechamentoCaixaBancoDriftList) {
			listModel.add(toModel(finFechamentoCaixaBancoDrift)!);
		}
		return listModel;
	}	

	FinFechamentoCaixaBancoModel? toModel(FinFechamentoCaixaBancoGrouped? finFechamentoCaixaBancoDrift) {
		if (finFechamentoCaixaBancoDrift != null) {
			return FinFechamentoCaixaBancoModel(
				id: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.id,
				idBancoContaCaixa: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.idBancoContaCaixa,
				dataFechamento: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.dataFechamento,
				mesAno: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.mesAno,
				mes: FinFechamentoCaixaBancoDomain.getMes(finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.mes),
				ano: FinFechamentoCaixaBancoDomain.getAno(finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.ano),
				saldoAnterior: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.saldoAnterior,
				recebimentos: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.recebimentos,
				pagamentos: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.pagamentos,
				saldoConta: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.saldoConta,
				chequeNaoCompensado: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.chequeNaoCompensado,
				saldoDisponivel: finFechamentoCaixaBancoDrift.finFechamentoCaixaBanco?.saldoDisponivel,
				bancoContaCaixaModel: BancoContaCaixaModel(
					id: finFechamentoCaixaBancoDrift.bancoContaCaixa?.id,
					idBancoAgencia: finFechamentoCaixaBancoDrift.bancoContaCaixa?.idBancoAgencia,
					numero: finFechamentoCaixaBancoDrift.bancoContaCaixa?.numero,
					digito: finFechamentoCaixaBancoDrift.bancoContaCaixa?.digito,
					nome: finFechamentoCaixaBancoDrift.bancoContaCaixa?.nome,
					tipo: finFechamentoCaixaBancoDrift.bancoContaCaixa?.tipo,
					descricao: finFechamentoCaixaBancoDrift.bancoContaCaixa?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	FinFechamentoCaixaBancoGrouped toDrift(FinFechamentoCaixaBancoModel finFechamentoCaixaBancoModel) {
		return FinFechamentoCaixaBancoGrouped(
			finFechamentoCaixaBanco: FinFechamentoCaixaBanco(
				id: finFechamentoCaixaBancoModel.id,
				idBancoContaCaixa: finFechamentoCaixaBancoModel.idBancoContaCaixa,
				dataFechamento: finFechamentoCaixaBancoModel.dataFechamento,
				mesAno: finFechamentoCaixaBancoModel.mesAno,
				mes: FinFechamentoCaixaBancoDomain.setMes(finFechamentoCaixaBancoModel.mes),
				ano: FinFechamentoCaixaBancoDomain.setAno(finFechamentoCaixaBancoModel.ano),
				saldoAnterior: finFechamentoCaixaBancoModel.saldoAnterior,
				recebimentos: finFechamentoCaixaBancoModel.recebimentos,
				pagamentos: finFechamentoCaixaBancoModel.pagamentos,
				saldoConta: finFechamentoCaixaBancoModel.saldoConta,
				chequeNaoCompensado: finFechamentoCaixaBancoModel.chequeNaoCompensado,
				saldoDisponivel: finFechamentoCaixaBancoModel.saldoDisponivel,
			),
		);
	}

		
}
