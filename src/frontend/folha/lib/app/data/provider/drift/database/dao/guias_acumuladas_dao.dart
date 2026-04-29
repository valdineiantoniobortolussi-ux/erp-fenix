import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'guias_acumuladas_dao.g.dart';

@DriftAccessor(tables: [
	GuiasAcumuladass,
])
class GuiasAcumuladasDao extends DatabaseAccessor<AppDatabase> with _$GuiasAcumuladasDaoMixin {
	final AppDatabase db;

	List<GuiasAcumuladas> guiasAcumuladasList = []; 
	List<GuiasAcumuladasGrouped> guiasAcumuladasGroupedList = []; 

	GuiasAcumuladasDao(this.db) : super(db);

	Future<List<GuiasAcumuladas>> getList() async {
		guiasAcumuladasList = await select(guiasAcumuladass).get();
		return guiasAcumuladasList;
	}

	Future<List<GuiasAcumuladas>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		guiasAcumuladasList = await (select(guiasAcumuladass)..where((t) => expression)).get();
		return guiasAcumuladasList;	 
	}

	Future<List<GuiasAcumuladasGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(guiasAcumuladass)
			.join([]);

		if (field != null && field != '') { 
			final column = guiasAcumuladass.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		guiasAcumuladasGroupedList = await query.map((row) {
			final guiasAcumuladas = row.readTableOrNull(guiasAcumuladass); 

			return GuiasAcumuladasGrouped(
				guiasAcumuladas: guiasAcumuladas, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var guiasAcumuladasGrouped in guiasAcumuladasGroupedList) {
		//}		

		return guiasAcumuladasGroupedList;	
	}

	Future<GuiasAcumuladas?> getObject(dynamic pk) async {
		return await (select(guiasAcumuladass)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<GuiasAcumuladas?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM guias_acumuladas WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as GuiasAcumuladas;		 
	} 

	Future<GuiasAcumuladasGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(GuiasAcumuladasGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.guiasAcumuladas = object.guiasAcumuladas!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(guiasAcumuladass).insert(object.guiasAcumuladas!);
			object.guiasAcumuladas = object.guiasAcumuladas!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(GuiasAcumuladasGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(guiasAcumuladass).replace(object.guiasAcumuladas!);
		});	 
	} 

	Future<int> deleteObject(GuiasAcumuladasGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(guiasAcumuladass).delete(object.guiasAcumuladas!);
		});		
	}

	Future<void> insertChildren(GuiasAcumuladasGrouped object) async {
	}
	
	Future<void> deleteChildren(GuiasAcumuladasGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from guias_acumuladas").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}