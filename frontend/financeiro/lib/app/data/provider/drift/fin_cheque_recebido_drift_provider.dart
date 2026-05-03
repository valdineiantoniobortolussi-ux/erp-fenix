import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinChequeRecebidoDriftProvider extends ProviderBase {

	Future<List<FinChequeRecebidoModel>?> getList({Filter? filter}) async {
		List<FinChequeRecebidoGrouped> finChequeRecebidoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finChequeRecebidoDriftList = await Session.database.finChequeRecebidoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finChequeRecebidoDriftList = await Session.database.finChequeRecebidoDao.getGroupedList(); 
			}
			if (finChequeRecebidoDriftList.isNotEmpty) {
				return toListModel(finChequeRecebidoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinChequeRecebidoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finChequeRecebidoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinChequeRecebidoModel?>? insert(FinChequeRecebidoModel finChequeRecebidoModel) async {
		try {
			final lastPk = await Session.database.finChequeRecebidoDao.insertObject(toDrift(finChequeRecebidoModel));
			finChequeRecebidoModel.id = lastPk;
			return finChequeRecebidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinChequeRecebidoModel?>? update(FinChequeRecebidoModel finChequeRecebidoModel) async {
		try {
			await Session.database.finChequeRecebidoDao.updateObject(toDrift(finChequeRecebidoModel));
			return finChequeRecebidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finChequeRecebidoDao.deleteObject(toDrift(FinChequeRecebidoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinChequeRecebidoModel> toListModel(List<FinChequeRecebidoGrouped> finChequeRecebidoDriftList) {
		List<FinChequeRecebidoModel> listModel = [];
		for (var finChequeRecebidoDrift in finChequeRecebidoDriftList) {
			listModel.add(toModel(finChequeRecebidoDrift)!);
		}
		return listModel;
	}	

	FinChequeRecebidoModel? toModel(FinChequeRecebidoGrouped? finChequeRecebidoDrift) {
		if (finChequeRecebidoDrift != null) {
			return FinChequeRecebidoModel(
				id: finChequeRecebidoDrift.finChequeRecebido?.id,
				idCliente: finChequeRecebidoDrift.finChequeRecebido?.idCliente,
				cpf: finChequeRecebidoDrift.finChequeRecebido?.cpf,
				cnpj: finChequeRecebidoDrift.finChequeRecebido?.cnpj,
				nome: finChequeRecebidoDrift.finChequeRecebido?.nome,
				codigoBanco: finChequeRecebidoDrift.finChequeRecebido?.codigoBanco,
				codigoAgencia: finChequeRecebidoDrift.finChequeRecebido?.codigoAgencia,
				conta: finChequeRecebidoDrift.finChequeRecebido?.conta,
				numero: finChequeRecebidoDrift.finChequeRecebido?.numero,
				dataEmissao: finChequeRecebidoDrift.finChequeRecebido?.dataEmissao,
				bomPara: finChequeRecebidoDrift.finChequeRecebido?.bomPara,
				dataCompensacao: finChequeRecebidoDrift.finChequeRecebido?.dataCompensacao,
				valor: finChequeRecebidoDrift.finChequeRecebido?.valor,
				custodiaData: finChequeRecebidoDrift.finChequeRecebido?.custodiaData,
				custodiaTarifa: finChequeRecebidoDrift.finChequeRecebido?.custodiaTarifa,
				custodiaComissao: finChequeRecebidoDrift.finChequeRecebido?.custodiaComissao,
				descontoData: finChequeRecebidoDrift.finChequeRecebido?.descontoData,
				descontoTarifa: finChequeRecebidoDrift.finChequeRecebido?.descontoTarifa,
				descontoComissao: finChequeRecebidoDrift.finChequeRecebido?.descontoComissao,
				valorRecebido: finChequeRecebidoDrift.finChequeRecebido?.valorRecebido,
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: finChequeRecebidoDrift.viewPessoaCliente?.id,
					nome: finChequeRecebidoDrift.viewPessoaCliente?.nome,
					tipo: finChequeRecebidoDrift.viewPessoaCliente?.tipo,
					email: finChequeRecebidoDrift.viewPessoaCliente?.email,
					site: finChequeRecebidoDrift.viewPessoaCliente?.site,
					cpfCnpj: finChequeRecebidoDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: finChequeRecebidoDrift.viewPessoaCliente?.rgIe,
					desde: finChequeRecebidoDrift.viewPessoaCliente?.desde,
					taxaDesconto: finChequeRecebidoDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: finChequeRecebidoDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: finChequeRecebidoDrift.viewPessoaCliente?.dataCadastro,
					observacao: finChequeRecebidoDrift.viewPessoaCliente?.observacao,
					idPessoa: finChequeRecebidoDrift.viewPessoaCliente?.idPessoa,
				),
			);
		} else {
			return null;
		}
	}


	FinChequeRecebidoGrouped toDrift(FinChequeRecebidoModel finChequeRecebidoModel) {
		return FinChequeRecebidoGrouped(
			finChequeRecebido: FinChequeRecebido(
				id: finChequeRecebidoModel.id,
				idCliente: finChequeRecebidoModel.idCliente,
				cpf: Util.removeMask(finChequeRecebidoModel.cpf),
				cnpj: Util.removeMask(finChequeRecebidoModel.cnpj),
				nome: finChequeRecebidoModel.nome,
				codigoBanco: finChequeRecebidoModel.codigoBanco,
				codigoAgencia: finChequeRecebidoModel.codigoAgencia,
				conta: finChequeRecebidoModel.conta,
				numero: finChequeRecebidoModel.numero,
				dataEmissao: finChequeRecebidoModel.dataEmissao,
				bomPara: finChequeRecebidoModel.bomPara,
				dataCompensacao: finChequeRecebidoModel.dataCompensacao,
				valor: finChequeRecebidoModel.valor,
				custodiaData: finChequeRecebidoModel.custodiaData,
				custodiaTarifa: finChequeRecebidoModel.custodiaTarifa,
				custodiaComissao: finChequeRecebidoModel.custodiaComissao,
				descontoData: finChequeRecebidoModel.descontoData,
				descontoTarifa: finChequeRecebidoModel.descontoTarifa,
				descontoComissao: finChequeRecebidoModel.descontoComissao,
				valorRecebido: finChequeRecebidoModel.valorRecebido,
			),
		);
	}

		
}
