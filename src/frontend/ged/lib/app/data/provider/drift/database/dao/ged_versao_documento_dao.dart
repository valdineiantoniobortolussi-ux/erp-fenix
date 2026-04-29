import 'package:drift/drift.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/provider/drift/database/database_imports.dart';

part 'ged_versao_documento_dao.g.dart';

@DriftAccessor(tables: [
	GedVersaoDocumentos,
	GedDocumentoDetalhes,
	ViewPessoaColaboradors,
])
class GedVersaoDocumentoDao extends DatabaseAccessor<AppDatabase> with _$GedVersaoDocumentoDaoMixin {
	final AppDatabase db;

	List<GedVersaoDocumento> gedVersaoDocumentoList = []; 
	List<GedVersaoDocumentoGrouped> gedVersaoDocumentoGroupedList = []; 

	GedVersaoDocumentoDao(this.db) : super(db);

	Future<List<GedVersaoDocumento>> getList() async {
		gedVersaoDocumentoList = await select(gedVersaoDocumentos).get();
		return gedVersaoDocumentoList;
	}

	Future<List<GedVersaoDocumento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		gedVersaoDocumentoList = await (select(gedVersaoDocumentos)..where((t) => expression)).get();
		return gedVersaoDocumentoList;	 
	}

	Future<List<GedVersaoDocumentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(gedVersaoDocumentos)
			.join([ 
				leftOuterJoin(gedDocumentoDetalhes, gedDocumentoDetalhes.id.equalsExp(gedVersaoDocumentos.idGedDocumentoDetalhe)), 
			]).join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(gedVersaoDocumentos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = gedVersaoDocumentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		gedVersaoDocumentoGroupedList = await query.map((row) {
			final gedVersaoDocumento = row.readTableOrNull(gedVersaoDocumentos); 
			final gedDocumentoDetalhe = row.readTableOrNull(gedDocumentoDetalhes); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return GedVersaoDocumentoGrouped(
				gedVersaoDocumento: gedVersaoDocumento, 
				gedDocumentoDetalhe: gedDocumentoDetalhe, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var gedVersaoDocumentoGrouped in gedVersaoDocumentoGroupedList) {
		//}		

		return gedVersaoDocumentoGroupedList;	
	}

	Future<GedVersaoDocumento?> getObject(dynamic pk) async {
		return await (select(gedVersaoDocumentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<GedVersaoDocumento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ged_versao_documento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as GedVersaoDocumento;		 
	} 

	Future<GedVersaoDocumentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(GedVersaoDocumentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.gedVersaoDocumento = object.gedVersaoDocumento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(gedVersaoDocumentos).insert(object.gedVersaoDocumento!);
			object.gedVersaoDocumento = object.gedVersaoDocumento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(GedVersaoDocumentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(gedVersaoDocumentos).replace(object.gedVersaoDocumento!);
		});	 
	} 

	Future<int> deleteObject(GedVersaoDocumentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(gedVersaoDocumentos).delete(object.gedVersaoDocumento!);
		});		
	}

	Future<void> insertChildren(GedVersaoDocumentoGrouped object) async {
	}
	
	Future<void> deleteChildren(GedVersaoDocumentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ged_versao_documento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}