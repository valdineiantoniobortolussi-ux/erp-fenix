import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/provider/provider_base.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class EmpresaDriftProvider extends ProviderBase {

	Future<List<EmpresaModel>?> getList({Filter? filter}) async {
		List<EmpresaGrouped> empresaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				empresaDriftList = await Session.database.empresaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				empresaDriftList = await Session.database.empresaDao.getGroupedList(); 
			}
			if (empresaDriftList.isNotEmpty) {
				return toListModel(empresaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EmpresaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.empresaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EmpresaModel?>? insert(EmpresaModel empresaModel) async {
		try {
			final lastPk = await Session.database.empresaDao.insertObject(toDrift(empresaModel));
			empresaModel.id = lastPk;
			return empresaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EmpresaModel?>? update(EmpresaModel empresaModel) async {
		try {
			await Session.database.empresaDao.updateObject(toDrift(empresaModel));
			return empresaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.empresaDao.deleteObject(toDrift(EmpresaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EmpresaModel> toListModel(List<EmpresaGrouped> empresaDriftList) {
		List<EmpresaModel> listModel = [];
		for (var empresaDrift in empresaDriftList) {
			listModel.add(toModel(empresaDrift)!);
		}
		return listModel;
	}	

	EmpresaModel? toModel(EmpresaGrouped? empresaDrift) {
		if (empresaDrift != null) {
			return EmpresaModel(
				id: empresaDrift.empresa?.id,
				razaoSocial: empresaDrift.empresa?.razaoSocial,
				nomeFantasia: empresaDrift.empresa?.nomeFantasia,
				cnpj: empresaDrift.empresa?.cnpj,
				inscricaoEstadual: empresaDrift.empresa?.inscricaoEstadual,
				inscricaoMunicipal: empresaDrift.empresa?.inscricaoMunicipal,
				tipoRegime: EmpresaDomain.getTipoRegime(empresaDrift.empresa?.tipoRegime),
				crt: EmpresaDomain.getCrt(empresaDrift.empresa?.crt),
				email: empresaDrift.empresa?.email,
				site: empresaDrift.empresa?.site,
				contato: empresaDrift.empresa?.contato,
				dataConstituicao: empresaDrift.empresa?.dataConstituicao,
				tipo: EmpresaDomain.getTipo(empresaDrift.empresa?.tipo),
				inscricaoJuntaComercial: empresaDrift.empresa?.inscricaoJuntaComercial,
				dataInscJuntaComercial: empresaDrift.empresa?.dataInscJuntaComercial,
				codigoIbgeCidade: empresaDrift.empresa?.codigoIbgeCidade,
				codigoIbgeUf: empresaDrift.empresa?.codigoIbgeUf,
				cei: empresaDrift.empresa?.cei,
				codigoCnaePrincipal: empresaDrift.empresa?.codigoCnaePrincipal,
				imagemLogotipo: empresaDrift.empresa?.imagemLogotipo,
				empresaContatoModelList: empresaContatoDriftToModel(empresaDrift.empresaContatoGroupedList),
				empresaTelefoneModelList: empresaTelefoneDriftToModel(empresaDrift.empresaTelefoneGroupedList),
				empresaCnaeModelList: empresaCnaeDriftToModel(empresaDrift.empresaCnaeGroupedList),
				empresaEnderecoModelList: empresaEnderecoDriftToModel(empresaDrift.empresaEnderecoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<EmpresaContatoModel> empresaContatoDriftToModel(List<EmpresaContatoGrouped>? empresaContatoDriftList) { 
		List<EmpresaContatoModel> empresaContatoModelList = [];
		if (empresaContatoDriftList != null) {
			for (var empresaContatoGrouped in empresaContatoDriftList) {
				empresaContatoModelList.add(
					EmpresaContatoModel(
						id: empresaContatoGrouped.empresaContato?.id,
						idEmpresa: empresaContatoGrouped.empresaContato?.idEmpresa,
						nome: empresaContatoGrouped.empresaContato?.nome,
						email: empresaContatoGrouped.empresaContato?.email,
						observacao: empresaContatoGrouped.empresaContato?.observacao,
					)
				);
			}
			return empresaContatoModelList;
		}
		return [];
	}

	List<EmpresaTelefoneModel> empresaTelefoneDriftToModel(List<EmpresaTelefoneGrouped>? empresaTelefoneDriftList) { 
		List<EmpresaTelefoneModel> empresaTelefoneModelList = [];
		if (empresaTelefoneDriftList != null) {
			for (var empresaTelefoneGrouped in empresaTelefoneDriftList) {
				empresaTelefoneModelList.add(
					EmpresaTelefoneModel(
						id: empresaTelefoneGrouped.empresaTelefone?.id,
						idEmpresa: empresaTelefoneGrouped.empresaTelefone?.idEmpresa,
						tipo: EmpresaTelefoneDomain.getTipo(empresaTelefoneGrouped.empresaTelefone?.tipo),
						numero: empresaTelefoneGrouped.empresaTelefone?.numero,
					)
				);
			}
			return empresaTelefoneModelList;
		}
		return [];
	}

	List<EmpresaCnaeModel> empresaCnaeDriftToModel(List<EmpresaCnaeGrouped>? empresaCnaeDriftList) { 
		List<EmpresaCnaeModel> empresaCnaeModelList = [];
		if (empresaCnaeDriftList != null) {
			for (var empresaCnaeGrouped in empresaCnaeDriftList) {
				empresaCnaeModelList.add(
					EmpresaCnaeModel(
						id: empresaCnaeGrouped.empresaCnae?.id,
						idEmpresa: empresaCnaeGrouped.empresaCnae?.idEmpresa,
						idCnae: empresaCnaeGrouped.empresaCnae?.idCnae,
						cnaeModel: CnaeModel(
							id: empresaCnaeGrouped.cnae?.id,
							codigo: empresaCnaeGrouped.cnae?.codigo,
							denominacao: empresaCnaeGrouped.cnae?.denominacao,
						),
						principal: EmpresaCnaeDomain.getPrincipal(empresaCnaeGrouped.empresaCnae?.principal),
						ramoAtividade: empresaCnaeGrouped.empresaCnae?.ramoAtividade,
						objetoSocial: empresaCnaeGrouped.empresaCnae?.objetoSocial,
					)
				);
			}
			return empresaCnaeModelList;
		}
		return [];
	}

	List<EmpresaEnderecoModel> empresaEnderecoDriftToModel(List<EmpresaEnderecoGrouped>? empresaEnderecoDriftList) { 
		List<EmpresaEnderecoModel> empresaEnderecoModelList = [];
		if (empresaEnderecoDriftList != null) {
			for (var empresaEnderecoGrouped in empresaEnderecoDriftList) {
				empresaEnderecoModelList.add(
					EmpresaEnderecoModel(
						id: empresaEnderecoGrouped.empresaEndereco?.id,
						idEmpresa: empresaEnderecoGrouped.empresaEndereco?.idEmpresa,
						logradouro: empresaEnderecoGrouped.empresaEndereco?.logradouro,
						numero: empresaEnderecoGrouped.empresaEndereco?.numero,
						bairro: empresaEnderecoGrouped.empresaEndereco?.bairro,
						cidade: empresaEnderecoGrouped.empresaEndereco?.cidade,
						uf: EmpresaEnderecoDomain.getUf(empresaEnderecoGrouped.empresaEndereco?.uf),
						cep: empresaEnderecoGrouped.empresaEndereco?.cep,
						municipioIbge: empresaEnderecoGrouped.empresaEndereco?.municipioIbge,
						complemento: empresaEnderecoGrouped.empresaEndereco?.complemento,
						principal: EmpresaEnderecoDomain.getPrincipal(empresaEnderecoGrouped.empresaEndereco?.principal),
						entrega: EmpresaEnderecoDomain.getEntrega(empresaEnderecoGrouped.empresaEndereco?.entrega),
						cobranca: EmpresaEnderecoDomain.getCobranca(empresaEnderecoGrouped.empresaEndereco?.cobranca),
						correspondencia: EmpresaEnderecoDomain.getCorrespondencia(empresaEnderecoGrouped.empresaEndereco?.correspondencia),
					)
				);
			}
			return empresaEnderecoModelList;
		}
		return [];
	}


	EmpresaGrouped toDrift(EmpresaModel empresaModel) {
		return EmpresaGrouped(
			empresa: Empresa(
				id: empresaModel.id,
				razaoSocial: empresaModel.razaoSocial,
				nomeFantasia: empresaModel.nomeFantasia,
				cnpj: Util.removeMask(empresaModel.cnpj),
				inscricaoEstadual: empresaModel.inscricaoEstadual,
				inscricaoMunicipal: empresaModel.inscricaoMunicipal,
				tipoRegime: EmpresaDomain.setTipoRegime(empresaModel.tipoRegime),
				crt: EmpresaDomain.setCrt(empresaModel.crt),
				email: empresaModel.email,
				site: empresaModel.site,
				contato: empresaModel.contato,
				dataConstituicao: empresaModel.dataConstituicao,
				tipo: EmpresaDomain.setTipo(empresaModel.tipo),
				inscricaoJuntaComercial: empresaModel.inscricaoJuntaComercial,
				dataInscJuntaComercial: empresaModel.dataInscJuntaComercial,
				codigoIbgeCidade: empresaModel.codigoIbgeCidade,
				codigoIbgeUf: empresaModel.codigoIbgeUf,
				cei: empresaModel.cei,
				codigoCnaePrincipal: empresaModel.codigoCnaePrincipal,
				imagemLogotipo: empresaModel.imagemLogotipo,
			),
			empresaContatoGroupedList: empresaContatoModelToDrift(empresaModel.empresaContatoModelList),
			empresaTelefoneGroupedList: empresaTelefoneModelToDrift(empresaModel.empresaTelefoneModelList),
			empresaCnaeGroupedList: empresaCnaeModelToDrift(empresaModel.empresaCnaeModelList),
			empresaEnderecoGroupedList: empresaEnderecoModelToDrift(empresaModel.empresaEnderecoModelList),
		);
	}

	List<EmpresaContatoGrouped> empresaContatoModelToDrift(List<EmpresaContatoModel>? empresaContatoModelList) { 
		List<EmpresaContatoGrouped> empresaContatoGroupedList = [];
		if (empresaContatoModelList != null) {
			for (var empresaContatoModel in empresaContatoModelList) {
				empresaContatoGroupedList.add(
					EmpresaContatoGrouped(
						empresaContato: EmpresaContato(
							id: empresaContatoModel.id,
							idEmpresa: empresaContatoModel.idEmpresa,
							nome: empresaContatoModel.nome,
							email: empresaContatoModel.email,
							observacao: empresaContatoModel.observacao,
						),
					),
				);
			}
			return empresaContatoGroupedList;
		}
		return [];
	}

	List<EmpresaTelefoneGrouped> empresaTelefoneModelToDrift(List<EmpresaTelefoneModel>? empresaTelefoneModelList) { 
		List<EmpresaTelefoneGrouped> empresaTelefoneGroupedList = [];
		if (empresaTelefoneModelList != null) {
			for (var empresaTelefoneModel in empresaTelefoneModelList) {
				empresaTelefoneGroupedList.add(
					EmpresaTelefoneGrouped(
						empresaTelefone: EmpresaTelefone(
							id: empresaTelefoneModel.id,
							idEmpresa: empresaTelefoneModel.idEmpresa,
							tipo: EmpresaTelefoneDomain.setTipo(empresaTelefoneModel.tipo),
							numero: Util.removeMask(empresaTelefoneModel.numero),
						),
					),
				);
			}
			return empresaTelefoneGroupedList;
		}
		return [];
	}

	List<EmpresaCnaeGrouped> empresaCnaeModelToDrift(List<EmpresaCnaeModel>? empresaCnaeModelList) { 
		List<EmpresaCnaeGrouped> empresaCnaeGroupedList = [];
		if (empresaCnaeModelList != null) {
			for (var empresaCnaeModel in empresaCnaeModelList) {
				empresaCnaeGroupedList.add(
					EmpresaCnaeGrouped(
						empresaCnae: EmpresaCnae(
							id: empresaCnaeModel.id,
							idEmpresa: empresaCnaeModel.idEmpresa,
							idCnae: empresaCnaeModel.idCnae,
							principal: EmpresaCnaeDomain.setPrincipal(empresaCnaeModel.principal),
							ramoAtividade: empresaCnaeModel.ramoAtividade,
							objetoSocial: empresaCnaeModel.objetoSocial,
						),
					),
				);
			}
			return empresaCnaeGroupedList;
		}
		return [];
	}

	List<EmpresaEnderecoGrouped> empresaEnderecoModelToDrift(List<EmpresaEnderecoModel>? empresaEnderecoModelList) { 
		List<EmpresaEnderecoGrouped> empresaEnderecoGroupedList = [];
		if (empresaEnderecoModelList != null) {
			for (var empresaEnderecoModel in empresaEnderecoModelList) {
				empresaEnderecoGroupedList.add(
					EmpresaEnderecoGrouped(
						empresaEndereco: EmpresaEndereco(
							id: empresaEnderecoModel.id,
							idEmpresa: empresaEnderecoModel.idEmpresa,
							logradouro: empresaEnderecoModel.logradouro,
							numero: empresaEnderecoModel.numero,
							bairro: empresaEnderecoModel.bairro,
							cidade: empresaEnderecoModel.cidade,
							uf: EmpresaEnderecoDomain.setUf(empresaEnderecoModel.uf),
							cep: Util.removeMask(empresaEnderecoModel.cep),
							municipioIbge: empresaEnderecoModel.municipioIbge,
							complemento: empresaEnderecoModel.complemento,
							principal: EmpresaEnderecoDomain.setPrincipal(empresaEnderecoModel.principal),
							entrega: EmpresaEnderecoDomain.setEntrega(empresaEnderecoModel.entrega),
							cobranca: EmpresaEnderecoDomain.setCobranca(empresaEnderecoModel.cobranca),
							correspondencia: EmpresaEnderecoDomain.setCorrespondencia(empresaEnderecoModel.correspondencia),
						),
					),
				);
			}
			return empresaEnderecoGroupedList;
		}
		return [];
	}

		
}
