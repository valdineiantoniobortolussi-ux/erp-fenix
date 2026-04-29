import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeInformacaoCte")
class MdfeInformacaoCtes extends Table {
	@override
	String get tableName => 'mdfe_informacao_cte';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeMunicipioDescarrega => integer().named('id_mdfe_municipio_descarrega').nullable()();
	TextColumn get chaveCte => text().named('chave_cte').withLength(min: 0, max: 44).nullable()();
	TextColumn get segundoCodigoBarra => text().named('segundo_codigo_barra').withLength(min: 0, max: 36).nullable()();
	IntColumn get indicadorReentrega => integer().named('indicador_reentrega').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeInformacaoCteGrouped {
	MdfeInformacaoCte? mdfeInformacaoCte; 
	MdfeMunicipioDescarrega? mdfeMunicipioDescarrega; 

  MdfeInformacaoCteGrouped({
		this.mdfeInformacaoCte, 
		this.mdfeMunicipioDescarrega, 

  });
}
