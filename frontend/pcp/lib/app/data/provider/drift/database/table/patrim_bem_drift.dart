import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimBem")
class PatrimBems extends Table {
	@override
	String get tableName => 'patrim_bem';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCentroResultado => integer().named('id_centro_resultado').nullable()();
	IntColumn get idPatrimTipoAquisicaoBem => integer().named('id_patrim_tipo_aquisicao_bem').nullable()();
	IntColumn get idPatrimEstadoConservacao => integer().named('id_patrim_estado_conservacao').nullable()();
	IntColumn get idPatrimGrupoBem => integer().named('id_patrim_grupo_bem').nullable()();
	IntColumn get idFornecedor => integer().named('id_fornecedor').nullable()();
	IntColumn get idSetor => integer().named('id_setor').nullable()();
	TextColumn get numeroNb => text().named('numero_nb').withLength(min: 0, max: 20).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get numeroSerie => text().named('numero_serie').withLength(min: 0, max: 50).nullable()();
	DateTimeColumn get dataAquisicao => dateTime().named('data_aquisicao').nullable()();
	DateTimeColumn get dataAceite => dateTime().named('data_aceite').nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	DateTimeColumn get dataContabilizado => dateTime().named('data_contabilizado').nullable()();
	DateTimeColumn get dataVistoria => dateTime().named('data_vistoria').nullable()();
	DateTimeColumn get dataMarcacao => dateTime().named('data_marcacao').nullable()();
	DateTimeColumn get dataBaixa => dateTime().named('data_baixa').nullable()();
	DateTimeColumn get vencimentoGarantia => dateTime().named('vencimento_garantia').nullable()();
	TextColumn get numeroNotaFiscal => text().named('numero_nota_fiscal').withLength(min: 0, max: 50).nullable()();
	TextColumn get chaveNfe => text().named('chave_nfe').withLength(min: 0, max: 44).nullable()();
	RealColumn get valorOriginal => real().named('valor_original').nullable()();
	RealColumn get valorCompra => real().named('valor_compra').nullable()();
	RealColumn get valorAtualizado => real().named('valor_atualizado').nullable()();
	RealColumn get valorBaixa => real().named('valor_baixa').nullable()();
	TextColumn get deprecia => text().named('deprecia').withLength(min: 0, max: 1).nullable()();
	TextColumn get metodoDepreciacao => text().named('metodo_depreciacao').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get inicioDepreciacao => dateTime().named('inicio_depreciacao').nullable()();
	DateTimeColumn get ultimaDepreciacao => dateTime().named('ultima_depreciacao').nullable()();
	TextColumn get tipoDepreciacao => text().named('tipo_depreciacao').withLength(min: 0, max: 1).nullable()();
	RealColumn get taxaAnualDepreciacao => real().named('taxa_anual_depreciacao').nullable()();
	RealColumn get taxaMensalDepreciacao => real().named('taxa_mensal_depreciacao').nullable()();
	RealColumn get taxaDepreciacaoAcelerada => real().named('taxa_depreciacao_acelerada').nullable()();
	RealColumn get taxaDepreciacaoIncentivada => real().named('taxa_depreciacao_incentivada').nullable()();
	TextColumn get funcao => text().named('funcao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimBemGrouped {
	PatrimBem? patrimBem; 

  PatrimBemGrouped({
		this.patrimBem, 

  });
}
