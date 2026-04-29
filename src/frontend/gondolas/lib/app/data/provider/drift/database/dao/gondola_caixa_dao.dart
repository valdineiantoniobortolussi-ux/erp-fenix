import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';

part 'gondola_caixa_dao.g.dart';

@DriftAccessor(tables: [
	GondolaCaixas,
	GondolaArmazenamentos,
	Produtos,
	GondolaEstantes,
])
class GondolaCaixaDao extends DatabaseAccessor<AppDatabase> with _$GondolaCaixaDaoMixin {
	final AppDatabase db;

	List<GondolaCaixa> gondolaCaixaList = []; 
	List<GondolaCaixaGrouped> gondolaCaixaGroupedList = []; 

	GondolaCaixaDao(this.db) : super(db);

	Future<List<GondolaCaixa>> getList() async {
		gondolaCaixaList = await select(gondolaCaixas).get();
		return gondolaCaixaList;
	}

	Future<List<GondolaCaixa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		gondolaCaixaList = await (select(gondolaCaixas)..where((t) => expression)).get();
		return gondolaCaixaList;	 
	}

	Future<List<GondolaCaixaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(gondolaCaixas)
			.join([ 
				leftOuterJoin(gondolaEstantes, gondolaEstantes.id.equalsExp(gondolaCaixas.idGondolaEstante)), 
			]);

		if (field != null && field != '') { 
			final column = gondolaCaixas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		gondolaCaixaGroupedList = await query.map((row) {
			final gondolaCaixa = row.readTableOrNull(gondolaCaixas); 
			final gondolaEstante = row.readTableOrNull(gondolaEstantes); 

			return GondolaCaixaGrouped(
				gondolaCaixa: gondolaCaixa, 
				gondolaEstante: gondolaEstante, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var gondolaCaixaGrouped in gondolaCaixaGroupedList) {
			gondolaCaixaGrouped.gondolaArmazenamentoGroupedList = [];
			final queryGondolaArmazenamento = ' id_gondola_caixa = ${gondolaCaixaGrouped.gondolaCaixa!.id}';
			expression = CustomExpression<bool>(queryGondolaArmazenamento);
			final gondolaArmazenamentoList = await (select(gondolaArmazenamentos)..where((t) => expression)).get();
			for (var gondolaArmazenamento in gondolaArmazenamentoList) {
				GondolaArmazenamentoGrouped gondolaArmazenamentoGrouped = GondolaArmazenamentoGrouped(
					gondolaArmazenamento: gondolaArmazenamento,
					produto: await (select(produtos)..where((t) => t.id.equals(gondolaArmazenamento.idProduto!))).getSingleOrNull(),
				);
				gondolaCaixaGrouped.gondolaArmazenamentoGroupedList!.add(gondolaArmazenamentoGrouped);
			}

		}		

		return gondolaCaixaGroupedList;	
	}

	Future<GondolaCaixa?> getObject(dynamic pk) async {
		return await (select(gondolaCaixas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<GondolaCaixa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM gondola_caixa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as GondolaCaixa;		 
	} 

	Future<GondolaCaixaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(GondolaCaixaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.gondolaCaixa = object.gondolaCaixa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(gondolaCaixas).insert(object.gondolaCaixa!);
			object.gondolaCaixa = object.gondolaCaixa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(GondolaCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(gondolaCaixas).replace(object.gondolaCaixa!);
		});	 
	} 

	Future<int> deleteObject(GondolaCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(gondolaCaixas).delete(object.gondolaCaixa!);
		});		
	}

	Future<void> insertChildren(GondolaCaixaGrouped object) async {
		for (var gondolaArmazenamentoGrouped in object.gondolaArmazenamentoGroupedList!) {
			gondolaArmazenamentoGrouped.gondolaArmazenamento = gondolaArmazenamentoGrouped.gondolaArmazenamento?.copyWith(
				id: const Value(null),
				idGondolaCaixa: Value(object.gondolaCaixa!.id),
			);
			await into(gondolaArmazenamentos).insert(gondolaArmazenamentoGrouped.gondolaArmazenamento!);
		}
	}
	
	Future<void> deleteChildren(GondolaCaixaGrouped object) async {
		await (delete(gondolaArmazenamentos)..where((t) => t.idGondolaCaixa.equals(object.gondolaCaixa!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from gondola_caixa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}