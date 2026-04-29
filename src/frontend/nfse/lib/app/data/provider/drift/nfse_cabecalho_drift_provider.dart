import 'package:nfse/app/data/provider/drift/database/database_imports.dart';
import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/data/provider/provider_base.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';
import 'package:nfse/app/data/model/model_imports.dart';
import 'package:nfse/app/data/domain/domain_imports.dart';

class NfseCabecalhoDriftProvider extends ProviderBase {

	Future<List<NfseCabecalhoModel>?> getList({Filter? filter}) async {
		List<NfseCabecalhoGrouped> nfseCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfseCabecalhoDriftList = await Session.database.nfseCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfseCabecalhoDriftList = await Session.database.nfseCabecalhoDao.getGroupedList(); 
			}
			if (nfseCabecalhoDriftList.isNotEmpty) {
				return toListModel(nfseCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfseCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfseCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfseCabecalhoModel?>? insert(NfseCabecalhoModel nfseCabecalhoModel) async {
		try {
			final lastPk = await Session.database.nfseCabecalhoDao.insertObject(toDrift(nfseCabecalhoModel));
			nfseCabecalhoModel.id = lastPk;
			return nfseCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfseCabecalhoModel?>? update(NfseCabecalhoModel nfseCabecalhoModel) async {
		try {
			await Session.database.nfseCabecalhoDao.updateObject(toDrift(nfseCabecalhoModel));
			return nfseCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfseCabecalhoDao.deleteObject(toDrift(NfseCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfseCabecalhoModel> toListModel(List<NfseCabecalhoGrouped> nfseCabecalhoDriftList) {
		List<NfseCabecalhoModel> listModel = [];
		for (var nfseCabecalhoDrift in nfseCabecalhoDriftList) {
			listModel.add(toModel(nfseCabecalhoDrift)!);
		}
		return listModel;
	}	

	NfseCabecalhoModel? toModel(NfseCabecalhoGrouped? nfseCabecalhoDrift) {
		if (nfseCabecalhoDrift != null) {
			return NfseCabecalhoModel(
				id: nfseCabecalhoDrift.nfseCabecalho?.id,
				idCliente: nfseCabecalhoDrift.nfseCabecalho?.idCliente,
				idOsAbertura: nfseCabecalhoDrift.nfseCabecalho?.idOsAbertura,
				numero: nfseCabecalhoDrift.nfseCabecalho?.numero,
				codigoVerificacao: nfseCabecalhoDrift.nfseCabecalho?.codigoVerificacao,
				dataHoraEmissao: nfseCabecalhoDrift.nfseCabecalho?.dataHoraEmissao,
				competencia: nfseCabecalhoDrift.nfseCabecalho?.competencia,
				numeroSubstituida: nfseCabecalhoDrift.nfseCabecalho?.numeroSubstituida,
				naturezaOperacao: NfseCabecalhoDomain.getNaturezaOperacao(nfseCabecalhoDrift.nfseCabecalho?.naturezaOperacao),
				regimeEspecialTributacao: NfseCabecalhoDomain.getRegimeEspecialTributacao(nfseCabecalhoDrift.nfseCabecalho?.regimeEspecialTributacao),
				optanteSimplesNacional: NfseCabecalhoDomain.getOptanteSimplesNacional(nfseCabecalhoDrift.nfseCabecalho?.optanteSimplesNacional),
				incentivadorCultural: NfseCabecalhoDomain.getIncentivadorCultural(nfseCabecalhoDrift.nfseCabecalho?.incentivadorCultural),
				numeroRps: nfseCabecalhoDrift.nfseCabecalho?.numeroRps,
				serieRps: nfseCabecalhoDrift.nfseCabecalho?.serieRps,
				tipoRps: NfseCabecalhoDomain.getTipoRps(nfseCabecalhoDrift.nfseCabecalho?.tipoRps),
				dataEmissaoRps: nfseCabecalhoDrift.nfseCabecalho?.dataEmissaoRps,
				outrasInformacoes: nfseCabecalhoDrift.nfseCabecalho?.outrasInformacoes,
				nfseDetalheModelList: nfseDetalheDriftToModel(nfseCabecalhoDrift.nfseDetalheGroupedList),
				nfseIntermediarioModelList: nfseIntermediarioDriftToModel(nfseCabecalhoDrift.nfseIntermediarioGroupedList),
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: nfseCabecalhoDrift.viewPessoaCliente?.id,
					nome: nfseCabecalhoDrift.viewPessoaCliente?.nome,
					tipo: nfseCabecalhoDrift.viewPessoaCliente?.tipo,
					email: nfseCabecalhoDrift.viewPessoaCliente?.email,
					site: nfseCabecalhoDrift.viewPessoaCliente?.site,
					cpfCnpj: nfseCabecalhoDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: nfseCabecalhoDrift.viewPessoaCliente?.rgIe,
					desde: nfseCabecalhoDrift.viewPessoaCliente?.desde,
					taxaDesconto: nfseCabecalhoDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: nfseCabecalhoDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: nfseCabecalhoDrift.viewPessoaCliente?.dataCadastro,
					observacao: nfseCabecalhoDrift.viewPessoaCliente?.observacao,
					idPessoa: nfseCabecalhoDrift.viewPessoaCliente?.idPessoa,
				),
				osAberturaModel: OsAberturaModel(
					id: nfseCabecalhoDrift.osAbertura?.id,
					idOsStatus: nfseCabecalhoDrift.osAbertura?.idOsStatus,
					idColaborador: nfseCabecalhoDrift.osAbertura?.idColaborador,
					idCliente: nfseCabecalhoDrift.osAbertura?.idCliente,
					numero: nfseCabecalhoDrift.osAbertura?.numero,
					dataInicio: nfseCabecalhoDrift.osAbertura?.dataInicio,
					horaInicio: nfseCabecalhoDrift.osAbertura?.horaInicio,
					dataPrevisao: nfseCabecalhoDrift.osAbertura?.dataPrevisao,
					horaPrevisao: nfseCabecalhoDrift.osAbertura?.horaPrevisao,
					dataFim: nfseCabecalhoDrift.osAbertura?.dataFim,
					horaFim: nfseCabecalhoDrift.osAbertura?.horaFim,
					nomeContato: nfseCabecalhoDrift.osAbertura?.nomeContato,
					foneContato: nfseCabecalhoDrift.osAbertura?.foneContato,
					observacaoCliente: nfseCabecalhoDrift.osAbertura?.observacaoCliente,
					observacaoAbertura: nfseCabecalhoDrift.osAbertura?.observacaoAbertura,
				),
			);
		} else {
			return null;
		}
	}

	List<NfseDetalheModel> nfseDetalheDriftToModel(List<NfseDetalheGrouped>? nfseDetalheDriftList) { 
		List<NfseDetalheModel> nfseDetalheModelList = [];
		if (nfseDetalheDriftList != null) {
			for (var nfseDetalheGrouped in nfseDetalheDriftList) {
				nfseDetalheModelList.add(
					NfseDetalheModel(
						id: nfseDetalheGrouped.nfseDetalhe?.id,
						idNfseCabecalho: nfseDetalheGrouped.nfseDetalhe?.idNfseCabecalho,
						idNfseListaServico: nfseDetalheGrouped.nfseDetalhe?.idNfseListaServico,
						nfseListaServicoModel: NfseListaServicoModel(
							id: nfseDetalheGrouped.nfseListaServico?.id,
							codigo: nfseDetalheGrouped.nfseListaServico?.codigo,
							descricao: nfseDetalheGrouped.nfseListaServico?.descricao,
						),
						codigoCnae: nfseDetalheGrouped.nfseDetalhe?.codigoCnae,
						codigoTributacaoMunicipio: nfseDetalheGrouped.nfseDetalhe?.codigoTributacaoMunicipio,
						valorServicos: nfseDetalheGrouped.nfseDetalhe?.valorServicos,
						valorDeducoes: nfseDetalheGrouped.nfseDetalhe?.valorDeducoes,
						valorPis: nfseDetalheGrouped.nfseDetalhe?.valorPis,
						valorCofins: nfseDetalheGrouped.nfseDetalhe?.valorCofins,
						valorInss: nfseDetalheGrouped.nfseDetalhe?.valorInss,
						valorIr: nfseDetalheGrouped.nfseDetalhe?.valorIr,
						valorCsll: nfseDetalheGrouped.nfseDetalhe?.valorCsll,
						valorBaseCalculo: nfseDetalheGrouped.nfseDetalhe?.valorBaseCalculo,
						aliquota: nfseDetalheGrouped.nfseDetalhe?.aliquota,
						valorIss: nfseDetalheGrouped.nfseDetalhe?.valorIss,
						valorLiquido: nfseDetalheGrouped.nfseDetalhe?.valorLiquido,
						outrasRetencoes: nfseDetalheGrouped.nfseDetalhe?.outrasRetencoes,
						valorCredito: nfseDetalheGrouped.nfseDetalhe?.valorCredito,
						issRetido: NfseDetalheDomain.getIssRetido(nfseDetalheGrouped.nfseDetalhe?.issRetido),
						valorIssRetido: nfseDetalheGrouped.nfseDetalhe?.valorIssRetido,
						valorDescontoCondicionado: nfseDetalheGrouped.nfseDetalhe?.valorDescontoCondicionado,
						valorDescontoIncondicionado: nfseDetalheGrouped.nfseDetalhe?.valorDescontoIncondicionado,
						municipioPrestacao: nfseDetalheGrouped.nfseDetalhe?.municipioPrestacao,
						discriminacao: nfseDetalheGrouped.nfseDetalhe?.discriminacao,
					)
				);
			}
			return nfseDetalheModelList;
		}
		return [];
	}

	List<NfseIntermediarioModel> nfseIntermediarioDriftToModel(List<NfseIntermediarioGrouped>? nfseIntermediarioDriftList) { 
		List<NfseIntermediarioModel> nfseIntermediarioModelList = [];
		if (nfseIntermediarioDriftList != null) {
			for (var nfseIntermediarioGrouped in nfseIntermediarioDriftList) {
				nfseIntermediarioModelList.add(
					NfseIntermediarioModel(
						id: nfseIntermediarioGrouped.nfseIntermediario?.id,
						idNfseCabecalho: nfseIntermediarioGrouped.nfseIntermediario?.idNfseCabecalho,
						cnpj: nfseIntermediarioGrouped.nfseIntermediario?.cnpj,
						inscricaoMunicipal: nfseIntermediarioGrouped.nfseIntermediario?.inscricaoMunicipal,
						razao: nfseIntermediarioGrouped.nfseIntermediario?.razao,
					)
				);
			}
			return nfseIntermediarioModelList;
		}
		return [];
	}


	NfseCabecalhoGrouped toDrift(NfseCabecalhoModel nfseCabecalhoModel) {
		return NfseCabecalhoGrouped(
			nfseCabecalho: NfseCabecalho(
				id: nfseCabecalhoModel.id,
				idCliente: nfseCabecalhoModel.idCliente,
				idOsAbertura: nfseCabecalhoModel.idOsAbertura,
				numero: nfseCabecalhoModel.numero,
				codigoVerificacao: nfseCabecalhoModel.codigoVerificacao,
				dataHoraEmissao: nfseCabecalhoModel.dataHoraEmissao,
				competencia: Util.removeMask(nfseCabecalhoModel.competencia),
				numeroSubstituida: nfseCabecalhoModel.numeroSubstituida,
				naturezaOperacao: NfseCabecalhoDomain.setNaturezaOperacao(nfseCabecalhoModel.naturezaOperacao),
				regimeEspecialTributacao: NfseCabecalhoDomain.setRegimeEspecialTributacao(nfseCabecalhoModel.regimeEspecialTributacao),
				optanteSimplesNacional: NfseCabecalhoDomain.setOptanteSimplesNacional(nfseCabecalhoModel.optanteSimplesNacional),
				incentivadorCultural: NfseCabecalhoDomain.setIncentivadorCultural(nfseCabecalhoModel.incentivadorCultural),
				numeroRps: nfseCabecalhoModel.numeroRps,
				serieRps: nfseCabecalhoModel.serieRps,
				tipoRps: NfseCabecalhoDomain.setTipoRps(nfseCabecalhoModel.tipoRps),
				dataEmissaoRps: nfseCabecalhoModel.dataEmissaoRps,
				outrasInformacoes: nfseCabecalhoModel.outrasInformacoes,
			),
			nfseDetalheGroupedList: nfseDetalheModelToDrift(nfseCabecalhoModel.nfseDetalheModelList),
			nfseIntermediarioGroupedList: nfseIntermediarioModelToDrift(nfseCabecalhoModel.nfseIntermediarioModelList),
		);
	}

	List<NfseDetalheGrouped> nfseDetalheModelToDrift(List<NfseDetalheModel>? nfseDetalheModelList) { 
		List<NfseDetalheGrouped> nfseDetalheGroupedList = [];
		if (nfseDetalheModelList != null) {
			for (var nfseDetalheModel in nfseDetalheModelList) {
				nfseDetalheGroupedList.add(
					NfseDetalheGrouped(
						nfseDetalhe: NfseDetalhe(
							id: nfseDetalheModel.id,
							idNfseCabecalho: nfseDetalheModel.idNfseCabecalho,
							idNfseListaServico: nfseDetalheModel.idNfseListaServico,
							codigoCnae: nfseDetalheModel.codigoCnae,
							codigoTributacaoMunicipio: nfseDetalheModel.codigoTributacaoMunicipio,
							valorServicos: nfseDetalheModel.valorServicos,
							valorDeducoes: nfseDetalheModel.valorDeducoes,
							valorPis: nfseDetalheModel.valorPis,
							valorCofins: nfseDetalheModel.valorCofins,
							valorInss: nfseDetalheModel.valorInss,
							valorIr: nfseDetalheModel.valorIr,
							valorCsll: nfseDetalheModel.valorCsll,
							valorBaseCalculo: nfseDetalheModel.valorBaseCalculo,
							aliquota: nfseDetalheModel.aliquota,
							valorIss: nfseDetalheModel.valorIss,
							valorLiquido: nfseDetalheModel.valorLiquido,
							outrasRetencoes: nfseDetalheModel.outrasRetencoes,
							valorCredito: nfseDetalheModel.valorCredito,
							issRetido: NfseDetalheDomain.setIssRetido(nfseDetalheModel.issRetido),
							valorIssRetido: nfseDetalheModel.valorIssRetido,
							valorDescontoCondicionado: nfseDetalheModel.valorDescontoCondicionado,
							valorDescontoIncondicionado: nfseDetalheModel.valorDescontoIncondicionado,
							municipioPrestacao: nfseDetalheModel.municipioPrestacao,
							discriminacao: nfseDetalheModel.discriminacao,
						),
					),
				);
			}
			return nfseDetalheGroupedList;
		}
		return [];
	}

	List<NfseIntermediarioGrouped> nfseIntermediarioModelToDrift(List<NfseIntermediarioModel>? nfseIntermediarioModelList) { 
		List<NfseIntermediarioGrouped> nfseIntermediarioGroupedList = [];
		if (nfseIntermediarioModelList != null) {
			for (var nfseIntermediarioModel in nfseIntermediarioModelList) {
				nfseIntermediarioGroupedList.add(
					NfseIntermediarioGrouped(
						nfseIntermediario: NfseIntermediario(
							id: nfseIntermediarioModel.id,
							idNfseCabecalho: nfseIntermediarioModel.idNfseCabecalho,
							cnpj: Util.removeMask(nfseIntermediarioModel.cnpj),
							inscricaoMunicipal: nfseIntermediarioModel.inscricaoMunicipal,
							razao: nfseIntermediarioModel.razao,
						),
					),
				);
			}
			return nfseIntermediarioGroupedList;
		}
		return [];
	}

		
}
