import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'registro_cartorio_dao.g.dart';

@DriftAccessor(tables: [
	RegistroCartorios,
])
class RegistroCartorioDao extends DatabaseAccessor<AppDatabase> with _$RegistroCartorioDaoMixin {
	final AppDatabase db;

	List<RegistroCartorio> registroCartorioList = []; 
	List<RegistroCartorioGrouped> registroCartorioGroupedList = []; 

	RegistroCartorioDao(this.db) : super(db);

	Future<List<RegistroCartorio>> getList() async {
		registroCartorioList = await select(registroCartorios).get();
		return registroCartorioList;
	}

	Future<List<RegistroCartorio>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		registroCartorioList = await (select(registroCartorios)..where((t) => expression)).get();
		return registroCartorioList;	 
	}

	Future<List<RegistroCartorioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(registroCartorios)
			.join([]);

		if (field != null && field != '') { 
			final column = registroCartorios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		registroCartorioGroupedList = await query.map((row) {
			final registroCartorio = row.readTableOrNull(registroCartorios); 

			return RegistroCartorioGrouped(
				registroCartorio: registroCartorio, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var registroCartorioGrouped in registroCartorioGroupedList) {
		//}		

		return registroCartorioGroupedList;	
	}

	Future<RegistroCartorio?> getObject(dynamic pk) async {
		return await (select(registroCartorios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<RegistroCartorio?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM registro_cartorio WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as RegistroCartorio;		 
	} 

	Future<RegistroCartorioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(RegistroCartorioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.registroCartorio = object.registroCartorio!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(registroCartorios).insert(object.registroCartorio!);
			object.registroCartorio = object.registroCartorio!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(RegistroCartorioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(registroCartorios).replace(object.registroCartorio!);
		});	 
	} 

	Future<int> deleteObject(RegistroCartorioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(registroCartorios).delete(object.registroCartorio!);
		});		
	}

	Future<void> insertChildren(RegistroCartorioGrouped object) async {
	}
	
	Future<void> deleteChildren(RegistroCartorioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from registro_cartorio").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}