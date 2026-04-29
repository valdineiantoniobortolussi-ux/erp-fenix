import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'sindicato_dao.g.dart';

@DriftAccessor(tables: [
	Sindicatos,
])
class SindicatoDao extends DatabaseAccessor<AppDatabase> with _$SindicatoDaoMixin {
	final AppDatabase db;

	List<Sindicato> sindicatoList = []; 
	List<SindicatoGrouped> sindicatoGroupedList = []; 

	SindicatoDao(this.db) : super(db);

	Future<List<Sindicato>> getList() async {
		sindicatoList = await select(sindicatos).get();
		return sindicatoList;
	}

	Future<List<Sindicato>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		sindicatoList = await (select(sindicatos)..where((t) => expression)).get();
		return sindicatoList;	 
	}

	Future<List<SindicatoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(sindicatos)
			.join([]);

		if (field != null && field != '') { 
			final column = sindicatos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		sindicatoGroupedList = await query.map((row) {
			final sindicato = row.readTableOrNull(sindicatos); 

			return SindicatoGrouped(
				sindicato: sindicato, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var sindicatoGrouped in sindicatoGroupedList) {
		//}		

		return sindicatoGroupedList;	
	}

	Future<Sindicato?> getObject(dynamic pk) async {
		return await (select(sindicatos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Sindicato?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM sindicato WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Sindicato;		 
	} 

	Future<SindicatoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(SindicatoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.sindicato = object.sindicato!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(sindicatos).insert(object.sindicato!);
			object.sindicato = object.sindicato!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(SindicatoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(sindicatos).replace(object.sindicato!);
		});	 
	} 

	Future<int> deleteObject(SindicatoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(sindicatos).delete(object.sindicato!);
		});		
	}

	Future<void> insertChildren(SindicatoGrouped object) async {
	}
	
	Future<void> deleteChildren(SindicatoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from sindicato").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}