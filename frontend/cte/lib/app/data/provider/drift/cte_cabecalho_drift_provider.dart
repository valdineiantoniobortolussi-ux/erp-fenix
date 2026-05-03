import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteCabecalhoDriftProvider extends ProviderBase {

	Future<List<CteCabecalhoModel>?> getList({Filter? filter}) async {
		List<CteCabecalhoGrouped> cteCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteCabecalhoDriftList = await Session.database.cteCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteCabecalhoDriftList = await Session.database.cteCabecalhoDao.getGroupedList(); 
			}
			if (cteCabecalhoDriftList.isNotEmpty) {
				return toListModel(cteCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteCabecalhoModel?>? insert(CteCabecalhoModel cteCabecalhoModel) async {
		try {
			final lastPk = await Session.database.cteCabecalhoDao.insertObject(toDrift(cteCabecalhoModel));
			cteCabecalhoModel.id = lastPk;
			return cteCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteCabecalhoModel?>? update(CteCabecalhoModel cteCabecalhoModel) async {
		try {
			await Session.database.cteCabecalhoDao.updateObject(toDrift(cteCabecalhoModel));
			return cteCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteCabecalhoDao.deleteObject(toDrift(CteCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteCabecalhoModel> toListModel(List<CteCabecalhoGrouped> cteCabecalhoDriftList) {
		List<CteCabecalhoModel> listModel = [];
		for (var cteCabecalhoDrift in cteCabecalhoDriftList) {
			listModel.add(toModel(cteCabecalhoDrift)!);
		}
		return listModel;
	}	

	CteCabecalhoModel? toModel(CteCabecalhoGrouped? cteCabecalhoDrift) {
		if (cteCabecalhoDrift != null) {
			return CteCabecalhoModel(
				id: cteCabecalhoDrift.cteCabecalho?.id,
				naturezaOperacao: cteCabecalhoDrift.cteCabecalho?.naturezaOperacao,
				chaveAcesso: cteCabecalhoDrift.cteCabecalho?.chaveAcesso,
				digitoChaveAcesso: cteCabecalhoDrift.cteCabecalho?.digitoChaveAcesso,
				codigoNumerico: cteCabecalhoDrift.cteCabecalho?.codigoNumerico,
				serie: cteCabecalhoDrift.cteCabecalho?.serie,
				numero: cteCabecalhoDrift.cteCabecalho?.numero,
				dataHoraEmissao: cteCabecalhoDrift.cteCabecalho?.dataHoraEmissao,
				ufEmitente: CteCabecalhoDomain.getUfEmitente(cteCabecalhoDrift.cteCabecalho?.ufEmitente),
				cfop: cteCabecalhoDrift.cteCabecalho?.cfop,
				formaPagamento: CteCabecalhoDomain.getFormaPagamento(cteCabecalhoDrift.cteCabecalho?.formaPagamento),
				modelo: CteCabecalhoDomain.getModelo(cteCabecalhoDrift.cteCabecalho?.modelo),
				formatoImpressaoDacte: CteCabecalhoDomain.getFormatoImpressaoDacte(cteCabecalhoDrift.cteCabecalho?.formatoImpressaoDacte),
				tipoEmissao: CteCabecalhoDomain.getTipoEmissao(cteCabecalhoDrift.cteCabecalho?.tipoEmissao),
				ambiente: CteCabecalhoDomain.getAmbiente(cteCabecalhoDrift.cteCabecalho?.ambiente),
				tipoCte: CteCabecalhoDomain.getTipoCte(cteCabecalhoDrift.cteCabecalho?.tipoCte),
				processoEmissao: CteCabecalhoDomain.getProcessoEmissao(cteCabecalhoDrift.cteCabecalho?.processoEmissao),
				versaoProcessoEmissao: cteCabecalhoDrift.cteCabecalho?.versaoProcessoEmissao,
				chaveReferenciado: cteCabecalhoDrift.cteCabecalho?.chaveReferenciado,
				codigoMunicipioEnvio: cteCabecalhoDrift.cteCabecalho?.codigoMunicipioEnvio,
				nomeMunicipioEnvio: cteCabecalhoDrift.cteCabecalho?.nomeMunicipioEnvio,
				ufEnvio: CteCabecalhoDomain.getUfEnvio(cteCabecalhoDrift.cteCabecalho?.ufEnvio),
				modal: CteCabecalhoDomain.getModal(cteCabecalhoDrift.cteCabecalho?.modal),
				tipoServico: CteCabecalhoDomain.getTipoServico(cteCabecalhoDrift.cteCabecalho?.tipoServico),
				codigoMunicipioIniPrestacao: cteCabecalhoDrift.cteCabecalho?.codigoMunicipioIniPrestacao,
				nomeMunicipioIniPrestacao: cteCabecalhoDrift.cteCabecalho?.nomeMunicipioIniPrestacao,
				ufIniPrestacao: CteCabecalhoDomain.getUfIniPrestacao(cteCabecalhoDrift.cteCabecalho?.ufIniPrestacao),
				codigoMunicipioFimPrestacao: cteCabecalhoDrift.cteCabecalho?.codigoMunicipioFimPrestacao,
				nomeMunicipioFimPrestacao: cteCabecalhoDrift.cteCabecalho?.nomeMunicipioFimPrestacao,
				ufFimPrestacao: CteCabecalhoDomain.getUfFimPrestacao(cteCabecalhoDrift.cteCabecalho?.ufFimPrestacao),
				retira: CteCabecalhoDomain.getRetira(cteCabecalhoDrift.cteCabecalho?.retira),
				retiraDetalhe: cteCabecalhoDrift.cteCabecalho?.retiraDetalhe,
				tomador: CteCabecalhoDomain.getTomador(cteCabecalhoDrift.cteCabecalho?.tomador),
				dataEntradaContingencia: cteCabecalhoDrift.cteCabecalho?.dataEntradaContingencia,
				justificativaContingencia: cteCabecalhoDrift.cteCabecalho?.justificativaContingencia,
				caracAdicionalTransporte: cteCabecalhoDrift.cteCabecalho?.caracAdicionalTransporte,
				caracAdicionalServico: cteCabecalhoDrift.cteCabecalho?.caracAdicionalServico,
				funcionarioEmissor: cteCabecalhoDrift.cteCabecalho?.funcionarioEmissor,
				fluxoOrigem: cteCabecalhoDrift.cteCabecalho?.fluxoOrigem,
				entregaTipoPeriodo: CteCabecalhoDomain.getEntregaTipoPeriodo(cteCabecalhoDrift.cteCabecalho?.entregaTipoPeriodo),
				entregaDataProgramada: cteCabecalhoDrift.cteCabecalho?.entregaDataProgramada,
				entregaDataInicial: cteCabecalhoDrift.cteCabecalho?.entregaDataInicial,
				entregaDataFinal: cteCabecalhoDrift.cteCabecalho?.entregaDataFinal,
				entregaTipoHora: CteCabecalhoDomain.getEntregaTipoHora(cteCabecalhoDrift.cteCabecalho?.entregaTipoHora),
				entregaHoraProgramada: cteCabecalhoDrift.cteCabecalho?.entregaHoraProgramada,
				entregaHoraInicial: cteCabecalhoDrift.cteCabecalho?.entregaHoraInicial,
				entregaHoraFinal: cteCabecalhoDrift.cteCabecalho?.entregaHoraFinal,
				municipioOrigemCalculo: cteCabecalhoDrift.cteCabecalho?.municipioOrigemCalculo,
				municipioDestinoCalculo: cteCabecalhoDrift.cteCabecalho?.municipioDestinoCalculo,
				observacoesGerais: cteCabecalhoDrift.cteCabecalho?.observacoesGerais,
				valorTotalServico: cteCabecalhoDrift.cteCabecalho?.valorTotalServico,
				valorReceber: cteCabecalhoDrift.cteCabecalho?.valorReceber,
				cst: cteCabecalhoDrift.cteCabecalho?.cst,
				baseCalculoIcms: cteCabecalhoDrift.cteCabecalho?.baseCalculoIcms,
				aliquotaIcms: cteCabecalhoDrift.cteCabecalho?.aliquotaIcms,
				valorIcms: cteCabecalhoDrift.cteCabecalho?.valorIcms,
				percentualReducaoBcIcms: cteCabecalhoDrift.cteCabecalho?.percentualReducaoBcIcms,
				valorBcIcmsStRetido: cteCabecalhoDrift.cteCabecalho?.valorBcIcmsStRetido,
				valorIcmsStRetido: cteCabecalhoDrift.cteCabecalho?.valorIcmsStRetido,
				aliquotaIcmsStRetido: cteCabecalhoDrift.cteCabecalho?.aliquotaIcmsStRetido,
				valorCreditoPresumidoIcms: cteCabecalhoDrift.cteCabecalho?.valorCreditoPresumidoIcms,
				percentualBcIcmsOutraUf: cteCabecalhoDrift.cteCabecalho?.percentualBcIcmsOutraUf,
				valorBcIcmsOutraUf: cteCabecalhoDrift.cteCabecalho?.valorBcIcmsOutraUf,
				aliquotaIcmsOutraUf: cteCabecalhoDrift.cteCabecalho?.aliquotaIcmsOutraUf,
				valorIcmsOutraUf: cteCabecalhoDrift.cteCabecalho?.valorIcmsOutraUf,
				simplesNacionalIndicador: CteCabecalhoDomain.getSimplesNacionalIndicador(cteCabecalhoDrift.cteCabecalho?.simplesNacionalIndicador),
				simplesNacionalTotal: cteCabecalhoDrift.cteCabecalho?.simplesNacionalTotal,
				informacoesAddFisco: cteCabecalhoDrift.cteCabecalho?.informacoesAddFisco,
				valorTotalCarga: cteCabecalhoDrift.cteCabecalho?.valorTotalCarga,
				produtoPredominante: cteCabecalhoDrift.cteCabecalho?.produtoPredominante,
				cargaOutrasCaracteristicas: cteCabecalhoDrift.cteCabecalho?.cargaOutrasCaracteristicas,
				modalVersaoLayout: cteCabecalhoDrift.cteCabecalho?.modalVersaoLayout,
				chaveCteSubstituido: cteCabecalhoDrift.cteCabecalho?.chaveCteSubstituido,
				cteEmitenteModelList: cteEmitenteDriftToModel(cteCabecalhoDrift.cteEmitenteGroupedList),
				cteLocalColetaModelList: cteLocalColetaDriftToModel(cteCabecalhoDrift.cteLocalColetaGroupedList),
				cteTomadorModelList: cteTomadorDriftToModel(cteCabecalhoDrift.cteTomadorGroupedList),
				ctePassagemModelList: ctePassagemDriftToModel(cteCabecalhoDrift.ctePassagemGroupedList),
				cteRemetenteModelList: cteRemetenteDriftToModel(cteCabecalhoDrift.cteRemetenteGroupedList),
				cteExpedidorModelList: cteExpedidorDriftToModel(cteCabecalhoDrift.cteExpedidorGroupedList),
				cteRecebedorModelList: cteRecebedorDriftToModel(cteCabecalhoDrift.cteRecebedorGroupedList),
				cteDestinatarioModelList: cteDestinatarioDriftToModel(cteCabecalhoDrift.cteDestinatarioGroupedList),
				cteLocalEntregaModelList: cteLocalEntregaDriftToModel(cteCabecalhoDrift.cteLocalEntregaGroupedList),
				cteComponenteModelList: cteComponenteDriftToModel(cteCabecalhoDrift.cteComponenteGroupedList),
				cteCargaModelList: cteCargaDriftToModel(cteCabecalhoDrift.cteCargaGroupedList),
				cteInformacaoNfOutrosModelList: cteInformacaoNfOutrosDriftToModel(cteCabecalhoDrift.cteInformacaoNfOutrosGroupedList),
				cteSeguroModelList: cteSeguroDriftToModel(cteCabecalhoDrift.cteSeguroGroupedList),
				ctePerigosoModelList: ctePerigosoDriftToModel(cteCabecalhoDrift.ctePerigosoGroupedList),
				cteVeiculoNovoModelList: cteVeiculoNovoDriftToModel(cteCabecalhoDrift.cteVeiculoNovoGroupedList),
				cteFaturaModelList: cteFaturaDriftToModel(cteCabecalhoDrift.cteFaturaGroupedList),
				cteDuplicataModelList: cteDuplicataDriftToModel(cteCabecalhoDrift.cteDuplicataGroupedList),
				cteRodoviarioModelList: cteRodoviarioDriftToModel(cteCabecalhoDrift.cteRodoviarioGroupedList),
				cteAereoModelList: cteAereoDriftToModel(cteCabecalhoDrift.cteAereoGroupedList),
				cteAquaviarioModelList: cteAquaviarioDriftToModel(cteCabecalhoDrift.cteAquaviarioGroupedList),
				cteFerroviarioModelList: cteFerroviarioDriftToModel(cteCabecalhoDrift.cteFerroviarioGroupedList),
				cteDutoviarioModelList: cteDutoviarioDriftToModel(cteCabecalhoDrift.cteDutoviarioGroupedList),
				cteMultimodalModelList: cteMultimodalDriftToModel(cteCabecalhoDrift.cteMultimodalGroupedList),
			);
		} else {
			return null;
		}
	}

	List<CteEmitenteModel> cteEmitenteDriftToModel(List<CteEmitenteGrouped>? cteEmitenteDriftList) { 
		List<CteEmitenteModel> cteEmitenteModelList = [];
		if (cteEmitenteDriftList != null) {
			for (var cteEmitenteGrouped in cteEmitenteDriftList) {
				cteEmitenteModelList.add(
					CteEmitenteModel(
						id: cteEmitenteGrouped.cteEmitente?.id,
						idCteCabecalho: cteEmitenteGrouped.cteEmitente?.idCteCabecalho,
						cnpj: cteEmitenteGrouped.cteEmitente?.cnpj,
						ie: cteEmitenteGrouped.cteEmitente?.ie,
						nome: cteEmitenteGrouped.cteEmitente?.nome,
						fantasia: cteEmitenteGrouped.cteEmitente?.fantasia,
						logradouro: cteEmitenteGrouped.cteEmitente?.logradouro,
						numero: cteEmitenteGrouped.cteEmitente?.numero,
						complemento: cteEmitenteGrouped.cteEmitente?.complemento,
						bairro: cteEmitenteGrouped.cteEmitente?.bairro,
						codigoMunicipio: cteEmitenteGrouped.cteEmitente?.codigoMunicipio,
						nomeMunicipio: cteEmitenteGrouped.cteEmitente?.nomeMunicipio,
						uf: CteEmitenteDomain.getUf(cteEmitenteGrouped.cteEmitente?.uf),
						cep: cteEmitenteGrouped.cteEmitente?.cep,
						telefone: cteEmitenteGrouped.cteEmitente?.telefone,
					)
				);
			}
			return cteEmitenteModelList;
		}
		return [];
	}

	List<CteLocalColetaModel> cteLocalColetaDriftToModel(List<CteLocalColetaGrouped>? cteLocalColetaDriftList) { 
		List<CteLocalColetaModel> cteLocalColetaModelList = [];
		if (cteLocalColetaDriftList != null) {
			for (var cteLocalColetaGrouped in cteLocalColetaDriftList) {
				cteLocalColetaModelList.add(
					CteLocalColetaModel(
						id: cteLocalColetaGrouped.cteLocalColeta?.id,
						idCteCabecalho: cteLocalColetaGrouped.cteLocalColeta?.idCteCabecalho,
						cnpj: cteLocalColetaGrouped.cteLocalColeta?.cnpj,
						cpf: cteLocalColetaGrouped.cteLocalColeta?.cpf,
						nome: cteLocalColetaGrouped.cteLocalColeta?.nome,
						logradouro: cteLocalColetaGrouped.cteLocalColeta?.logradouro,
						numero: cteLocalColetaGrouped.cteLocalColeta?.numero,
						complemento: cteLocalColetaGrouped.cteLocalColeta?.complemento,
						bairro: cteLocalColetaGrouped.cteLocalColeta?.bairro,
						codigoMunicipio: cteLocalColetaGrouped.cteLocalColeta?.codigoMunicipio,
						nomeMunicipio: cteLocalColetaGrouped.cteLocalColeta?.nomeMunicipio,
						uf: CteLocalColetaDomain.getUf(cteLocalColetaGrouped.cteLocalColeta?.uf),
					)
				);
			}
			return cteLocalColetaModelList;
		}
		return [];
	}

	List<CteTomadorModel> cteTomadorDriftToModel(List<CteTomadorGrouped>? cteTomadorDriftList) { 
		List<CteTomadorModel> cteTomadorModelList = [];
		if (cteTomadorDriftList != null) {
			for (var cteTomadorGrouped in cteTomadorDriftList) {
				cteTomadorModelList.add(
					CteTomadorModel(
						id: cteTomadorGrouped.cteTomador?.id,
						idCteCabecalho: cteTomadorGrouped.cteTomador?.idCteCabecalho,
						cnpj: cteTomadorGrouped.cteTomador?.cnpj,
						cpf: cteTomadorGrouped.cteTomador?.cpf,
						ie: cteTomadorGrouped.cteTomador?.ie,
						nome: cteTomadorGrouped.cteTomador?.nome,
						fantasia: cteTomadorGrouped.cteTomador?.fantasia,
						telefone: cteTomadorGrouped.cteTomador?.telefone,
						logradouro: cteTomadorGrouped.cteTomador?.logradouro,
						numero: cteTomadorGrouped.cteTomador?.numero,
						complemento: cteTomadorGrouped.cteTomador?.complemento,
						bairro: cteTomadorGrouped.cteTomador?.bairro,
						codigoMunicipio: cteTomadorGrouped.cteTomador?.codigoMunicipio,
						nomeMunicipio: cteTomadorGrouped.cteTomador?.nomeMunicipio,
						uf: CteTomadorDomain.getUf(cteTomadorGrouped.cteTomador?.uf),
						cep: cteTomadorGrouped.cteTomador?.cep,
						codigoPais: cteTomadorGrouped.cteTomador?.codigoPais,
						nomePais: cteTomadorGrouped.cteTomador?.nomePais,
						email: cteTomadorGrouped.cteTomador?.email,
					)
				);
			}
			return cteTomadorModelList;
		}
		return [];
	}

	List<CtePassagemModel> ctePassagemDriftToModel(List<CtePassagemGrouped>? ctePassagemDriftList) { 
		List<CtePassagemModel> ctePassagemModelList = [];
		if (ctePassagemDriftList != null) {
			for (var ctePassagemGrouped in ctePassagemDriftList) {
				ctePassagemModelList.add(
					CtePassagemModel(
						id: ctePassagemGrouped.ctePassagem?.id,
						idCteCabecalho: ctePassagemGrouped.ctePassagem?.idCteCabecalho,
						siglaPassagem: ctePassagemGrouped.ctePassagem?.siglaPassagem,
						siglaDestino: ctePassagemGrouped.ctePassagem?.siglaDestino,
						rota: ctePassagemGrouped.ctePassagem?.rota,
					)
				);
			}
			return ctePassagemModelList;
		}
		return [];
	}

	List<CteRemetenteModel> cteRemetenteDriftToModel(List<CteRemetenteGrouped>? cteRemetenteDriftList) { 
		List<CteRemetenteModel> cteRemetenteModelList = [];
		if (cteRemetenteDriftList != null) {
			for (var cteRemetenteGrouped in cteRemetenteDriftList) {
				cteRemetenteModelList.add(
					CteRemetenteModel(
						id: cteRemetenteGrouped.cteRemetente?.id,
						idCteCabecalho: cteRemetenteGrouped.cteRemetente?.idCteCabecalho,
						cnpj: cteRemetenteGrouped.cteRemetente?.cnpj,
						cpf: cteRemetenteGrouped.cteRemetente?.cpf,
						ie: cteRemetenteGrouped.cteRemetente?.ie,
						nome: cteRemetenteGrouped.cteRemetente?.nome,
						fantasia: cteRemetenteGrouped.cteRemetente?.fantasia,
						telefone: cteRemetenteGrouped.cteRemetente?.telefone,
						logradouro: cteRemetenteGrouped.cteRemetente?.logradouro,
						numero: cteRemetenteGrouped.cteRemetente?.numero,
						complemento: cteRemetenteGrouped.cteRemetente?.complemento,
						bairro: cteRemetenteGrouped.cteRemetente?.bairro,
						codigoMunicipio: cteRemetenteGrouped.cteRemetente?.codigoMunicipio,
						nomeMunicipio: cteRemetenteGrouped.cteRemetente?.nomeMunicipio,
						uf: CteRemetenteDomain.getUf(cteRemetenteGrouped.cteRemetente?.uf),
						cep: cteRemetenteGrouped.cteRemetente?.cep,
						codigoPais: cteRemetenteGrouped.cteRemetente?.codigoPais,
						nomePais: cteRemetenteGrouped.cteRemetente?.nomePais,
						email: cteRemetenteGrouped.cteRemetente?.email,
					)
				);
			}
			return cteRemetenteModelList;
		}
		return [];
	}

	List<CteExpedidorModel> cteExpedidorDriftToModel(List<CteExpedidorGrouped>? cteExpedidorDriftList) { 
		List<CteExpedidorModel> cteExpedidorModelList = [];
		if (cteExpedidorDriftList != null) {
			for (var cteExpedidorGrouped in cteExpedidorDriftList) {
				cteExpedidorModelList.add(
					CteExpedidorModel(
						id: cteExpedidorGrouped.cteExpedidor?.id,
						idCteCabecalho: cteExpedidorGrouped.cteExpedidor?.idCteCabecalho,
						cnpj: cteExpedidorGrouped.cteExpedidor?.cnpj,
						cpf: cteExpedidorGrouped.cteExpedidor?.cpf,
						ie: cteExpedidorGrouped.cteExpedidor?.ie,
						nome: cteExpedidorGrouped.cteExpedidor?.nome,
						fantasia: cteExpedidorGrouped.cteExpedidor?.fantasia,
						telefone: cteExpedidorGrouped.cteExpedidor?.telefone,
						logradouro: cteExpedidorGrouped.cteExpedidor?.logradouro,
						numero: cteExpedidorGrouped.cteExpedidor?.numero,
						complemento: cteExpedidorGrouped.cteExpedidor?.complemento,
						bairro: cteExpedidorGrouped.cteExpedidor?.bairro,
						codigoMunicipio: cteExpedidorGrouped.cteExpedidor?.codigoMunicipio,
						nomeMunicipio: cteExpedidorGrouped.cteExpedidor?.nomeMunicipio,
						uf: CteExpedidorDomain.getUf(cteExpedidorGrouped.cteExpedidor?.uf),
						cep: cteExpedidorGrouped.cteExpedidor?.cep,
						codigoPais: cteExpedidorGrouped.cteExpedidor?.codigoPais,
						nomePais: cteExpedidorGrouped.cteExpedidor?.nomePais,
						email: cteExpedidorGrouped.cteExpedidor?.email,
					)
				);
			}
			return cteExpedidorModelList;
		}
		return [];
	}

	List<CteRecebedorModel> cteRecebedorDriftToModel(List<CteRecebedorGrouped>? cteRecebedorDriftList) { 
		List<CteRecebedorModel> cteRecebedorModelList = [];
		if (cteRecebedorDriftList != null) {
			for (var cteRecebedorGrouped in cteRecebedorDriftList) {
				cteRecebedorModelList.add(
					CteRecebedorModel(
						id: cteRecebedorGrouped.cteRecebedor?.id,
						idCteCabecalho: cteRecebedorGrouped.cteRecebedor?.idCteCabecalho,
						cnpj: cteRecebedorGrouped.cteRecebedor?.cnpj,
						cpf: cteRecebedorGrouped.cteRecebedor?.cpf,
						ie: cteRecebedorGrouped.cteRecebedor?.ie,
						nome: cteRecebedorGrouped.cteRecebedor?.nome,
						fantasia: cteRecebedorGrouped.cteRecebedor?.fantasia,
						telefone: cteRecebedorGrouped.cteRecebedor?.telefone,
						logradouro: cteRecebedorGrouped.cteRecebedor?.logradouro,
						numero: cteRecebedorGrouped.cteRecebedor?.numero,
						complemento: cteRecebedorGrouped.cteRecebedor?.complemento,
						bairro: cteRecebedorGrouped.cteRecebedor?.bairro,
						codigoMunicipio: cteRecebedorGrouped.cteRecebedor?.codigoMunicipio,
						nomeMunicipio: cteRecebedorGrouped.cteRecebedor?.nomeMunicipio,
						uf: CteRecebedorDomain.getUf(cteRecebedorGrouped.cteRecebedor?.uf),
						cep: cteRecebedorGrouped.cteRecebedor?.cep,
						codigoPais: cteRecebedorGrouped.cteRecebedor?.codigoPais,
						nomePais: cteRecebedorGrouped.cteRecebedor?.nomePais,
						email: cteRecebedorGrouped.cteRecebedor?.email,
					)
				);
			}
			return cteRecebedorModelList;
		}
		return [];
	}

	List<CteDestinatarioModel> cteDestinatarioDriftToModel(List<CteDestinatarioGrouped>? cteDestinatarioDriftList) { 
		List<CteDestinatarioModel> cteDestinatarioModelList = [];
		if (cteDestinatarioDriftList != null) {
			for (var cteDestinatarioGrouped in cteDestinatarioDriftList) {
				cteDestinatarioModelList.add(
					CteDestinatarioModel(
						id: cteDestinatarioGrouped.cteDestinatario?.id,
						idCteCabecalho: cteDestinatarioGrouped.cteDestinatario?.idCteCabecalho,
						cnpj: cteDestinatarioGrouped.cteDestinatario?.cnpj,
						cpf: cteDestinatarioGrouped.cteDestinatario?.cpf,
						ie: cteDestinatarioGrouped.cteDestinatario?.ie,
						nome: cteDestinatarioGrouped.cteDestinatario?.nome,
						fantasia: cteDestinatarioGrouped.cteDestinatario?.fantasia,
						telefone: cteDestinatarioGrouped.cteDestinatario?.telefone,
						logradouro: cteDestinatarioGrouped.cteDestinatario?.logradouro,
						numero: cteDestinatarioGrouped.cteDestinatario?.numero,
						complemento: cteDestinatarioGrouped.cteDestinatario?.complemento,
						bairro: cteDestinatarioGrouped.cteDestinatario?.bairro,
						codigoMunicipio: cteDestinatarioGrouped.cteDestinatario?.codigoMunicipio,
						nomeMunicipio: cteDestinatarioGrouped.cteDestinatario?.nomeMunicipio,
						uf: CteDestinatarioDomain.getUf(cteDestinatarioGrouped.cteDestinatario?.uf),
						cep: cteDestinatarioGrouped.cteDestinatario?.cep,
						codigoPais: cteDestinatarioGrouped.cteDestinatario?.codigoPais,
						nomePais: cteDestinatarioGrouped.cteDestinatario?.nomePais,
						email: cteDestinatarioGrouped.cteDestinatario?.email,
					)
				);
			}
			return cteDestinatarioModelList;
		}
		return [];
	}

	List<CteLocalEntregaModel> cteLocalEntregaDriftToModel(List<CteLocalEntregaGrouped>? cteLocalEntregaDriftList) { 
		List<CteLocalEntregaModel> cteLocalEntregaModelList = [];
		if (cteLocalEntregaDriftList != null) {
			for (var cteLocalEntregaGrouped in cteLocalEntregaDriftList) {
				cteLocalEntregaModelList.add(
					CteLocalEntregaModel(
						id: cteLocalEntregaGrouped.cteLocalEntrega?.id,
						idCteCabecalho: cteLocalEntregaGrouped.cteLocalEntrega?.idCteCabecalho,
						cnpj: cteLocalEntregaGrouped.cteLocalEntrega?.cnpj,
						cpf: cteLocalEntregaGrouped.cteLocalEntrega?.cpf,
						nome: cteLocalEntregaGrouped.cteLocalEntrega?.nome,
						logradouro: cteLocalEntregaGrouped.cteLocalEntrega?.logradouro,
						numero: cteLocalEntregaGrouped.cteLocalEntrega?.numero,
						complemento: cteLocalEntregaGrouped.cteLocalEntrega?.complemento,
						bairro: cteLocalEntregaGrouped.cteLocalEntrega?.bairro,
						codigoMunicipio: cteLocalEntregaGrouped.cteLocalEntrega?.codigoMunicipio,
						nomeMunicipio: cteLocalEntregaGrouped.cteLocalEntrega?.nomeMunicipio,
						uf: CteLocalEntregaDomain.getUf(cteLocalEntregaGrouped.cteLocalEntrega?.uf),
					)
				);
			}
			return cteLocalEntregaModelList;
		}
		return [];
	}

	List<CteComponenteModel> cteComponenteDriftToModel(List<CteComponenteGrouped>? cteComponenteDriftList) { 
		List<CteComponenteModel> cteComponenteModelList = [];
		if (cteComponenteDriftList != null) {
			for (var cteComponenteGrouped in cteComponenteDriftList) {
				cteComponenteModelList.add(
					CteComponenteModel(
						id: cteComponenteGrouped.cteComponente?.id,
						idCteCabecalho: cteComponenteGrouped.cteComponente?.idCteCabecalho,
						nome: cteComponenteGrouped.cteComponente?.nome,
						valor: cteComponenteGrouped.cteComponente?.valor,
					)
				);
			}
			return cteComponenteModelList;
		}
		return [];
	}

	List<CteCargaModel> cteCargaDriftToModel(List<CteCargaGrouped>? cteCargaDriftList) { 
		List<CteCargaModel> cteCargaModelList = [];
		if (cteCargaDriftList != null) {
			for (var cteCargaGrouped in cteCargaDriftList) {
				cteCargaModelList.add(
					CteCargaModel(
						id: cteCargaGrouped.cteCarga?.id,
						idCteCabecalho: cteCargaGrouped.cteCarga?.idCteCabecalho,
						codigoUnidadeMedida: CteCargaDomain.getCodigoUnidadeMedida(cteCargaGrouped.cteCarga?.codigoUnidadeMedida),
						tipoMedida: cteCargaGrouped.cteCarga?.tipoMedida,
						quantidade: cteCargaGrouped.cteCarga?.quantidade,
					)
				);
			}
			return cteCargaModelList;
		}
		return [];
	}

	List<CteInformacaoNfOutrosModel> cteInformacaoNfOutrosDriftToModel(List<CteInformacaoNfOutrosGrouped>? cteInformacaoNfOutrosDriftList) { 
		List<CteInformacaoNfOutrosModel> cteInformacaoNfOutrosModelList = [];
		if (cteInformacaoNfOutrosDriftList != null) {
			for (var cteInformacaoNfOutrosGrouped in cteInformacaoNfOutrosDriftList) {
				cteInformacaoNfOutrosModelList.add(
					CteInformacaoNfOutrosModel(
						id: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.id,
						idCteCabecalho: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.idCteCabecalho,
						numeroRomaneio: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.numeroRomaneio,
						numeroPedido: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.numeroPedido,
						chaveAcessoNfe: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.chaveAcessoNfe,
						codigoModelo: CteInformacaoNfOutrosDomain.getCodigoModelo(cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.codigoModelo),
						serie: CteInformacaoNfOutrosDomain.getSerie(cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.serie),
						numero: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.numero,
						dataEmissao: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.dataEmissao,
						ufEmitente: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.ufEmitente,
						baseCalculoIcms: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.baseCalculoIcms,
						valorIcms: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.valorIcms,
						baseCalculoIcmsSt: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.baseCalculoIcmsSt,
						valorIcmsSt: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.valorIcmsSt,
						valorTotalProdutos: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.valorTotalProdutos,
						valorTotal: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.valorTotal,
						cfopPredominante: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.cfopPredominante,
						pesoTotalKg: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.pesoTotalKg,
						pinSuframa: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.pinSuframa,
						dataPrevistaEntrega: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.dataPrevistaEntrega,
						outroTipoDocOrig: CteInformacaoNfOutrosDomain.getOutroTipoDocOrig(cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.outroTipoDocOrig),
						outroDescricao: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.outroDescricao,
						outroValorDocumento: cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.outroValorDocumento,
					)
				);
			}
			return cteInformacaoNfOutrosModelList;
		}
		return [];
	}

	List<CteSeguroModel> cteSeguroDriftToModel(List<CteSeguroGrouped>? cteSeguroDriftList) { 
		List<CteSeguroModel> cteSeguroModelList = [];
		if (cteSeguroDriftList != null) {
			for (var cteSeguroGrouped in cteSeguroDriftList) {
				cteSeguroModelList.add(
					CteSeguroModel(
						id: cteSeguroGrouped.cteSeguro?.id,
						idCteCabecalho: cteSeguroGrouped.cteSeguro?.idCteCabecalho,
						responsavel: CteSeguroDomain.getResponsavel(cteSeguroGrouped.cteSeguro?.responsavel),
						seguradora: cteSeguroGrouped.cteSeguro?.seguradora,
						apolice: cteSeguroGrouped.cteSeguro?.apolice,
						averbacao: cteSeguroGrouped.cteSeguro?.averbacao,
						valorCarga: cteSeguroGrouped.cteSeguro?.valorCarga,
					)
				);
			}
			return cteSeguroModelList;
		}
		return [];
	}

	List<CtePerigosoModel> ctePerigosoDriftToModel(List<CtePerigosoGrouped>? ctePerigosoDriftList) { 
		List<CtePerigosoModel> ctePerigosoModelList = [];
		if (ctePerigosoDriftList != null) {
			for (var ctePerigosoGrouped in ctePerigosoDriftList) {
				ctePerigosoModelList.add(
					CtePerigosoModel(
						id: ctePerigosoGrouped.ctePerigoso?.id,
						idCteCabecalho: ctePerigosoGrouped.ctePerigoso?.idCteCabecalho,
						numeroOnu: ctePerigosoGrouped.ctePerigoso?.numeroOnu,
						nomeApropriado: ctePerigosoGrouped.ctePerigoso?.nomeApropriado,
						classeRisco: ctePerigosoGrouped.ctePerigoso?.classeRisco,
						grupoEmbalagem: ctePerigosoGrouped.ctePerigoso?.grupoEmbalagem,
						quantidadeTotalProduto: ctePerigosoGrouped.ctePerigoso?.quantidadeTotalProduto,
						quantidadeTipoVolume: ctePerigosoGrouped.ctePerigoso?.quantidadeTipoVolume,
						pontoFulgor: ctePerigosoGrouped.ctePerigoso?.pontoFulgor,
					)
				);
			}
			return ctePerigosoModelList;
		}
		return [];
	}

	List<CteVeiculoNovoModel> cteVeiculoNovoDriftToModel(List<CteVeiculoNovoGrouped>? cteVeiculoNovoDriftList) { 
		List<CteVeiculoNovoModel> cteVeiculoNovoModelList = [];
		if (cteVeiculoNovoDriftList != null) {
			for (var cteVeiculoNovoGrouped in cteVeiculoNovoDriftList) {
				cteVeiculoNovoModelList.add(
					CteVeiculoNovoModel(
						id: cteVeiculoNovoGrouped.cteVeiculoNovo?.id,
						idCteCabecalho: cteVeiculoNovoGrouped.cteVeiculoNovo?.idCteCabecalho,
						chassi: cteVeiculoNovoGrouped.cteVeiculoNovo?.chassi,
						cor: cteVeiculoNovoGrouped.cteVeiculoNovo?.cor,
						descricaoCor: cteVeiculoNovoGrouped.cteVeiculoNovo?.descricaoCor,
						codigoMarcaModelo: cteVeiculoNovoGrouped.cteVeiculoNovo?.codigoMarcaModelo,
						valorUnitario: cteVeiculoNovoGrouped.cteVeiculoNovo?.valorUnitario,
						valorFrete: cteVeiculoNovoGrouped.cteVeiculoNovo?.valorFrete,
					)
				);
			}
			return cteVeiculoNovoModelList;
		}
		return [];
	}

	List<CteFaturaModel> cteFaturaDriftToModel(List<CteFaturaGrouped>? cteFaturaDriftList) { 
		List<CteFaturaModel> cteFaturaModelList = [];
		if (cteFaturaDriftList != null) {
			for (var cteFaturaGrouped in cteFaturaDriftList) {
				cteFaturaModelList.add(
					CteFaturaModel(
						id: cteFaturaGrouped.cteFatura?.id,
						idCteCabecalho: cteFaturaGrouped.cteFatura?.idCteCabecalho,
						numero: cteFaturaGrouped.cteFatura?.numero,
						valorOriginal: cteFaturaGrouped.cteFatura?.valorOriginal,
						valorDesconto: cteFaturaGrouped.cteFatura?.valorDesconto,
						valorLiquido: cteFaturaGrouped.cteFatura?.valorLiquido,
					)
				);
			}
			return cteFaturaModelList;
		}
		return [];
	}

	List<CteDuplicataModel> cteDuplicataDriftToModel(List<CteDuplicataGrouped>? cteDuplicataDriftList) { 
		List<CteDuplicataModel> cteDuplicataModelList = [];
		if (cteDuplicataDriftList != null) {
			for (var cteDuplicataGrouped in cteDuplicataDriftList) {
				cteDuplicataModelList.add(
					CteDuplicataModel(
						id: cteDuplicataGrouped.cteDuplicata?.id,
						idCteCabecalho: cteDuplicataGrouped.cteDuplicata?.idCteCabecalho,
						numero: cteDuplicataGrouped.cteDuplicata?.numero,
						dataVencimento: cteDuplicataGrouped.cteDuplicata?.dataVencimento,
						valor: cteDuplicataGrouped.cteDuplicata?.valor,
					)
				);
			}
			return cteDuplicataModelList;
		}
		return [];
	}

	List<CteRodoviarioModel> cteRodoviarioDriftToModel(List<CteRodoviarioGrouped>? cteRodoviarioDriftList) { 
		List<CteRodoviarioModel> cteRodoviarioModelList = [];
		if (cteRodoviarioDriftList != null) {
			for (var cteRodoviarioGrouped in cteRodoviarioDriftList) {
				cteRodoviarioModelList.add(
					CteRodoviarioModel(
						id: cteRodoviarioGrouped.cteRodoviario?.id,
						idCteCabecalho: cteRodoviarioGrouped.cteRodoviario?.idCteCabecalho,
						rntrc: cteRodoviarioGrouped.cteRodoviario?.rntrc,
						dataPrevistaEntrega: cteRodoviarioGrouped.cteRodoviario?.dataPrevistaEntrega,
						indicadorLotacao: CteRodoviarioDomain.getIndicadorLotacao(cteRodoviarioGrouped.cteRodoviario?.indicadorLotacao),
						ciot: cteRodoviarioGrouped.cteRodoviario?.ciot,
					)
				);
			}
			return cteRodoviarioModelList;
		}
		return [];
	}

	List<CteAereoModel> cteAereoDriftToModel(List<CteAereoGrouped>? cteAereoDriftList) { 
		List<CteAereoModel> cteAereoModelList = [];
		if (cteAereoDriftList != null) {
			for (var cteAereoGrouped in cteAereoDriftList) {
				cteAereoModelList.add(
					CteAereoModel(
						id: cteAereoGrouped.cteAereo?.id,
						idCteCabecalho: cteAereoGrouped.cteAereo?.idCteCabecalho,
						numeroMinuta: cteAereoGrouped.cteAereo?.numeroMinuta,
						numeroConhecimento: cteAereoGrouped.cteAereo?.numeroConhecimento,
						dataPrevistaEntrega: cteAereoGrouped.cteAereo?.dataPrevistaEntrega,
						idEmissor: cteAereoGrouped.cteAereo?.idEmissor,
						idInternaTomador: cteAereoGrouped.cteAereo?.idInternaTomador,
						tarifaClasse: CteAereoDomain.getTarifaClasse(cteAereoGrouped.cteAereo?.tarifaClasse),
						tarifaCodigo: cteAereoGrouped.cteAereo?.tarifaCodigo,
						tarifaValor: cteAereoGrouped.cteAereo?.tarifaValor,
						cargaDimensao: cteAereoGrouped.cteAereo?.cargaDimensao,
						cargaInformacaoManuseio: CteAereoDomain.getCargaInformacaoManuseio(cteAereoGrouped.cteAereo?.cargaInformacaoManuseio),
						cargaEspecial: CteAereoDomain.getCargaEspecial(cteAereoGrouped.cteAereo?.cargaEspecial),
					)
				);
			}
			return cteAereoModelList;
		}
		return [];
	}

	List<CteAquaviarioModel> cteAquaviarioDriftToModel(List<CteAquaviarioGrouped>? cteAquaviarioDriftList) { 
		List<CteAquaviarioModel> cteAquaviarioModelList = [];
		if (cteAquaviarioDriftList != null) {
			for (var cteAquaviarioGrouped in cteAquaviarioDriftList) {
				cteAquaviarioModelList.add(
					CteAquaviarioModel(
						id: cteAquaviarioGrouped.cteAquaviario?.id,
						idCteCabecalho: cteAquaviarioGrouped.cteAquaviario?.idCteCabecalho,
						valorPrestacao: cteAquaviarioGrouped.cteAquaviario?.valorPrestacao,
						afrmm: cteAquaviarioGrouped.cteAquaviario?.afrmm,
						numeroBooking: cteAquaviarioGrouped.cteAquaviario?.numeroBooking,
						numeroControle: cteAquaviarioGrouped.cteAquaviario?.numeroControle,
						idNavio: cteAquaviarioGrouped.cteAquaviario?.idNavio,
					)
				);
			}
			return cteAquaviarioModelList;
		}
		return [];
	}

	List<CteFerroviarioModel> cteFerroviarioDriftToModel(List<CteFerroviarioGrouped>? cteFerroviarioDriftList) { 
		List<CteFerroviarioModel> cteFerroviarioModelList = [];
		if (cteFerroviarioDriftList != null) {
			for (var cteFerroviarioGrouped in cteFerroviarioDriftList) {
				cteFerroviarioModelList.add(
					CteFerroviarioModel(
						id: cteFerroviarioGrouped.cteFerroviario?.id,
						idCteCabecalho: cteFerroviarioGrouped.cteFerroviario?.idCteCabecalho,
						tipoTrafego: CteFerroviarioDomain.getTipoTrafego(cteFerroviarioGrouped.cteFerroviario?.tipoTrafego),
						responsavelFaturamento: CteFerroviarioDomain.getResponsavelFaturamento(cteFerroviarioGrouped.cteFerroviario?.responsavelFaturamento),
						ferroviaEmitenteCte: CteFerroviarioDomain.getFerroviaEmitenteCte(cteFerroviarioGrouped.cteFerroviario?.ferroviaEmitenteCte),
						fluxo: cteFerroviarioGrouped.cteFerroviario?.fluxo,
						idTrem: cteFerroviarioGrouped.cteFerroviario?.idTrem,
						valorFrete: cteFerroviarioGrouped.cteFerroviario?.valorFrete,
					)
				);
			}
			return cteFerroviarioModelList;
		}
		return [];
	}

	List<CteDutoviarioModel> cteDutoviarioDriftToModel(List<CteDutoviarioGrouped>? cteDutoviarioDriftList) { 
		List<CteDutoviarioModel> cteDutoviarioModelList = [];
		if (cteDutoviarioDriftList != null) {
			for (var cteDutoviarioGrouped in cteDutoviarioDriftList) {
				cteDutoviarioModelList.add(
					CteDutoviarioModel(
						id: cteDutoviarioGrouped.cteDutoviario?.id,
						idCteCabecalho: cteDutoviarioGrouped.cteDutoviario?.idCteCabecalho,
						valorTarifa: cteDutoviarioGrouped.cteDutoviario?.valorTarifa,
						dataInicio: cteDutoviarioGrouped.cteDutoviario?.dataInicio,
						dataFim: cteDutoviarioGrouped.cteDutoviario?.dataFim,
					)
				);
			}
			return cteDutoviarioModelList;
		}
		return [];
	}

	List<CteMultimodalModel> cteMultimodalDriftToModel(List<CteMultimodalGrouped>? cteMultimodalDriftList) { 
		List<CteMultimodalModel> cteMultimodalModelList = [];
		if (cteMultimodalDriftList != null) {
			for (var cteMultimodalGrouped in cteMultimodalDriftList) {
				cteMultimodalModelList.add(
					CteMultimodalModel(
						id: cteMultimodalGrouped.cteMultimodal?.id,
						idCteCabecalho: cteMultimodalGrouped.cteMultimodal?.idCteCabecalho,
						cotm: cteMultimodalGrouped.cteMultimodal?.cotm,
						indicadorNegociavel: CteMultimodalDomain.getIndicadorNegociavel(cteMultimodalGrouped.cteMultimodal?.indicadorNegociavel),
					)
				);
			}
			return cteMultimodalModelList;
		}
		return [];
	}


	CteCabecalhoGrouped toDrift(CteCabecalhoModel cteCabecalhoModel) {
		return CteCabecalhoGrouped(
			cteCabecalho: CteCabecalho(
				id: cteCabecalhoModel.id,
				naturezaOperacao: cteCabecalhoModel.naturezaOperacao,
				chaveAcesso: cteCabecalhoModel.chaveAcesso,
				digitoChaveAcesso: cteCabecalhoModel.digitoChaveAcesso,
				codigoNumerico: cteCabecalhoModel.codigoNumerico,
				serie: cteCabecalhoModel.serie,
				numero: cteCabecalhoModel.numero,
				dataHoraEmissao: cteCabecalhoModel.dataHoraEmissao,
				ufEmitente: CteCabecalhoDomain.setUfEmitente(cteCabecalhoModel.ufEmitente),
				cfop: cteCabecalhoModel.cfop,
				formaPagamento: CteCabecalhoDomain.setFormaPagamento(cteCabecalhoModel.formaPagamento),
				modelo: CteCabecalhoDomain.setModelo(cteCabecalhoModel.modelo),
				formatoImpressaoDacte: CteCabecalhoDomain.setFormatoImpressaoDacte(cteCabecalhoModel.formatoImpressaoDacte),
				tipoEmissao: CteCabecalhoDomain.setTipoEmissao(cteCabecalhoModel.tipoEmissao),
				ambiente: CteCabecalhoDomain.setAmbiente(cteCabecalhoModel.ambiente),
				tipoCte: CteCabecalhoDomain.setTipoCte(cteCabecalhoModel.tipoCte),
				processoEmissao: CteCabecalhoDomain.setProcessoEmissao(cteCabecalhoModel.processoEmissao),
				versaoProcessoEmissao: cteCabecalhoModel.versaoProcessoEmissao,
				chaveReferenciado: cteCabecalhoModel.chaveReferenciado,
				codigoMunicipioEnvio: cteCabecalhoModel.codigoMunicipioEnvio,
				nomeMunicipioEnvio: cteCabecalhoModel.nomeMunicipioEnvio,
				ufEnvio: CteCabecalhoDomain.setUfEnvio(cteCabecalhoModel.ufEnvio),
				modal: CteCabecalhoDomain.setModal(cteCabecalhoModel.modal),
				tipoServico: CteCabecalhoDomain.setTipoServico(cteCabecalhoModel.tipoServico),
				codigoMunicipioIniPrestacao: cteCabecalhoModel.codigoMunicipioIniPrestacao,
				nomeMunicipioIniPrestacao: cteCabecalhoModel.nomeMunicipioIniPrestacao,
				ufIniPrestacao: CteCabecalhoDomain.setUfIniPrestacao(cteCabecalhoModel.ufIniPrestacao),
				codigoMunicipioFimPrestacao: cteCabecalhoModel.codigoMunicipioFimPrestacao,
				nomeMunicipioFimPrestacao: cteCabecalhoModel.nomeMunicipioFimPrestacao,
				ufFimPrestacao: CteCabecalhoDomain.setUfFimPrestacao(cteCabecalhoModel.ufFimPrestacao),
				retira: CteCabecalhoDomain.setRetira(cteCabecalhoModel.retira),
				retiraDetalhe: cteCabecalhoModel.retiraDetalhe,
				tomador: CteCabecalhoDomain.setTomador(cteCabecalhoModel.tomador),
				dataEntradaContingencia: cteCabecalhoModel.dataEntradaContingencia,
				justificativaContingencia: cteCabecalhoModel.justificativaContingencia,
				caracAdicionalTransporte: cteCabecalhoModel.caracAdicionalTransporte,
				caracAdicionalServico: cteCabecalhoModel.caracAdicionalServico,
				funcionarioEmissor: cteCabecalhoModel.funcionarioEmissor,
				fluxoOrigem: cteCabecalhoModel.fluxoOrigem,
				entregaTipoPeriodo: CteCabecalhoDomain.setEntregaTipoPeriodo(cteCabecalhoModel.entregaTipoPeriodo),
				entregaDataProgramada: cteCabecalhoModel.entregaDataProgramada,
				entregaDataInicial: cteCabecalhoModel.entregaDataInicial,
				entregaDataFinal: cteCabecalhoModel.entregaDataFinal,
				entregaTipoHora: CteCabecalhoDomain.setEntregaTipoHora(cteCabecalhoModel.entregaTipoHora),
				entregaHoraProgramada: cteCabecalhoModel.entregaHoraProgramada,
				entregaHoraInicial: cteCabecalhoModel.entregaHoraInicial,
				entregaHoraFinal: cteCabecalhoModel.entregaHoraFinal,
				municipioOrigemCalculo: cteCabecalhoModel.municipioOrigemCalculo,
				municipioDestinoCalculo: cteCabecalhoModel.municipioDestinoCalculo,
				observacoesGerais: cteCabecalhoModel.observacoesGerais,
				valorTotalServico: cteCabecalhoModel.valorTotalServico,
				valorReceber: cteCabecalhoModel.valorReceber,
				cst: cteCabecalhoModel.cst,
				baseCalculoIcms: cteCabecalhoModel.baseCalculoIcms,
				aliquotaIcms: cteCabecalhoModel.aliquotaIcms,
				valorIcms: cteCabecalhoModel.valorIcms,
				percentualReducaoBcIcms: cteCabecalhoModel.percentualReducaoBcIcms,
				valorBcIcmsStRetido: cteCabecalhoModel.valorBcIcmsStRetido,
				valorIcmsStRetido: cteCabecalhoModel.valorIcmsStRetido,
				aliquotaIcmsStRetido: cteCabecalhoModel.aliquotaIcmsStRetido,
				valorCreditoPresumidoIcms: cteCabecalhoModel.valorCreditoPresumidoIcms,
				percentualBcIcmsOutraUf: cteCabecalhoModel.percentualBcIcmsOutraUf,
				valorBcIcmsOutraUf: cteCabecalhoModel.valorBcIcmsOutraUf,
				aliquotaIcmsOutraUf: cteCabecalhoModel.aliquotaIcmsOutraUf,
				valorIcmsOutraUf: cteCabecalhoModel.valorIcmsOutraUf,
				simplesNacionalIndicador: CteCabecalhoDomain.setSimplesNacionalIndicador(cteCabecalhoModel.simplesNacionalIndicador),
				simplesNacionalTotal: cteCabecalhoModel.simplesNacionalTotal,
				informacoesAddFisco: cteCabecalhoModel.informacoesAddFisco,
				valorTotalCarga: cteCabecalhoModel.valorTotalCarga,
				produtoPredominante: cteCabecalhoModel.produtoPredominante,
				cargaOutrasCaracteristicas: cteCabecalhoModel.cargaOutrasCaracteristicas,
				modalVersaoLayout: cteCabecalhoModel.modalVersaoLayout,
				chaveCteSubstituido: cteCabecalhoModel.chaveCteSubstituido,
			),
			cteEmitenteGroupedList: cteEmitenteModelToDrift(cteCabecalhoModel.cteEmitenteModelList),
			cteLocalColetaGroupedList: cteLocalColetaModelToDrift(cteCabecalhoModel.cteLocalColetaModelList),
			cteTomadorGroupedList: cteTomadorModelToDrift(cteCabecalhoModel.cteTomadorModelList),
			ctePassagemGroupedList: ctePassagemModelToDrift(cteCabecalhoModel.ctePassagemModelList),
			cteRemetenteGroupedList: cteRemetenteModelToDrift(cteCabecalhoModel.cteRemetenteModelList),
			cteExpedidorGroupedList: cteExpedidorModelToDrift(cteCabecalhoModel.cteExpedidorModelList),
			cteRecebedorGroupedList: cteRecebedorModelToDrift(cteCabecalhoModel.cteRecebedorModelList),
			cteDestinatarioGroupedList: cteDestinatarioModelToDrift(cteCabecalhoModel.cteDestinatarioModelList),
			cteLocalEntregaGroupedList: cteLocalEntregaModelToDrift(cteCabecalhoModel.cteLocalEntregaModelList),
			cteComponenteGroupedList: cteComponenteModelToDrift(cteCabecalhoModel.cteComponenteModelList),
			cteCargaGroupedList: cteCargaModelToDrift(cteCabecalhoModel.cteCargaModelList),
			cteInformacaoNfOutrosGroupedList: cteInformacaoNfOutrosModelToDrift(cteCabecalhoModel.cteInformacaoNfOutrosModelList),
			cteSeguroGroupedList: cteSeguroModelToDrift(cteCabecalhoModel.cteSeguroModelList),
			ctePerigosoGroupedList: ctePerigosoModelToDrift(cteCabecalhoModel.ctePerigosoModelList),
			cteVeiculoNovoGroupedList: cteVeiculoNovoModelToDrift(cteCabecalhoModel.cteVeiculoNovoModelList),
			cteFaturaGroupedList: cteFaturaModelToDrift(cteCabecalhoModel.cteFaturaModelList),
			cteDuplicataGroupedList: cteDuplicataModelToDrift(cteCabecalhoModel.cteDuplicataModelList),
			cteRodoviarioGroupedList: cteRodoviarioModelToDrift(cteCabecalhoModel.cteRodoviarioModelList),
			cteAereoGroupedList: cteAereoModelToDrift(cteCabecalhoModel.cteAereoModelList),
			cteAquaviarioGroupedList: cteAquaviarioModelToDrift(cteCabecalhoModel.cteAquaviarioModelList),
			cteFerroviarioGroupedList: cteFerroviarioModelToDrift(cteCabecalhoModel.cteFerroviarioModelList),
			cteDutoviarioGroupedList: cteDutoviarioModelToDrift(cteCabecalhoModel.cteDutoviarioModelList),
			cteMultimodalGroupedList: cteMultimodalModelToDrift(cteCabecalhoModel.cteMultimodalModelList),
		);
	}

	List<CteEmitenteGrouped> cteEmitenteModelToDrift(List<CteEmitenteModel>? cteEmitenteModelList) { 
		List<CteEmitenteGrouped> cteEmitenteGroupedList = [];
		if (cteEmitenteModelList != null) {
			for (var cteEmitenteModel in cteEmitenteModelList) {
				cteEmitenteGroupedList.add(
					CteEmitenteGrouped(
						cteEmitente: CteEmitente(
							id: cteEmitenteModel.id,
							idCteCabecalho: cteEmitenteModel.idCteCabecalho,
							cnpj: Util.removeMask(cteEmitenteModel.cnpj),
							ie: cteEmitenteModel.ie,
							nome: cteEmitenteModel.nome,
							fantasia: cteEmitenteModel.fantasia,
							logradouro: cteEmitenteModel.logradouro,
							numero: cteEmitenteModel.numero,
							complemento: cteEmitenteModel.complemento,
							bairro: cteEmitenteModel.bairro,
							codigoMunicipio: cteEmitenteModel.codigoMunicipio,
							nomeMunicipio: cteEmitenteModel.nomeMunicipio,
							uf: CteEmitenteDomain.setUf(cteEmitenteModel.uf),
							cep: Util.removeMask(cteEmitenteModel.cep),
							telefone: cteEmitenteModel.telefone,
						),
					),
				);
			}
			return cteEmitenteGroupedList;
		}
		return [];
	}

	List<CteLocalColetaGrouped> cteLocalColetaModelToDrift(List<CteLocalColetaModel>? cteLocalColetaModelList) { 
		List<CteLocalColetaGrouped> cteLocalColetaGroupedList = [];
		if (cteLocalColetaModelList != null) {
			for (var cteLocalColetaModel in cteLocalColetaModelList) {
				cteLocalColetaGroupedList.add(
					CteLocalColetaGrouped(
						cteLocalColeta: CteLocalColeta(
							id: cteLocalColetaModel.id,
							idCteCabecalho: cteLocalColetaModel.idCteCabecalho,
							cnpj: Util.removeMask(cteLocalColetaModel.cnpj),
							cpf: Util.removeMask(cteLocalColetaModel.cpf),
							nome: cteLocalColetaModel.nome,
							logradouro: cteLocalColetaModel.logradouro,
							numero: cteLocalColetaModel.numero,
							complemento: cteLocalColetaModel.complemento,
							bairro: cteLocalColetaModel.bairro,
							codigoMunicipio: cteLocalColetaModel.codigoMunicipio,
							nomeMunicipio: cteLocalColetaModel.nomeMunicipio,
							uf: CteLocalColetaDomain.setUf(cteLocalColetaModel.uf),
						),
					),
				);
			}
			return cteLocalColetaGroupedList;
		}
		return [];
	}

	List<CteTomadorGrouped> cteTomadorModelToDrift(List<CteTomadorModel>? cteTomadorModelList) { 
		List<CteTomadorGrouped> cteTomadorGroupedList = [];
		if (cteTomadorModelList != null) {
			for (var cteTomadorModel in cteTomadorModelList) {
				cteTomadorGroupedList.add(
					CteTomadorGrouped(
						cteTomador: CteTomador(
							id: cteTomadorModel.id,
							idCteCabecalho: cteTomadorModel.idCteCabecalho,
							cnpj: Util.removeMask(cteTomadorModel.cnpj),
							cpf: Util.removeMask(cteTomadorModel.cpf),
							ie: cteTomadorModel.ie,
							nome: cteTomadorModel.nome,
							fantasia: cteTomadorModel.fantasia,
							telefone: cteTomadorModel.telefone,
							logradouro: cteTomadorModel.logradouro,
							numero: cteTomadorModel.numero,
							complemento: cteTomadorModel.complemento,
							bairro: cteTomadorModel.bairro,
							codigoMunicipio: cteTomadorModel.codigoMunicipio,
							nomeMunicipio: cteTomadorModel.nomeMunicipio,
							uf: CteTomadorDomain.setUf(cteTomadorModel.uf),
							cep: Util.removeMask(cteTomadorModel.cep),
							codigoPais: cteTomadorModel.codigoPais,
							nomePais: cteTomadorModel.nomePais,
							email: cteTomadorModel.email,
						),
					),
				);
			}
			return cteTomadorGroupedList;
		}
		return [];
	}

	List<CtePassagemGrouped> ctePassagemModelToDrift(List<CtePassagemModel>? ctePassagemModelList) { 
		List<CtePassagemGrouped> ctePassagemGroupedList = [];
		if (ctePassagemModelList != null) {
			for (var ctePassagemModel in ctePassagemModelList) {
				ctePassagemGroupedList.add(
					CtePassagemGrouped(
						ctePassagem: CtePassagem(
							id: ctePassagemModel.id,
							idCteCabecalho: ctePassagemModel.idCteCabecalho,
							siglaPassagem: ctePassagemModel.siglaPassagem,
							siglaDestino: ctePassagemModel.siglaDestino,
							rota: ctePassagemModel.rota,
						),
					),
				);
			}
			return ctePassagemGroupedList;
		}
		return [];
	}

	List<CteRemetenteGrouped> cteRemetenteModelToDrift(List<CteRemetenteModel>? cteRemetenteModelList) { 
		List<CteRemetenteGrouped> cteRemetenteGroupedList = [];
		if (cteRemetenteModelList != null) {
			for (var cteRemetenteModel in cteRemetenteModelList) {
				cteRemetenteGroupedList.add(
					CteRemetenteGrouped(
						cteRemetente: CteRemetente(
							id: cteRemetenteModel.id,
							idCteCabecalho: cteRemetenteModel.idCteCabecalho,
							cnpj: Util.removeMask(cteRemetenteModel.cnpj),
							cpf: Util.removeMask(cteRemetenteModel.cpf),
							ie: cteRemetenteModel.ie,
							nome: cteRemetenteModel.nome,
							fantasia: cteRemetenteModel.fantasia,
							telefone: cteRemetenteModel.telefone,
							logradouro: cteRemetenteModel.logradouro,
							numero: cteRemetenteModel.numero,
							complemento: cteRemetenteModel.complemento,
							bairro: cteRemetenteModel.bairro,
							codigoMunicipio: cteRemetenteModel.codigoMunicipio,
							nomeMunicipio: cteRemetenteModel.nomeMunicipio,
							uf: CteRemetenteDomain.setUf(cteRemetenteModel.uf),
							cep: Util.removeMask(cteRemetenteModel.cep),
							codigoPais: cteRemetenteModel.codigoPais,
							nomePais: cteRemetenteModel.nomePais,
							email: cteRemetenteModel.email,
						),
					),
				);
			}
			return cteRemetenteGroupedList;
		}
		return [];
	}

	List<CteExpedidorGrouped> cteExpedidorModelToDrift(List<CteExpedidorModel>? cteExpedidorModelList) { 
		List<CteExpedidorGrouped> cteExpedidorGroupedList = [];
		if (cteExpedidorModelList != null) {
			for (var cteExpedidorModel in cteExpedidorModelList) {
				cteExpedidorGroupedList.add(
					CteExpedidorGrouped(
						cteExpedidor: CteExpedidor(
							id: cteExpedidorModel.id,
							idCteCabecalho: cteExpedidorModel.idCteCabecalho,
							cnpj: Util.removeMask(cteExpedidorModel.cnpj),
							cpf: Util.removeMask(cteExpedidorModel.cpf),
							ie: cteExpedidorModel.ie,
							nome: cteExpedidorModel.nome,
							fantasia: cteExpedidorModel.fantasia,
							telefone: cteExpedidorModel.telefone,
							logradouro: cteExpedidorModel.logradouro,
							numero: cteExpedidorModel.numero,
							complemento: cteExpedidorModel.complemento,
							bairro: cteExpedidorModel.bairro,
							codigoMunicipio: cteExpedidorModel.codigoMunicipio,
							nomeMunicipio: cteExpedidorModel.nomeMunicipio,
							uf: CteExpedidorDomain.setUf(cteExpedidorModel.uf),
							cep: Util.removeMask(cteExpedidorModel.cep),
							codigoPais: cteExpedidorModel.codigoPais,
							nomePais: cteExpedidorModel.nomePais,
							email: cteExpedidorModel.email,
						),
					),
				);
			}
			return cteExpedidorGroupedList;
		}
		return [];
	}

	List<CteRecebedorGrouped> cteRecebedorModelToDrift(List<CteRecebedorModel>? cteRecebedorModelList) { 
		List<CteRecebedorGrouped> cteRecebedorGroupedList = [];
		if (cteRecebedorModelList != null) {
			for (var cteRecebedorModel in cteRecebedorModelList) {
				cteRecebedorGroupedList.add(
					CteRecebedorGrouped(
						cteRecebedor: CteRecebedor(
							id: cteRecebedorModel.id,
							idCteCabecalho: cteRecebedorModel.idCteCabecalho,
							cnpj: Util.removeMask(cteRecebedorModel.cnpj),
							cpf: Util.removeMask(cteRecebedorModel.cpf),
							ie: cteRecebedorModel.ie,
							nome: cteRecebedorModel.nome,
							fantasia: cteRecebedorModel.fantasia,
							telefone: cteRecebedorModel.telefone,
							logradouro: cteRecebedorModel.logradouro,
							numero: cteRecebedorModel.numero,
							complemento: cteRecebedorModel.complemento,
							bairro: cteRecebedorModel.bairro,
							codigoMunicipio: cteRecebedorModel.codigoMunicipio,
							nomeMunicipio: cteRecebedorModel.nomeMunicipio,
							uf: CteRecebedorDomain.setUf(cteRecebedorModel.uf),
							cep: Util.removeMask(cteRecebedorModel.cep),
							codigoPais: cteRecebedorModel.codigoPais,
							nomePais: cteRecebedorModel.nomePais,
							email: cteRecebedorModel.email,
						),
					),
				);
			}
			return cteRecebedorGroupedList;
		}
		return [];
	}

	List<CteDestinatarioGrouped> cteDestinatarioModelToDrift(List<CteDestinatarioModel>? cteDestinatarioModelList) { 
		List<CteDestinatarioGrouped> cteDestinatarioGroupedList = [];
		if (cteDestinatarioModelList != null) {
			for (var cteDestinatarioModel in cteDestinatarioModelList) {
				cteDestinatarioGroupedList.add(
					CteDestinatarioGrouped(
						cteDestinatario: CteDestinatario(
							id: cteDestinatarioModel.id,
							idCteCabecalho: cteDestinatarioModel.idCteCabecalho,
							cnpj: Util.removeMask(cteDestinatarioModel.cnpj),
							cpf: Util.removeMask(cteDestinatarioModel.cpf),
							ie: cteDestinatarioModel.ie,
							nome: cteDestinatarioModel.nome,
							fantasia: cteDestinatarioModel.fantasia,
							telefone: cteDestinatarioModel.telefone,
							logradouro: cteDestinatarioModel.logradouro,
							numero: cteDestinatarioModel.numero,
							complemento: cteDestinatarioModel.complemento,
							bairro: cteDestinatarioModel.bairro,
							codigoMunicipio: cteDestinatarioModel.codigoMunicipio,
							nomeMunicipio: cteDestinatarioModel.nomeMunicipio,
							uf: CteDestinatarioDomain.setUf(cteDestinatarioModel.uf),
							cep: Util.removeMask(cteDestinatarioModel.cep),
							codigoPais: cteDestinatarioModel.codigoPais,
							nomePais: cteDestinatarioModel.nomePais,
							email: cteDestinatarioModel.email,
						),
					),
				);
			}
			return cteDestinatarioGroupedList;
		}
		return [];
	}

	List<CteLocalEntregaGrouped> cteLocalEntregaModelToDrift(List<CteLocalEntregaModel>? cteLocalEntregaModelList) { 
		List<CteLocalEntregaGrouped> cteLocalEntregaGroupedList = [];
		if (cteLocalEntregaModelList != null) {
			for (var cteLocalEntregaModel in cteLocalEntregaModelList) {
				cteLocalEntregaGroupedList.add(
					CteLocalEntregaGrouped(
						cteLocalEntrega: CteLocalEntrega(
							id: cteLocalEntregaModel.id,
							idCteCabecalho: cteLocalEntregaModel.idCteCabecalho,
							cnpj: Util.removeMask(cteLocalEntregaModel.cnpj),
							cpf: Util.removeMask(cteLocalEntregaModel.cpf),
							nome: cteLocalEntregaModel.nome,
							logradouro: cteLocalEntregaModel.logradouro,
							numero: cteLocalEntregaModel.numero,
							complemento: cteLocalEntregaModel.complemento,
							bairro: cteLocalEntregaModel.bairro,
							codigoMunicipio: cteLocalEntregaModel.codigoMunicipio,
							nomeMunicipio: cteLocalEntregaModel.nomeMunicipio,
							uf: CteLocalEntregaDomain.setUf(cteLocalEntregaModel.uf),
						),
					),
				);
			}
			return cteLocalEntregaGroupedList;
		}
		return [];
	}

	List<CteComponenteGrouped> cteComponenteModelToDrift(List<CteComponenteModel>? cteComponenteModelList) { 
		List<CteComponenteGrouped> cteComponenteGroupedList = [];
		if (cteComponenteModelList != null) {
			for (var cteComponenteModel in cteComponenteModelList) {
				cteComponenteGroupedList.add(
					CteComponenteGrouped(
						cteComponente: CteComponente(
							id: cteComponenteModel.id,
							idCteCabecalho: cteComponenteModel.idCteCabecalho,
							nome: cteComponenteModel.nome,
							valor: cteComponenteModel.valor,
						),
					),
				);
			}
			return cteComponenteGroupedList;
		}
		return [];
	}

	List<CteCargaGrouped> cteCargaModelToDrift(List<CteCargaModel>? cteCargaModelList) { 
		List<CteCargaGrouped> cteCargaGroupedList = [];
		if (cteCargaModelList != null) {
			for (var cteCargaModel in cteCargaModelList) {
				cteCargaGroupedList.add(
					CteCargaGrouped(
						cteCarga: CteCarga(
							id: cteCargaModel.id,
							idCteCabecalho: cteCargaModel.idCteCabecalho,
							codigoUnidadeMedida: CteCargaDomain.setCodigoUnidadeMedida(cteCargaModel.codigoUnidadeMedida),
							tipoMedida: cteCargaModel.tipoMedida,
							quantidade: cteCargaModel.quantidade,
						),
					),
				);
			}
			return cteCargaGroupedList;
		}
		return [];
	}

	List<CteInformacaoNfOutrosGrouped> cteInformacaoNfOutrosModelToDrift(List<CteInformacaoNfOutrosModel>? cteInformacaoNfOutrosModelList) { 
		List<CteInformacaoNfOutrosGrouped> cteInformacaoNfOutrosGroupedList = [];
		if (cteInformacaoNfOutrosModelList != null) {
			for (var cteInformacaoNfOutrosModel in cteInformacaoNfOutrosModelList) {
				cteInformacaoNfOutrosGroupedList.add(
					CteInformacaoNfOutrosGrouped(
						cteInformacaoNfOutros: CteInformacaoNfOutros(
							id: cteInformacaoNfOutrosModel.id,
							idCteCabecalho: cteInformacaoNfOutrosModel.idCteCabecalho,
							numeroRomaneio: cteInformacaoNfOutrosModel.numeroRomaneio,
							numeroPedido: cteInformacaoNfOutrosModel.numeroPedido,
							chaveAcessoNfe: cteInformacaoNfOutrosModel.chaveAcessoNfe,
							codigoModelo: CteInformacaoNfOutrosDomain.setCodigoModelo(cteInformacaoNfOutrosModel.codigoModelo),
							serie: CteInformacaoNfOutrosDomain.setSerie(cteInformacaoNfOutrosModel.serie),
							numero: cteInformacaoNfOutrosModel.numero,
							dataEmissao: cteInformacaoNfOutrosModel.dataEmissao,
							ufEmitente: cteInformacaoNfOutrosModel.ufEmitente,
							baseCalculoIcms: cteInformacaoNfOutrosModel.baseCalculoIcms,
							valorIcms: cteInformacaoNfOutrosModel.valorIcms,
							baseCalculoIcmsSt: cteInformacaoNfOutrosModel.baseCalculoIcmsSt,
							valorIcmsSt: cteInformacaoNfOutrosModel.valorIcmsSt,
							valorTotalProdutos: cteInformacaoNfOutrosModel.valorTotalProdutos,
							valorTotal: cteInformacaoNfOutrosModel.valorTotal,
							cfopPredominante: cteInformacaoNfOutrosModel.cfopPredominante,
							pesoTotalKg: cteInformacaoNfOutrosModel.pesoTotalKg,
							pinSuframa: cteInformacaoNfOutrosModel.pinSuframa,
							dataPrevistaEntrega: cteInformacaoNfOutrosModel.dataPrevistaEntrega,
							outroTipoDocOrig: CteInformacaoNfOutrosDomain.setOutroTipoDocOrig(cteInformacaoNfOutrosModel.outroTipoDocOrig),
							outroDescricao: cteInformacaoNfOutrosModel.outroDescricao,
							outroValorDocumento: cteInformacaoNfOutrosModel.outroValorDocumento,
						),
					),
				);
			}
			return cteInformacaoNfOutrosGroupedList;
		}
		return [];
	}

	List<CteSeguroGrouped> cteSeguroModelToDrift(List<CteSeguroModel>? cteSeguroModelList) { 
		List<CteSeguroGrouped> cteSeguroGroupedList = [];
		if (cteSeguroModelList != null) {
			for (var cteSeguroModel in cteSeguroModelList) {
				cteSeguroGroupedList.add(
					CteSeguroGrouped(
						cteSeguro: CteSeguro(
							id: cteSeguroModel.id,
							idCteCabecalho: cteSeguroModel.idCteCabecalho,
							responsavel: CteSeguroDomain.setResponsavel(cteSeguroModel.responsavel),
							seguradora: cteSeguroModel.seguradora,
							apolice: cteSeguroModel.apolice,
							averbacao: cteSeguroModel.averbacao,
							valorCarga: cteSeguroModel.valorCarga,
						),
					),
				);
			}
			return cteSeguroGroupedList;
		}
		return [];
	}

	List<CtePerigosoGrouped> ctePerigosoModelToDrift(List<CtePerigosoModel>? ctePerigosoModelList) { 
		List<CtePerigosoGrouped> ctePerigosoGroupedList = [];
		if (ctePerigosoModelList != null) {
			for (var ctePerigosoModel in ctePerigosoModelList) {
				ctePerigosoGroupedList.add(
					CtePerigosoGrouped(
						ctePerigoso: CtePerigoso(
							id: ctePerigosoModel.id,
							idCteCabecalho: ctePerigosoModel.idCteCabecalho,
							numeroOnu: ctePerigosoModel.numeroOnu,
							nomeApropriado: ctePerigosoModel.nomeApropriado,
							classeRisco: ctePerigosoModel.classeRisco,
							grupoEmbalagem: ctePerigosoModel.grupoEmbalagem,
							quantidadeTotalProduto: ctePerigosoModel.quantidadeTotalProduto,
							quantidadeTipoVolume: ctePerigosoModel.quantidadeTipoVolume,
							pontoFulgor: ctePerigosoModel.pontoFulgor,
						),
					),
				);
			}
			return ctePerigosoGroupedList;
		}
		return [];
	}

	List<CteVeiculoNovoGrouped> cteVeiculoNovoModelToDrift(List<CteVeiculoNovoModel>? cteVeiculoNovoModelList) { 
		List<CteVeiculoNovoGrouped> cteVeiculoNovoGroupedList = [];
		if (cteVeiculoNovoModelList != null) {
			for (var cteVeiculoNovoModel in cteVeiculoNovoModelList) {
				cteVeiculoNovoGroupedList.add(
					CteVeiculoNovoGrouped(
						cteVeiculoNovo: CteVeiculoNovo(
							id: cteVeiculoNovoModel.id,
							idCteCabecalho: cteVeiculoNovoModel.idCteCabecalho,
							chassi: cteVeiculoNovoModel.chassi,
							cor: cteVeiculoNovoModel.cor,
							descricaoCor: cteVeiculoNovoModel.descricaoCor,
							codigoMarcaModelo: cteVeiculoNovoModel.codigoMarcaModelo,
							valorUnitario: cteVeiculoNovoModel.valorUnitario,
							valorFrete: cteVeiculoNovoModel.valorFrete,
						),
					),
				);
			}
			return cteVeiculoNovoGroupedList;
		}
		return [];
	}

	List<CteFaturaGrouped> cteFaturaModelToDrift(List<CteFaturaModel>? cteFaturaModelList) { 
		List<CteFaturaGrouped> cteFaturaGroupedList = [];
		if (cteFaturaModelList != null) {
			for (var cteFaturaModel in cteFaturaModelList) {
				cteFaturaGroupedList.add(
					CteFaturaGrouped(
						cteFatura: CteFatura(
							id: cteFaturaModel.id,
							idCteCabecalho: cteFaturaModel.idCteCabecalho,
							numero: cteFaturaModel.numero,
							valorOriginal: cteFaturaModel.valorOriginal,
							valorDesconto: cteFaturaModel.valorDesconto,
							valorLiquido: cteFaturaModel.valorLiquido,
						),
					),
				);
			}
			return cteFaturaGroupedList;
		}
		return [];
	}

	List<CteDuplicataGrouped> cteDuplicataModelToDrift(List<CteDuplicataModel>? cteDuplicataModelList) { 
		List<CteDuplicataGrouped> cteDuplicataGroupedList = [];
		if (cteDuplicataModelList != null) {
			for (var cteDuplicataModel in cteDuplicataModelList) {
				cteDuplicataGroupedList.add(
					CteDuplicataGrouped(
						cteDuplicata: CteDuplicata(
							id: cteDuplicataModel.id,
							idCteCabecalho: cteDuplicataModel.idCteCabecalho,
							numero: cteDuplicataModel.numero,
							dataVencimento: cteDuplicataModel.dataVencimento,
							valor: cteDuplicataModel.valor,
						),
					),
				);
			}
			return cteDuplicataGroupedList;
		}
		return [];
	}

	List<CteRodoviarioGrouped> cteRodoviarioModelToDrift(List<CteRodoviarioModel>? cteRodoviarioModelList) { 
		List<CteRodoviarioGrouped> cteRodoviarioGroupedList = [];
		if (cteRodoviarioModelList != null) {
			for (var cteRodoviarioModel in cteRodoviarioModelList) {
				cteRodoviarioGroupedList.add(
					CteRodoviarioGrouped(
						cteRodoviario: CteRodoviario(
							id: cteRodoviarioModel.id,
							idCteCabecalho: cteRodoviarioModel.idCteCabecalho,
							rntrc: cteRodoviarioModel.rntrc,
							dataPrevistaEntrega: cteRodoviarioModel.dataPrevistaEntrega,
							indicadorLotacao: CteRodoviarioDomain.setIndicadorLotacao(cteRodoviarioModel.indicadorLotacao),
							ciot: cteRodoviarioModel.ciot,
						),
					),
				);
			}
			return cteRodoviarioGroupedList;
		}
		return [];
	}

	List<CteAereoGrouped> cteAereoModelToDrift(List<CteAereoModel>? cteAereoModelList) { 
		List<CteAereoGrouped> cteAereoGroupedList = [];
		if (cteAereoModelList != null) {
			for (var cteAereoModel in cteAereoModelList) {
				cteAereoGroupedList.add(
					CteAereoGrouped(
						cteAereo: CteAereo(
							id: cteAereoModel.id,
							idCteCabecalho: cteAereoModel.idCteCabecalho,
							numeroMinuta: cteAereoModel.numeroMinuta,
							numeroConhecimento: cteAereoModel.numeroConhecimento,
							dataPrevistaEntrega: cteAereoModel.dataPrevistaEntrega,
							idEmissor: cteAereoModel.idEmissor,
							idInternaTomador: cteAereoModel.idInternaTomador,
							tarifaClasse: CteAereoDomain.setTarifaClasse(cteAereoModel.tarifaClasse),
							tarifaCodigo: cteAereoModel.tarifaCodigo,
							tarifaValor: cteAereoModel.tarifaValor,
							cargaDimensao: cteAereoModel.cargaDimensao,
							cargaInformacaoManuseio: CteAereoDomain.setCargaInformacaoManuseio(cteAereoModel.cargaInformacaoManuseio),
							cargaEspecial: CteAereoDomain.setCargaEspecial(cteAereoModel.cargaEspecial),
						),
					),
				);
			}
			return cteAereoGroupedList;
		}
		return [];
	}

	List<CteAquaviarioGrouped> cteAquaviarioModelToDrift(List<CteAquaviarioModel>? cteAquaviarioModelList) { 
		List<CteAquaviarioGrouped> cteAquaviarioGroupedList = [];
		if (cteAquaviarioModelList != null) {
			for (var cteAquaviarioModel in cteAquaviarioModelList) {
				cteAquaviarioGroupedList.add(
					CteAquaviarioGrouped(
						cteAquaviario: CteAquaviario(
							id: cteAquaviarioModel.id,
							idCteCabecalho: cteAquaviarioModel.idCteCabecalho,
							valorPrestacao: cteAquaviarioModel.valorPrestacao,
							afrmm: cteAquaviarioModel.afrmm,
							numeroBooking: cteAquaviarioModel.numeroBooking,
							numeroControle: cteAquaviarioModel.numeroControle,
							idNavio: cteAquaviarioModel.idNavio,
						),
					),
				);
			}
			return cteAquaviarioGroupedList;
		}
		return [];
	}

	List<CteFerroviarioGrouped> cteFerroviarioModelToDrift(List<CteFerroviarioModel>? cteFerroviarioModelList) { 
		List<CteFerroviarioGrouped> cteFerroviarioGroupedList = [];
		if (cteFerroviarioModelList != null) {
			for (var cteFerroviarioModel in cteFerroviarioModelList) {
				cteFerroviarioGroupedList.add(
					CteFerroviarioGrouped(
						cteFerroviario: CteFerroviario(
							id: cteFerroviarioModel.id,
							idCteCabecalho: cteFerroviarioModel.idCteCabecalho,
							tipoTrafego: CteFerroviarioDomain.setTipoTrafego(cteFerroviarioModel.tipoTrafego),
							responsavelFaturamento: CteFerroviarioDomain.setResponsavelFaturamento(cteFerroviarioModel.responsavelFaturamento),
							ferroviaEmitenteCte: CteFerroviarioDomain.setFerroviaEmitenteCte(cteFerroviarioModel.ferroviaEmitenteCte),
							fluxo: cteFerroviarioModel.fluxo,
							idTrem: cteFerroviarioModel.idTrem,
							valorFrete: cteFerroviarioModel.valorFrete,
						),
					),
				);
			}
			return cteFerroviarioGroupedList;
		}
		return [];
	}

	List<CteDutoviarioGrouped> cteDutoviarioModelToDrift(List<CteDutoviarioModel>? cteDutoviarioModelList) { 
		List<CteDutoviarioGrouped> cteDutoviarioGroupedList = [];
		if (cteDutoviarioModelList != null) {
			for (var cteDutoviarioModel in cteDutoviarioModelList) {
				cteDutoviarioGroupedList.add(
					CteDutoviarioGrouped(
						cteDutoviario: CteDutoviario(
							id: cteDutoviarioModel.id,
							idCteCabecalho: cteDutoviarioModel.idCteCabecalho,
							valorTarifa: cteDutoviarioModel.valorTarifa,
							dataInicio: cteDutoviarioModel.dataInicio,
							dataFim: cteDutoviarioModel.dataFim,
						),
					),
				);
			}
			return cteDutoviarioGroupedList;
		}
		return [];
	}

	List<CteMultimodalGrouped> cteMultimodalModelToDrift(List<CteMultimodalModel>? cteMultimodalModelList) { 
		List<CteMultimodalGrouped> cteMultimodalGroupedList = [];
		if (cteMultimodalModelList != null) {
			for (var cteMultimodalModel in cteMultimodalModelList) {
				cteMultimodalGroupedList.add(
					CteMultimodalGrouped(
						cteMultimodal: CteMultimodal(
							id: cteMultimodalModel.id,
							idCteCabecalho: cteMultimodalModel.idCteCabecalho,
							cotm: cteMultimodalModel.cotm,
							indicadorNegociavel: CteMultimodalDomain.setIndicadorNegociavel(cteMultimodalModel.indicadorNegociavel),
						),
					),
				);
			}
			return cteMultimodalGroupedList;
		}
		return [];
	}

		
}
