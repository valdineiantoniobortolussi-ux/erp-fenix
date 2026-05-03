import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeTransporte")
class NfeTransportes extends Table {
	@override
	String get tableName => 'nfe_transporte';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	IntColumn get idTransportadora => integer().named('id_transportadora').nullable()();
	TextColumn get modalidadeFrete => text().named('modalidade_frete').withLength(min: 0, max: 1).nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 60).nullable()();
	TextColumn get inscricaoEstadual => text().named('inscricao_estadual').withLength(min: 0, max: 14).nullable()();
	TextColumn get endereco => text().named('endereco').withLength(min: 0, max: 60).nullable()();
	TextColumn get nomeMunicipio => text().named('nome_municipio').withLength(min: 0, max: 60).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	RealColumn get valorServico => real().named('valor_servico').nullable()();
	RealColumn get valorBcRetencaoIcms => real().named('valor_bc_retencao_icms').nullable()();
	RealColumn get aliquotaRetencaoIcms => real().named('aliquota_retencao_icms').nullable()();
	RealColumn get valorIcmsRetido => real().named('valor_icms_retido').nullable()();
	IntColumn get cfop => integer().named('cfop').nullable()();
	IntColumn get municipio => integer().named('municipio').nullable()();
	TextColumn get placaVeiculo => text().named('placa_veiculo').withLength(min: 0, max: 7).nullable()();
	TextColumn get ufVeiculo => text().named('uf_veiculo').withLength(min: 0, max: 2).nullable()();
	TextColumn get rntcVeiculo => text().named('rntc_veiculo').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeTransporteGrouped {
	NfeTransporte? nfeTransporte; 

  NfeTransporteGrouped({
		this.nfeTransporte, 

  });
}
