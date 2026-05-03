import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoMarcacaoDriftProvider extends ProviderBase {

	Future<List<PontoMarcacaoModel>?> getList({Filter? filter}) async {
		List<PontoMarcacaoGrouped> pontoMarcacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoMarcacaoDriftList = await Session.database.pontoMarcacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoMarcacaoDriftList = await Session.database.pontoMarcacaoDao.getGroupedList(); 
			}
			if (pontoMarcacaoDriftList.isNotEmpty) {
				return toListModel(pontoMarcacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoMarcacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoMarcacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoMarcacaoModel?>? insert(PontoMarcacaoModel pontoMarcacaoModel) async {
		try {
			final lastPk = await Session.database.pontoMarcacaoDao.insertObject(toDrift(pontoMarcacaoModel));
			pontoMarcacaoModel.id = lastPk;
			return pontoMarcacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoMarcacaoModel?>? update(PontoMarcacaoModel pontoMarcacaoModel) async {
		try {
			await Session.database.pontoMarcacaoDao.updateObject(toDrift(pontoMarcacaoModel));
			return pontoMarcacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoMarcacaoDao.deleteObject(toDrift(PontoMarcacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoMarcacaoModel> toListModel(List<PontoMarcacaoGrouped> pontoMarcacaoDriftList) {
		List<PontoMarcacaoModel> listModel = [];
		for (var pontoMarcacaoDrift in pontoMarcacaoDriftList) {
			listModel.add(toModel(pontoMarcacaoDrift)!);
		}
		return listModel;
	}	

	PontoMarcacaoModel? toModel(PontoMarcacaoGrouped? pontoMarcacaoDrift) {
		if (pontoMarcacaoDrift != null) {
			return PontoMarcacaoModel(
				id: pontoMarcacaoDrift.pontoMarcacao?.id,
				idPontoRelogio: pontoMarcacaoDrift.pontoMarcacao?.idPontoRelogio,
				idColaborador: pontoMarcacaoDrift.pontoMarcacao?.idColaborador,
				nsr: pontoMarcacaoDrift.pontoMarcacao?.nsr,
				dataMarcacao: pontoMarcacaoDrift.pontoMarcacao?.dataMarcacao,
				horaMarcacao: pontoMarcacaoDrift.pontoMarcacao?.horaMarcacao,
				tipoMarcacao: PontoMarcacaoDomain.getTipoMarcacao(pontoMarcacaoDrift.pontoMarcacao?.tipoMarcacao),
				tipoRegistro: PontoMarcacaoDomain.getTipoRegistro(pontoMarcacaoDrift.pontoMarcacao?.tipoRegistro),
				parEntradaSaida: PontoMarcacaoDomain.getParEntradaSaida(pontoMarcacaoDrift.pontoMarcacao?.parEntradaSaida),
				justificativa: pontoMarcacaoDrift.pontoMarcacao?.justificativa,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: pontoMarcacaoDrift.viewPessoaColaborador?.id,
					nome: pontoMarcacaoDrift.viewPessoaColaborador?.nome,
					tipo: pontoMarcacaoDrift.viewPessoaColaborador?.tipo,
					email: pontoMarcacaoDrift.viewPessoaColaborador?.email,
					site: pontoMarcacaoDrift.viewPessoaColaborador?.site,
					cpfCnpj: pontoMarcacaoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: pontoMarcacaoDrift.viewPessoaColaborador?.rgIe,
					matricula: pontoMarcacaoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: pontoMarcacaoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: pontoMarcacaoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: pontoMarcacaoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: pontoMarcacaoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: pontoMarcacaoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: pontoMarcacaoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: pontoMarcacaoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: pontoMarcacaoDrift.viewPessoaColaborador?.observacao,
					logradouro: pontoMarcacaoDrift.viewPessoaColaborador?.logradouro,
					numero: pontoMarcacaoDrift.viewPessoaColaborador?.numero,
					complemento: pontoMarcacaoDrift.viewPessoaColaborador?.complemento,
					bairro: pontoMarcacaoDrift.viewPessoaColaborador?.bairro,
					cidade: pontoMarcacaoDrift.viewPessoaColaborador?.cidade,
					cep: pontoMarcacaoDrift.viewPessoaColaborador?.cep,
					municipioIbge: pontoMarcacaoDrift.viewPessoaColaborador?.municipioIbge,
					uf: pontoMarcacaoDrift.viewPessoaColaborador?.uf,
					idPessoa: pontoMarcacaoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: pontoMarcacaoDrift.viewPessoaColaborador?.idCargo,
					idSetor: pontoMarcacaoDrift.viewPessoaColaborador?.idSetor,
				),
				pontoRelogioModel: PontoRelogioModel(
					id: pontoMarcacaoDrift.pontoRelogio?.id,
					localizacao: pontoMarcacaoDrift.pontoRelogio?.localizacao,
					marca: pontoMarcacaoDrift.pontoRelogio?.marca,
					fabricante: pontoMarcacaoDrift.pontoRelogio?.fabricante,
					numeroSerie: pontoMarcacaoDrift.pontoRelogio?.numeroSerie,
					utilizacao: pontoMarcacaoDrift.pontoRelogio?.utilizacao,
				),
			);
		} else {
			return null;
		}
	}


	PontoMarcacaoGrouped toDrift(PontoMarcacaoModel pontoMarcacaoModel) {
		return PontoMarcacaoGrouped(
			pontoMarcacao: PontoMarcacao(
				id: pontoMarcacaoModel.id,
				idPontoRelogio: pontoMarcacaoModel.idPontoRelogio,
				idColaborador: pontoMarcacaoModel.idColaborador,
				nsr: pontoMarcacaoModel.nsr,
				dataMarcacao: pontoMarcacaoModel.dataMarcacao,
				horaMarcacao: pontoMarcacaoModel.horaMarcacao,
				tipoMarcacao: PontoMarcacaoDomain.setTipoMarcacao(pontoMarcacaoModel.tipoMarcacao),
				tipoRegistro: PontoMarcacaoDomain.setTipoRegistro(pontoMarcacaoModel.tipoRegistro),
				parEntradaSaida: PontoMarcacaoDomain.setParEntradaSaida(pontoMarcacaoModel.parEntradaSaida),
				justificativa: pontoMarcacaoModel.justificativa,
			),
		);
	}

		
}
