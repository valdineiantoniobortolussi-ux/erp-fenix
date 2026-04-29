import 'package:ordem_servico/app/data/provider/drift/database/database_imports.dart';
import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/data/provider/provider_base.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/data/domain/domain_imports.dart';

class OsAberturaDriftProvider extends ProviderBase {

	Future<List<OsAberturaModel>?> getList({Filter? filter}) async {
		List<OsAberturaGrouped> osAberturaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				osAberturaDriftList = await Session.database.osAberturaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				osAberturaDriftList = await Session.database.osAberturaDao.getGroupedList(); 
			}
			if (osAberturaDriftList.isNotEmpty) {
				return toListModel(osAberturaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OsAberturaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.osAberturaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsAberturaModel?>? insert(OsAberturaModel osAberturaModel) async {
		try {
			final lastPk = await Session.database.osAberturaDao.insertObject(toDrift(osAberturaModel));
			osAberturaModel.id = lastPk;
			return osAberturaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsAberturaModel?>? update(OsAberturaModel osAberturaModel) async {
		try {
			await Session.database.osAberturaDao.updateObject(toDrift(osAberturaModel));
			return osAberturaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.osAberturaDao.deleteObject(toDrift(OsAberturaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OsAberturaModel> toListModel(List<OsAberturaGrouped> osAberturaDriftList) {
		List<OsAberturaModel> listModel = [];
		for (var osAberturaDrift in osAberturaDriftList) {
			listModel.add(toModel(osAberturaDrift)!);
		}
		return listModel;
	}	

	OsAberturaModel? toModel(OsAberturaGrouped? osAberturaDrift) {
		if (osAberturaDrift != null) {
			return OsAberturaModel(
				id: osAberturaDrift.osAbertura?.id,
				idOsStatus: osAberturaDrift.osAbertura?.idOsStatus,
				idColaborador: osAberturaDrift.osAbertura?.idColaborador,
				idCliente: osAberturaDrift.osAbertura?.idCliente,
				numero: osAberturaDrift.osAbertura?.numero,
				dataInicio: osAberturaDrift.osAbertura?.dataInicio,
				horaInicio: osAberturaDrift.osAbertura?.horaInicio,
				dataPrevisao: osAberturaDrift.osAbertura?.dataPrevisao,
				horaPrevisao: osAberturaDrift.osAbertura?.horaPrevisao,
				dataFim: osAberturaDrift.osAbertura?.dataFim,
				horaFim: osAberturaDrift.osAbertura?.horaFim,
				nomeContato: osAberturaDrift.osAbertura?.nomeContato,
				foneContato: osAberturaDrift.osAbertura?.foneContato,
				observacaoCliente: osAberturaDrift.osAbertura?.observacaoCliente,
				observacaoAbertura: osAberturaDrift.osAbertura?.observacaoAbertura,
				osAberturaEquipamentoModelList: osAberturaEquipamentoDriftToModel(osAberturaDrift.osAberturaEquipamentoGroupedList),
				osProdutoServicoModelList: osProdutoServicoDriftToModel(osAberturaDrift.osProdutoServicoGroupedList),
				osEvolucaoModelList: osEvolucaoDriftToModel(osAberturaDrift.osEvolucaoGroupedList),
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: osAberturaDrift.viewPessoaCliente?.id,
					nome: osAberturaDrift.viewPessoaCliente?.nome,
					tipo: osAberturaDrift.viewPessoaCliente?.tipo,
					email: osAberturaDrift.viewPessoaCliente?.email,
					site: osAberturaDrift.viewPessoaCliente?.site,
					cpfCnpj: osAberturaDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: osAberturaDrift.viewPessoaCliente?.rgIe,
					desde: osAberturaDrift.viewPessoaCliente?.desde,
					taxaDesconto: osAberturaDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: osAberturaDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: osAberturaDrift.viewPessoaCliente?.dataCadastro,
					observacao: osAberturaDrift.viewPessoaCliente?.observacao,
					idPessoa: osAberturaDrift.viewPessoaCliente?.idPessoa,
				),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: osAberturaDrift.viewPessoaColaborador?.id,
					nome: osAberturaDrift.viewPessoaColaborador?.nome,
					tipo: osAberturaDrift.viewPessoaColaborador?.tipo,
					email: osAberturaDrift.viewPessoaColaborador?.email,
					site: osAberturaDrift.viewPessoaColaborador?.site,
					cpfCnpj: osAberturaDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: osAberturaDrift.viewPessoaColaborador?.rgIe,
					matricula: osAberturaDrift.viewPessoaColaborador?.matricula,
					dataCadastro: osAberturaDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: osAberturaDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: osAberturaDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: osAberturaDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: osAberturaDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: osAberturaDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: osAberturaDrift.viewPessoaColaborador?.ctpsUf,
					observacao: osAberturaDrift.viewPessoaColaborador?.observacao,
					logradouro: osAberturaDrift.viewPessoaColaborador?.logradouro,
					numero: osAberturaDrift.viewPessoaColaborador?.numero,
					complemento: osAberturaDrift.viewPessoaColaborador?.complemento,
					bairro: osAberturaDrift.viewPessoaColaborador?.bairro,
					cidade: osAberturaDrift.viewPessoaColaborador?.cidade,
					cep: osAberturaDrift.viewPessoaColaborador?.cep,
					municipioIbge: osAberturaDrift.viewPessoaColaborador?.municipioIbge,
					uf: osAberturaDrift.viewPessoaColaborador?.uf,
					idPessoa: osAberturaDrift.viewPessoaColaborador?.idPessoa,
					idCargo: osAberturaDrift.viewPessoaColaborador?.idCargo,
					idSetor: osAberturaDrift.viewPessoaColaborador?.idSetor,
				),
				osStatusModel: OsStatusModel(
					id: osAberturaDrift.osStatus?.id,
					codigo: osAberturaDrift.osStatus?.codigo,
					nome: osAberturaDrift.osStatus?.nome,
				),
			);
		} else {
			return null;
		}
	}

	List<OsAberturaEquipamentoModel> osAberturaEquipamentoDriftToModel(List<OsAberturaEquipamentoGrouped>? osAberturaEquipamentoDriftList) { 
		List<OsAberturaEquipamentoModel> osAberturaEquipamentoModelList = [];
		if (osAberturaEquipamentoDriftList != null) {
			for (var osAberturaEquipamentoGrouped in osAberturaEquipamentoDriftList) {
				osAberturaEquipamentoModelList.add(
					OsAberturaEquipamentoModel(
						id: osAberturaEquipamentoGrouped.osAberturaEquipamento?.id,
						idOsAbertura: osAberturaEquipamentoGrouped.osAberturaEquipamento?.idOsAbertura,
						idOsEquipamento: osAberturaEquipamentoGrouped.osAberturaEquipamento?.idOsEquipamento,
						osEquipamentoModel: OsEquipamentoModel(
							id: osAberturaEquipamentoGrouped.osEquipamento?.id,
							nome: osAberturaEquipamentoGrouped.osEquipamento?.nome,
							descricao: osAberturaEquipamentoGrouped.osEquipamento?.descricao,
						),
						tipoCobertura: OsAberturaEquipamentoDomain.getTipoCobertura(osAberturaEquipamentoGrouped.osAberturaEquipamento?.tipoCobertura),
						numeroSerie: osAberturaEquipamentoGrouped.osAberturaEquipamento?.numeroSerie,
					)
				);
			}
			return osAberturaEquipamentoModelList;
		}
		return [];
	}

	List<OsProdutoServicoModel> osProdutoServicoDriftToModel(List<OsProdutoServicoGrouped>? osProdutoServicoDriftList) { 
		List<OsProdutoServicoModel> osProdutoServicoModelList = [];
		if (osProdutoServicoDriftList != null) {
			for (var osProdutoServicoGrouped in osProdutoServicoDriftList) {
				osProdutoServicoModelList.add(
					OsProdutoServicoModel(
						id: osProdutoServicoGrouped.osProdutoServico?.id,
						idOsAbertura: osProdutoServicoGrouped.osProdutoServico?.idOsAbertura,
						idProduto: osProdutoServicoGrouped.osProdutoServico?.idProduto,
						produtoModel: ProdutoModel(
							id: osProdutoServicoGrouped.produto?.id,
							idProdutoSubgrupo: osProdutoServicoGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: osProdutoServicoGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: osProdutoServicoGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: osProdutoServicoGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: osProdutoServicoGrouped.produto?.idTributGrupoTributario,
							nome: osProdutoServicoGrouped.produto?.nome,
							descricao: osProdutoServicoGrouped.produto?.descricao,
							gtin: osProdutoServicoGrouped.produto?.gtin,
							codigoInterno: osProdutoServicoGrouped.produto?.codigoInterno,
							valorCompra: osProdutoServicoGrouped.produto?.valorCompra,
							valorVenda: osProdutoServicoGrouped.produto?.valorVenda,
							codigoNcm: osProdutoServicoGrouped.produto?.codigoNcm,
							estoqueMinimo: osProdutoServicoGrouped.produto?.estoqueMinimo,
							estoqueMaximo: osProdutoServicoGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: osProdutoServicoGrouped.produto?.quantidadeEstoque,
							dataCadastro: osProdutoServicoGrouped.produto?.dataCadastro,
						),
						tipo: OsProdutoServicoDomain.getTipo(osProdutoServicoGrouped.osProdutoServico?.tipo),
						complemento: osProdutoServicoGrouped.osProdutoServico?.complemento,
						quantidade: osProdutoServicoGrouped.osProdutoServico?.quantidade,
						valorUnitario: osProdutoServicoGrouped.osProdutoServico?.valorUnitario,
						valorSubtotal: osProdutoServicoGrouped.osProdutoServico?.valorSubtotal,
						taxaDesconto: osProdutoServicoGrouped.osProdutoServico?.taxaDesconto,
						valorDesconto: osProdutoServicoGrouped.osProdutoServico?.valorDesconto,
						valorTotal: osProdutoServicoGrouped.osProdutoServico?.valorTotal,
					)
				);
			}
			return osProdutoServicoModelList;
		}
		return [];
	}

	List<OsEvolucaoModel> osEvolucaoDriftToModel(List<OsEvolucaoGrouped>? osEvolucaoDriftList) { 
		List<OsEvolucaoModel> osEvolucaoModelList = [];
		if (osEvolucaoDriftList != null) {
			for (var osEvolucaoGrouped in osEvolucaoDriftList) {
				osEvolucaoModelList.add(
					OsEvolucaoModel(
						id: osEvolucaoGrouped.osEvolucao?.id,
						idOsAbertura: osEvolucaoGrouped.osEvolucao?.idOsAbertura,
						dataRegistro: osEvolucaoGrouped.osEvolucao?.dataRegistro,
						horaRegistro: osEvolucaoGrouped.osEvolucao?.horaRegistro,
						enviarEmail: OsEvolucaoDomain.getEnviarEmail(osEvolucaoGrouped.osEvolucao?.enviarEmail),
						observacao: osEvolucaoGrouped.osEvolucao?.observacao,
					)
				);
			}
			return osEvolucaoModelList;
		}
		return [];
	}


	OsAberturaGrouped toDrift(OsAberturaModel osAberturaModel) {
		return OsAberturaGrouped(
			osAbertura: OsAbertura(
				id: osAberturaModel.id,
				idOsStatus: osAberturaModel.idOsStatus,
				idColaborador: osAberturaModel.idColaborador,
				idCliente: osAberturaModel.idCliente,
				numero: osAberturaModel.numero,
				dataInicio: osAberturaModel.dataInicio,
				horaInicio: osAberturaModel.horaInicio,
				dataPrevisao: osAberturaModel.dataPrevisao,
				horaPrevisao: Util.removeMask(osAberturaModel.horaPrevisao),
				dataFim: osAberturaModel.dataFim,
				horaFim: Util.removeMask(osAberturaModel.horaFim),
				nomeContato: osAberturaModel.nomeContato,
				foneContato: Util.removeMask(osAberturaModel.foneContato),
				observacaoCliente: osAberturaModel.observacaoCliente,
				observacaoAbertura: osAberturaModel.observacaoAbertura,
			),
			osAberturaEquipamentoGroupedList: osAberturaEquipamentoModelToDrift(osAberturaModel.osAberturaEquipamentoModelList),
			osProdutoServicoGroupedList: osProdutoServicoModelToDrift(osAberturaModel.osProdutoServicoModelList),
			osEvolucaoGroupedList: osEvolucaoModelToDrift(osAberturaModel.osEvolucaoModelList),
		);
	}

	List<OsAberturaEquipamentoGrouped> osAberturaEquipamentoModelToDrift(List<OsAberturaEquipamentoModel>? osAberturaEquipamentoModelList) { 
		List<OsAberturaEquipamentoGrouped> osAberturaEquipamentoGroupedList = [];
		if (osAberturaEquipamentoModelList != null) {
			for (var osAberturaEquipamentoModel in osAberturaEquipamentoModelList) {
				osAberturaEquipamentoGroupedList.add(
					OsAberturaEquipamentoGrouped(
						osAberturaEquipamento: OsAberturaEquipamento(
							id: osAberturaEquipamentoModel.id,
							idOsAbertura: osAberturaEquipamentoModel.idOsAbertura,
							idOsEquipamento: osAberturaEquipamentoModel.idOsEquipamento,
							tipoCobertura: OsAberturaEquipamentoDomain.setTipoCobertura(osAberturaEquipamentoModel.tipoCobertura),
							numeroSerie: osAberturaEquipamentoModel.numeroSerie,
						),
					),
				);
			}
			return osAberturaEquipamentoGroupedList;
		}
		return [];
	}

	List<OsProdutoServicoGrouped> osProdutoServicoModelToDrift(List<OsProdutoServicoModel>? osProdutoServicoModelList) { 
		List<OsProdutoServicoGrouped> osProdutoServicoGroupedList = [];
		if (osProdutoServicoModelList != null) {
			for (var osProdutoServicoModel in osProdutoServicoModelList) {
				osProdutoServicoGroupedList.add(
					OsProdutoServicoGrouped(
						osProdutoServico: OsProdutoServico(
							id: osProdutoServicoModel.id,
							idOsAbertura: osProdutoServicoModel.idOsAbertura,
							idProduto: osProdutoServicoModel.idProduto,
							tipo: OsProdutoServicoDomain.setTipo(osProdutoServicoModel.tipo),
							complemento: osProdutoServicoModel.complemento,
							quantidade: osProdutoServicoModel.quantidade,
							valorUnitario: osProdutoServicoModel.valorUnitario,
							valorSubtotal: osProdutoServicoModel.valorSubtotal,
							taxaDesconto: osProdutoServicoModel.taxaDesconto,
							valorDesconto: osProdutoServicoModel.valorDesconto,
							valorTotal: osProdutoServicoModel.valorTotal,
						),
					),
				);
			}
			return osProdutoServicoGroupedList;
		}
		return [];
	}

	List<OsEvolucaoGrouped> osEvolucaoModelToDrift(List<OsEvolucaoModel>? osEvolucaoModelList) { 
		List<OsEvolucaoGrouped> osEvolucaoGroupedList = [];
		if (osEvolucaoModelList != null) {
			for (var osEvolucaoModel in osEvolucaoModelList) {
				osEvolucaoGroupedList.add(
					OsEvolucaoGrouped(
						osEvolucao: OsEvolucao(
							id: osEvolucaoModel.id,
							idOsAbertura: osEvolucaoModel.idOsAbertura,
							dataRegistro: osEvolucaoModel.dataRegistro,
							horaRegistro: Util.removeMask(osEvolucaoModel.horaRegistro),
							enviarEmail: OsEvolucaoDomain.setEnviarEmail(osEvolucaoModel.enviarEmail),
							observacao: osEvolucaoModel.observacao,
						),
					),
				);
			}
			return osEvolucaoGroupedList;
		}
		return [];
	}

		
}
