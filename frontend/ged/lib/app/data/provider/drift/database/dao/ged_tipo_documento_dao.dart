import 'package:drift/drift.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/provider/drift/database/database_imports.dart';

part 'ged_tipo_documento_dao.g.dart';

@DriftAccessor(tables: [
	GedTipoDocumentos,
])
class GedTipoDocumentoDao extends DatabaseAccessor<AppDatabase> with _$GedTipoDocumentoDaoMixin {
	final AppDatabase db;

	List<GedTipoDocumento> gedTipoDocumentoList = []; 
	List<GedTipoDocumentoGrouped> gedTipoDocumentoGroupedList = []; 

	GedTipoDocumentoDao(this.db) : super(db);

	Future<List<GedTipoDocumento>> getList() async {
		gedTipoDocumentoList = await select(gedTipoDocumentos).get();
		return gedTipoDocumentoList;
	}

	Future<List<GedTipoDocumento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		gedTipoDocumentoList = await (select(gedTipoDocumentos)..where((t) => expression)).get();
		return gedTipoDocumentoList;	 
	}

	Future<List<GedTipoDocumentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(gedTipoDocumentos)
			.join([]);

		if (field != null && field != '') { 
			final column = gedTipoDocumentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		gedTipoDocumentoGroupedList = await query.map((row) {
			final gedTipoDocumento = row.readTableOrNull(gedTipoDocumentos); 

			return GedTipoDocumentoGrouped(
				gedTipoDocumento: gedTipoDocumento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var gedTipoDocumentoGrouped in gedTipoDocumentoGroupedList) {
		//}		

		return gedTipoDocumentoGroupedList;	
	}

	Future<GedTipoDocumento?> getObject(dynamic pk) async {
		return await (select(gedTipoDocumentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<GedTipoDocumento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ged_tipo_documento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as GedTipoDocumento;		 
	} 

	Future<GedTipoDocumentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(GedTipoDocumentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.gedTipoDocumento = object.gedTipoDocumento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(gedTipoDocumentos).insert(object.gedTipoDocumento!);
			object.gedTipoDocumento = object.gedTipoDocumento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(GedTipoDocumentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(gedTipoDocumentos).replace(object.gedTipoDocumento!);
		});	 
	} 

	Future<int> deleteObject(GedTipoDocumentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(gedTipoDocumentos).delete(object.gedTipoDocumento!);
		});		
	}

	Future<void> insertChildren(GedTipoDocumentoGrouped object) async {
	}
	
	Future<void> deleteChildren(GedTipoDocumentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ged_tipo_documento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}