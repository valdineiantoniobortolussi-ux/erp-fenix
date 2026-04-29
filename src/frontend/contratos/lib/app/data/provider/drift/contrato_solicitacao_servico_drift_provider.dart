import 'package:contratos/app/data/provider/drift/database/database_imports.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/provider/provider_base.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:contratos/app/data/domain/domain_imports.dart';

class ContratoSolicitacaoServicoDriftProvider extends ProviderBase {

	Future<List<ContratoSolicitacaoServicoModel>?> getList({Filter? filter}) async {
		List<ContratoSolicitacaoServicoGrouped> contratoSolicitacaoServicoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contratoSolicitacaoServicoDriftList = await Session.database.contratoSolicitacaoServicoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contratoSolicitacaoServicoDriftList = await Session.database.contratoSolicitacaoServicoDao.getGroupedList(); 
			}
			if (contratoSolicitacaoServicoDriftList.isNotEmpty) {
				return toListModel(contratoSolicitacaoServicoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContratoSolicitacaoServicoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contratoSolicitacaoServicoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoSolicitacaoServicoModel?>? insert(ContratoSolicitacaoServicoModel contratoSolicitacaoServicoModel) async {
		try {
			final lastPk = await Session.database.contratoSolicitacaoServicoDao.insertObject(toDrift(contratoSolicitacaoServicoModel));
			contratoSolicitacaoServicoModel.id = lastPk;
			return contratoSolicitacaoServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoSolicitacaoServicoModel?>? update(ContratoSolicitacaoServicoModel contratoSolicitacaoServicoModel) async {
		try {
			await Session.database.contratoSolicitacaoServicoDao.updateObject(toDrift(contratoSolicitacaoServicoModel));
			return contratoSolicitacaoServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contratoSolicitacaoServicoDao.deleteObject(toDrift(ContratoSolicitacaoServicoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContratoSolicitacaoServicoModel> toListModel(List<ContratoSolicitacaoServicoGrouped> contratoSolicitacaoServicoDriftList) {
		List<ContratoSolicitacaoServicoModel> listModel = [];
		for (var contratoSolicitacaoServicoDrift in contratoSolicitacaoServicoDriftList) {
			listModel.add(toModel(contratoSolicitacaoServicoDrift)!);
		}
		return listModel;
	}	

	ContratoSolicitacaoServicoModel? toModel(ContratoSolicitacaoServicoGrouped? contratoSolicitacaoServicoDrift) {
		if (contratoSolicitacaoServicoDrift != null) {
			return ContratoSolicitacaoServicoModel(
				id: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.id,
				idContratoTipoServico: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.idContratoTipoServico,
				idSetor: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.idSetor,
				idColaborador: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.idColaborador,
				idCliente: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.idCliente,
				idFornecedor: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.idFornecedor,
				dataSolicitacao: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.dataSolicitacao,
				dataDesejadaInicio: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.dataDesejadaInicio,
				urgente: ContratoSolicitacaoServicoDomain.getUrgente(contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.urgente),
				statusSolicitacao: ContratoSolicitacaoServicoDomain.getStatusSolicitacao(contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.statusSolicitacao),
				descricao: contratoSolicitacaoServicoDrift.contratoSolicitacaoServico?.descricao,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.id,
					nome: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.nome,
					tipo: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.tipo,
					email: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.email,
					site: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.site,
					cpfCnpj: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.rgIe,
					matricula: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.observacao,
					logradouro: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.logradouro,
					numero: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.numero,
					complemento: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.complemento,
					bairro: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.bairro,
					cidade: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.cidade,
					cep: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.cep,
					municipioIbge: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.municipioIbge,
					uf: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.uf,
					idPessoa: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.idCargo,
					idSetor: contratoSolicitacaoServicoDrift.viewPessoaColaborador?.idSetor,
				),
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: contratoSolicitacaoServicoDrift.viewPessoaCliente?.id,
					nome: contratoSolicitacaoServicoDrift.viewPessoaCliente?.nome,
					tipo: contratoSolicitacaoServicoDrift.viewPessoaCliente?.tipo,
					email: contratoSolicitacaoServicoDrift.viewPessoaCliente?.email,
					site: contratoSolicitacaoServicoDrift.viewPessoaCliente?.site,
					cpfCnpj: contratoSolicitacaoServicoDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: contratoSolicitacaoServicoDrift.viewPessoaCliente?.rgIe,
					desde: contratoSolicitacaoServicoDrift.viewPessoaCliente?.desde,
					taxaDesconto: contratoSolicitacaoServicoDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: contratoSolicitacaoServicoDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: contratoSolicitacaoServicoDrift.viewPessoaCliente?.dataCadastro,
					observacao: contratoSolicitacaoServicoDrift.viewPessoaCliente?.observacao,
					idPessoa: contratoSolicitacaoServicoDrift.viewPessoaCliente?.idPessoa,
				),
				viewPessoaFornecedorModel: ViewPessoaFornecedorModel(
					id: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.id,
					nome: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.nome,
					tipo: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.tipo,
					email: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.email,
					site: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.site,
					cpfCnpj: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.cpfCnpj,
					rgIe: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.rgIe,
					desde: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.desde,
					dataCadastro: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.dataCadastro,
					observacao: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.observacao,
					idPessoa: contratoSolicitacaoServicoDrift.viewPessoaFornecedor?.idPessoa,
				),
				setorModel: SetorModel(
					id: contratoSolicitacaoServicoDrift.setor?.id,
					nome: contratoSolicitacaoServicoDrift.setor?.nome,
					descricao: contratoSolicitacaoServicoDrift.setor?.descricao,
				),
				contratoTipoServicoModel: ContratoTipoServicoModel(
					id: contratoSolicitacaoServicoDrift.contratoTipoServico?.id,
					nome: contratoSolicitacaoServicoDrift.contratoTipoServico?.nome,
					descricao: contratoSolicitacaoServicoDrift.contratoTipoServico?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	ContratoSolicitacaoServicoGrouped toDrift(ContratoSolicitacaoServicoModel contratoSolicitacaoServicoModel) {
		return ContratoSolicitacaoServicoGrouped(
			contratoSolicitacaoServico: ContratoSolicitacaoServico(
				id: contratoSolicitacaoServicoModel.id,
				idContratoTipoServico: contratoSolicitacaoServicoModel.idContratoTipoServico,
				idSetor: contratoSolicitacaoServicoModel.idSetor,
				idColaborador: contratoSolicitacaoServicoModel.idColaborador,
				idCliente: contratoSolicitacaoServicoModel.idCliente,
				idFornecedor: contratoSolicitacaoServicoModel.idFornecedor,
				dataSolicitacao: contratoSolicitacaoServicoModel.dataSolicitacao,
				dataDesejadaInicio: contratoSolicitacaoServicoModel.dataDesejadaInicio,
				urgente: ContratoSolicitacaoServicoDomain.setUrgente(contratoSolicitacaoServicoModel.urgente),
				statusSolicitacao: ContratoSolicitacaoServicoDomain.setStatusSolicitacao(contratoSolicitacaoServicoModel.statusSolicitacao),
				descricao: contratoSolicitacaoServicoModel.descricao,
			),
		);
	}

		
}
