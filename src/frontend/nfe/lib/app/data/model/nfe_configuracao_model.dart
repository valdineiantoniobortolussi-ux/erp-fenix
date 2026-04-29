import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeConfiguracaoModel {
	int? id;
	String? certificadoDigitalSerie;
	String? certificadoDigitalCaminho;
	String? certificadoDigitalSenha;
	int? tipoEmissao;
	int? formatoImpressaoDanfe;
	int? processoEmissao;
	String? versaoProcessoEmissao;
	String? caminhoLogomarca;
	String? salvarXml;
	String? caminhoSalvarXml;
	String? caminhoSchemas;
	String? caminhoArquivoDanfe;
	String? caminhoSalvarPdf;
	String? webserviceUf;
	int? webserviceAmbiente;
	String? webserviceProxyHost;
	int? webserviceProxyPorta;
	String? webserviceProxyUsuario;
	String? webserviceProxySenha;
	String? webserviceVisualizar;
	String? emailServidorSmtp;
	int? emailPorta;
	String? emailUsuario;
	String? emailSenha;
	String? emailAssunto;
	String? emailAutenticaSsl;
	String? emailTexto;

	NfeConfiguracaoModel({
		this.id,
		this.certificadoDigitalSerie,
		this.certificadoDigitalCaminho,
		this.certificadoDigitalSenha,
		this.tipoEmissao,
		this.formatoImpressaoDanfe,
		this.processoEmissao,
		this.versaoProcessoEmissao,
		this.caminhoLogomarca,
		this.salvarXml,
		this.caminhoSalvarXml,
		this.caminhoSchemas,
		this.caminhoArquivoDanfe,
		this.caminhoSalvarPdf,
		this.webserviceUf,
		this.webserviceAmbiente,
		this.webserviceProxyHost,
		this.webserviceProxyPorta,
		this.webserviceProxyUsuario,
		this.webserviceProxySenha,
		this.webserviceVisualizar,
		this.emailServidorSmtp,
		this.emailPorta,
		this.emailUsuario,
		this.emailSenha,
		this.emailAssunto,
		this.emailAutenticaSsl,
		this.emailTexto,
	});

	static List<String> dbColumns = <String>[
		'id',
		'certificado_digital_serie',
		'certificado_digital_caminho',
		'certificado_digital_senha',
		'tipo_emissao',
		'formato_impressao_danfe',
		'processo_emissao',
		'versao_processo_emissao',
		'caminho_logomarca',
		'salvar_xml',
		'caminho_salvar_xml',
		'caminho_schemas',
		'caminho_arquivo_danfe',
		'caminho_salvar_pdf',
		'webservice_uf',
		'webservice_ambiente',
		'webservice_proxy_host',
		'webservice_proxy_porta',
		'webservice_proxy_usuario',
		'webservice_proxy_senha',
		'webservice_visualizar',
		'email_servidor_smtp',
		'email_porta',
		'email_usuario',
		'email_senha',
		'email_assunto',
		'email_autentica_ssl',
		'email_texto',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Certificado Digital Serie',
		'Certificado Digital Caminho',
		'Certificado Digital Senha',
		'Tipo Emissao',
		'Formato Impressao Danfe',
		'Processo Emissao',
		'Versao Processo Emissao',
		'Caminho Logomarca',
		'Salvar Xml',
		'Caminho Salvar Xml',
		'Caminho Schemas',
		'Caminho Arquivo Danfe',
		'Caminho Salvar Pdf',
		'Webservice Uf',
		'Webservice Ambiente',
		'Webservice Proxy Host',
		'Webservice Proxy Porta',
		'Webservice Proxy Usuario',
		'Webservice Proxy Senha',
		'Webservice Visualizar',
		'Email Servidor Smtp',
		'Email Porta',
		'Email Usuario',
		'Email Senha',
		'Email Assunto',
		'Email Autentica Ssl',
		'Email Texto',
	];

	NfeConfiguracaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		certificadoDigitalSerie = jsonData['certificadoDigitalSerie'];
		certificadoDigitalCaminho = jsonData['certificadoDigitalCaminho'];
		certificadoDigitalSenha = jsonData['certificadoDigitalSenha'];
		tipoEmissao = jsonData['tipoEmissao'];
		formatoImpressaoDanfe = jsonData['formatoImpressaoDanfe'];
		processoEmissao = jsonData['processoEmissao'];
		versaoProcessoEmissao = jsonData['versaoProcessoEmissao'];
		caminhoLogomarca = jsonData['caminhoLogomarca'];
		salvarXml = NfeConfiguracaoDomain.getSalvarXml(jsonData['salvarXml']);
		caminhoSalvarXml = jsonData['caminhoSalvarXml'];
		caminhoSchemas = jsonData['caminhoSchemas'];
		caminhoArquivoDanfe = jsonData['caminhoArquivoDanfe'];
		caminhoSalvarPdf = jsonData['caminhoSalvarPdf'];
		webserviceUf = NfeConfiguracaoDomain.getWebserviceUf(jsonData['webserviceUf']);
		webserviceAmbiente = jsonData['webserviceAmbiente'];
		webserviceProxyHost = jsonData['webserviceProxyHost'];
		webserviceProxyPorta = jsonData['webserviceProxyPorta'];
		webserviceProxyUsuario = jsonData['webserviceProxyUsuario'];
		webserviceProxySenha = jsonData['webserviceProxySenha'];
		webserviceVisualizar = NfeConfiguracaoDomain.getWebserviceVisualizar(jsonData['webserviceVisualizar']);
		emailServidorSmtp = jsonData['emailServidorSmtp'];
		emailPorta = jsonData['emailPorta'];
		emailUsuario = jsonData['emailUsuario'];
		emailSenha = jsonData['emailSenha'];
		emailAssunto = jsonData['emailAssunto'];
		emailAutenticaSsl = NfeConfiguracaoDomain.getEmailAutenticaSsl(jsonData['emailAutenticaSsl']);
		emailTexto = jsonData['emailTexto'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['certificadoDigitalSerie'] = certificadoDigitalSerie;
		jsonData['certificadoDigitalCaminho'] = certificadoDigitalCaminho;
		jsonData['certificadoDigitalSenha'] = certificadoDigitalSenha;
		jsonData['tipoEmissao'] = tipoEmissao;
		jsonData['formatoImpressaoDanfe'] = formatoImpressaoDanfe;
		jsonData['processoEmissao'] = processoEmissao;
		jsonData['versaoProcessoEmissao'] = versaoProcessoEmissao;
		jsonData['caminhoLogomarca'] = caminhoLogomarca;
		jsonData['salvarXml'] = NfeConfiguracaoDomain.setSalvarXml(salvarXml);
		jsonData['caminhoSalvarXml'] = caminhoSalvarXml;
		jsonData['caminhoSchemas'] = caminhoSchemas;
		jsonData['caminhoArquivoDanfe'] = caminhoArquivoDanfe;
		jsonData['caminhoSalvarPdf'] = caminhoSalvarPdf;
		jsonData['webserviceUf'] = NfeConfiguracaoDomain.setWebserviceUf(webserviceUf);
		jsonData['webserviceAmbiente'] = webserviceAmbiente;
		jsonData['webserviceProxyHost'] = webserviceProxyHost;
		jsonData['webserviceProxyPorta'] = webserviceProxyPorta;
		jsonData['webserviceProxyUsuario'] = webserviceProxyUsuario;
		jsonData['webserviceProxySenha'] = webserviceProxySenha;
		jsonData['webserviceVisualizar'] = NfeConfiguracaoDomain.setWebserviceVisualizar(webserviceVisualizar);
		jsonData['emailServidorSmtp'] = emailServidorSmtp;
		jsonData['emailPorta'] = emailPorta;
		jsonData['emailUsuario'] = emailUsuario;
		jsonData['emailSenha'] = emailSenha;
		jsonData['emailAssunto'] = emailAssunto;
		jsonData['emailAutenticaSsl'] = NfeConfiguracaoDomain.setEmailAutenticaSsl(emailAutenticaSsl);
		jsonData['emailTexto'] = emailTexto;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		certificadoDigitalSerie = plutoRow.cells['certificadoDigitalSerie']?.value;
		certificadoDigitalCaminho = plutoRow.cells['certificadoDigitalCaminho']?.value;
		certificadoDigitalSenha = plutoRow.cells['certificadoDigitalSenha']?.value;
		tipoEmissao = plutoRow.cells['tipoEmissao']?.value;
		formatoImpressaoDanfe = plutoRow.cells['formatoImpressaoDanfe']?.value;
		processoEmissao = plutoRow.cells['processoEmissao']?.value;
		versaoProcessoEmissao = plutoRow.cells['versaoProcessoEmissao']?.value;
		caminhoLogomarca = plutoRow.cells['caminhoLogomarca']?.value;
		salvarXml = plutoRow.cells['salvarXml']?.value != '' ? plutoRow.cells['salvarXml']?.value : 'AAA';
		caminhoSalvarXml = plutoRow.cells['caminhoSalvarXml']?.value;
		caminhoSchemas = plutoRow.cells['caminhoSchemas']?.value;
		caminhoArquivoDanfe = plutoRow.cells['caminhoArquivoDanfe']?.value;
		caminhoSalvarPdf = plutoRow.cells['caminhoSalvarPdf']?.value;
		webserviceUf = plutoRow.cells['webserviceUf']?.value != '' ? plutoRow.cells['webserviceUf']?.value : 'AC';
		webserviceAmbiente = plutoRow.cells['webserviceAmbiente']?.value;
		webserviceProxyHost = plutoRow.cells['webserviceProxyHost']?.value;
		webserviceProxyPorta = plutoRow.cells['webserviceProxyPorta']?.value;
		webserviceProxyUsuario = plutoRow.cells['webserviceProxyUsuario']?.value;
		webserviceProxySenha = plutoRow.cells['webserviceProxySenha']?.value;
		webserviceVisualizar = plutoRow.cells['webserviceVisualizar']?.value != '' ? plutoRow.cells['webserviceVisualizar']?.value : 'AAA';
		emailServidorSmtp = plutoRow.cells['emailServidorSmtp']?.value;
		emailPorta = plutoRow.cells['emailPorta']?.value;
		emailUsuario = plutoRow.cells['emailUsuario']?.value;
		emailSenha = plutoRow.cells['emailSenha']?.value;
		emailAssunto = plutoRow.cells['emailAssunto']?.value;
		emailAutenticaSsl = plutoRow.cells['emailAutenticaSsl']?.value != '' ? plutoRow.cells['emailAutenticaSsl']?.value : 'AAA';
		emailTexto = plutoRow.cells['emailTexto']?.value;
	}	

	NfeConfiguracaoModel clone() {
		return NfeConfiguracaoModel(
			id: id,
			certificadoDigitalSerie: certificadoDigitalSerie,
			certificadoDigitalCaminho: certificadoDigitalCaminho,
			certificadoDigitalSenha: certificadoDigitalSenha,
			tipoEmissao: tipoEmissao,
			formatoImpressaoDanfe: formatoImpressaoDanfe,
			processoEmissao: processoEmissao,
			versaoProcessoEmissao: versaoProcessoEmissao,
			caminhoLogomarca: caminhoLogomarca,
			salvarXml: salvarXml,
			caminhoSalvarXml: caminhoSalvarXml,
			caminhoSchemas: caminhoSchemas,
			caminhoArquivoDanfe: caminhoArquivoDanfe,
			caminhoSalvarPdf: caminhoSalvarPdf,
			webserviceUf: webserviceUf,
			webserviceAmbiente: webserviceAmbiente,
			webserviceProxyHost: webserviceProxyHost,
			webserviceProxyPorta: webserviceProxyPorta,
			webserviceProxyUsuario: webserviceProxyUsuario,
			webserviceProxySenha: webserviceProxySenha,
			webserviceVisualizar: webserviceVisualizar,
			emailServidorSmtp: emailServidorSmtp,
			emailPorta: emailPorta,
			emailUsuario: emailUsuario,
			emailSenha: emailSenha,
			emailAssunto: emailAssunto,
			emailAutenticaSsl: emailAutenticaSsl,
			emailTexto: emailTexto,
		);			
	}

	
}