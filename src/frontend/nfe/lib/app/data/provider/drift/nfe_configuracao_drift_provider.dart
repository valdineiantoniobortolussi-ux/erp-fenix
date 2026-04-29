import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeConfiguracaoDriftProvider extends ProviderBase {

	Future<List<NfeConfiguracaoModel>?> getList({Filter? filter}) async {
		List<NfeConfiguracaoGrouped> nfeConfiguracaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeConfiguracaoDriftList = await Session.database.nfeConfiguracaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeConfiguracaoDriftList = await Session.database.nfeConfiguracaoDao.getGroupedList(); 
			}
			if (nfeConfiguracaoDriftList.isNotEmpty) {
				return toListModel(nfeConfiguracaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeConfiguracaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeConfiguracaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeConfiguracaoModel?>? insert(NfeConfiguracaoModel nfeConfiguracaoModel) async {
		try {
			final lastPk = await Session.database.nfeConfiguracaoDao.insertObject(toDrift(nfeConfiguracaoModel));
			nfeConfiguracaoModel.id = lastPk;
			return nfeConfiguracaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeConfiguracaoModel?>? update(NfeConfiguracaoModel nfeConfiguracaoModel) async {
		try {
			await Session.database.nfeConfiguracaoDao.updateObject(toDrift(nfeConfiguracaoModel));
			return nfeConfiguracaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeConfiguracaoDao.deleteObject(toDrift(NfeConfiguracaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeConfiguracaoModel> toListModel(List<NfeConfiguracaoGrouped> nfeConfiguracaoDriftList) {
		List<NfeConfiguracaoModel> listModel = [];
		for (var nfeConfiguracaoDrift in nfeConfiguracaoDriftList) {
			listModel.add(toModel(nfeConfiguracaoDrift)!);
		}
		return listModel;
	}	

	NfeConfiguracaoModel? toModel(NfeConfiguracaoGrouped? nfeConfiguracaoDrift) {
		if (nfeConfiguracaoDrift != null) {
			return NfeConfiguracaoModel(
				id: nfeConfiguracaoDrift.nfeConfiguracao?.id,
				certificadoDigitalSerie: nfeConfiguracaoDrift.nfeConfiguracao?.certificadoDigitalSerie,
				certificadoDigitalCaminho: nfeConfiguracaoDrift.nfeConfiguracao?.certificadoDigitalCaminho,
				certificadoDigitalSenha: nfeConfiguracaoDrift.nfeConfiguracao?.certificadoDigitalSenha,
				tipoEmissao: nfeConfiguracaoDrift.nfeConfiguracao?.tipoEmissao,
				formatoImpressaoDanfe: nfeConfiguracaoDrift.nfeConfiguracao?.formatoImpressaoDanfe,
				processoEmissao: nfeConfiguracaoDrift.nfeConfiguracao?.processoEmissao,
				versaoProcessoEmissao: nfeConfiguracaoDrift.nfeConfiguracao?.versaoProcessoEmissao,
				caminhoLogomarca: nfeConfiguracaoDrift.nfeConfiguracao?.caminhoLogomarca,
				salvarXml: NfeConfiguracaoDomain.getSalvarXml(nfeConfiguracaoDrift.nfeConfiguracao?.salvarXml),
				caminhoSalvarXml: nfeConfiguracaoDrift.nfeConfiguracao?.caminhoSalvarXml,
				caminhoSchemas: nfeConfiguracaoDrift.nfeConfiguracao?.caminhoSchemas,
				caminhoArquivoDanfe: nfeConfiguracaoDrift.nfeConfiguracao?.caminhoArquivoDanfe,
				caminhoSalvarPdf: nfeConfiguracaoDrift.nfeConfiguracao?.caminhoSalvarPdf,
				webserviceUf: NfeConfiguracaoDomain.getWebserviceUf(nfeConfiguracaoDrift.nfeConfiguracao?.webserviceUf),
				webserviceAmbiente: nfeConfiguracaoDrift.nfeConfiguracao?.webserviceAmbiente,
				webserviceProxyHost: nfeConfiguracaoDrift.nfeConfiguracao?.webserviceProxyHost,
				webserviceProxyPorta: nfeConfiguracaoDrift.nfeConfiguracao?.webserviceProxyPorta,
				webserviceProxyUsuario: nfeConfiguracaoDrift.nfeConfiguracao?.webserviceProxyUsuario,
				webserviceProxySenha: nfeConfiguracaoDrift.nfeConfiguracao?.webserviceProxySenha,
				webserviceVisualizar: NfeConfiguracaoDomain.getWebserviceVisualizar(nfeConfiguracaoDrift.nfeConfiguracao?.webserviceVisualizar),
				emailServidorSmtp: nfeConfiguracaoDrift.nfeConfiguracao?.emailServidorSmtp,
				emailPorta: nfeConfiguracaoDrift.nfeConfiguracao?.emailPorta,
				emailUsuario: nfeConfiguracaoDrift.nfeConfiguracao?.emailUsuario,
				emailSenha: nfeConfiguracaoDrift.nfeConfiguracao?.emailSenha,
				emailAssunto: nfeConfiguracaoDrift.nfeConfiguracao?.emailAssunto,
				emailAutenticaSsl: NfeConfiguracaoDomain.getEmailAutenticaSsl(nfeConfiguracaoDrift.nfeConfiguracao?.emailAutenticaSsl),
				emailTexto: nfeConfiguracaoDrift.nfeConfiguracao?.emailTexto,
			);
		} else {
			return null;
		}
	}


	NfeConfiguracaoGrouped toDrift(NfeConfiguracaoModel nfeConfiguracaoModel) {
		return NfeConfiguracaoGrouped(
			nfeConfiguracao: NfeConfiguracao(
				id: nfeConfiguracaoModel.id,
				certificadoDigitalSerie: nfeConfiguracaoModel.certificadoDigitalSerie,
				certificadoDigitalCaminho: nfeConfiguracaoModel.certificadoDigitalCaminho,
				certificadoDigitalSenha: nfeConfiguracaoModel.certificadoDigitalSenha,
				tipoEmissao: nfeConfiguracaoModel.tipoEmissao,
				formatoImpressaoDanfe: nfeConfiguracaoModel.formatoImpressaoDanfe,
				processoEmissao: nfeConfiguracaoModel.processoEmissao,
				versaoProcessoEmissao: nfeConfiguracaoModel.versaoProcessoEmissao,
				caminhoLogomarca: nfeConfiguracaoModel.caminhoLogomarca,
				salvarXml: NfeConfiguracaoDomain.setSalvarXml(nfeConfiguracaoModel.salvarXml),
				caminhoSalvarXml: nfeConfiguracaoModel.caminhoSalvarXml,
				caminhoSchemas: nfeConfiguracaoModel.caminhoSchemas,
				caminhoArquivoDanfe: nfeConfiguracaoModel.caminhoArquivoDanfe,
				caminhoSalvarPdf: nfeConfiguracaoModel.caminhoSalvarPdf,
				webserviceUf: NfeConfiguracaoDomain.setWebserviceUf(nfeConfiguracaoModel.webserviceUf),
				webserviceAmbiente: nfeConfiguracaoModel.webserviceAmbiente,
				webserviceProxyHost: nfeConfiguracaoModel.webserviceProxyHost,
				webserviceProxyPorta: nfeConfiguracaoModel.webserviceProxyPorta,
				webserviceProxyUsuario: nfeConfiguracaoModel.webserviceProxyUsuario,
				webserviceProxySenha: nfeConfiguracaoModel.webserviceProxySenha,
				webserviceVisualizar: NfeConfiguracaoDomain.setWebserviceVisualizar(nfeConfiguracaoModel.webserviceVisualizar),
				emailServidorSmtp: nfeConfiguracaoModel.emailServidorSmtp,
				emailPorta: nfeConfiguracaoModel.emailPorta,
				emailUsuario: nfeConfiguracaoModel.emailUsuario,
				emailSenha: nfeConfiguracaoModel.emailSenha,
				emailAssunto: nfeConfiguracaoModel.emailAssunto,
				emailAutenticaSsl: NfeConfiguracaoDomain.setEmailAutenticaSsl(nfeConfiguracaoModel.emailAutenticaSsl),
				emailTexto: nfeConfiguracaoModel.emailTexto,
			),
		);
	}

		
}
