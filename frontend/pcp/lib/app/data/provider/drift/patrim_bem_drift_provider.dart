import 'package:pcp/app/data/provider/drift/database/database_imports.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/provider/provider_base.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:pcp/app/data/domain/domain_imports.dart';

class PatrimBemDriftProvider extends ProviderBase {

	Future<List<PatrimBemModel>?> getList({Filter? filter}) async {
		List<PatrimBemGrouped> patrimBemDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimBemDriftList = await Session.database.patrimBemDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimBemDriftList = await Session.database.patrimBemDao.getGroupedList(); 
			}
			if (patrimBemDriftList.isNotEmpty) {
				return toListModel(patrimBemDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimBemModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimBemDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimBemModel?>? insert(PatrimBemModel patrimBemModel) async {
		try {
			final lastPk = await Session.database.patrimBemDao.insertObject(toDrift(patrimBemModel));
			patrimBemModel.id = lastPk;
			return patrimBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimBemModel?>? update(PatrimBemModel patrimBemModel) async {
		try {
			await Session.database.patrimBemDao.updateObject(toDrift(patrimBemModel));
			return patrimBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimBemDao.deleteObject(toDrift(PatrimBemModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimBemModel> toListModel(List<PatrimBemGrouped> patrimBemDriftList) {
		List<PatrimBemModel> listModel = [];
		for (var patrimBemDrift in patrimBemDriftList) {
			listModel.add(toModel(patrimBemDrift)!);
		}
		return listModel;
	}	

	PatrimBemModel? toModel(PatrimBemGrouped? patrimBemDrift) {
		if (patrimBemDrift != null) {
			return PatrimBemModel(
				id: patrimBemDrift.patrimBem?.id,
				idCentroResultado: patrimBemDrift.patrimBem?.idCentroResultado,
				idPatrimTipoAquisicaoBem: patrimBemDrift.patrimBem?.idPatrimTipoAquisicaoBem,
				idPatrimEstadoConservacao: patrimBemDrift.patrimBem?.idPatrimEstadoConservacao,
				idPatrimGrupoBem: patrimBemDrift.patrimBem?.idPatrimGrupoBem,
				idFornecedor: patrimBemDrift.patrimBem?.idFornecedor,
				idSetor: patrimBemDrift.patrimBem?.idSetor,
				numeroNb: patrimBemDrift.patrimBem?.numeroNb,
				nome: patrimBemDrift.patrimBem?.nome,
				descricao: patrimBemDrift.patrimBem?.descricao,
				numeroSerie: patrimBemDrift.patrimBem?.numeroSerie,
				dataAquisicao: patrimBemDrift.patrimBem?.dataAquisicao,
				dataAceite: patrimBemDrift.patrimBem?.dataAceite,
				dataCadastro: patrimBemDrift.patrimBem?.dataCadastro,
				dataContabilizado: patrimBemDrift.patrimBem?.dataContabilizado,
				dataVistoria: patrimBemDrift.patrimBem?.dataVistoria,
				dataMarcacao: patrimBemDrift.patrimBem?.dataMarcacao,
				dataBaixa: patrimBemDrift.patrimBem?.dataBaixa,
				vencimentoGarantia: patrimBemDrift.patrimBem?.vencimentoGarantia,
				numeroNotaFiscal: patrimBemDrift.patrimBem?.numeroNotaFiscal,
				chaveNfe: patrimBemDrift.patrimBem?.chaveNfe,
				valorOriginal: patrimBemDrift.patrimBem?.valorOriginal,
				valorCompra: patrimBemDrift.patrimBem?.valorCompra,
				valorAtualizado: patrimBemDrift.patrimBem?.valorAtualizado,
				valorBaixa: patrimBemDrift.patrimBem?.valorBaixa,
				deprecia: PatrimBemDomain.getDeprecia(patrimBemDrift.patrimBem?.deprecia),
				metodoDepreciacao: PatrimBemDomain.getMetodoDepreciacao(patrimBemDrift.patrimBem?.metodoDepreciacao),
				inicioDepreciacao: patrimBemDrift.patrimBem?.inicioDepreciacao,
				ultimaDepreciacao: patrimBemDrift.patrimBem?.ultimaDepreciacao,
				tipoDepreciacao: PatrimBemDomain.getTipoDepreciacao(patrimBemDrift.patrimBem?.tipoDepreciacao),
				taxaAnualDepreciacao: patrimBemDrift.patrimBem?.taxaAnualDepreciacao,
				taxaMensalDepreciacao: patrimBemDrift.patrimBem?.taxaMensalDepreciacao,
				taxaDepreciacaoAcelerada: patrimBemDrift.patrimBem?.taxaDepreciacaoAcelerada,
				taxaDepreciacaoIncentivada: patrimBemDrift.patrimBem?.taxaDepreciacaoIncentivada,
				funcao: patrimBemDrift.patrimBem?.funcao,
			);
		} else {
			return null;
		}
	}


	PatrimBemGrouped toDrift(PatrimBemModel patrimBemModel) {
		return PatrimBemGrouped(
			patrimBem: PatrimBem(
				id: patrimBemModel.id,
				idCentroResultado: patrimBemModel.idCentroResultado,
				idPatrimTipoAquisicaoBem: patrimBemModel.idPatrimTipoAquisicaoBem,
				idPatrimEstadoConservacao: patrimBemModel.idPatrimEstadoConservacao,
				idPatrimGrupoBem: patrimBemModel.idPatrimGrupoBem,
				idFornecedor: patrimBemModel.idFornecedor,
				idSetor: patrimBemModel.idSetor,
				numeroNb: patrimBemModel.numeroNb,
				nome: patrimBemModel.nome,
				descricao: patrimBemModel.descricao,
				numeroSerie: patrimBemModel.numeroSerie,
				dataAquisicao: patrimBemModel.dataAquisicao,
				dataAceite: patrimBemModel.dataAceite,
				dataCadastro: patrimBemModel.dataCadastro,
				dataContabilizado: patrimBemModel.dataContabilizado,
				dataVistoria: patrimBemModel.dataVistoria,
				dataMarcacao: patrimBemModel.dataMarcacao,
				dataBaixa: patrimBemModel.dataBaixa,
				vencimentoGarantia: patrimBemModel.vencimentoGarantia,
				numeroNotaFiscal: patrimBemModel.numeroNotaFiscal,
				chaveNfe: patrimBemModel.chaveNfe,
				valorOriginal: patrimBemModel.valorOriginal,
				valorCompra: patrimBemModel.valorCompra,
				valorAtualizado: patrimBemModel.valorAtualizado,
				valorBaixa: patrimBemModel.valorBaixa,
				deprecia: PatrimBemDomain.setDeprecia(patrimBemModel.deprecia),
				metodoDepreciacao: PatrimBemDomain.setMetodoDepreciacao(patrimBemModel.metodoDepreciacao),
				inicioDepreciacao: patrimBemModel.inicioDepreciacao,
				ultimaDepreciacao: patrimBemModel.ultimaDepreciacao,
				tipoDepreciacao: PatrimBemDomain.setTipoDepreciacao(patrimBemModel.tipoDepreciacao),
				taxaAnualDepreciacao: patrimBemModel.taxaAnualDepreciacao,
				taxaMensalDepreciacao: patrimBemModel.taxaMensalDepreciacao,
				taxaDepreciacaoAcelerada: patrimBemModel.taxaDepreciacaoAcelerada,
				taxaDepreciacaoIncentivada: patrimBemModel.taxaDepreciacaoIncentivada,
				funcao: patrimBemModel.funcao,
			),
		);
	}

		
}
