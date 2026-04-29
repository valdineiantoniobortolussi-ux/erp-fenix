import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoHorarioAutorizadoDriftProvider extends ProviderBase {

	Future<List<PontoHorarioAutorizadoModel>?> getList({Filter? filter}) async {
		List<PontoHorarioAutorizadoGrouped> pontoHorarioAutorizadoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoHorarioAutorizadoDriftList = await Session.database.pontoHorarioAutorizadoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoHorarioAutorizadoDriftList = await Session.database.pontoHorarioAutorizadoDao.getGroupedList(); 
			}
			if (pontoHorarioAutorizadoDriftList.isNotEmpty) {
				return toListModel(pontoHorarioAutorizadoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoHorarioAutorizadoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoHorarioAutorizadoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoHorarioAutorizadoModel?>? insert(PontoHorarioAutorizadoModel pontoHorarioAutorizadoModel) async {
		try {
			final lastPk = await Session.database.pontoHorarioAutorizadoDao.insertObject(toDrift(pontoHorarioAutorizadoModel));
			pontoHorarioAutorizadoModel.id = lastPk;
			return pontoHorarioAutorizadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoHorarioAutorizadoModel?>? update(PontoHorarioAutorizadoModel pontoHorarioAutorizadoModel) async {
		try {
			await Session.database.pontoHorarioAutorizadoDao.updateObject(toDrift(pontoHorarioAutorizadoModel));
			return pontoHorarioAutorizadoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoHorarioAutorizadoDao.deleteObject(toDrift(PontoHorarioAutorizadoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoHorarioAutorizadoModel> toListModel(List<PontoHorarioAutorizadoGrouped> pontoHorarioAutorizadoDriftList) {
		List<PontoHorarioAutorizadoModel> listModel = [];
		for (var pontoHorarioAutorizadoDrift in pontoHorarioAutorizadoDriftList) {
			listModel.add(toModel(pontoHorarioAutorizadoDrift)!);
		}
		return listModel;
	}	

	PontoHorarioAutorizadoModel? toModel(PontoHorarioAutorizadoGrouped? pontoHorarioAutorizadoDrift) {
		if (pontoHorarioAutorizadoDrift != null) {
			return PontoHorarioAutorizadoModel(
				id: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.id,
				idColaborador: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.idColaborador,
				dataHorario: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.dataHorario,
				tipo: PontoHorarioAutorizadoDomain.getTipo(pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.tipo),
				cargaHoraria: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.cargaHoraria,
				entrada01: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.entrada01,
				saida01: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.saida01,
				entrada02: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.entrada02,
				saida02: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.saida02,
				entrada03: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.entrada03,
				saida03: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.saida03,
				entrada04: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.entrada04,
				saida04: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.saida04,
				entrada05: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.entrada05,
				saida05: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.saida05,
				horaFechamentoDia: pontoHorarioAutorizadoDrift.pontoHorarioAutorizado?.horaFechamentoDia,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.id,
					nome: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.nome,
					tipo: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.tipo,
					email: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.email,
					site: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.site,
					cpfCnpj: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.rgIe,
					matricula: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.observacao,
					logradouro: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.logradouro,
					numero: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.numero,
					complemento: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.complemento,
					bairro: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.bairro,
					cidade: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.cidade,
					cep: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.cep,
					municipioIbge: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.municipioIbge,
					uf: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.uf,
					idPessoa: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.idCargo,
					idSetor: pontoHorarioAutorizadoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}


	PontoHorarioAutorizadoGrouped toDrift(PontoHorarioAutorizadoModel pontoHorarioAutorizadoModel) {
		return PontoHorarioAutorizadoGrouped(
			pontoHorarioAutorizado: PontoHorarioAutorizado(
				id: pontoHorarioAutorizadoModel.id,
				idColaborador: pontoHorarioAutorizadoModel.idColaborador,
				dataHorario: pontoHorarioAutorizadoModel.dataHorario,
				tipo: PontoHorarioAutorizadoDomain.setTipo(pontoHorarioAutorizadoModel.tipo),
				cargaHoraria: Util.removeMask(pontoHorarioAutorizadoModel.cargaHoraria),
				entrada01: Util.removeMask(pontoHorarioAutorizadoModel.entrada01),
				saida01: Util.removeMask(pontoHorarioAutorizadoModel.saida01),
				entrada02: Util.removeMask(pontoHorarioAutorizadoModel.entrada02),
				saida02: Util.removeMask(pontoHorarioAutorizadoModel.saida02),
				entrada03: Util.removeMask(pontoHorarioAutorizadoModel.entrada03),
				saida03: Util.removeMask(pontoHorarioAutorizadoModel.saida03),
				entrada04: Util.removeMask(pontoHorarioAutorizadoModel.entrada04),
				saida04: Util.removeMask(pontoHorarioAutorizadoModel.saida04),
				entrada05: Util.removeMask(pontoHorarioAutorizadoModel.entrada05),
				saida05: Util.removeMask(pontoHorarioAutorizadoModel.saida05),
				horaFechamentoDia: Util.removeMask(pontoHorarioAutorizadoModel.horaFechamentoDia),
			),
		);
	}

		
}
