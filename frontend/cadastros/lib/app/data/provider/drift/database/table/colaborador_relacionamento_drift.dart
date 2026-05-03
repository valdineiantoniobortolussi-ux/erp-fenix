import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("ColaboradorRelacionamento")
class ColaboradorRelacionamentos extends Table {
	@override
	String get tableName => 'colaborador_relacionamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idTipoRelacionamento => integer().named('id_tipo_relacionamento').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataNascimento => dateTime().named('data_nascimento').nullable()();
	TextColumn get cpf => text().named('cpf').withLength(min: 0, max: 11).nullable()();
	TextColumn get registroMatricula => text().named('registro_matricula').withLength(min: 0, max: 50).nullable()();
	TextColumn get registroCartorio => text().named('registro_cartorio').withLength(min: 0, max: 50).nullable()();
	TextColumn get registroCartorioNumero => text().named('registro_cartorio_numero').withLength(min: 0, max: 50).nullable()();
	TextColumn get registroNumeroLivro => text().named('registro_numero_livro').withLength(min: 0, max: 10).nullable()();
	TextColumn get registroNumeroFolha => text().named('registro_numero_folha').withLength(min: 0, max: 10).nullable()();
	DateTimeColumn get dataEntregaDocumento => dateTime().named('data_entrega_documento').nullable()();
	TextColumn get salarioFamilia => text().named('salario_familia').withLength(min: 0, max: 1).nullable()();
	IntColumn get salarioFamiliaIdadeLimite => integer().named('salario_familia_idade_limite').nullable()();
	DateTimeColumn get salarioFamiliaDataFim => dateTime().named('salario_familia_data_fim').nullable()();
	IntColumn get impostoRendaIdadeLimite => integer().named('imposto_renda_idade_limite').nullable()();
	IntColumn get impostoRendaDataFim => integer().named('imposto_renda_data_fim').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ColaboradorRelacionamentoGrouped {
	ColaboradorRelacionamento? colaboradorRelacionamento; 
	TipoRelacionamento? tipoRelacionamento; 

  ColaboradorRelacionamentoGrouped({
		this.colaboradorRelacionamento, 
		this.tipoRelacionamento, 

  });
}
