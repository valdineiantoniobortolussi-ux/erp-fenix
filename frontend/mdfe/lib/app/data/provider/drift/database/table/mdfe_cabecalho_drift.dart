import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

@DataClassName("MdfeCabecalho")
class MdfeCabecalhos extends Table {
	@override
	String get tableName => 'mdfe_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get tipoAmbiente => text().named('tipo_ambiente').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoEmitente => text().named('tipo_emitente').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoTransportadora => text().named('tipo_transportadora').withLength(min: 0, max: 3).nullable()();
	TextColumn get modelo => text().named('modelo').withLength(min: 0, max: 2).nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	TextColumn get numeroMdfe => text().named('numero_mdfe').withLength(min: 0, max: 9).nullable()();
	TextColumn get codigoNumerico => text().named('codigo_numerico').withLength(min: 0, max: 8).nullable()();
	TextColumn get chaveAcesso => text().named('chave_acesso').withLength(min: 0, max: 44).nullable()();
	IntColumn get digitoVerificador => integer().named('digito_verificador').nullable()();
	TextColumn get modal => text().named('modal').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataHoraEmissao => dateTime().named('data_hora_emissao').nullable()();
	TextColumn get tipoEmissao => text().named('tipo_emissao').withLength(min: 0, max: 1).nullable()();
	TextColumn get processoEmissao => text().named('processo_emissao').withLength(min: 0, max: 1).nullable()();
	TextColumn get versaoProcessoEmissao => text().named('versao_processo_emissao').withLength(min: 0, max: 20).nullable()();
	TextColumn get ufInicio => text().named('uf_inicio').withLength(min: 0, max: 2).nullable()();
	TextColumn get ufFim => text().named('uf_fim').withLength(min: 0, max: 2).nullable()();
	DateTimeColumn get dataHoraPrevisaoViagem => dateTime().named('data_hora_previsao_viagem').nullable()();
	IntColumn get quantidadeTotalCte => integer().named('quantidade_total_cte').nullable()();
	IntColumn get quantidadeTotalNfe => integer().named('quantidade_total_nfe').nullable()();
	IntColumn get quantidadeTotalMdfe => integer().named('quantidade_total_mdfe').nullable()();
	TextColumn get codigoUnidadeMedida => text().named('codigo_unidade_medida').withLength(min: 0, max: 2).nullable()();
	RealColumn get pesoBrutoCarga => real().named('peso_bruto_carga').nullable()();
	RealColumn get valorCarga => real().named('valor_carga').nullable()();
	TextColumn get numeroProtocolo => text().named('numero_protocolo').withLength(min: 0, max: 15).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeCabecalhoGrouped {
	MdfeCabecalho? mdfeCabecalho; 
	List<MdfeLacreGrouped>? mdfeLacreGroupedList; 
	List<MdfeMunicipioDescarregaGrouped>? mdfeMunicipioDescarregaGroupedList; 
	List<MdfeEmitenteGrouped>? mdfeEmitenteGroupedList; 
	List<MdfePercursoGrouped>? mdfePercursoGroupedList; 
	List<MdfeMunicipioCarregamentoGrouped>? mdfeMunicipioCarregamentoGroupedList; 
	List<MdfeRodoviarioGrouped>? mdfeRodoviarioGroupedList; 
	List<MdfeInformacaoSeguroGrouped>? mdfeInformacaoSeguroGroupedList; 

  MdfeCabecalhoGrouped({
		this.mdfeCabecalho, 
		this.mdfeLacreGroupedList, 
		this.mdfeMunicipioDescarregaGroupedList, 
		this.mdfeEmitenteGroupedList, 
		this.mdfePercursoGroupedList, 
		this.mdfeMunicipioCarregamentoGroupedList, 
		this.mdfeRodoviarioGroupedList, 
		this.mdfeInformacaoSeguroGroupedList, 

  });
}
