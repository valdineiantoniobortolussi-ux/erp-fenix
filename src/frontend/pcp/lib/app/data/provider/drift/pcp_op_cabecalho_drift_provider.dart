import 'package:pcp/app/data/provider/drift/database/database_imports.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/provider/provider_base.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpOpCabecalhoDriftProvider extends ProviderBase {

	Future<List<PcpOpCabecalhoModel>?> getList({Filter? filter}) async {
		List<PcpOpCabecalhoGrouped> pcpOpCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pcpOpCabecalhoDriftList = await Session.database.pcpOpCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pcpOpCabecalhoDriftList = await Session.database.pcpOpCabecalhoDao.getGroupedList(); 
			}
			if (pcpOpCabecalhoDriftList.isNotEmpty) {
				return toListModel(pcpOpCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PcpOpCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pcpOpCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpOpCabecalhoModel?>? insert(PcpOpCabecalhoModel pcpOpCabecalhoModel) async {
		try {
			final lastPk = await Session.database.pcpOpCabecalhoDao.insertObject(toDrift(pcpOpCabecalhoModel));
			pcpOpCabecalhoModel.id = lastPk;
			return pcpOpCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpOpCabecalhoModel?>? update(PcpOpCabecalhoModel pcpOpCabecalhoModel) async {
		try {
			await Session.database.pcpOpCabecalhoDao.updateObject(toDrift(pcpOpCabecalhoModel));
			return pcpOpCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pcpOpCabecalhoDao.deleteObject(toDrift(PcpOpCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PcpOpCabecalhoModel> toListModel(List<PcpOpCabecalhoGrouped> pcpOpCabecalhoDriftList) {
		List<PcpOpCabecalhoModel> listModel = [];
		for (var pcpOpCabecalhoDrift in pcpOpCabecalhoDriftList) {
			listModel.add(toModel(pcpOpCabecalhoDrift)!);
		}
		return listModel;
	}	

	PcpOpCabecalhoModel? toModel(PcpOpCabecalhoGrouped? pcpOpCabecalhoDrift) {
		if (pcpOpCabecalhoDrift != null) {
			return PcpOpCabecalhoModel(
				id: pcpOpCabecalhoDrift.pcpOpCabecalho?.id,
				dataInicio: pcpOpCabecalhoDrift.pcpOpCabecalho?.dataInicio,
				dataPrevisaoEntrega: pcpOpCabecalhoDrift.pcpOpCabecalho?.dataPrevisaoEntrega,
				dataTermino: pcpOpCabecalhoDrift.pcpOpCabecalho?.dataTermino,
				custoTotalPrevisto: pcpOpCabecalhoDrift.pcpOpCabecalho?.custoTotalPrevisto,
				custoTotalRealizado: pcpOpCabecalhoDrift.pcpOpCabecalho?.custoTotalRealizado,
				porcentoVenda: pcpOpCabecalhoDrift.pcpOpCabecalho?.porcentoVenda,
				porcentoEstoque: pcpOpCabecalhoDrift.pcpOpCabecalho?.porcentoEstoque,
				pcpOpDetalheModelList: pcpOpDetalheDriftToModel(pcpOpCabecalhoDrift.pcpOpDetalheGroupedList),
				pcpInstrucaoOpModelList: pcpInstrucaoOpDriftToModel(pcpOpCabecalhoDrift.pcpInstrucaoOpGroupedList),
			);
		} else {
			return null;
		}
	}

	List<PcpOpDetalheModel> pcpOpDetalheDriftToModel(List<PcpOpDetalheGrouped>? pcpOpDetalheDriftList) { 
		List<PcpOpDetalheModel> pcpOpDetalheModelList = [];
		if (pcpOpDetalheDriftList != null) {
			for (var pcpOpDetalheGrouped in pcpOpDetalheDriftList) {
				pcpOpDetalheModelList.add(
					PcpOpDetalheModel(
						id: pcpOpDetalheGrouped.pcpOpDetalhe?.id,
						idPcpOpCabecalho: pcpOpDetalheGrouped.pcpOpDetalhe?.idPcpOpCabecalho,
						idProduto: pcpOpDetalheGrouped.pcpOpDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: pcpOpDetalheGrouped.produto?.id,
							idTributIcmsCustomCab: pcpOpDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: pcpOpDetalheGrouped.produto?.idTributGrupoTributario,
							nome: pcpOpDetalheGrouped.produto?.nome,
							descricao: pcpOpDetalheGrouped.produto?.descricao,
							gtin: pcpOpDetalheGrouped.produto?.gtin,
							codigoInterno: pcpOpDetalheGrouped.produto?.codigoInterno,
							valorCompra: pcpOpDetalheGrouped.produto?.valorCompra,
							valorVenda: pcpOpDetalheGrouped.produto?.valorVenda,
							codigoNcm: pcpOpDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: pcpOpDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: pcpOpDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: pcpOpDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: pcpOpDetalheGrouped.produto?.dataCadastro,
						),
						quantidadeProduzir: pcpOpDetalheGrouped.pcpOpDetalhe?.quantidadeProduzir,
						quantidadeProduzida: pcpOpDetalheGrouped.pcpOpDetalhe?.quantidadeProduzida,
						quantidadeEntregue: pcpOpDetalheGrouped.pcpOpDetalhe?.quantidadeEntregue,
						custoPrevisto: pcpOpDetalheGrouped.pcpOpDetalhe?.custoPrevisto,
						custoRealizado: pcpOpDetalheGrouped.pcpOpDetalhe?.custoRealizado,
					)
				);
			}
			return pcpOpDetalheModelList;
		}
		return [];
	}

	List<PcpInstrucaoOpModel> pcpInstrucaoOpDriftToModel(List<PcpInstrucaoOpGrouped>? pcpInstrucaoOpDriftList) { 
		List<PcpInstrucaoOpModel> pcpInstrucaoOpModelList = [];
		if (pcpInstrucaoOpDriftList != null) {
			for (var pcpInstrucaoOpGrouped in pcpInstrucaoOpDriftList) {
				pcpInstrucaoOpModelList.add(
					PcpInstrucaoOpModel(
						id: pcpInstrucaoOpGrouped.pcpInstrucaoOp?.id,
						idPcpInstrucao: pcpInstrucaoOpGrouped.pcpInstrucaoOp?.idPcpInstrucao,
						pcpInstrucaoModel: PcpInstrucaoModel(
							id: pcpInstrucaoOpGrouped.pcpInstrucao?.id,
							codigo: pcpInstrucaoOpGrouped.pcpInstrucao?.codigo,
							descricao: pcpInstrucaoOpGrouped.pcpInstrucao?.descricao,
						),
						idPcpOpCabecalho: pcpInstrucaoOpGrouped.pcpInstrucaoOp?.idPcpOpCabecalho,
					)
				);
			}
			return pcpInstrucaoOpModelList;
		}
		return [];
	}


	PcpOpCabecalhoGrouped toDrift(PcpOpCabecalhoModel pcpOpCabecalhoModel) {
		return PcpOpCabecalhoGrouped(
			pcpOpCabecalho: PcpOpCabecalho(
				id: pcpOpCabecalhoModel.id,
				dataInicio: pcpOpCabecalhoModel.dataInicio,
				dataPrevisaoEntrega: pcpOpCabecalhoModel.dataPrevisaoEntrega,
				dataTermino: pcpOpCabecalhoModel.dataTermino,
				custoTotalPrevisto: pcpOpCabecalhoModel.custoTotalPrevisto,
				custoTotalRealizado: pcpOpCabecalhoModel.custoTotalRealizado,
				porcentoVenda: pcpOpCabecalhoModel.porcentoVenda,
				porcentoEstoque: pcpOpCabecalhoModel.porcentoEstoque,
			),
			pcpOpDetalheGroupedList: pcpOpDetalheModelToDrift(pcpOpCabecalhoModel.pcpOpDetalheModelList),
			pcpInstrucaoOpGroupedList: pcpInstrucaoOpModelToDrift(pcpOpCabecalhoModel.pcpInstrucaoOpModelList),
		);
	}

	List<PcpOpDetalheGrouped> pcpOpDetalheModelToDrift(List<PcpOpDetalheModel>? pcpOpDetalheModelList) { 
		List<PcpOpDetalheGrouped> pcpOpDetalheGroupedList = [];
		if (pcpOpDetalheModelList != null) {
			for (var pcpOpDetalheModel in pcpOpDetalheModelList) {
				pcpOpDetalheGroupedList.add(
					PcpOpDetalheGrouped(
						pcpOpDetalhe: PcpOpDetalhe(
							id: pcpOpDetalheModel.id,
							idPcpOpCabecalho: pcpOpDetalheModel.idPcpOpCabecalho,
							idProduto: pcpOpDetalheModel.idProduto,
							quantidadeProduzir: pcpOpDetalheModel.quantidadeProduzir,
							quantidadeProduzida: pcpOpDetalheModel.quantidadeProduzida,
							quantidadeEntregue: pcpOpDetalheModel.quantidadeEntregue,
							custoPrevisto: pcpOpDetalheModel.custoPrevisto,
							custoRealizado: pcpOpDetalheModel.custoRealizado,
						),
					),
				);
			}
			return pcpOpDetalheGroupedList;
		}
		return [];
	}

	List<PcpInstrucaoOpGrouped> pcpInstrucaoOpModelToDrift(List<PcpInstrucaoOpModel>? pcpInstrucaoOpModelList) { 
		List<PcpInstrucaoOpGrouped> pcpInstrucaoOpGroupedList = [];
		if (pcpInstrucaoOpModelList != null) {
			for (var pcpInstrucaoOpModel in pcpInstrucaoOpModelList) {
				pcpInstrucaoOpGroupedList.add(
					PcpInstrucaoOpGrouped(
						pcpInstrucaoOp: PcpInstrucaoOp(
							id: pcpInstrucaoOpModel.id,
							idPcpInstrucao: pcpInstrucaoOpModel.idPcpInstrucao,
							idPcpOpCabecalho: pcpInstrucaoOpModel.idPcpOpCabecalho,
						),
					),
				);
			}
			return pcpInstrucaoOpGroupedList;
		}
		return [];
	}

		
}
