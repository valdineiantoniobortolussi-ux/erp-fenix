import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'tipo_relacionamento_dao.g.dart';

@DriftAccessor(tables: [
	TipoRelacionamentos,
])
class TipoRelacionamentoDao extends DatabaseAccessor<AppDatabase> with _$TipoRelacionamentoDaoMixin {
	final AppDatabase db;

	List<TipoRelacionamento> tipoRelacionamentoList = []; 
	List<TipoRelacionamentoGrouped> tipoRelacionamentoGroupedList = []; 

	TipoRelacionamentoDao(this.db) : super(db);

	Future<List<TipoRelacionamento>> getList() async {
		tipoRelacionamentoList = await select(tipoRelacionamentos).get();
		return tipoRelacionamentoList;
	}

	Future<List<TipoRelacionamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tipoRelacionamentoList = await (select(tipoRelacionamentos)..where((t) => expression)).get();
		return tipoRelacionamentoList;	 
	}

	Future<List<TipoRelacionamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tipoRelacionamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = tipoRelacionamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tipoRelacionamentoGroupedList = await query.map((row) {
			final tipoRelacionamento = row.readTableOrNull(tipoRelacionamentos); 

			return TipoRelacionamentoGrouped(
				tipoRelacionamento: tipoRelacionamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tipoRelacionamentoGrouped in tipoRelacionamentoGroupedList) {
		//}		

		return tipoRelacionamentoGroupedList;	
	}

	Future<TipoRelacionamento?> getObject(dynamic pk) async {
		return await (select(tipoRelacionamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TipoRelacionamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tipo_relacionamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TipoRelacionamento;		 
	} 

	Future<TipoRelacionamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TipoRelacionamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tipoRelacionamento = object.tipoRelacionamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tipoRelacionamentos).insert(object.tipoRelacionamento!);
			object.tipoRelacionamento = object.tipoRelacionamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TipoRelacionamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tipoRelacionamentos).replace(object.tipoRelacionamento!);
		});	 
	} 

	Future<int> deleteObject(TipoRelacionamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tipoRelacionamentos).delete(object.tipoRelacionamento!);
		});		
	}

	Future<void> insertChildren(TipoRelacionamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(TipoRelacionamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tipo_relacionamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}