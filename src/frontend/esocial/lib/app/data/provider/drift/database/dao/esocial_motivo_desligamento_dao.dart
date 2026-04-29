import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/provider/drift/database/database_imports.dart';

part 'esocial_motivo_desligamento_dao.g.dart';

@DriftAccessor(tables: [
	EsocialMotivoDesligamentos,
])
class EsocialMotivoDesligamentoDao extends DatabaseAccessor<AppDatabase> with _$EsocialMotivoDesligamentoDaoMixin {
	final AppDatabase db;

	List<EsocialMotivoDesligamento> esocialMotivoDesligamentoList = []; 
	List<EsocialMotivoDesligamentoGrouped> esocialMotivoDesligamentoGroupedList = []; 

	EsocialMotivoDesligamentoDao(this.db) : super(db);

	Future<List<EsocialMotivoDesligamento>> getList() async {
		esocialMotivoDesligamentoList = await select(esocialMotivoDesligamentos).get();
		return esocialMotivoDesligamentoList;
	}

	Future<List<EsocialMotivoDesligamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		esocialMotivoDesligamentoList = await (select(esocialMotivoDesligamentos)..where((t) => expression)).get();
		return esocialMotivoDesligamentoList;	 
	}

	Future<List<EsocialMotivoDesligamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(esocialMotivoDesligamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = esocialMotivoDesligamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		esocialMotivoDesligamentoGroupedList = await query.map((row) {
			final esocialMotivoDesligamento = row.readTableOrNull(esocialMotivoDesligamentos); 

			return EsocialMotivoDesligamentoGrouped(
				esocialMotivoDesligamento: esocialMotivoDesligamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var esocialMotivoDesligamentoGrouped in esocialMotivoDesligamentoGroupedList) {
		//}		

		return esocialMotivoDesligamentoGroupedList;	
	}

	Future<EsocialMotivoDesligamento?> getObject(dynamic pk) async {
		return await (select(esocialMotivoDesligamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EsocialMotivoDesligamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM esocial_motivo_desligamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EsocialMotivoDesligamento;		 
	} 

	Future<EsocialMotivoDesligamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EsocialMotivoDesligamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.esocialMotivoDesligamento = object.esocialMotivoDesligamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(esocialMotivoDesligamentos).insert(object.esocialMotivoDesligamento!);
			object.esocialMotivoDesligamento = object.esocialMotivoDesligamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EsocialMotivoDesligamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(esocialMotivoDesligamentos).replace(object.esocialMotivoDesligamento!);
		});	 
	} 

	Future<int> deleteObject(EsocialMotivoDesligamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(esocialMotivoDesligamentos).delete(object.esocialMotivoDesligamento!);
		});		
	}

	Future<void> insertChildren(EsocialMotivoDesligamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(EsocialMotivoDesligamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from esocial_motivo_desligamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}