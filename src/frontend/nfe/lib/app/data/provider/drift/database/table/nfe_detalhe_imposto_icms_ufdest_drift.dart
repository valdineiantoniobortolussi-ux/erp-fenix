import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoIcmsUfdest")
class NfeDetalheImpostoIcmsUfdests extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_icms_ufdest';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	RealColumn get valorBcIcmsUfDestino => real().named('valor_bc_icms_uf_destino').nullable()();
	RealColumn get valorBcFcpUfDestino => real().named('valor_bc_fcp_uf_destino').nullable()();
	RealColumn get percentualFcpUfDestino => real().named('percentual_fcp_uf_destino').nullable()();
	RealColumn get aliquotaInternaUfDestino => real().named('aliquota_interna_uf_destino').nullable()();
	RealColumn get aliquotaInteresdatualUfEnvolvidas => real().named('aliquota_interesdatual_uf_envolvidas').nullable()();
	RealColumn get percentualProvisorioPartilhaIcms => real().named('percentual_provisorio_partilha_icms').nullable()();
	RealColumn get valorIcmsFcpUfDestino => real().named('valor_icms_fcp_uf_destino').nullable()();
	RealColumn get valorInterestadualUfDestino => real().named('valor_interestadual_uf_destino').nullable()();
	RealColumn get valorInterestadualUfRemetente => real().named('valor_interestadual_uf_remetente').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoIcmsUfdestGrouped {
	NfeDetalheImpostoIcmsUfdest? nfeDetalheImpostoIcmsUfdest; 

  NfeDetalheImpostoIcmsUfdestGrouped({
		this.nfeDetalheImpostoIcmsUfdest, 

  });
}
