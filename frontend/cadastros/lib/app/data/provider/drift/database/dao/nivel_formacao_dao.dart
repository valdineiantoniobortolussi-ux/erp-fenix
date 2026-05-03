import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'nivel_formacao_dao.g.dart';

@DriftAccessor(tables: [
	NivelFormacaos,
])
class NivelFormacaoDao extends DatabaseAccessor<AppDatabase> with _$NivelFormacaoDaoMixin {
	final AppDatabase db;

	List<NivelFormacao> nivelFormacaoList = []; 
	List<NivelFormacaoGrouped> nivelFormacaoGroupedList = []; 

	NivelFormacaoDao(this.db) : super(db);

	Future<List<NivelFormacao>> getList() async {
		nivelFormacaoList = await select(nivelFormacaos).get();
		return nivelFormacaoList;
	}

	Future<List<NivelFormacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nivelFormacaoList = await (select(nivelFormacaos)..where((t) => expression)).get();
		return nivelFormacaoList;	 
	}

	Future<List<NivelFormacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nivelFormacaos)
			.join([]);

		if (field != null && field != '') { 
			final column = nivelFormacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nivelFormacaoGroupedList = await query.map((row) {
			final nivelFormacao = row.readTableOrNull(nivelFormacaos); 

			return NivelFormacaoGrouped(
				nivelFormacao: nivelFormacao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nivelFormacaoGrouped in nivelFormacaoGroupedList) {
		//}		

		return nivelFormacaoGroupedList;	
	}

	Future<NivelFormacao?> getObject(dynamic pk) async {
		return await (select(nivelFormacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NivelFormacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nivel_formacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NivelFormacao;		 
	} 

	Future<NivelFormacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NivelFormacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nivelFormacao = object.nivelFormacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nivelFormacaos).insert(object.nivelFormacao!);
			object.nivelFormacao = object.nivelFormacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NivelFormacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nivelFormacaos).replace(object.nivelFormacao!);
		});	 
	} 

	Future<int> deleteObject(NivelFormacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nivelFormacaos).delete(object.nivelFormacao!);
		});		
	}

	Future<void> insertChildren(NivelFormacaoGrouped object) async {
	}
	
	Future<void> deleteChildren(NivelFormacaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nivel_formacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}