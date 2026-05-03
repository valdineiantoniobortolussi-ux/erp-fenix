import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'patrim_tipo_movimentacao_dao.g.dart';

@DriftAccessor(tables: [
	PatrimTipoMovimentacaos,
])
class PatrimTipoMovimentacaoDao extends DatabaseAccessor<AppDatabase> with _$PatrimTipoMovimentacaoDaoMixin {
	final AppDatabase db;

	List<PatrimTipoMovimentacao> patrimTipoMovimentacaoList = []; 
	List<PatrimTipoMovimentacaoGrouped> patrimTipoMovimentacaoGroupedList = []; 

	PatrimTipoMovimentacaoDao(this.db) : super(db);

	Future<List<PatrimTipoMovimentacao>> getList() async {
		patrimTipoMovimentacaoList = await select(patrimTipoMovimentacaos).get();
		return patrimTipoMovimentacaoList;
	}

	Future<List<PatrimTipoMovimentacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimTipoMovimentacaoList = await (select(patrimTipoMovimentacaos)..where((t) => expression)).get();
		return patrimTipoMovimentacaoList;	 
	}

	Future<List<PatrimTipoMovimentacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimTipoMovimentacaos)
			.join([]);

		if (field != null && field != '') { 
			final column = patrimTipoMovimentacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimTipoMovimentacaoGroupedList = await query.map((row) {
			final patrimTipoMovimentacao = row.readTableOrNull(patrimTipoMovimentacaos); 

			return PatrimTipoMovimentacaoGrouped(
				patrimTipoMovimentacao: patrimTipoMovimentacao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var patrimTipoMovimentacaoGrouped in patrimTipoMovimentacaoGroupedList) {
		//}		

		return patrimTipoMovimentacaoGroupedList;	
	}

	Future<PatrimTipoMovimentacao?> getObject(dynamic pk) async {
		return await (select(patrimTipoMovimentacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimTipoMovimentacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_tipo_movimentacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimTipoMovimentacao;		 
	} 

	Future<PatrimTipoMovimentacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimTipoMovimentacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimTipoMovimentacao = object.patrimTipoMovimentacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimTipoMovimentacaos).insert(object.patrimTipoMovimentacao!);
			object.patrimTipoMovimentacao = object.patrimTipoMovimentacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimTipoMovimentacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimTipoMovimentacaos).replace(object.patrimTipoMovimentacao!);
		});	 
	} 

	Future<int> deleteObject(PatrimTipoMovimentacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimTipoMovimentacaos).delete(object.patrimTipoMovimentacao!);
		});		
	}

	Future<void> insertChildren(PatrimTipoMovimentacaoGrouped object) async {
	}
	
	Future<void> deleteChildren(PatrimTipoMovimentacaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_tipo_movimentacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}