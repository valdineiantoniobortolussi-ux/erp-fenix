import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FeriasPeriodoAquisitivoDriftProvider extends ProviderBase {

	Future<List<FeriasPeriodoAquisitivoModel>?> getList({Filter? filter}) async {
		List<FeriasPeriodoAquisitivoGrouped> feriasPeriodoAquisitivoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				feriasPeriodoAquisitivoDriftList = await Session.database.feriasPeriodoAquisitivoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				feriasPeriodoAquisitivoDriftList = await Session.database.feriasPeriodoAquisitivoDao.getGroupedList(); 
			}
			if (feriasPeriodoAquisitivoDriftList.isNotEmpty) {
				return toListModel(feriasPeriodoAquisitivoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FeriasPeriodoAquisitivoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.feriasPeriodoAquisitivoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FeriasPeriodoAquisitivoModel?>? insert(FeriasPeriodoAquisitivoModel feriasPeriodoAquisitivoModel) async {
		try {
			final lastPk = await Session.database.feriasPeriodoAquisitivoDao.insertObject(toDrift(feriasPeriodoAquisitivoModel));
			feriasPeriodoAquisitivoModel.id = lastPk;
			return feriasPeriodoAquisitivoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FeriasPeriodoAquisitivoModel?>? update(FeriasPeriodoAquisitivoModel feriasPeriodoAquisitivoModel) async {
		try {
			await Session.database.feriasPeriodoAquisitivoDao.updateObject(toDrift(feriasPeriodoAquisitivoModel));
			return feriasPeriodoAquisitivoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.feriasPeriodoAquisitivoDao.deleteObject(toDrift(FeriasPeriodoAquisitivoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FeriasPeriodoAquisitivoModel> toListModel(List<FeriasPeriodoAquisitivoGrouped> feriasPeriodoAquisitivoDriftList) {
		List<FeriasPeriodoAquisitivoModel> listModel = [];
		for (var feriasPeriodoAquisitivoDrift in feriasPeriodoAquisitivoDriftList) {
			listModel.add(toModel(feriasPeriodoAquisitivoDrift)!);
		}
		return listModel;
	}	

	FeriasPeriodoAquisitivoModel? toModel(FeriasPeriodoAquisitivoGrouped? feriasPeriodoAquisitivoDrift) {
		if (feriasPeriodoAquisitivoDrift != null) {
			return FeriasPeriodoAquisitivoModel(
				id: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.id,
				idColaborador: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.idColaborador,
				dataInicio: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.dataInicio,
				dataFim: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.dataFim,
				situacao: FeriasPeriodoAquisitivoDomain.getSituacao(feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.situacao),
				limiteParaGozo: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.limiteParaGozo,
				descontarFaltas: FeriasPeriodoAquisitivoDomain.getDescontarFaltas(feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.descontarFaltas),
				desconsiderarAfastamento: FeriasPeriodoAquisitivoDomain.getDesconsiderarAfastamento(feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.desconsiderarAfastamento),
				afastamentoPrevidencia: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.afastamentoPrevidencia,
				afastamentoSemRemun: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.afastamentoSemRemun,
				afastamentoComRemun: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.afastamentoComRemun,
				diasDireito: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.diasDireito,
				diasGozados: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.diasGozados,
				diasFaltas: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.diasFaltas,
				diasRestantes: feriasPeriodoAquisitivoDrift.feriasPeriodoAquisitivo?.diasRestantes,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.id,
					nome: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.nome,
					tipo: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.tipo,
					email: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.email,
					site: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.site,
					cpfCnpj: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.rgIe,
					matricula: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.observacao,
					logradouro: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.logradouro,
					numero: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.numero,
					complemento: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.complemento,
					bairro: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.bairro,
					cidade: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.cidade,
					cep: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.cep,
					municipioIbge: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.municipioIbge,
					uf: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.uf,
					idPessoa: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.idCargo,
					idSetor: feriasPeriodoAquisitivoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}


	FeriasPeriodoAquisitivoGrouped toDrift(FeriasPeriodoAquisitivoModel feriasPeriodoAquisitivoModel) {
		return FeriasPeriodoAquisitivoGrouped(
			feriasPeriodoAquisitivo: FeriasPeriodoAquisitivo(
				id: feriasPeriodoAquisitivoModel.id,
				idColaborador: feriasPeriodoAquisitivoModel.idColaborador,
				dataInicio: feriasPeriodoAquisitivoModel.dataInicio,
				dataFim: feriasPeriodoAquisitivoModel.dataFim,
				situacao: FeriasPeriodoAquisitivoDomain.setSituacao(feriasPeriodoAquisitivoModel.situacao),
				limiteParaGozo: feriasPeriodoAquisitivoModel.limiteParaGozo,
				descontarFaltas: FeriasPeriodoAquisitivoDomain.setDescontarFaltas(feriasPeriodoAquisitivoModel.descontarFaltas),
				desconsiderarAfastamento: FeriasPeriodoAquisitivoDomain.setDesconsiderarAfastamento(feriasPeriodoAquisitivoModel.desconsiderarAfastamento),
				afastamentoPrevidencia: feriasPeriodoAquisitivoModel.afastamentoPrevidencia,
				afastamentoSemRemun: feriasPeriodoAquisitivoModel.afastamentoSemRemun,
				afastamentoComRemun: feriasPeriodoAquisitivoModel.afastamentoComRemun,
				diasDireito: feriasPeriodoAquisitivoModel.diasDireito,
				diasGozados: feriasPeriodoAquisitivoModel.diasGozados,
				diasFaltas: feriasPeriodoAquisitivoModel.diasFaltas,
				diasRestantes: feriasPeriodoAquisitivoModel.diasRestantes,
			),
		);
	}

		
}
