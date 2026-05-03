import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/provider/provider_base.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/data/domain/domain_imports.dart';

class MdfeCabecalhoDriftProvider extends ProviderBase {

	Future<List<MdfeCabecalhoModel>?> getList({Filter? filter}) async {
		List<MdfeCabecalhoGrouped> mdfeCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				mdfeCabecalhoDriftList = await Session.database.mdfeCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				mdfeCabecalhoDriftList = await Session.database.mdfeCabecalhoDao.getGroupedList(); 
			}
			if (mdfeCabecalhoDriftList.isNotEmpty) {
				return toListModel(mdfeCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MdfeCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.mdfeCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeCabecalhoModel?>? insert(MdfeCabecalhoModel mdfeCabecalhoModel) async {
		try {
			final lastPk = await Session.database.mdfeCabecalhoDao.insertObject(toDrift(mdfeCabecalhoModel));
			mdfeCabecalhoModel.id = lastPk;
			return mdfeCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeCabecalhoModel?>? update(MdfeCabecalhoModel mdfeCabecalhoModel) async {
		try {
			await Session.database.mdfeCabecalhoDao.updateObject(toDrift(mdfeCabecalhoModel));
			return mdfeCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.mdfeCabecalhoDao.deleteObject(toDrift(MdfeCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MdfeCabecalhoModel> toListModel(List<MdfeCabecalhoGrouped> mdfeCabecalhoDriftList) {
		List<MdfeCabecalhoModel> listModel = [];
		for (var mdfeCabecalhoDrift in mdfeCabecalhoDriftList) {
			listModel.add(toModel(mdfeCabecalhoDrift)!);
		}
		return listModel;
	}	

	MdfeCabecalhoModel? toModel(MdfeCabecalhoGrouped? mdfeCabecalhoDrift) {
		if (mdfeCabecalhoDrift != null) {
			return MdfeCabecalhoModel(
				id: mdfeCabecalhoDrift.mdfeCabecalho?.id,
				uf: MdfeCabecalhoDomain.getUf(mdfeCabecalhoDrift.mdfeCabecalho?.uf),
				tipoAmbiente: MdfeCabecalhoDomain.getTipoAmbiente(mdfeCabecalhoDrift.mdfeCabecalho?.tipoAmbiente),
				tipoEmitente: MdfeCabecalhoDomain.getTipoEmitente(mdfeCabecalhoDrift.mdfeCabecalho?.tipoEmitente),
				tipoTransportadora: MdfeCabecalhoDomain.getTipoTransportadora(mdfeCabecalhoDrift.mdfeCabecalho?.tipoTransportadora),
				modelo: MdfeCabecalhoDomain.getModelo(mdfeCabecalhoDrift.mdfeCabecalho?.modelo),
				serie: mdfeCabecalhoDrift.mdfeCabecalho?.serie,
				numeroMdfe: mdfeCabecalhoDrift.mdfeCabecalho?.numeroMdfe,
				codigoNumerico: mdfeCabecalhoDrift.mdfeCabecalho?.codigoNumerico,
				chaveAcesso: mdfeCabecalhoDrift.mdfeCabecalho?.chaveAcesso,
				digitoVerificador: mdfeCabecalhoDrift.mdfeCabecalho?.digitoVerificador,
				modal: MdfeCabecalhoDomain.getModal(mdfeCabecalhoDrift.mdfeCabecalho?.modal),
				dataHoraEmissao: mdfeCabecalhoDrift.mdfeCabecalho?.dataHoraEmissao,
				tipoEmissao: MdfeCabecalhoDomain.getTipoEmissao(mdfeCabecalhoDrift.mdfeCabecalho?.tipoEmissao),
				processoEmissao: MdfeCabecalhoDomain.getProcessoEmissao(mdfeCabecalhoDrift.mdfeCabecalho?.processoEmissao),
				versaoProcessoEmissao: mdfeCabecalhoDrift.mdfeCabecalho?.versaoProcessoEmissao,
				ufInicio: MdfeCabecalhoDomain.getUfInicio(mdfeCabecalhoDrift.mdfeCabecalho?.ufInicio),
				ufFim: MdfeCabecalhoDomain.getUfFim(mdfeCabecalhoDrift.mdfeCabecalho?.ufFim),
				dataHoraPrevisaoViagem: mdfeCabecalhoDrift.mdfeCabecalho?.dataHoraPrevisaoViagem,
				quantidadeTotalCte: mdfeCabecalhoDrift.mdfeCabecalho?.quantidadeTotalCte,
				quantidadeTotalNfe: mdfeCabecalhoDrift.mdfeCabecalho?.quantidadeTotalNfe,
				quantidadeTotalMdfe: mdfeCabecalhoDrift.mdfeCabecalho?.quantidadeTotalMdfe,
				codigoUnidadeMedida: MdfeCabecalhoDomain.getCodigoUnidadeMedida(mdfeCabecalhoDrift.mdfeCabecalho?.codigoUnidadeMedida),
				pesoBrutoCarga: mdfeCabecalhoDrift.mdfeCabecalho?.pesoBrutoCarga,
				valorCarga: mdfeCabecalhoDrift.mdfeCabecalho?.valorCarga,
				numeroProtocolo: mdfeCabecalhoDrift.mdfeCabecalho?.numeroProtocolo,
				mdfeLacreModelList: mdfeLacreDriftToModel(mdfeCabecalhoDrift.mdfeLacreGroupedList),
				mdfeMunicipioDescarregaModelList: mdfeMunicipioDescarregaDriftToModel(mdfeCabecalhoDrift.mdfeMunicipioDescarregaGroupedList),
				mdfeEmitenteModelList: mdfeEmitenteDriftToModel(mdfeCabecalhoDrift.mdfeEmitenteGroupedList),
				mdfePercursoModelList: mdfePercursoDriftToModel(mdfeCabecalhoDrift.mdfePercursoGroupedList),
				mdfeMunicipioCarregamentoModelList: mdfeMunicipioCarregamentoDriftToModel(mdfeCabecalhoDrift.mdfeMunicipioCarregamentoGroupedList),
				mdfeRodoviarioModelList: mdfeRodoviarioDriftToModel(mdfeCabecalhoDrift.mdfeRodoviarioGroupedList),
				mdfeInformacaoSeguroModelList: mdfeInformacaoSeguroDriftToModel(mdfeCabecalhoDrift.mdfeInformacaoSeguroGroupedList),
			);
		} else {
			return null;
		}
	}

	List<MdfeLacreModel> mdfeLacreDriftToModel(List<MdfeLacreGrouped>? mdfeLacreDriftList) { 
		List<MdfeLacreModel> mdfeLacreModelList = [];
		if (mdfeLacreDriftList != null) {
			for (var mdfeLacreGrouped in mdfeLacreDriftList) {
				mdfeLacreModelList.add(
					MdfeLacreModel(
						id: mdfeLacreGrouped.mdfeLacre?.id,
						idMdfeCabecalho: mdfeLacreGrouped.mdfeLacre?.idMdfeCabecalho,
						numeroLacre: mdfeLacreGrouped.mdfeLacre?.numeroLacre,
					)
				);
			}
			return mdfeLacreModelList;
		}
		return [];
	}

	List<MdfeMunicipioDescarregaModel> mdfeMunicipioDescarregaDriftToModel(List<MdfeMunicipioDescarregaGrouped>? mdfeMunicipioDescarregaDriftList) { 
		List<MdfeMunicipioDescarregaModel> mdfeMunicipioDescarregaModelList = [];
		if (mdfeMunicipioDescarregaDriftList != null) {
			for (var mdfeMunicipioDescarregaGrouped in mdfeMunicipioDescarregaDriftList) {
				mdfeMunicipioDescarregaModelList.add(
					MdfeMunicipioDescarregaModel(
						id: mdfeMunicipioDescarregaGrouped.mdfeMunicipioDescarrega?.id,
						idMdfeCabecalho: mdfeMunicipioDescarregaGrouped.mdfeMunicipioDescarrega?.idMdfeCabecalho,
						codigoMunicipio: mdfeMunicipioDescarregaGrouped.mdfeMunicipioDescarrega?.codigoMunicipio,
						nomeMunicipio: mdfeMunicipioDescarregaGrouped.mdfeMunicipioDescarrega?.nomeMunicipio,
					)
				);
			}
			return mdfeMunicipioDescarregaModelList;
		}
		return [];
	}

	List<MdfeEmitenteModel> mdfeEmitenteDriftToModel(List<MdfeEmitenteGrouped>? mdfeEmitenteDriftList) { 
		List<MdfeEmitenteModel> mdfeEmitenteModelList = [];
		if (mdfeEmitenteDriftList != null) {
			for (var mdfeEmitenteGrouped in mdfeEmitenteDriftList) {
				mdfeEmitenteModelList.add(
					MdfeEmitenteModel(
						id: mdfeEmitenteGrouped.mdfeEmitente?.id,
						idMdfeCabecalho: mdfeEmitenteGrouped.mdfeEmitente?.idMdfeCabecalho,
						nome: mdfeEmitenteGrouped.mdfeEmitente?.nome,
						fantasia: mdfeEmitenteGrouped.mdfeEmitente?.fantasia,
						cnpj: mdfeEmitenteGrouped.mdfeEmitente?.cnpj,
						ie: mdfeEmitenteGrouped.mdfeEmitente?.ie,
						logradouro: mdfeEmitenteGrouped.mdfeEmitente?.logradouro,
						numero: mdfeEmitenteGrouped.mdfeEmitente?.numero,
						complemento: mdfeEmitenteGrouped.mdfeEmitente?.complemento,
						bairro: mdfeEmitenteGrouped.mdfeEmitente?.bairro,
						codigoMunicipio: mdfeEmitenteGrouped.mdfeEmitente?.codigoMunicipio,
						nomeMunicipio: mdfeEmitenteGrouped.mdfeEmitente?.nomeMunicipio,
						cep: mdfeEmitenteGrouped.mdfeEmitente?.cep,
						uf: MdfeEmitenteDomain.getUf(mdfeEmitenteGrouped.mdfeEmitente?.uf),
						telefone: mdfeEmitenteGrouped.mdfeEmitente?.telefone,
						email: mdfeEmitenteGrouped.mdfeEmitente?.email,
					)
				);
			}
			return mdfeEmitenteModelList;
		}
		return [];
	}

	List<MdfePercursoModel> mdfePercursoDriftToModel(List<MdfePercursoGrouped>? mdfePercursoDriftList) { 
		List<MdfePercursoModel> mdfePercursoModelList = [];
		if (mdfePercursoDriftList != null) {
			for (var mdfePercursoGrouped in mdfePercursoDriftList) {
				mdfePercursoModelList.add(
					MdfePercursoModel(
						id: mdfePercursoGrouped.mdfePercurso?.id,
						idMdfeCabecalho: mdfePercursoGrouped.mdfePercurso?.idMdfeCabecalho,
						ufPercurso: MdfePercursoDomain.getUfPercurso(mdfePercursoGrouped.mdfePercurso?.ufPercurso),
						dataInicioViagem: mdfePercursoGrouped.mdfePercurso?.dataInicioViagem,
					)
				);
			}
			return mdfePercursoModelList;
		}
		return [];
	}

	List<MdfeMunicipioCarregamentoModel> mdfeMunicipioCarregamentoDriftToModel(List<MdfeMunicipioCarregamentoGrouped>? mdfeMunicipioCarregamentoDriftList) { 
		List<MdfeMunicipioCarregamentoModel> mdfeMunicipioCarregamentoModelList = [];
		if (mdfeMunicipioCarregamentoDriftList != null) {
			for (var mdfeMunicipioCarregamentoGrouped in mdfeMunicipioCarregamentoDriftList) {
				mdfeMunicipioCarregamentoModelList.add(
					MdfeMunicipioCarregamentoModel(
						id: mdfeMunicipioCarregamentoGrouped.mdfeMunicipioCarregamento?.id,
						idMdfeCabecalho: mdfeMunicipioCarregamentoGrouped.mdfeMunicipioCarregamento?.idMdfeCabecalho,
						codigoMunicipio: mdfeMunicipioCarregamentoGrouped.mdfeMunicipioCarregamento?.codigoMunicipio,
						nomeMunicipio: mdfeMunicipioCarregamentoGrouped.mdfeMunicipioCarregamento?.nomeMunicipio,
					)
				);
			}
			return mdfeMunicipioCarregamentoModelList;
		}
		return [];
	}

	List<MdfeRodoviarioModel> mdfeRodoviarioDriftToModel(List<MdfeRodoviarioGrouped>? mdfeRodoviarioDriftList) { 
		List<MdfeRodoviarioModel> mdfeRodoviarioModelList = [];
		if (mdfeRodoviarioDriftList != null) {
			for (var mdfeRodoviarioGrouped in mdfeRodoviarioDriftList) {
				mdfeRodoviarioModelList.add(
					MdfeRodoviarioModel(
						id: mdfeRodoviarioGrouped.mdfeRodoviario?.id,
						idMdfeCabecalho: mdfeRodoviarioGrouped.mdfeRodoviario?.idMdfeCabecalho,
						rntrc: mdfeRodoviarioGrouped.mdfeRodoviario?.rntrc,
						codigoAgendamento: mdfeRodoviarioGrouped.mdfeRodoviario?.codigoAgendamento,
					)
				);
			}
			return mdfeRodoviarioModelList;
		}
		return [];
	}

	List<MdfeInformacaoSeguroModel> mdfeInformacaoSeguroDriftToModel(List<MdfeInformacaoSeguroGrouped>? mdfeInformacaoSeguroDriftList) { 
		List<MdfeInformacaoSeguroModel> mdfeInformacaoSeguroModelList = [];
		if (mdfeInformacaoSeguroDriftList != null) {
			for (var mdfeInformacaoSeguroGrouped in mdfeInformacaoSeguroDriftList) {
				mdfeInformacaoSeguroModelList.add(
					MdfeInformacaoSeguroModel(
						id: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.id,
						idMdfeCabecalho: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.idMdfeCabecalho,
						responsavel: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.responsavel,
						cnpjCpf: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.cnpjCpf,
						seguradora: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.seguradora,
						cnpjSeguradora: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.cnpjSeguradora,
						apolice: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.apolice,
						averbacao: mdfeInformacaoSeguroGrouped.mdfeInformacaoSeguro?.averbacao,
					)
				);
			}
			return mdfeInformacaoSeguroModelList;
		}
		return [];
	}


	MdfeCabecalhoGrouped toDrift(MdfeCabecalhoModel mdfeCabecalhoModel) {
		return MdfeCabecalhoGrouped(
			mdfeCabecalho: MdfeCabecalho(
				id: mdfeCabecalhoModel.id,
				uf: MdfeCabecalhoDomain.setUf(mdfeCabecalhoModel.uf),
				tipoAmbiente: MdfeCabecalhoDomain.setTipoAmbiente(mdfeCabecalhoModel.tipoAmbiente),
				tipoEmitente: MdfeCabecalhoDomain.setTipoEmitente(mdfeCabecalhoModel.tipoEmitente),
				tipoTransportadora: MdfeCabecalhoDomain.setTipoTransportadora(mdfeCabecalhoModel.tipoTransportadora),
				modelo: MdfeCabecalhoDomain.setModelo(mdfeCabecalhoModel.modelo),
				serie: mdfeCabecalhoModel.serie,
				numeroMdfe: mdfeCabecalhoModel.numeroMdfe,
				codigoNumerico: mdfeCabecalhoModel.codigoNumerico,
				chaveAcesso: mdfeCabecalhoModel.chaveAcesso,
				digitoVerificador: mdfeCabecalhoModel.digitoVerificador,
				modal: MdfeCabecalhoDomain.setModal(mdfeCabecalhoModel.modal),
				dataHoraEmissao: mdfeCabecalhoModel.dataHoraEmissao,
				tipoEmissao: MdfeCabecalhoDomain.setTipoEmissao(mdfeCabecalhoModel.tipoEmissao),
				processoEmissao: MdfeCabecalhoDomain.setProcessoEmissao(mdfeCabecalhoModel.processoEmissao),
				versaoProcessoEmissao: mdfeCabecalhoModel.versaoProcessoEmissao,
				ufInicio: MdfeCabecalhoDomain.setUfInicio(mdfeCabecalhoModel.ufInicio),
				ufFim: MdfeCabecalhoDomain.setUfFim(mdfeCabecalhoModel.ufFim),
				dataHoraPrevisaoViagem: mdfeCabecalhoModel.dataHoraPrevisaoViagem,
				quantidadeTotalCte: mdfeCabecalhoModel.quantidadeTotalCte,
				quantidadeTotalNfe: mdfeCabecalhoModel.quantidadeTotalNfe,
				quantidadeTotalMdfe: mdfeCabecalhoModel.quantidadeTotalMdfe,
				codigoUnidadeMedida: MdfeCabecalhoDomain.setCodigoUnidadeMedida(mdfeCabecalhoModel.codigoUnidadeMedida),
				pesoBrutoCarga: mdfeCabecalhoModel.pesoBrutoCarga,
				valorCarga: mdfeCabecalhoModel.valorCarga,
				numeroProtocolo: mdfeCabecalhoModel.numeroProtocolo,
			),
			mdfeLacreGroupedList: mdfeLacreModelToDrift(mdfeCabecalhoModel.mdfeLacreModelList),
			mdfeMunicipioDescarregaGroupedList: mdfeMunicipioDescarregaModelToDrift(mdfeCabecalhoModel.mdfeMunicipioDescarregaModelList),
			mdfeEmitenteGroupedList: mdfeEmitenteModelToDrift(mdfeCabecalhoModel.mdfeEmitenteModelList),
			mdfePercursoGroupedList: mdfePercursoModelToDrift(mdfeCabecalhoModel.mdfePercursoModelList),
			mdfeMunicipioCarregamentoGroupedList: mdfeMunicipioCarregamentoModelToDrift(mdfeCabecalhoModel.mdfeMunicipioCarregamentoModelList),
			mdfeRodoviarioGroupedList: mdfeRodoviarioModelToDrift(mdfeCabecalhoModel.mdfeRodoviarioModelList),
			mdfeInformacaoSeguroGroupedList: mdfeInformacaoSeguroModelToDrift(mdfeCabecalhoModel.mdfeInformacaoSeguroModelList),
		);
	}

	List<MdfeLacreGrouped> mdfeLacreModelToDrift(List<MdfeLacreModel>? mdfeLacreModelList) { 
		List<MdfeLacreGrouped> mdfeLacreGroupedList = [];
		if (mdfeLacreModelList != null) {
			for (var mdfeLacreModel in mdfeLacreModelList) {
				mdfeLacreGroupedList.add(
					MdfeLacreGrouped(
						mdfeLacre: MdfeLacre(
							id: mdfeLacreModel.id,
							idMdfeCabecalho: mdfeLacreModel.idMdfeCabecalho,
							numeroLacre: mdfeLacreModel.numeroLacre,
						),
					),
				);
			}
			return mdfeLacreGroupedList;
		}
		return [];
	}

	List<MdfeMunicipioDescarregaGrouped> mdfeMunicipioDescarregaModelToDrift(List<MdfeMunicipioDescarregaModel>? mdfeMunicipioDescarregaModelList) { 
		List<MdfeMunicipioDescarregaGrouped> mdfeMunicipioDescarregaGroupedList = [];
		if (mdfeMunicipioDescarregaModelList != null) {
			for (var mdfeMunicipioDescarregaModel in mdfeMunicipioDescarregaModelList) {
				mdfeMunicipioDescarregaGroupedList.add(
					MdfeMunicipioDescarregaGrouped(
						mdfeMunicipioDescarrega: MdfeMunicipioDescarrega(
							id: mdfeMunicipioDescarregaModel.id,
							idMdfeCabecalho: mdfeMunicipioDescarregaModel.idMdfeCabecalho,
							codigoMunicipio: mdfeMunicipioDescarregaModel.codigoMunicipio,
							nomeMunicipio: mdfeMunicipioDescarregaModel.nomeMunicipio,
						),
					),
				);
			}
			return mdfeMunicipioDescarregaGroupedList;
		}
		return [];
	}

	List<MdfeEmitenteGrouped> mdfeEmitenteModelToDrift(List<MdfeEmitenteModel>? mdfeEmitenteModelList) { 
		List<MdfeEmitenteGrouped> mdfeEmitenteGroupedList = [];
		if (mdfeEmitenteModelList != null) {
			for (var mdfeEmitenteModel in mdfeEmitenteModelList) {
				mdfeEmitenteGroupedList.add(
					MdfeEmitenteGrouped(
						mdfeEmitente: MdfeEmitente(
							id: mdfeEmitenteModel.id,
							idMdfeCabecalho: mdfeEmitenteModel.idMdfeCabecalho,
							nome: mdfeEmitenteModel.nome,
							fantasia: mdfeEmitenteModel.fantasia,
							cnpj: Util.removeMask(mdfeEmitenteModel.cnpj),
							ie: mdfeEmitenteModel.ie,
							logradouro: mdfeEmitenteModel.logradouro,
							numero: mdfeEmitenteModel.numero,
							complemento: mdfeEmitenteModel.complemento,
							bairro: mdfeEmitenteModel.bairro,
							codigoMunicipio: mdfeEmitenteModel.codigoMunicipio,
							nomeMunicipio: mdfeEmitenteModel.nomeMunicipio,
							cep: Util.removeMask(mdfeEmitenteModel.cep),
							uf: MdfeEmitenteDomain.setUf(mdfeEmitenteModel.uf),
							telefone: Util.removeMask(mdfeEmitenteModel.telefone),
							email: mdfeEmitenteModel.email,
						),
					),
				);
			}
			return mdfeEmitenteGroupedList;
		}
		return [];
	}

	List<MdfePercursoGrouped> mdfePercursoModelToDrift(List<MdfePercursoModel>? mdfePercursoModelList) { 
		List<MdfePercursoGrouped> mdfePercursoGroupedList = [];
		if (mdfePercursoModelList != null) {
			for (var mdfePercursoModel in mdfePercursoModelList) {
				mdfePercursoGroupedList.add(
					MdfePercursoGrouped(
						mdfePercurso: MdfePercurso(
							id: mdfePercursoModel.id,
							idMdfeCabecalho: mdfePercursoModel.idMdfeCabecalho,
							ufPercurso: MdfePercursoDomain.setUfPercurso(mdfePercursoModel.ufPercurso),
							dataInicioViagem: mdfePercursoModel.dataInicioViagem,
						),
					),
				);
			}
			return mdfePercursoGroupedList;
		}
		return [];
	}

	List<MdfeMunicipioCarregamentoGrouped> mdfeMunicipioCarregamentoModelToDrift(List<MdfeMunicipioCarregamentoModel>? mdfeMunicipioCarregamentoModelList) { 
		List<MdfeMunicipioCarregamentoGrouped> mdfeMunicipioCarregamentoGroupedList = [];
		if (mdfeMunicipioCarregamentoModelList != null) {
			for (var mdfeMunicipioCarregamentoModel in mdfeMunicipioCarregamentoModelList) {
				mdfeMunicipioCarregamentoGroupedList.add(
					MdfeMunicipioCarregamentoGrouped(
						mdfeMunicipioCarregamento: MdfeMunicipioCarregamento(
							id: mdfeMunicipioCarregamentoModel.id,
							idMdfeCabecalho: mdfeMunicipioCarregamentoModel.idMdfeCabecalho,
							codigoMunicipio: mdfeMunicipioCarregamentoModel.codigoMunicipio,
							nomeMunicipio: mdfeMunicipioCarregamentoModel.nomeMunicipio,
						),
					),
				);
			}
			return mdfeMunicipioCarregamentoGroupedList;
		}
		return [];
	}

	List<MdfeRodoviarioGrouped> mdfeRodoviarioModelToDrift(List<MdfeRodoviarioModel>? mdfeRodoviarioModelList) { 
		List<MdfeRodoviarioGrouped> mdfeRodoviarioGroupedList = [];
		if (mdfeRodoviarioModelList != null) {
			for (var mdfeRodoviarioModel in mdfeRodoviarioModelList) {
				mdfeRodoviarioGroupedList.add(
					MdfeRodoviarioGrouped(
						mdfeRodoviario: MdfeRodoviario(
							id: mdfeRodoviarioModel.id,
							idMdfeCabecalho: mdfeRodoviarioModel.idMdfeCabecalho,
							rntrc: mdfeRodoviarioModel.rntrc,
							codigoAgendamento: mdfeRodoviarioModel.codigoAgendamento,
						),
					),
				);
			}
			return mdfeRodoviarioGroupedList;
		}
		return [];
	}

	List<MdfeInformacaoSeguroGrouped> mdfeInformacaoSeguroModelToDrift(List<MdfeInformacaoSeguroModel>? mdfeInformacaoSeguroModelList) { 
		List<MdfeInformacaoSeguroGrouped> mdfeInformacaoSeguroGroupedList = [];
		if (mdfeInformacaoSeguroModelList != null) {
			for (var mdfeInformacaoSeguroModel in mdfeInformacaoSeguroModelList) {
				mdfeInformacaoSeguroGroupedList.add(
					MdfeInformacaoSeguroGrouped(
						mdfeInformacaoSeguro: MdfeInformacaoSeguro(
							id: mdfeInformacaoSeguroModel.id,
							idMdfeCabecalho: mdfeInformacaoSeguroModel.idMdfeCabecalho,
							responsavel: mdfeInformacaoSeguroModel.responsavel,
							cnpjCpf: Util.removeMask(mdfeInformacaoSeguroModel.cnpjCpf),
							seguradora: mdfeInformacaoSeguroModel.seguradora,
							cnpjSeguradora: Util.removeMask(mdfeInformacaoSeguroModel.cnpjSeguradora),
							apolice: mdfeInformacaoSeguroModel.apolice,
							averbacao: mdfeInformacaoSeguroModel.averbacao,
						),
					),
				);
			}
			return mdfeInformacaoSeguroGroupedList;
		}
		return [];
	}

		
}
