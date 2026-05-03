import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'setor_dao.g.dart';

@DriftAccessor(tables: [
	Setors,
])
class SetorDao extends DatabaseAccessor<AppDatabase> with _$SetorDaoMixin {
	final AppDatabase db;

	List<Setor> setorList = []; 
	List<SetorGrouped> setorGroupedList = []; 

	SetorDao(this.db) : super(db);

	Future<List<Setor>> getList() async {
		setorList = await select(setors).get();
		return setorList;
	}

	Future<List<Setor>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		setorList = await (select(setors)..where((t) => expression)).get();
		return setorList;	 
	}

	Future<List<SetorGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(setors)
			.join([]);

		if (field != null && field != '') { 
			final column = setors.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		setorGroupedList = await query.map((row) {
			final setor = row.readTableOrNull(setors); 

			return SetorGrouped(
				setor: setor, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var setorGrouped in setorGroupedList) {
		//}		

		return setorGroupedList;	
	}

	Future<Setor?> getObject(dynamic pk) async {
		return await (select(setors)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Setor?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM setor WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Setor;		 
	} 

	Future<SetorGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(SetorGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.setor = object.setor!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(setors).insert(object.setor!);
			object.setor = object.setor!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(SetorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(setors).replace(object.setor!);
		});	 
	} 

	Future<int> deleteObject(SetorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(setors).delete(object.setor!);
		});		
	}

	Future<void> insertChildren(SetorGrouped object) async {
	}
	
	Future<void> deleteChildren(SetorGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from setor").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}