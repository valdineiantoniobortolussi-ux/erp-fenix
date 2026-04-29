import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'simples_nacional_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	SimplesNacionalCabecalhos,
	SimplesNacionalDetalhes,
])
class SimplesNacionalCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$SimplesNacionalCabecalhoDaoMixin {
	final AppDatabase db;

	List<SimplesNacionalCabecalho> simplesNacionalCabecalhoList = []; 
	List<SimplesNacionalCabecalhoGrouped> simplesNacionalCabecalhoGroupedList = []; 

	SimplesNacionalCabecalhoDao(this.db) : super(db);

	Future<List<SimplesNacionalCabecalho>> getList() async {
		simplesNacionalCabecalhoList = await select(simplesNacionalCabecalhos).get();
		return simplesNacionalCabecalhoList;
	}

	Future<List<SimplesNacionalCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		simplesNacionalCabecalhoList = await (select(simplesNacionalCabecalhos)..where((t) => expression)).get();
		return simplesNacionalCabecalhoList;	 
	}

	Future<List<SimplesNacionalCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(simplesNacionalCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = simplesNacionalCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		simplesNacionalCabecalhoGroupedList = await query.map((row) {
			final simplesNacionalCabecalho = row.readTableOrNull(simplesNacionalCabecalhos); 

			return SimplesNacionalCabecalhoGrouped(
				simplesNacionalCabecalho: simplesNacionalCabecalho, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var simplesNacionalCabecalhoGrouped in simplesNacionalCabecalhoGroupedList) {
			simplesNacionalCabecalhoGrouped.simplesNacionalDetalheGroupedList = [];
			final querySimplesNacionalDetalhe = ' id_simples_nacional_cabecalho = ${simplesNacionalCabecalhoGrouped.simplesNacionalCabecalho!.id}';
			expression = CustomExpression<bool>(querySimplesNacionalDetalhe);
			final simplesNacionalDetalheList = await (select(simplesNacionalDetalhes)..where((t) => expression)).get();
			for (var simplesNacionalDetalhe in simplesNacionalDetalheList) {
				SimplesNacionalDetalheGrouped simplesNacionalDetalheGrouped = SimplesNacionalDetalheGrouped(
					simplesNacionalDetalhe: simplesNacionalDetalhe,
				);
				simplesNacionalCabecalhoGrouped.simplesNacionalDetalheGroupedList!.add(simplesNacionalDetalheGrouped);
			}

		}		

		return simplesNacionalCabecalhoGroupedList;	
	}

	Future<SimplesNacionalCabecalho?> getObject(dynamic pk) async {
		return await (select(simplesNacionalCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<SimplesNacionalCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM simples_nacional_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as SimplesNacionalCabecalho;		 
	} 

	Future<SimplesNacionalCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(SimplesNacionalCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.simplesNacionalCabecalho = object.simplesNacionalCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(simplesNacionalCabecalhos).insert(object.simplesNacionalCabecalho!);
			object.simplesNacionalCabecalho = object.simplesNacionalCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(SimplesNacionalCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(simplesNacionalCabecalhos).replace(object.simplesNacionalCabecalho!);
		});	 
	} 

	Future<int> deleteObject(SimplesNacionalCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(simplesNacionalCabecalhos).delete(object.simplesNacionalCabecalho!);
		});		
	}

	Future<void> insertChildren(SimplesNacionalCabecalhoGrouped object) async {
		for (var simplesNacionalDetalheGrouped in object.simplesNacionalDetalheGroupedList!) {
			simplesNacionalDetalheGrouped.simplesNacionalDetalhe = simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.copyWith(
				id: const Value(null),
				idSimplesNacionalCabecalho: Value(object.simplesNacionalCabecalho!.id),
			);
			await into(simplesNacionalDetalhes).insert(simplesNacionalDetalheGrouped.simplesNacionalDetalhe!);
		}
	}
	
	Future<void> deleteChildren(SimplesNacionalCabecalhoGrouped object) async {
		await (delete(simplesNacionalDetalhes)..where((t) => t.idSimplesNacionalCabecalho.equals(object.simplesNacionalCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from simples_nacional_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}