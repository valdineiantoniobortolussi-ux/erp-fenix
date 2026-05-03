import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class PessoaDriftProvider extends ProviderBase {

	Future<List<PessoaModel>?> getList({Filter? filter}) async {
		List<PessoaGrouped> pessoaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pessoaDriftList = await Session.database.pessoaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pessoaDriftList = await Session.database.pessoaDao.getGroupedList(); 
			}
			if (pessoaDriftList.isNotEmpty) {
				return toListModel(pessoaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PessoaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pessoaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PessoaModel?>? insert(PessoaModel pessoaModel) async {
		try {
			final lastPk = await Session.database.pessoaDao.insertObject(toDrift(pessoaModel));
			pessoaModel.id = lastPk;
			return pessoaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PessoaModel?>? update(PessoaModel pessoaModel) async {
		try {
			await Session.database.pessoaDao.updateObject(toDrift(pessoaModel));
			return pessoaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pessoaDao.deleteObject(toDrift(PessoaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PessoaModel> toListModel(List<PessoaGrouped> pessoaDriftList) {
		List<PessoaModel> listModel = [];
		for (var pessoaDrift in pessoaDriftList) {
			listModel.add(toModel(pessoaDrift)!);
		}
		return listModel;
	}	

	PessoaModel? toModel(PessoaGrouped? pessoaDrift) {
		if (pessoaDrift != null) {
			return PessoaModel(
				id: pessoaDrift.pessoa?.id,
				nome: pessoaDrift.pessoa?.nome,
				tipo: PessoaDomain.getTipo(pessoaDrift.pessoa?.tipo),
				site: pessoaDrift.pessoa?.site,
				email: pessoaDrift.pessoa?.email,
				ehCliente: PessoaDomain.getEhCliente(pessoaDrift.pessoa?.ehCliente),
				ehFornecedor: PessoaDomain.getEhFornecedor(pessoaDrift.pessoa?.ehFornecedor),
				ehTransportadora: PessoaDomain.getEhTransportadora(pessoaDrift.pessoa?.ehTransportadora),
				ehColaborador: PessoaDomain.getEhColaborador(pessoaDrift.pessoa?.ehColaborador),
				ehContador: PessoaDomain.getEhContador(pessoaDrift.pessoa?.ehContador),
				pessoaJuridicaModel: PessoaJuridicaModel(
					id: pessoaDrift.pessoaJuridica?.id,
					idPessoa: pessoaDrift.pessoaJuridica?.idPessoa,
					cnpj: pessoaDrift.pessoaJuridica?.cnpj,
					nomeFantasia: pessoaDrift.pessoaJuridica?.nomeFantasia,
					inscricaoEstadual: pessoaDrift.pessoaJuridica?.inscricaoEstadual,
					inscricaoMunicipal: pessoaDrift.pessoaJuridica?.inscricaoMunicipal,
					dataConstituicao: pessoaDrift.pessoaJuridica?.dataConstituicao,
					tipoRegime: PessoaJuridicaDomain.getTipoRegime(pessoaDrift.pessoaJuridica?.tipoRegime),
					crt: PessoaJuridicaDomain.getCrt(pessoaDrift.pessoaJuridica?.crt),
				),
				fornecedorModel: FornecedorModel(
					id: pessoaDrift.fornecedor?.id,
					idPessoa: pessoaDrift.fornecedor?.idPessoa,
					desde: pessoaDrift.fornecedor?.desde,
					dataCadastro: pessoaDrift.fornecedor?.dataCadastro,
					observacao: pessoaDrift.fornecedor?.observacao,
				),
				clienteModel: ClienteModel(
					id: pessoaDrift.clienteGrouped?.cliente?.id,
					idPessoa: pessoaDrift.clienteGrouped?.cliente?.idPessoa,
					idTabelaPreco: pessoaDrift.clienteGrouped?.cliente?.idTabelaPreco,
					desde: pessoaDrift.clienteGrouped?.cliente?.desde,
					dataCadastro: pessoaDrift.clienteGrouped?.cliente?.dataCadastro,
					taxaDesconto: pessoaDrift.clienteGrouped?.cliente?.taxaDesconto,
					limiteCredito: pessoaDrift.clienteGrouped?.cliente?.limiteCredito,
					observacao: pessoaDrift.clienteGrouped?.cliente?.observacao,
					tabelaPrecoModel: TabelaPrecoModel(
						id: pessoaDrift.clienteGrouped?.tabelaPreco?.id,
						nome: pessoaDrift.clienteGrouped?.tabelaPreco?.nome,
						principal: pessoaDrift.clienteGrouped?.tabelaPreco?.principal,
						coeficiente: pessoaDrift.clienteGrouped?.tabelaPreco?.coeficiente,
					),
				),
				pessoaFisicaModel: PessoaFisicaModel(
					id: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.id,
					idPessoa: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.idPessoa,
					idNivelFormacao: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.idNivelFormacao,
					idEstadoCivil: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.idEstadoCivil,
					cpf: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.cpf,
					rg: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.rg,
					orgaoRg: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.orgaoRg,
					dataEmissaoRg: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.dataEmissaoRg,
					dataNascimento: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.dataNascimento,
					sexo: PessoaFisicaDomain.getSexo(pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.sexo),
					raca: PessoaFisicaDomain.getRaca(pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.raca),
					nacionalidade: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.nacionalidade,
					naturalidade: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.naturalidade,
					nomePai: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.nomePai,
					nomeMae: pessoaDrift.pessoaFisicaGrouped?.pessoaFisica?.nomeMae,
					estadoCivilModel: EstadoCivilModel(
						id: pessoaDrift.pessoaFisicaGrouped?.estadoCivil?.id,
						nome: pessoaDrift.pessoaFisicaGrouped?.estadoCivil?.nome,
						descricao: pessoaDrift.pessoaFisicaGrouped?.estadoCivil?.descricao,
					),
					nivelFormacaoModel: NivelFormacaoModel(
						id: pessoaDrift.pessoaFisicaGrouped?.nivelFormacao?.id,
						nome: pessoaDrift.pessoaFisicaGrouped?.nivelFormacao?.nome,
						descricao: pessoaDrift.pessoaFisicaGrouped?.nivelFormacao?.descricao,
					),
				),
				transportadoraModel: TransportadoraModel(
					id: pessoaDrift.transportadora?.id,
					idPessoa: pessoaDrift.transportadora?.idPessoa,
					dataCadastro: pessoaDrift.transportadora?.dataCadastro,
					observacao: pessoaDrift.transportadora?.observacao,
				),
				contadorModel: ContadorModel(
					id: pessoaDrift.contador?.id,
					idPessoa: pessoaDrift.contador?.idPessoa,
					crcInscricao: pessoaDrift.contador?.crcInscricao,
					crcUf: ContadorDomain.getCrcUf(pessoaDrift.contador?.crcUf),
				),
				pessoaContatoModelList: pessoaContatoDriftToModel(pessoaDrift.pessoaContatoGroupedList),
				pessoaTelefoneModelList: pessoaTelefoneDriftToModel(pessoaDrift.pessoaTelefoneGroupedList),
				pessoaEnderecoModelList: pessoaEnderecoDriftToModel(pessoaDrift.pessoaEnderecoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<PessoaContatoModel> pessoaContatoDriftToModel(List<PessoaContatoGrouped>? pessoaContatoDriftList) { 
		List<PessoaContatoModel> pessoaContatoModelList = [];
		if (pessoaContatoDriftList != null) {
			for (var pessoaContatoGrouped in pessoaContatoDriftList) {
				pessoaContatoModelList.add(
					PessoaContatoModel(
						id: pessoaContatoGrouped.pessoaContato?.id,
						idPessoa: pessoaContatoGrouped.pessoaContato?.idPessoa,
						nome: pessoaContatoGrouped.pessoaContato?.nome,
						email: pessoaContatoGrouped.pessoaContato?.email,
						observacao: pessoaContatoGrouped.pessoaContato?.observacao,
					)
				);
			}
			return pessoaContatoModelList;
		}
		return [];
	}

	List<PessoaTelefoneModel> pessoaTelefoneDriftToModel(List<PessoaTelefoneGrouped>? pessoaTelefoneDriftList) { 
		List<PessoaTelefoneModel> pessoaTelefoneModelList = [];
		if (pessoaTelefoneDriftList != null) {
			for (var pessoaTelefoneGrouped in pessoaTelefoneDriftList) {
				pessoaTelefoneModelList.add(
					PessoaTelefoneModel(
						id: pessoaTelefoneGrouped.pessoaTelefone?.id,
						idPessoa: pessoaTelefoneGrouped.pessoaTelefone?.idPessoa,
						tipo: PessoaTelefoneDomain.getTipo(pessoaTelefoneGrouped.pessoaTelefone?.tipo),
						numero: pessoaTelefoneGrouped.pessoaTelefone?.numero,
					)
				);
			}
			return pessoaTelefoneModelList;
		}
		return [];
	}

	List<PessoaEnderecoModel> pessoaEnderecoDriftToModel(List<PessoaEnderecoGrouped>? pessoaEnderecoDriftList) { 
		List<PessoaEnderecoModel> pessoaEnderecoModelList = [];
		if (pessoaEnderecoDriftList != null) {
			for (var pessoaEnderecoGrouped in pessoaEnderecoDriftList) {
				pessoaEnderecoModelList.add(
					PessoaEnderecoModel(
						id: pessoaEnderecoGrouped.pessoaEndereco?.id,
						idPessoa: pessoaEnderecoGrouped.pessoaEndereco?.idPessoa,
						logradouro: pessoaEnderecoGrouped.pessoaEndereco?.logradouro,
						numero: pessoaEnderecoGrouped.pessoaEndereco?.numero,
						complemento: pessoaEnderecoGrouped.pessoaEndereco?.complemento,
						bairro: pessoaEnderecoGrouped.pessoaEndereco?.bairro,
						cidade: pessoaEnderecoGrouped.pessoaEndereco?.cidade,
						uf: PessoaEnderecoDomain.getUf(pessoaEnderecoGrouped.pessoaEndereco?.uf),
						cep: pessoaEnderecoGrouped.pessoaEndereco?.cep,
						municipioIbge: pessoaEnderecoGrouped.pessoaEndereco?.municipioIbge,
						principal: PessoaEnderecoDomain.getPrincipal(pessoaEnderecoGrouped.pessoaEndereco?.principal),
						entrega: PessoaEnderecoDomain.getEntrega(pessoaEnderecoGrouped.pessoaEndereco?.entrega),
						cobranca: PessoaEnderecoDomain.getCobranca(pessoaEnderecoGrouped.pessoaEndereco?.cobranca),
						correspondencia: PessoaEnderecoDomain.getCorrespondencia(pessoaEnderecoGrouped.pessoaEndereco?.correspondencia),
					)
				);
			}
			return pessoaEnderecoModelList;
		}
		return [];
	}


	PessoaGrouped toDrift(PessoaModel pessoaModel) {
		return PessoaGrouped(
			pessoa: Pessoa(
				id: pessoaModel.id,
				nome: pessoaModel.nome,
				tipo: PessoaDomain.setTipo(pessoaModel.tipo),
				site: pessoaModel.site,
				email: pessoaModel.email,
				ehCliente: PessoaDomain.setEhCliente(pessoaModel.ehCliente),
				ehFornecedor: PessoaDomain.setEhFornecedor(pessoaModel.ehFornecedor),
				ehTransportadora: PessoaDomain.setEhTransportadora(pessoaModel.ehTransportadora),
				ehColaborador: PessoaDomain.setEhColaborador(pessoaModel.ehColaborador),
				ehContador: PessoaDomain.setEhContador(pessoaModel.ehContador),
			),
			pessoaJuridica: PessoaJuridica(
				id: pessoaModel.pessoaJuridicaModel?.id,
				idPessoa: pessoaModel.pessoaJuridicaModel?.idPessoa,
				cnpj: Util.removeMask(pessoaModel.pessoaJuridicaModel?.cnpj),
				nomeFantasia: pessoaModel.pessoaJuridicaModel?.nomeFantasia,
				inscricaoEstadual: pessoaModel.pessoaJuridicaModel?.inscricaoEstadual,
				inscricaoMunicipal: pessoaModel.pessoaJuridicaModel?.inscricaoMunicipal,
				dataConstituicao: pessoaModel.pessoaJuridicaModel?.dataConstituicao,
				tipoRegime: PessoaJuridicaDomain.setTipoRegime(pessoaModel.pessoaJuridicaModel?.tipoRegime),
				crt: PessoaJuridicaDomain.setCrt(pessoaModel.pessoaJuridicaModel?.crt),
			),
			fornecedor: Fornecedor(
				id: pessoaModel.fornecedorModel?.id,
				idPessoa: pessoaModel.fornecedorModel?.idPessoa,
				desde: pessoaModel.fornecedorModel?.desde,
				dataCadastro: pessoaModel.fornecedorModel?.dataCadastro,
				observacao: pessoaModel.fornecedorModel?.observacao,
			),
			clienteGrouped: ClienteGrouped(
				cliente: Cliente(
					id: pessoaModel.clienteModel?.id,
					idPessoa: pessoaModel.clienteModel?.idPessoa,
					idTabelaPreco: pessoaModel.clienteModel?.idTabelaPreco,
					desde: pessoaModel.clienteModel?.desde,
					dataCadastro: pessoaModel.clienteModel?.dataCadastro,
					taxaDesconto: pessoaModel.clienteModel?.taxaDesconto,
					limiteCredito: pessoaModel.clienteModel?.limiteCredito,
					observacao: pessoaModel.clienteModel?.observacao,
				),
				tabelaPreco: TabelaPreco(
					id: pessoaModel.clienteModel?.tabelaPrecoModel?.id,
					nome: pessoaModel.clienteModel?.tabelaPrecoModel?.nome,
					principal: pessoaModel.clienteModel?.tabelaPrecoModel?.principal,
					coeficiente: pessoaModel.clienteModel?.tabelaPrecoModel?.coeficiente,
				),
			),
			pessoaFisicaGrouped: PessoaFisicaGrouped(
				pessoaFisica: PessoaFisica(
					id: pessoaModel.pessoaFisicaModel?.id,
					idPessoa: pessoaModel.pessoaFisicaModel?.idPessoa,
					idNivelFormacao: pessoaModel.pessoaFisicaModel?.idNivelFormacao,
					idEstadoCivil: pessoaModel.pessoaFisicaModel?.idEstadoCivil,
					cpf: Util.removeMask(pessoaModel.pessoaFisicaModel?.cpf),
					rg: pessoaModel.pessoaFisicaModel?.rg,
					orgaoRg: pessoaModel.pessoaFisicaModel?.orgaoRg,
					dataEmissaoRg: pessoaModel.pessoaFisicaModel?.dataEmissaoRg,
					dataNascimento: pessoaModel.pessoaFisicaModel?.dataNascimento,
					sexo: PessoaFisicaDomain.setSexo(pessoaModel.pessoaFisicaModel?.sexo),
					raca: PessoaFisicaDomain.setRaca(pessoaModel.pessoaFisicaModel?.raca),
					nacionalidade: pessoaModel.pessoaFisicaModel?.nacionalidade,
					naturalidade: pessoaModel.pessoaFisicaModel?.naturalidade,
					nomePai: pessoaModel.pessoaFisicaModel?.nomePai,
					nomeMae: pessoaModel.pessoaFisicaModel?.nomeMae,
				),
				estadoCivil: EstadoCivil(
					id: pessoaModel.pessoaFisicaModel?.estadoCivilModel?.id,
					nome: pessoaModel.pessoaFisicaModel?.estadoCivilModel?.nome,
					descricao: pessoaModel.pessoaFisicaModel?.estadoCivilModel?.descricao,
				),
				nivelFormacao: NivelFormacao(
					id: pessoaModel.pessoaFisicaModel?.nivelFormacaoModel?.id,
					nome: pessoaModel.pessoaFisicaModel?.nivelFormacaoModel?.nome,
					descricao: pessoaModel.pessoaFisicaModel?.nivelFormacaoModel?.descricao,
				),
			),
			transportadora: Transportadora(
				id: pessoaModel.transportadoraModel?.id,
				idPessoa: pessoaModel.transportadoraModel?.idPessoa,
				dataCadastro: pessoaModel.transportadoraModel?.dataCadastro,
				observacao: pessoaModel.transportadoraModel?.observacao,
			),
			contador: Contador(
				id: pessoaModel.contadorModel?.id,
				idPessoa: pessoaModel.contadorModel?.idPessoa,
				crcInscricao: pessoaModel.contadorModel?.crcInscricao,
				crcUf: ContadorDomain.setCrcUf(pessoaModel.contadorModel?.crcUf),
			),
			pessoaContatoGroupedList: pessoaContatoModelToDrift(pessoaModel.pessoaContatoModelList),
			pessoaTelefoneGroupedList: pessoaTelefoneModelToDrift(pessoaModel.pessoaTelefoneModelList),
			pessoaEnderecoGroupedList: pessoaEnderecoModelToDrift(pessoaModel.pessoaEnderecoModelList),
		);
	}

	List<PessoaContatoGrouped> pessoaContatoModelToDrift(List<PessoaContatoModel>? pessoaContatoModelList) { 
		List<PessoaContatoGrouped> pessoaContatoGroupedList = [];
		if (pessoaContatoModelList != null) {
			for (var pessoaContatoModel in pessoaContatoModelList) {
				pessoaContatoGroupedList.add(
					PessoaContatoGrouped(
						pessoaContato: PessoaContato(
							id: pessoaContatoModel.id,
							idPessoa: pessoaContatoModel.idPessoa,
							nome: pessoaContatoModel.nome,
							email: pessoaContatoModel.email,
							observacao: pessoaContatoModel.observacao,
						),
					),
				);
			}
			return pessoaContatoGroupedList;
		}
		return [];
	}

	List<PessoaTelefoneGrouped> pessoaTelefoneModelToDrift(List<PessoaTelefoneModel>? pessoaTelefoneModelList) { 
		List<PessoaTelefoneGrouped> pessoaTelefoneGroupedList = [];
		if (pessoaTelefoneModelList != null) {
			for (var pessoaTelefoneModel in pessoaTelefoneModelList) {
				pessoaTelefoneGroupedList.add(
					PessoaTelefoneGrouped(
						pessoaTelefone: PessoaTelefone(
							id: pessoaTelefoneModel.id,
							idPessoa: pessoaTelefoneModel.idPessoa,
							tipo: PessoaTelefoneDomain.setTipo(pessoaTelefoneModel.tipo),
							numero: Util.removeMask(pessoaTelefoneModel.numero),
						),
					),
				);
			}
			return pessoaTelefoneGroupedList;
		}
		return [];
	}

	List<PessoaEnderecoGrouped> pessoaEnderecoModelToDrift(List<PessoaEnderecoModel>? pessoaEnderecoModelList) { 
		List<PessoaEnderecoGrouped> pessoaEnderecoGroupedList = [];
		if (pessoaEnderecoModelList != null) {
			for (var pessoaEnderecoModel in pessoaEnderecoModelList) {
				pessoaEnderecoGroupedList.add(
					PessoaEnderecoGrouped(
						pessoaEndereco: PessoaEndereco(
							id: pessoaEnderecoModel.id,
							idPessoa: pessoaEnderecoModel.idPessoa,
							logradouro: pessoaEnderecoModel.logradouro,
							numero: pessoaEnderecoModel.numero,
							complemento: pessoaEnderecoModel.complemento,
							bairro: pessoaEnderecoModel.bairro,
							cidade: pessoaEnderecoModel.cidade,
							uf: PessoaEnderecoDomain.setUf(pessoaEnderecoModel.uf),
							cep: Util.removeMask(pessoaEnderecoModel.cep),
							municipioIbge: pessoaEnderecoModel.municipioIbge,
							principal: PessoaEnderecoDomain.setPrincipal(pessoaEnderecoModel.principal),
							entrega: PessoaEnderecoDomain.setEntrega(pessoaEnderecoModel.entrega),
							cobranca: PessoaEnderecoDomain.setCobranca(pessoaEnderecoModel.cobranca),
							correspondencia: PessoaEnderecoDomain.setCorrespondencia(pessoaEnderecoModel.correspondencia),
						),
					),
				);
			}
			return pessoaEnderecoGroupedList;
		}
		return [];
	}

		
}
