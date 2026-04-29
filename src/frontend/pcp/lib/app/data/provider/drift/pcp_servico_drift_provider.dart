import 'package:pcp/app/data/provider/drift/database/database_imports.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/provider/provider_base.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpServicoDriftProvider extends ProviderBase {

	Future<List<PcpServicoModel>?> getList({Filter? filter}) async {
		List<PcpServicoGrouped> pcpServicoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pcpServicoDriftList = await Session.database.pcpServicoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pcpServicoDriftList = await Session.database.pcpServicoDao.getGroupedList(); 
			}
			if (pcpServicoDriftList.isNotEmpty) {
				return toListModel(pcpServicoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PcpServicoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pcpServicoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpServicoModel?>? insert(PcpServicoModel pcpServicoModel) async {
		try {
			final lastPk = await Session.database.pcpServicoDao.insertObject(toDrift(pcpServicoModel));
			pcpServicoModel.id = lastPk;
			return pcpServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpServicoModel?>? update(PcpServicoModel pcpServicoModel) async {
		try {
			await Session.database.pcpServicoDao.updateObject(toDrift(pcpServicoModel));
			return pcpServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pcpServicoDao.deleteObject(toDrift(PcpServicoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PcpServicoModel> toListModel(List<PcpServicoGrouped> pcpServicoDriftList) {
		List<PcpServicoModel> listModel = [];
		for (var pcpServicoDrift in pcpServicoDriftList) {
			listModel.add(toModel(pcpServicoDrift)!);
		}
		return listModel;
	}	

	PcpServicoModel? toModel(PcpServicoGrouped? pcpServicoDrift) {
		if (pcpServicoDrift != null) {
			return PcpServicoModel(
				id: pcpServicoDrift.pcpServico?.id,
				idPcpOpDetalhe: pcpServicoDrift.pcpServico?.idPcpOpDetalhe,
				inicioPrevisto: pcpServicoDrift.pcpServico?.inicioPrevisto,
				terminoPrevisto: pcpServicoDrift.pcpServico?.terminoPrevisto,
				horasPrevisto: pcpServicoDrift.pcpServico?.horasPrevisto,
				minutosPrevisto: pcpServicoDrift.pcpServico?.minutosPrevisto,
				segundosPrevisto: pcpServicoDrift.pcpServico?.segundosPrevisto,
				custoPrevisto: pcpServicoDrift.pcpServico?.custoPrevisto,
				inicioRealizado: pcpServicoDrift.pcpServico?.inicioRealizado,
				terminoRealizado: pcpServicoDrift.pcpServico?.terminoRealizado,
				horasRealizado: pcpServicoDrift.pcpServico?.horasRealizado,
				minutosRealizado: pcpServicoDrift.pcpServico?.minutosRealizado,
				segundosRealizado: pcpServicoDrift.pcpServico?.segundosRealizado,
				custoRealizado: pcpServicoDrift.pcpServico?.custoRealizado,
				pcpServicoColaboradorModelList: pcpServicoColaboradorDriftToModel(pcpServicoDrift.pcpServicoColaboradorGroupedList),
				pcpServicoEquipamentoModelList: pcpServicoEquipamentoDriftToModel(pcpServicoDrift.pcpServicoEquipamentoGroupedList),
				pcpOpDetalheModel: PcpOpDetalheModel(
					id: pcpServicoDrift.pcpOpDetalhe?.id,
					idPcpOpCabecalho: pcpServicoDrift.pcpOpDetalhe?.idPcpOpCabecalho,
					idProduto: pcpServicoDrift.pcpOpDetalhe?.idProduto,
					quantidadeProduzir: pcpServicoDrift.pcpOpDetalhe?.quantidadeProduzir,
					quantidadeProduzida: pcpServicoDrift.pcpOpDetalhe?.quantidadeProduzida,
					quantidadeEntregue: pcpServicoDrift.pcpOpDetalhe?.quantidadeEntregue,
					custoPrevisto: pcpServicoDrift.pcpOpDetalhe?.custoPrevisto,
					custoRealizado: pcpServicoDrift.pcpOpDetalhe?.custoRealizado,
				),
			);
		} else {
			return null;
		}
	}

	List<PcpServicoColaboradorModel> pcpServicoColaboradorDriftToModel(List<PcpServicoColaboradorGrouped>? pcpServicoColaboradorDriftList) { 
		List<PcpServicoColaboradorModel> pcpServicoColaboradorModelList = [];
		if (pcpServicoColaboradorDriftList != null) {
			for (var pcpServicoColaboradorGrouped in pcpServicoColaboradorDriftList) {
				pcpServicoColaboradorModelList.add(
					PcpServicoColaboradorModel(
						id: pcpServicoColaboradorGrouped.pcpServicoColaborador?.id,
						idColaborador: pcpServicoColaboradorGrouped.pcpServicoColaborador?.idColaborador,
						viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
							id: pcpServicoColaboradorGrouped.viewPessoaColaborador?.id,
							nome: pcpServicoColaboradorGrouped.viewPessoaColaborador?.nome,
							tipo: pcpServicoColaboradorGrouped.viewPessoaColaborador?.tipo,
							email: pcpServicoColaboradorGrouped.viewPessoaColaborador?.email,
							site: pcpServicoColaboradorGrouped.viewPessoaColaborador?.site,
							cpfCnpj: pcpServicoColaboradorGrouped.viewPessoaColaborador?.cpfCnpj,
							rgIe: pcpServicoColaboradorGrouped.viewPessoaColaborador?.rgIe,
							matricula: pcpServicoColaboradorGrouped.viewPessoaColaborador?.matricula,
							dataCadastro: pcpServicoColaboradorGrouped.viewPessoaColaborador?.dataCadastro,
							dataAdmissao: pcpServicoColaboradorGrouped.viewPessoaColaborador?.dataAdmissao,
							dataDemissao: pcpServicoColaboradorGrouped.viewPessoaColaborador?.dataDemissao,
							ctpsNumero: pcpServicoColaboradorGrouped.viewPessoaColaborador?.ctpsNumero,
							ctpsSerie: pcpServicoColaboradorGrouped.viewPessoaColaborador?.ctpsSerie,
							ctpsDataExpedicao: pcpServicoColaboradorGrouped.viewPessoaColaborador?.ctpsDataExpedicao,
							ctpsUf: pcpServicoColaboradorGrouped.viewPessoaColaborador?.ctpsUf,
							observacao: pcpServicoColaboradorGrouped.viewPessoaColaborador?.observacao,
							logradouro: pcpServicoColaboradorGrouped.viewPessoaColaborador?.logradouro,
							numero: pcpServicoColaboradorGrouped.viewPessoaColaborador?.numero,
							complemento: pcpServicoColaboradorGrouped.viewPessoaColaborador?.complemento,
							bairro: pcpServicoColaboradorGrouped.viewPessoaColaborador?.bairro,
							cidade: pcpServicoColaboradorGrouped.viewPessoaColaborador?.cidade,
							cep: pcpServicoColaboradorGrouped.viewPessoaColaborador?.cep,
							municipioIbge: pcpServicoColaboradorGrouped.viewPessoaColaborador?.municipioIbge,
							uf: pcpServicoColaboradorGrouped.viewPessoaColaborador?.uf,
							idPessoa: pcpServicoColaboradorGrouped.viewPessoaColaborador?.idPessoa,
							idCargo: pcpServicoColaboradorGrouped.viewPessoaColaborador?.idCargo,
							idSetor: pcpServicoColaboradorGrouped.viewPessoaColaborador?.idSetor,
						),
						idPcpServico: pcpServicoColaboradorGrouped.pcpServicoColaborador?.idPcpServico,
					)
				);
			}
			return pcpServicoColaboradorModelList;
		}
		return [];
	}

	List<PcpServicoEquipamentoModel> pcpServicoEquipamentoDriftToModel(List<PcpServicoEquipamentoGrouped>? pcpServicoEquipamentoDriftList) { 
		List<PcpServicoEquipamentoModel> pcpServicoEquipamentoModelList = [];
		if (pcpServicoEquipamentoDriftList != null) {
			for (var pcpServicoEquipamentoGrouped in pcpServicoEquipamentoDriftList) {
				pcpServicoEquipamentoModelList.add(
					PcpServicoEquipamentoModel(
						id: pcpServicoEquipamentoGrouped.pcpServicoEquipamento?.id,
						idPcpServico: pcpServicoEquipamentoGrouped.pcpServicoEquipamento?.idPcpServico,
						idPatrimBem: pcpServicoEquipamentoGrouped.pcpServicoEquipamento?.idPatrimBem,
						patrimBemModel: PatrimBemModel(
							id: pcpServicoEquipamentoGrouped.patrimBem?.id,
							idCentroResultado: pcpServicoEquipamentoGrouped.patrimBem?.idCentroResultado,
							idPatrimTipoAquisicaoBem: pcpServicoEquipamentoGrouped.patrimBem?.idPatrimTipoAquisicaoBem,
							idPatrimEstadoConservacao: pcpServicoEquipamentoGrouped.patrimBem?.idPatrimEstadoConservacao,
							idPatrimGrupoBem: pcpServicoEquipamentoGrouped.patrimBem?.idPatrimGrupoBem,
							idFornecedor: pcpServicoEquipamentoGrouped.patrimBem?.idFornecedor,
							idSetor: pcpServicoEquipamentoGrouped.patrimBem?.idSetor,
							numeroNb: pcpServicoEquipamentoGrouped.patrimBem?.numeroNb,
							nome: pcpServicoEquipamentoGrouped.patrimBem?.nome,
							descricao: pcpServicoEquipamentoGrouped.patrimBem?.descricao,
							numeroSerie: pcpServicoEquipamentoGrouped.patrimBem?.numeroSerie,
							dataAquisicao: pcpServicoEquipamentoGrouped.patrimBem?.dataAquisicao,
							dataAceite: pcpServicoEquipamentoGrouped.patrimBem?.dataAceite,
							dataCadastro: pcpServicoEquipamentoGrouped.patrimBem?.dataCadastro,
							dataContabilizado: pcpServicoEquipamentoGrouped.patrimBem?.dataContabilizado,
							dataVistoria: pcpServicoEquipamentoGrouped.patrimBem?.dataVistoria,
							dataMarcacao: pcpServicoEquipamentoGrouped.patrimBem?.dataMarcacao,
							dataBaixa: pcpServicoEquipamentoGrouped.patrimBem?.dataBaixa,
							vencimentoGarantia: pcpServicoEquipamentoGrouped.patrimBem?.vencimentoGarantia,
							numeroNotaFiscal: pcpServicoEquipamentoGrouped.patrimBem?.numeroNotaFiscal,
							chaveNfe: pcpServicoEquipamentoGrouped.patrimBem?.chaveNfe,
							valorOriginal: pcpServicoEquipamentoGrouped.patrimBem?.valorOriginal,
							valorCompra: pcpServicoEquipamentoGrouped.patrimBem?.valorCompra,
							valorAtualizado: pcpServicoEquipamentoGrouped.patrimBem?.valorAtualizado,
							valorBaixa: pcpServicoEquipamentoGrouped.patrimBem?.valorBaixa,
							deprecia: pcpServicoEquipamentoGrouped.patrimBem?.deprecia,
							metodoDepreciacao: pcpServicoEquipamentoGrouped.patrimBem?.metodoDepreciacao,
							inicioDepreciacao: pcpServicoEquipamentoGrouped.patrimBem?.inicioDepreciacao,
							ultimaDepreciacao: pcpServicoEquipamentoGrouped.patrimBem?.ultimaDepreciacao,
							tipoDepreciacao: pcpServicoEquipamentoGrouped.patrimBem?.tipoDepreciacao,
							taxaAnualDepreciacao: pcpServicoEquipamentoGrouped.patrimBem?.taxaAnualDepreciacao,
							taxaMensalDepreciacao: pcpServicoEquipamentoGrouped.patrimBem?.taxaMensalDepreciacao,
							taxaDepreciacaoAcelerada: pcpServicoEquipamentoGrouped.patrimBem?.taxaDepreciacaoAcelerada,
							taxaDepreciacaoIncentivada: pcpServicoEquipamentoGrouped.patrimBem?.taxaDepreciacaoIncentivada,
							funcao: pcpServicoEquipamentoGrouped.patrimBem?.funcao,
						),
					)
				);
			}
			return pcpServicoEquipamentoModelList;
		}
		return [];
	}


	PcpServicoGrouped toDrift(PcpServicoModel pcpServicoModel) {
		return PcpServicoGrouped(
			pcpServico: PcpServico(
				id: pcpServicoModel.id,
				idPcpOpDetalhe: pcpServicoModel.idPcpOpDetalhe,
				inicioPrevisto: pcpServicoModel.inicioPrevisto,
				terminoPrevisto: pcpServicoModel.terminoPrevisto,
				horasPrevisto: pcpServicoModel.horasPrevisto,
				minutosPrevisto: pcpServicoModel.minutosPrevisto,
				segundosPrevisto: pcpServicoModel.segundosPrevisto,
				custoPrevisto: pcpServicoModel.custoPrevisto,
				inicioRealizado: pcpServicoModel.inicioRealizado,
				terminoRealizado: pcpServicoModel.terminoRealizado,
				horasRealizado: pcpServicoModel.horasRealizado,
				minutosRealizado: pcpServicoModel.minutosRealizado,
				segundosRealizado: pcpServicoModel.segundosRealizado,
				custoRealizado: pcpServicoModel.custoRealizado,
			),
			pcpServicoColaboradorGroupedList: pcpServicoColaboradorModelToDrift(pcpServicoModel.pcpServicoColaboradorModelList),
			pcpServicoEquipamentoGroupedList: pcpServicoEquipamentoModelToDrift(pcpServicoModel.pcpServicoEquipamentoModelList),
		);
	}

	List<PcpServicoColaboradorGrouped> pcpServicoColaboradorModelToDrift(List<PcpServicoColaboradorModel>? pcpServicoColaboradorModelList) { 
		List<PcpServicoColaboradorGrouped> pcpServicoColaboradorGroupedList = [];
		if (pcpServicoColaboradorModelList != null) {
			for (var pcpServicoColaboradorModel in pcpServicoColaboradorModelList) {
				pcpServicoColaboradorGroupedList.add(
					PcpServicoColaboradorGrouped(
						pcpServicoColaborador: PcpServicoColaborador(
							id: pcpServicoColaboradorModel.id,
							idColaborador: pcpServicoColaboradorModel.idColaborador,
							idPcpServico: pcpServicoColaboradorModel.idPcpServico,
						),
					),
				);
			}
			return pcpServicoColaboradorGroupedList;
		}
		return [];
	}

	List<PcpServicoEquipamentoGrouped> pcpServicoEquipamentoModelToDrift(List<PcpServicoEquipamentoModel>? pcpServicoEquipamentoModelList) { 
		List<PcpServicoEquipamentoGrouped> pcpServicoEquipamentoGroupedList = [];
		if (pcpServicoEquipamentoModelList != null) {
			for (var pcpServicoEquipamentoModel in pcpServicoEquipamentoModelList) {
				pcpServicoEquipamentoGroupedList.add(
					PcpServicoEquipamentoGrouped(
						pcpServicoEquipamento: PcpServicoEquipamento(
							id: pcpServicoEquipamentoModel.id,
							idPcpServico: pcpServicoEquipamentoModel.idPcpServico,
							idPatrimBem: pcpServicoEquipamentoModel.idPatrimBem,
						),
					),
				);
			}
			return pcpServicoEquipamentoGroupedList;
		}
		return [];
	}

		
}
