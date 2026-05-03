import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/provider/drift/database/database_imports.dart';

part 'agenda_categoria_compromisso_dao.g.dart';

@DriftAccessor(tables: [
	AgendaCategoriaCompromissos,
])
class AgendaCategoriaCompromissoDao extends DatabaseAccessor<AppDatabase> with _$AgendaCategoriaCompromissoDaoMixin {
	final AppDatabase db;

	List<AgendaCategoriaCompromisso> agendaCategoriaCompromissoList = []; 
	List<AgendaCategoriaCompromissoGrouped> agendaCategoriaCompromissoGroupedList = []; 

	AgendaCategoriaCompromissoDao(this.db) : super(db);

	Future<List<AgendaCategoriaCompromisso>> getList() async {
		agendaCategoriaCompromissoList = await select(agendaCategoriaCompromissos).get();
		return agendaCategoriaCompromissoList;
	}

	Future<List<AgendaCategoriaCompromisso>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		agendaCategoriaCompromissoList = await (select(agendaCategoriaCompromissos)..where((t) => expression)).get();
		return agendaCategoriaCompromissoList;	 
	}

	Future<List<AgendaCategoriaCompromissoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(agendaCategoriaCompromissos)
			.join([]);

		if (field != null && field != '') { 
			final column = agendaCategoriaCompromissos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		agendaCategoriaCompromissoGroupedList = await query.map((row) {
			final agendaCategoriaCompromisso = row.readTableOrNull(agendaCategoriaCompromissos); 

			return AgendaCategoriaCompromissoGrouped(
				agendaCategoriaCompromisso: agendaCategoriaCompromisso, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var agendaCategoriaCompromissoGrouped in agendaCategoriaCompromissoGroupedList) {
		//}		

		return agendaCategoriaCompromissoGroupedList;	
	}

	Future<AgendaCategoriaCompromisso?> getObject(dynamic pk) async {
		return await (select(agendaCategoriaCompromissos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<AgendaCategoriaCompromisso?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM agenda_categoria_compromisso WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as AgendaCategoriaCompromisso;		 
	} 

	Future<AgendaCategoriaCompromissoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(AgendaCategoriaCompromissoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.agendaCategoriaCompromisso = object.agendaCategoriaCompromisso!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(agendaCategoriaCompromissos).insert(object.agendaCategoriaCompromisso!);
			object.agendaCategoriaCompromisso = object.agendaCategoriaCompromisso!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(AgendaCategoriaCompromissoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(agendaCategoriaCompromissos).replace(object.agendaCategoriaCompromisso!);
		});	 
	} 

	Future<int> deleteObject(AgendaCategoriaCompromissoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(agendaCategoriaCompromissos).delete(object.agendaCategoriaCompromisso!);
		});		
	}

	Future<void> insertChildren(AgendaCategoriaCompromissoGrouped object) async {
	}
	
	Future<void> deleteChildren(AgendaCategoriaCompromissoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from agenda_categoria_compromisso").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}