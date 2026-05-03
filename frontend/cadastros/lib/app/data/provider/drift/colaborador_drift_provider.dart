import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class ColaboradorDriftProvider extends ProviderBase {

	Future<List<ColaboradorModel>?> getList({Filter? filter}) async {
		List<ColaboradorGrouped> colaboradorDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				colaboradorDriftList = await Session.database.colaboradorDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				colaboradorDriftList = await Session.database.colaboradorDao.getGroupedList(); 
			}
			if (colaboradorDriftList.isNotEmpty) {
				return toListModel(colaboradorDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ColaboradorModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.colaboradorDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ColaboradorModel?>? insert(ColaboradorModel colaboradorModel) async {
		try {
			final lastPk = await Session.database.colaboradorDao.insertObject(toDrift(colaboradorModel));
			colaboradorModel.id = lastPk;
			return colaboradorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ColaboradorModel?>? update(ColaboradorModel colaboradorModel) async {
		try {
			await Session.database.colaboradorDao.updateObject(toDrift(colaboradorModel));
			return colaboradorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.colaboradorDao.deleteObject(toDrift(ColaboradorModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ColaboradorModel> toListModel(List<ColaboradorGrouped> colaboradorDriftList) {
		List<ColaboradorModel> listModel = [];
		for (var colaboradorDrift in colaboradorDriftList) {
			listModel.add(toModel(colaboradorDrift)!);
		}
		return listModel;
	}	

	ColaboradorModel? toModel(ColaboradorGrouped? colaboradorDrift) {
		if (colaboradorDrift != null) {
			return ColaboradorModel(
				id: colaboradorDrift.colaborador?.id,
				idPessoa: colaboradorDrift.colaborador?.idPessoa,
				idCargo: colaboradorDrift.colaborador?.idCargo,
				idSetor: colaboradorDrift.colaborador?.idSetor,
				idColaboradorSituacao: colaboradorDrift.colaborador?.idColaboradorSituacao,
				idTipoAdmissao: colaboradorDrift.colaborador?.idTipoAdmissao,
				idColaboradorTipo: colaboradorDrift.colaborador?.idColaboradorTipo,
				idSindicato: colaboradorDrift.colaborador?.idSindicato,
				matricula: colaboradorDrift.colaborador?.matricula,
				dataCadastro: colaboradorDrift.colaborador?.dataCadastro,
				dataAdmissao: colaboradorDrift.colaborador?.dataAdmissao,
				dataDemissao: colaboradorDrift.colaborador?.dataDemissao,
				ctpsNumero: colaboradorDrift.colaborador?.ctpsNumero,
				ctpsSerie: colaboradorDrift.colaborador?.ctpsSerie,
				ctpsDataExpedicao: colaboradorDrift.colaborador?.ctpsDataExpedicao,
				ctpsUf: ColaboradorDomain.getCtpsUf(colaboradorDrift.colaborador?.ctpsUf),
				observacao: colaboradorDrift.colaborador?.observacao,
				vendedorModel: VendedorModel(
					id: colaboradorDrift.vendedorGrouped?.vendedor?.id,
					idColaborador: colaboradorDrift.vendedorGrouped?.vendedor?.idColaborador,
					idComissaoPerfil: colaboradorDrift.vendedorGrouped?.vendedor?.idComissaoPerfil,
					comissao: colaboradorDrift.vendedorGrouped?.vendedor?.comissao,
					metaVenda: colaboradorDrift.vendedorGrouped?.vendedor?.metaVenda,
					comissaoPerfilModel: ComissaoPerfilModel(
						id: colaboradorDrift.vendedorGrouped?.comissaoPerfil?.id,
						codigo: colaboradorDrift.vendedorGrouped?.comissaoPerfil?.codigo,
						nome: colaboradorDrift.vendedorGrouped?.comissaoPerfil?.nome,
					),
				),
				pessoaModel: PessoaModel(
					id: colaboradorDrift.pessoa?.id,
					nome: colaboradorDrift.pessoa?.nome,
					tipo: colaboradorDrift.pessoa?.tipo,
					site: colaboradorDrift.pessoa?.site,
					email: colaboradorDrift.pessoa?.email,
					ehCliente: colaboradorDrift.pessoa?.ehCliente,
					ehFornecedor: colaboradorDrift.pessoa?.ehFornecedor,
					ehTransportadora: colaboradorDrift.pessoa?.ehTransportadora,
					ehColaborador: colaboradorDrift.pessoa?.ehColaborador,
					ehContador: colaboradorDrift.pessoa?.ehContador,
				),
				colaboradorSituacaoModel: ColaboradorSituacaoModel(
					id: colaboradorDrift.colaboradorSituacao?.id,
					codigo: colaboradorDrift.colaboradorSituacao?.codigo,
					nome: colaboradorDrift.colaboradorSituacao?.nome,
					descricao: colaboradorDrift.colaboradorSituacao?.descricao,
				),
				colaboradorTipoModel: ColaboradorTipoModel(
					id: colaboradorDrift.colaboradorTipo?.id,
					nome: colaboradorDrift.colaboradorTipo?.nome,
					descricao: colaboradorDrift.colaboradorTipo?.descricao,
				),
				setorModel: SetorModel(
					id: colaboradorDrift.setor?.id,
					nome: colaboradorDrift.setor?.nome,
					descricao: colaboradorDrift.setor?.descricao,
				),
				cargoModel: CargoModel(
					id: colaboradorDrift.cargo?.id,
					nome: colaboradorDrift.cargo?.nome,
					descricao: colaboradorDrift.cargo?.descricao,
					salario: colaboradorDrift.cargo?.salario,
					cbo1994: colaboradorDrift.cargo?.cbo1994,
					cbo2002: colaboradorDrift.cargo?.cbo2002,
				),
				tipoAdmissaoModel: TipoAdmissaoModel(
					id: colaboradorDrift.tipoAdmissao?.id,
					codigo: colaboradorDrift.tipoAdmissao?.codigo,
					nome: colaboradorDrift.tipoAdmissao?.nome,
					descricao: colaboradorDrift.tipoAdmissao?.descricao,
				),
				colaboradorRelacionamentoModelList: colaboradorRelacionamentoDriftToModel(colaboradorDrift.colaboradorRelacionamentoGroupedList),
				sindicatoModel: SindicatoModel(
					id: colaboradorDrift.sindicato?.id,
					nome: colaboradorDrift.sindicato?.nome,
					codigoBanco: colaboradorDrift.sindicato?.codigoBanco,
					codigoAgencia: colaboradorDrift.sindicato?.codigoAgencia,
					contaBanco: colaboradorDrift.sindicato?.contaBanco,
					codigoCedente: colaboradorDrift.sindicato?.codigoCedente,
					logradouro: colaboradorDrift.sindicato?.logradouro,
					numero: colaboradorDrift.sindicato?.numero,
					bairro: colaboradorDrift.sindicato?.bairro,
					municipioIbge: colaboradorDrift.sindicato?.municipioIbge,
					uf: colaboradorDrift.sindicato?.uf,
					fone1: colaboradorDrift.sindicato?.fone1,
					fone2: colaboradorDrift.sindicato?.fone2,
					email: colaboradorDrift.sindicato?.email,
					tipoSindicato: colaboradorDrift.sindicato?.tipoSindicato,
					dataBase: colaboradorDrift.sindicato?.dataBase,
					pisoSalarial: colaboradorDrift.sindicato?.pisoSalarial,
					cnpj: colaboradorDrift.sindicato?.cnpj,
					classificacaoContabilConta: colaboradorDrift.sindicato?.classificacaoContabilConta,
				),
			);
		} else {
			return null;
		}
	}

	List<ColaboradorRelacionamentoModel> colaboradorRelacionamentoDriftToModel(List<ColaboradorRelacionamentoGrouped>? colaboradorRelacionamentoDriftList) { 
		List<ColaboradorRelacionamentoModel> colaboradorRelacionamentoModelList = [];
		if (colaboradorRelacionamentoDriftList != null) {
			for (var colaboradorRelacionamentoGrouped in colaboradorRelacionamentoDriftList) {
				colaboradorRelacionamentoModelList.add(
					ColaboradorRelacionamentoModel(
						id: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.id,
						idColaborador: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.idColaborador,
						idTipoRelacionamento: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.idTipoRelacionamento,
						tipoRelacionamentoModel: TipoRelacionamentoModel(
							id: colaboradorRelacionamentoGrouped.tipoRelacionamento?.id,
							codigo: colaboradorRelacionamentoGrouped.tipoRelacionamento?.codigo,
							nome: colaboradorRelacionamentoGrouped.tipoRelacionamento?.nome,
							descricao: colaboradorRelacionamentoGrouped.tipoRelacionamento?.descricao,
						),
						nome: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.nome,
						dataNascimento: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.dataNascimento,
						cpf: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.cpf,
						registroMatricula: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.registroMatricula,
						registroCartorio: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.registroCartorio,
						registroCartorioNumero: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.registroCartorioNumero,
						registroNumeroLivro: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.registroNumeroLivro,
						registroNumeroFolha: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.registroNumeroFolha,
						dataEntregaDocumento: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.dataEntregaDocumento,
						salarioFamilia: ColaboradorRelacionamentoDomain.getSalarioFamilia(colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.salarioFamilia),
						salarioFamiliaIdadeLimite: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.salarioFamiliaIdadeLimite,
						salarioFamiliaDataFim: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.salarioFamiliaDataFim,
						impostoRendaIdadeLimite: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.impostoRendaIdadeLimite,
						impostoRendaDataFim: colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.impostoRendaDataFim,
					)
				);
			}
			return colaboradorRelacionamentoModelList;
		}
		return [];
	}


	ColaboradorGrouped toDrift(ColaboradorModel colaboradorModel) {
		return ColaboradorGrouped(
			colaborador: Colaborador(
				id: colaboradorModel.id,
				idPessoa: colaboradorModel.idPessoa,
				idCargo: colaboradorModel.idCargo,
				idSetor: colaboradorModel.idSetor,
				idColaboradorSituacao: colaboradorModel.idColaboradorSituacao,
				idTipoAdmissao: colaboradorModel.idTipoAdmissao,
				idColaboradorTipo: colaboradorModel.idColaboradorTipo,
				idSindicato: colaboradorModel.idSindicato,
				matricula: colaboradorModel.matricula,
				dataCadastro: colaboradorModel.dataCadastro,
				dataAdmissao: colaboradorModel.dataAdmissao,
				dataDemissao: colaboradorModel.dataDemissao,
				ctpsNumero: colaboradorModel.ctpsNumero,
				ctpsSerie: colaboradorModel.ctpsSerie,
				ctpsDataExpedicao: colaboradorModel.ctpsDataExpedicao,
				ctpsUf: ColaboradorDomain.setCtpsUf(colaboradorModel.ctpsUf),
				observacao: colaboradorModel.observacao,
			),
			vendedorGrouped: VendedorGrouped(
				vendedor: Vendedor(
					id: colaboradorModel.vendedorModel?.id,
					idColaborador: colaboradorModel.vendedorModel?.idColaborador,
					idComissaoPerfil: colaboradorModel.vendedorModel?.idComissaoPerfil,
					comissao: colaboradorModel.vendedorModel?.comissao,
					metaVenda: colaboradorModel.vendedorModel?.metaVenda,
				),
				comissaoPerfil: ComissaoPerfil(
					id: colaboradorModel.vendedorModel?.comissaoPerfilModel?.id,
					codigo: colaboradorModel.vendedorModel?.comissaoPerfilModel?.codigo,
					nome: colaboradorModel.vendedorModel?.comissaoPerfilModel?.nome,
				),
			),
			colaboradorRelacionamentoGroupedList: colaboradorRelacionamentoModelToDrift(colaboradorModel.colaboradorRelacionamentoModelList),
		);
	}

	List<ColaboradorRelacionamentoGrouped> colaboradorRelacionamentoModelToDrift(List<ColaboradorRelacionamentoModel>? colaboradorRelacionamentoModelList) { 
		List<ColaboradorRelacionamentoGrouped> colaboradorRelacionamentoGroupedList = [];
		if (colaboradorRelacionamentoModelList != null) {
			for (var colaboradorRelacionamentoModel in colaboradorRelacionamentoModelList) {
				colaboradorRelacionamentoGroupedList.add(
					ColaboradorRelacionamentoGrouped(
						colaboradorRelacionamento: ColaboradorRelacionamento(
							id: colaboradorRelacionamentoModel.id,
							idColaborador: colaboradorRelacionamentoModel.idColaborador,
							idTipoRelacionamento: colaboradorRelacionamentoModel.idTipoRelacionamento,
							nome: colaboradorRelacionamentoModel.nome,
							dataNascimento: colaboradorRelacionamentoModel.dataNascimento,
							cpf: Util.removeMask(colaboradorRelacionamentoModel.cpf),
							registroMatricula: colaboradorRelacionamentoModel.registroMatricula,
							registroCartorio: colaboradorRelacionamentoModel.registroCartorio,
							registroCartorioNumero: colaboradorRelacionamentoModel.registroCartorioNumero,
							registroNumeroLivro: colaboradorRelacionamentoModel.registroNumeroLivro,
							registroNumeroFolha: colaboradorRelacionamentoModel.registroNumeroFolha,
							dataEntregaDocumento: colaboradorRelacionamentoModel.dataEntregaDocumento,
							salarioFamilia: ColaboradorRelacionamentoDomain.setSalarioFamilia(colaboradorRelacionamentoModel.salarioFamilia),
							salarioFamiliaIdadeLimite: colaboradorRelacionamentoModel.salarioFamiliaIdadeLimite,
							salarioFamiliaDataFim: colaboradorRelacionamentoModel.salarioFamiliaDataFim,
							impostoRendaIdadeLimite: colaboradorRelacionamentoModel.impostoRendaIdadeLimite,
							impostoRendaDataFim: colaboradorRelacionamentoModel.impostoRendaDataFim,
						),
					),
				);
			}
			return colaboradorRelacionamentoGroupedList;
		}
		return [];
	}

		
}
