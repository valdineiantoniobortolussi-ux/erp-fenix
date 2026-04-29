import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeConfiguracao")
class NfeConfiguracaos extends Table {
	@override
	String get tableName => 'nfe_configuracao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get certificadoDigitalSerie => text().named('certificado_digital_serie').withLength(min: 0, max: 100).nullable()();
	TextColumn get certificadoDigitalCaminho => text().named('certificado_digital_caminho').nullable()();
	TextColumn get certificadoDigitalSenha => text().named('certificado_digital_senha').withLength(min: 0, max: 100).nullable()();
	IntColumn get tipoEmissao => integer().named('tipo_emissao').nullable()();
	IntColumn get formatoImpressaoDanfe => integer().named('formato_impressao_danfe').nullable()();
	IntColumn get processoEmissao => integer().named('processo_emissao').nullable()();
	TextColumn get versaoProcessoEmissao => text().named('versao_processo_emissao').withLength(min: 0, max: 20).nullable()();
	TextColumn get caminhoLogomarca => text().named('caminho_logomarca').nullable()();
	TextColumn get salvarXml => text().named('salvar_xml').withLength(min: 0, max: 1).nullable()();
	TextColumn get caminhoSalvarXml => text().named('caminho_salvar_xml').nullable()();
	TextColumn get caminhoSchemas => text().named('caminho_schemas').nullable()();
	TextColumn get caminhoArquivoDanfe => text().named('caminho_arquivo_danfe').nullable()();
	TextColumn get caminhoSalvarPdf => text().named('caminho_salvar_pdf').nullable()();
	TextColumn get webserviceUf => text().named('webservice_uf').withLength(min: 0, max: 2).nullable()();
	IntColumn get webserviceAmbiente => integer().named('webservice_ambiente').nullable()();
	TextColumn get webserviceProxyHost => text().named('webservice_proxy_host').withLength(min: 0, max: 100).nullable()();
	IntColumn get webserviceProxyPorta => integer().named('webservice_proxy_porta').nullable()();
	TextColumn get webserviceProxyUsuario => text().named('webservice_proxy_usuario').withLength(min: 0, max: 100).nullable()();
	TextColumn get webserviceProxySenha => text().named('webservice_proxy_senha').withLength(min: 0, max: 100).nullable()();
	TextColumn get webserviceVisualizar => text().named('webservice_visualizar').withLength(min: 0, max: 1).nullable()();
	TextColumn get emailServidorSmtp => text().named('email_servidor_smtp').withLength(min: 0, max: 100).nullable()();
	IntColumn get emailPorta => integer().named('email_porta').nullable()();
	TextColumn get emailUsuario => text().named('email_usuario').withLength(min: 0, max: 100).nullable()();
	TextColumn get emailSenha => text().named('email_senha').withLength(min: 0, max: 100).nullable()();
	TextColumn get emailAssunto => text().named('email_assunto').withLength(min: 0, max: 100).nullable()();
	TextColumn get emailAutenticaSsl => text().named('email_autentica_ssl').withLength(min: 0, max: 1).nullable()();
	TextColumn get emailTexto => text().named('email_texto').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeConfiguracaoGrouped {
	NfeConfiguracao? nfeConfiguracao; 

  NfeConfiguracaoGrouped({
		this.nfeConfiguracao, 

  });
}
