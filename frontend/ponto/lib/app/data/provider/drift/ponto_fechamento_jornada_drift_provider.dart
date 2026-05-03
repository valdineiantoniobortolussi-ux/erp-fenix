import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoFechamentoJornadaDriftProvider extends ProviderBase {

	Future<List<PontoFechamentoJornadaModel>?> getList({Filter? filter}) async {
		List<PontoFechamentoJornadaGrouped> pontoFechamentoJornadaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoFechamentoJornadaDriftList = await Session.database.pontoFechamentoJornadaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoFechamentoJornadaDriftList = await Session.database.pontoFechamentoJornadaDao.getGroupedList(); 
			}
			if (pontoFechamentoJornadaDriftList.isNotEmpty) {
				return toListModel(pontoFechamentoJornadaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoFechamentoJornadaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoFechamentoJornadaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoFechamentoJornadaModel?>? insert(PontoFechamentoJornadaModel pontoFechamentoJornadaModel) async {
		try {
			final lastPk = await Session.database.pontoFechamentoJornadaDao.insertObject(toDrift(pontoFechamentoJornadaModel));
			pontoFechamentoJornadaModel.id = lastPk;
			return pontoFechamentoJornadaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoFechamentoJornadaModel?>? update(PontoFechamentoJornadaModel pontoFechamentoJornadaModel) async {
		try {
			await Session.database.pontoFechamentoJornadaDao.updateObject(toDrift(pontoFechamentoJornadaModel));
			return pontoFechamentoJornadaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoFechamentoJornadaDao.deleteObject(toDrift(PontoFechamentoJornadaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoFechamentoJornadaModel> toListModel(List<PontoFechamentoJornadaGrouped> pontoFechamentoJornadaDriftList) {
		List<PontoFechamentoJornadaModel> listModel = [];
		for (var pontoFechamentoJornadaDrift in pontoFechamentoJornadaDriftList) {
			listModel.add(toModel(pontoFechamentoJornadaDrift)!);
		}
		return listModel;
	}	

	PontoFechamentoJornadaModel? toModel(PontoFechamentoJornadaGrouped? pontoFechamentoJornadaDrift) {
		if (pontoFechamentoJornadaDrift != null) {
			return PontoFechamentoJornadaModel(
				id: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.id,
				idPontoClassificacaoJornada: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.idPontoClassificacaoJornada,
				idColaborador: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.idColaborador,
				dataFechamento: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.dataFechamento,
				diaSemana: PontoFechamentoJornadaDomain.getDiaSemana(pontoFechamentoJornadaDrift.pontoFechamentoJornada?.diaSemana),
				codigoHorario: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.codigoHorario,
				cargaHorariaEsperada: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.cargaHorariaEsperada,
				cargaHorariaDiurna: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.cargaHorariaDiurna,
				cargaHorariaNoturna: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.cargaHorariaNoturna,
				cargaHorariaTotal: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.cargaHorariaTotal,
				entrada01: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.entrada01,
				saida01: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.saida01,
				entrada02: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.entrada02,
				saida02: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.saida02,
				entrada03: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.entrada03,
				saida03: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.saida03,
				entrada04: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.entrada04,
				saida04: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.saida04,
				entrada05: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.entrada05,
				saida05: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.saida05,
				horaInicioJornada: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.horaInicioJornada,
				horaFimJornada: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.horaFimJornada,
				horaExtra01: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.horaExtra01,
				percentualHoraExtra01: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.percentualHoraExtra01,
				modalidadeHoraExtra01: PontoFechamentoJornadaDomain.getModalidadeHoraExtra01(pontoFechamentoJornadaDrift.pontoFechamentoJornada?.modalidadeHoraExtra01),
				horaExtra02: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.horaExtra02,
				percentualHoraExtra02: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.percentualHoraExtra02,
				modalidadeHoraExtra02: PontoFechamentoJornadaDomain.getModalidadeHoraExtra02(pontoFechamentoJornadaDrift.pontoFechamentoJornada?.modalidadeHoraExtra02),
				horaExtra03: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.horaExtra03,
				percentualHoraExtra03: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.percentualHoraExtra03,
				modalidadeHoraExtra03: PontoFechamentoJornadaDomain.getModalidadeHoraExtra03(pontoFechamentoJornadaDrift.pontoFechamentoJornada?.modalidadeHoraExtra03),
				horaExtra04: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.horaExtra04,
				percentualHoraExtra04: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.percentualHoraExtra04,
				modalidadeHoraExtra04: PontoFechamentoJornadaDomain.getModalidadeHoraExtra04(pontoFechamentoJornadaDrift.pontoFechamentoJornada?.modalidadeHoraExtra04),
				faltaAtraso: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.faltaAtraso,
				compensar: PontoFechamentoJornadaDomain.getCompensar(pontoFechamentoJornadaDrift.pontoFechamentoJornada?.compensar),
				bancoHoras: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.bancoHoras,
				observacao: pontoFechamentoJornadaDrift.pontoFechamentoJornada?.observacao,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: pontoFechamentoJornadaDrift.viewPessoaColaborador?.id,
					nome: pontoFechamentoJornadaDrift.viewPessoaColaborador?.nome,
					tipo: pontoFechamentoJornadaDrift.viewPessoaColaborador?.tipo,
					email: pontoFechamentoJornadaDrift.viewPessoaColaborador?.email,
					site: pontoFechamentoJornadaDrift.viewPessoaColaborador?.site,
					cpfCnpj: pontoFechamentoJornadaDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: pontoFechamentoJornadaDrift.viewPessoaColaborador?.rgIe,
					matricula: pontoFechamentoJornadaDrift.viewPessoaColaborador?.matricula,
					dataCadastro: pontoFechamentoJornadaDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: pontoFechamentoJornadaDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: pontoFechamentoJornadaDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: pontoFechamentoJornadaDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: pontoFechamentoJornadaDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: pontoFechamentoJornadaDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: pontoFechamentoJornadaDrift.viewPessoaColaborador?.ctpsUf,
					observacao: pontoFechamentoJornadaDrift.viewPessoaColaborador?.observacao,
					logradouro: pontoFechamentoJornadaDrift.viewPessoaColaborador?.logradouro,
					numero: pontoFechamentoJornadaDrift.viewPessoaColaborador?.numero,
					complemento: pontoFechamentoJornadaDrift.viewPessoaColaborador?.complemento,
					bairro: pontoFechamentoJornadaDrift.viewPessoaColaborador?.bairro,
					cidade: pontoFechamentoJornadaDrift.viewPessoaColaborador?.cidade,
					cep: pontoFechamentoJornadaDrift.viewPessoaColaborador?.cep,
					municipioIbge: pontoFechamentoJornadaDrift.viewPessoaColaborador?.municipioIbge,
					uf: pontoFechamentoJornadaDrift.viewPessoaColaborador?.uf,
					idPessoa: pontoFechamentoJornadaDrift.viewPessoaColaborador?.idPessoa,
					idCargo: pontoFechamentoJornadaDrift.viewPessoaColaborador?.idCargo,
					idSetor: pontoFechamentoJornadaDrift.viewPessoaColaborador?.idSetor,
				),
				pontoClassificacaoJornadaModel: PontoClassificacaoJornadaModel(
					id: pontoFechamentoJornadaDrift.pontoClassificacaoJornada?.id,
					codigo: pontoFechamentoJornadaDrift.pontoClassificacaoJornada?.codigo,
					nome: pontoFechamentoJornadaDrift.pontoClassificacaoJornada?.nome,
					descricao: pontoFechamentoJornadaDrift.pontoClassificacaoJornada?.descricao,
					padrao: pontoFechamentoJornadaDrift.pontoClassificacaoJornada?.padrao,
					descontarHoras: pontoFechamentoJornadaDrift.pontoClassificacaoJornada?.descontarHoras,
				),
			);
		} else {
			return null;
		}
	}


	PontoFechamentoJornadaGrouped toDrift(PontoFechamentoJornadaModel pontoFechamentoJornadaModel) {
		return PontoFechamentoJornadaGrouped(
			pontoFechamentoJornada: PontoFechamentoJornada(
				id: pontoFechamentoJornadaModel.id,
				idPontoClassificacaoJornada: pontoFechamentoJornadaModel.idPontoClassificacaoJornada,
				idColaborador: pontoFechamentoJornadaModel.idColaborador,
				dataFechamento: pontoFechamentoJornadaModel.dataFechamento,
				diaSemana: PontoFechamentoJornadaDomain.setDiaSemana(pontoFechamentoJornadaModel.diaSemana),
				codigoHorario: pontoFechamentoJornadaModel.codigoHorario,
				cargaHorariaEsperada: Util.removeMask(pontoFechamentoJornadaModel.cargaHorariaEsperada),
				cargaHorariaDiurna: Util.removeMask(pontoFechamentoJornadaModel.cargaHorariaDiurna),
				cargaHorariaNoturna: Util.removeMask(pontoFechamentoJornadaModel.cargaHorariaNoturna),
				cargaHorariaTotal: Util.removeMask(pontoFechamentoJornadaModel.cargaHorariaTotal),
				entrada01: Util.removeMask(pontoFechamentoJornadaModel.entrada01),
				saida01: Util.removeMask(pontoFechamentoJornadaModel.saida01),
				entrada02: Util.removeMask(pontoFechamentoJornadaModel.entrada02),
				saida02: Util.removeMask(pontoFechamentoJornadaModel.saida02),
				entrada03: Util.removeMask(pontoFechamentoJornadaModel.entrada03),
				saida03: Util.removeMask(pontoFechamentoJornadaModel.saida03),
				entrada04: Util.removeMask(pontoFechamentoJornadaModel.entrada04),
				saida04: Util.removeMask(pontoFechamentoJornadaModel.saida04),
				entrada05: Util.removeMask(pontoFechamentoJornadaModel.entrada05),
				saida05: Util.removeMask(pontoFechamentoJornadaModel.saida05),
				horaInicioJornada: Util.removeMask(pontoFechamentoJornadaModel.horaInicioJornada),
				horaFimJornada: Util.removeMask(pontoFechamentoJornadaModel.horaFimJornada),
				horaExtra01: Util.removeMask(pontoFechamentoJornadaModel.horaExtra01),
				percentualHoraExtra01: pontoFechamentoJornadaModel.percentualHoraExtra01,
				modalidadeHoraExtra01: PontoFechamentoJornadaDomain.setModalidadeHoraExtra01(pontoFechamentoJornadaModel.modalidadeHoraExtra01),
				horaExtra02: Util.removeMask(pontoFechamentoJornadaModel.horaExtra02),
				percentualHoraExtra02: pontoFechamentoJornadaModel.percentualHoraExtra02,
				modalidadeHoraExtra02: PontoFechamentoJornadaDomain.setModalidadeHoraExtra02(pontoFechamentoJornadaModel.modalidadeHoraExtra02),
				horaExtra03: Util.removeMask(pontoFechamentoJornadaModel.horaExtra03),
				percentualHoraExtra03: pontoFechamentoJornadaModel.percentualHoraExtra03,
				modalidadeHoraExtra03: PontoFechamentoJornadaDomain.setModalidadeHoraExtra03(pontoFechamentoJornadaModel.modalidadeHoraExtra03),
				horaExtra04: Util.removeMask(pontoFechamentoJornadaModel.horaExtra04),
				percentualHoraExtra04: pontoFechamentoJornadaModel.percentualHoraExtra04,
				modalidadeHoraExtra04: PontoFechamentoJornadaDomain.setModalidadeHoraExtra04(pontoFechamentoJornadaModel.modalidadeHoraExtra04),
				faltaAtraso: Util.removeMask(pontoFechamentoJornadaModel.faltaAtraso),
				compensar: PontoFechamentoJornadaDomain.setCompensar(pontoFechamentoJornadaModel.compensar),
				bancoHoras: Util.removeMask(pontoFechamentoJornadaModel.bancoHoras),
				observacao: pontoFechamentoJornadaModel.observacao,
			),
		);
	}

		
}
