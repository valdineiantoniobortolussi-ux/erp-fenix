import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("EmpresaEndereco")
class EmpresaEnderecos extends Table {
	@override
	String get tableName => 'empresa_endereco';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idEmpresa => integer().named('id_empresa').nullable()();
	TextColumn get logradouro => text().named('logradouro').withLength(min: 0, max: 100).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 10).nullable()();
	TextColumn get bairro => text().named('bairro').withLength(min: 0, max: 100).nullable()();
	TextColumn get cidade => text().named('cidade').withLength(min: 0, max: 100).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get cep => text().named('cep').withLength(min: 0, max: 8).nullable()();
	IntColumn get municipioIbge => integer().named('municipio_ibge').nullable()();
	TextColumn get complemento => text().named('complemento').withLength(min: 0, max: 100).nullable()();
	TextColumn get principal => text().named('principal').withLength(min: 0, max: 1).nullable()();
	TextColumn get entrega => text().named('entrega').withLength(min: 0, max: 1).nullable()();
	TextColumn get cobranca => text().named('cobranca').withLength(min: 0, max: 1).nullable()();
	TextColumn get correspondencia => text().named('correspondencia').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EmpresaEnderecoGrouped {
	EmpresaEndereco? empresaEndereco; 

  EmpresaEnderecoGrouped({
		this.empresaEndereco, 

  });
}
