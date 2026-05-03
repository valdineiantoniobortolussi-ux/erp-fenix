import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'cargo_dao.g.dart';

@DriftAccessor(tables: [
	Cargos,
])
class CargoDao extends DatabaseAccessor<AppDatabase> with _$CargoDaoMixin {
	final AppDatabase db;

	List<Cargo> cargoList = []; 
	List<CargoGrouped> cargoGroupedList = []; 

	CargoDao(this.db) : super(db);

	Future<List<Cargo>> getList() async {
		cargoList = await select(cargos).get();
		return cargoList;
	}

	Future<List<Cargo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cargoList = await (select(cargos)..where((t) => expression)).get();
		return cargoList;	 
	}

	Future<List<CargoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cargos)
			.join([]);

		if (field != null && field != '') { 
			final column = cargos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cargoGroupedList = await query.map((row) {
			final cargo = row.readTableOrNull(cargos); 

			return CargoGrouped(
				cargo: cargo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cargoGrouped in cargoGroupedList) {
		//}		

		return cargoGroupedList;	
	}

	Future<Cargo?> getObject(dynamic pk) async {
		return await (select(cargos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Cargo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cargo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Cargo;		 
	} 

	Future<CargoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CargoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cargo = object.cargo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cargos).insert(object.cargo!);
			object.cargo = object.cargo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CargoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cargos).replace(object.cargo!);
		});	 
	} 

	Future<int> deleteObject(CargoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cargos).delete(object.cargo!);
		});		
	}

	Future<void> insertChildren(CargoGrouped object) async {
	}
	
	Future<void> deleteChildren(CargoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cargo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}