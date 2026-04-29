import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilParametroDriftProvider extends ProviderBase {

	Future<List<ContabilParametroModel>?> getList({Filter? filter}) async {
		List<ContabilParametroGrouped> contabilParametroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilParametroDriftList = await Session.database.contabilParametroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilParametroDriftList = await Session.database.contabilParametroDao.getGroupedList(); 
			}
			if (contabilParametroDriftList.isNotEmpty) {
				return toListModel(contabilParametroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilParametroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilParametroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilParametroModel?>? insert(ContabilParametroModel contabilParametroModel) async {
		try {
			final lastPk = await Session.database.contabilParametroDao.insertObject(toDrift(contabilParametroModel));
			contabilParametroModel.id = lastPk;
			return contabilParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilParametroModel?>? update(ContabilParametroModel contabilParametroModel) async {
		try {
			await Session.database.contabilParametroDao.updateObject(toDrift(contabilParametroModel));
			return contabilParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilParametroDao.deleteObject(toDrift(ContabilParametroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilParametroModel> toListModel(List<ContabilParametroGrouped> contabilParametroDriftList) {
		List<ContabilParametroModel> listModel = [];
		for (var contabilParametroDrift in contabilParametroDriftList) {
			listModel.add(toModel(contabilParametroDrift)!);
		}
		return listModel;
	}	

	ContabilParametroModel? toModel(ContabilParametroGrouped? contabilParametroDrift) {
		if (contabilParametroDrift != null) {
			return ContabilParametroModel(
				id: contabilParametroDrift.contabilParametro?.id,
				mascara: contabilParametroDrift.contabilParametro?.mascara,
				niveis: contabilParametroDrift.contabilParametro?.niveis,
				informarContaPor: ContabilParametroDomain.getInformarContaPor(contabilParametroDrift.contabilParametro?.informarContaPor),
				compartilhaPlanoConta: ContabilParametroDomain.getCompartilhaPlanoConta(contabilParametroDrift.contabilParametro?.compartilhaPlanoConta),
				compartilhaHistoricos: ContabilParametroDomain.getCompartilhaHistoricos(contabilParametroDrift.contabilParametro?.compartilhaHistoricos),
				alteraLancamentoOutro: ContabilParametroDomain.getAlteraLancamentoOutro(contabilParametroDrift.contabilParametro?.alteraLancamentoOutro),
				historicoObrigatorio: ContabilParametroDomain.getHistoricoObrigatorio(contabilParametroDrift.contabilParametro?.historicoObrigatorio),
				permiteLancamentoZerado: ContabilParametroDomain.getPermiteLancamentoZerado(contabilParametroDrift.contabilParametro?.permiteLancamentoZerado),
				geraInformativoSped: ContabilParametroDomain.getGeraInformativoSped(contabilParametroDrift.contabilParametro?.geraInformativoSped),
				spedFormaEscritDiario: ContabilParametroDomain.getSpedFormaEscritDiario(contabilParametroDrift.contabilParametro?.spedFormaEscritDiario),
				spedNomeLivroDiario: contabilParametroDrift.contabilParametro?.spedNomeLivroDiario,
				assinaturaDireita: contabilParametroDrift.contabilParametro?.assinaturaDireita,
				assinaturaEsquerda: contabilParametroDrift.contabilParametro?.assinaturaEsquerda,
				contaAtivo: contabilParametroDrift.contabilParametro?.contaAtivo,
				contaPassivo: contabilParametroDrift.contabilParametro?.contaPassivo,
				contaPatrimonioLiquido: contabilParametroDrift.contabilParametro?.contaPatrimonioLiquido,
				contaDepreciacaoAcumulada: contabilParametroDrift.contabilParametro?.contaDepreciacaoAcumulada,
				contaCapitalSocial: contabilParametroDrift.contabilParametro?.contaCapitalSocial,
				contaResultadoExercicio: contabilParametroDrift.contabilParametro?.contaResultadoExercicio,
				contaPrejuizoAcumulado: contabilParametroDrift.contabilParametro?.contaPrejuizoAcumulado,
				contaLucroAcumulado: contabilParametroDrift.contabilParametro?.contaLucroAcumulado,
				contaTituloPagar: contabilParametroDrift.contabilParametro?.contaTituloPagar,
				contaTituloReceber: contabilParametroDrift.contabilParametro?.contaTituloReceber,
				contaJurosPassivo: contabilParametroDrift.contabilParametro?.contaJurosPassivo,
				contaJurosAtivo: contabilParametroDrift.contabilParametro?.contaJurosAtivo,
				contaDescontoObtido: contabilParametroDrift.contabilParametro?.contaDescontoObtido,
				contaDescontoConcedido: contabilParametroDrift.contabilParametro?.contaDescontoConcedido,
				contaCmv: contabilParametroDrift.contabilParametro?.contaCmv,
				contaVenda: contabilParametroDrift.contabilParametro?.contaVenda,
				contaVendaServico: contabilParametroDrift.contabilParametro?.contaVendaServico,
				contaEstoque: contabilParametroDrift.contabilParametro?.contaEstoque,
				contaApuraResultado: contabilParametroDrift.contabilParametro?.contaApuraResultado,
				contaJurosApropriar: contabilParametroDrift.contabilParametro?.contaJurosApropriar,
				idHistPadraoResultado: contabilParametroDrift.contabilParametro?.idHistPadraoResultado,
				idHistPadraoLucro: contabilParametroDrift.contabilParametro?.idHistPadraoLucro,
				idHistPadraoPrejuizo: contabilParametroDrift.contabilParametro?.idHistPadraoPrejuizo,
			);
		} else {
			return null;
		}
	}


	ContabilParametroGrouped toDrift(ContabilParametroModel contabilParametroModel) {
		return ContabilParametroGrouped(
			contabilParametro: ContabilParametro(
				id: contabilParametroModel.id,
				mascara: contabilParametroModel.mascara,
				niveis: contabilParametroModel.niveis,
				informarContaPor: ContabilParametroDomain.setInformarContaPor(contabilParametroModel.informarContaPor),
				compartilhaPlanoConta: ContabilParametroDomain.setCompartilhaPlanoConta(contabilParametroModel.compartilhaPlanoConta),
				compartilhaHistoricos: ContabilParametroDomain.setCompartilhaHistoricos(contabilParametroModel.compartilhaHistoricos),
				alteraLancamentoOutro: ContabilParametroDomain.setAlteraLancamentoOutro(contabilParametroModel.alteraLancamentoOutro),
				historicoObrigatorio: ContabilParametroDomain.setHistoricoObrigatorio(contabilParametroModel.historicoObrigatorio),
				permiteLancamentoZerado: ContabilParametroDomain.setPermiteLancamentoZerado(contabilParametroModel.permiteLancamentoZerado),
				geraInformativoSped: ContabilParametroDomain.setGeraInformativoSped(contabilParametroModel.geraInformativoSped),
				spedFormaEscritDiario: ContabilParametroDomain.setSpedFormaEscritDiario(contabilParametroModel.spedFormaEscritDiario),
				spedNomeLivroDiario: contabilParametroModel.spedNomeLivroDiario,
				assinaturaDireita: contabilParametroModel.assinaturaDireita,
				assinaturaEsquerda: contabilParametroModel.assinaturaEsquerda,
				contaAtivo: contabilParametroModel.contaAtivo,
				contaPassivo: contabilParametroModel.contaPassivo,
				contaPatrimonioLiquido: contabilParametroModel.contaPatrimonioLiquido,
				contaDepreciacaoAcumulada: contabilParametroModel.contaDepreciacaoAcumulada,
				contaCapitalSocial: contabilParametroModel.contaCapitalSocial,
				contaResultadoExercicio: contabilParametroModel.contaResultadoExercicio,
				contaPrejuizoAcumulado: contabilParametroModel.contaPrejuizoAcumulado,
				contaLucroAcumulado: contabilParametroModel.contaLucroAcumulado,
				contaTituloPagar: contabilParametroModel.contaTituloPagar,
				contaTituloReceber: contabilParametroModel.contaTituloReceber,
				contaJurosPassivo: contabilParametroModel.contaJurosPassivo,
				contaJurosAtivo: contabilParametroModel.contaJurosAtivo,
				contaDescontoObtido: contabilParametroModel.contaDescontoObtido,
				contaDescontoConcedido: contabilParametroModel.contaDescontoConcedido,
				contaCmv: contabilParametroModel.contaCmv,
				contaVenda: contabilParametroModel.contaVenda,
				contaVendaServico: contabilParametroModel.contaVendaServico,
				contaEstoque: contabilParametroModel.contaEstoque,
				contaApuraResultado: contabilParametroModel.contaApuraResultado,
				contaJurosApropriar: contabilParametroModel.contaJurosApropriar,
				idHistPadraoResultado: contabilParametroModel.idHistPadraoResultado,
				idHistPadraoLucro: contabilParametroModel.idHistPadraoLucro,
				idHistPadraoPrejuizo: contabilParametroModel.idHistPadraoPrejuizo,
			),
		);
	}

		
}
