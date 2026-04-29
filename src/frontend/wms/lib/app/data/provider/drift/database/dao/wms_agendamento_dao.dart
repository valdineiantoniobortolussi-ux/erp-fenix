import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_agendamento_dao.g.dart';

@DriftAccessor(tables: [
	WmsAgendamentos,
])
class WmsAgendamentoDao extends DatabaseAccessor<AppDatabase> with _$WmsAgendamentoDaoMixin {
	final AppDatabase db;

	List<WmsAgendamento> wmsAgendamentoList = []; 
	List<WmsAgendamentoGrouped> wmsAgendamentoGroupedList = []; 

	WmsAgendamentoDao(this.db) : super(db);

	Future<List<WmsAgendamento>> getList() async {
		wmsAgendamentoList = await select(wmsAgendamentos).get();
		return wmsAgendamentoList;
	}

	Future<List<WmsAgendamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsAgendamentoList = await (select(wmsAgendamentos)..where((t) => expression)).get();
		return wmsAgendamentoList;	 
	}

	Future<List<WmsAgendamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsAgendamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = wmsAgendamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsAgendamentoGroupedList = await query.map((row) {
			final wmsAgendamento = row.readTableOrNull(wmsAgendamentos); 

			return WmsAgendamentoGrouped(
				wmsAgendamento: wmsAgendamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var wmsAgendamentoGrouped in wmsAgendamentoGroupedList) {
		//}		

		return wmsAgendamentoGroupedList;	
	}

	Future<WmsAgendamento?> getObject(dynamic pk) async {
		return await (select(wmsAgendamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsAgendamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_agendamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsAgendamento;		 
	} 

	Future<WmsAgendamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsAgendamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsAgendamento = object.wmsAgendamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsAgendamentos).insert(object.wmsAgendamento!);
			object.wmsAgendamento = object.wmsAgendamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsAgendamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsAgendamentos).replace(object.wmsAgendamento!);
		});	 
	} 

	Future<int> deleteObject(WmsAgendamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsAgendamentos).delete(object.wmsAgendamento!);
		});		
	}

	Future<void> insertChildren(WmsAgendamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(WmsAgendamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_agendamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}