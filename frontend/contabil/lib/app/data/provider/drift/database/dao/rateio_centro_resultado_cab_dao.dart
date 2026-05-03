import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'rateio_centro_resultado_cab_dao.g.dart';

@DriftAccessor(tables: [
	RateioCentroResultadoCabs,
	RateioCentroResultadoDets,
	CentroResultados,
	CentroResultados,
])
class RateioCentroResultadoCabDao extends DatabaseAccessor<AppDatabase> with _$RateioCentroResultadoCabDaoMixin {
	final AppDatabase db;

	List<RateioCentroResultadoCab> rateioCentroResultadoCabList = []; 
	List<RateioCentroResultadoCabGrouped> rateioCentroResultadoCabGroupedList = []; 

	RateioCentroResultadoCabDao(this.db) : super(db);

	Future<List<RateioCentroResultadoCab>> getList() async {
		rateioCentroResultadoCabList = await select(rateioCentroResultadoCabs).get();
		return rateioCentroResultadoCabList;
	}

	Future<List<RateioCentroResultadoCab>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		rateioCentroResultadoCabList = await (select(rateioCentroResultadoCabs)..where((t) => expression)).get();
		return rateioCentroResultadoCabList;	 
	}

	Future<List<RateioCentroResultadoCabGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(rateioCentroResultadoCabs)
			.join([ 
				leftOuterJoin(centroResultados, centroResultados.id.equalsExp(rateioCentroResultadoCabs.idCentroResultado)), 
			]);

		if (field != null && field != '') { 
			final column = rateioCentroResultadoCabs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		rateioCentroResultadoCabGroupedList = await query.map((row) {
			final rateioCentroResultadoCab = row.readTableOrNull(rateioCentroResultadoCabs); 
			final centroResultado = row.readTableOrNull(centroResultados); 

			return RateioCentroResultadoCabGrouped(
				rateioCentroResultadoCab: rateioCentroResultadoCab, 
				centroResultado: centroResultado, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var rateioCentroResultadoCabGrouped in rateioCentroResultadoCabGroupedList) {
			rateioCentroResultadoCabGrouped.rateioCentroResultadoDetGroupedList = [];
			final queryRateioCentroResultadoDet = ' id_rateio_centro_resul_cab = ${rateioCentroResultadoCabGrouped.rateioCentroResultadoCab!.id}';
			expression = CustomExpression<bool>(queryRateioCentroResultadoDet);
			final rateioCentroResultadoDetList = await (select(rateioCentroResultadoDets)..where((t) => expression)).get();
			for (var rateioCentroResultadoDet in rateioCentroResultadoDetList) {
				RateioCentroResultadoDetGrouped rateioCentroResultadoDetGrouped = RateioCentroResultadoDetGrouped(
					rateioCentroResultadoDet: rateioCentroResultadoDet,
					centroResultado: await (select(centroResultados)..where((t) => t.id.equals(rateioCentroResultadoDet.idCentroResultadoDestino!))).getSingleOrNull(),
				);
				rateioCentroResultadoCabGrouped.rateioCentroResultadoDetGroupedList!.add(rateioCentroResultadoDetGrouped);
			}

		}		

		return rateioCentroResultadoCabGroupedList;	
	}

	Future<RateioCentroResultadoCab?> getObject(dynamic pk) async {
		return await (select(rateioCentroResultadoCabs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<RateioCentroResultadoCab?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM rateio_centro_resultado_cab WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as RateioCentroResultadoCab;		 
	} 

	Future<RateioCentroResultadoCabGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(RateioCentroResultadoCabGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.rateioCentroResultadoCab = object.rateioCentroResultadoCab!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(rateioCentroResultadoCabs).insert(object.rateioCentroResultadoCab!);
			object.rateioCentroResultadoCab = object.rateioCentroResultadoCab!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(RateioCentroResultadoCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(rateioCentroResultadoCabs).replace(object.rateioCentroResultadoCab!);
		});	 
	} 

	Future<int> deleteObject(RateioCentroResultadoCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(rateioCentroResultadoCabs).delete(object.rateioCentroResultadoCab!);
		});		
	}

	Future<void> insertChildren(RateioCentroResultadoCabGrouped object) async {
		for (var rateioCentroResultadoDetGrouped in object.rateioCentroResultadoDetGroupedList!) {
			rateioCentroResultadoDetGrouped.rateioCentroResultadoDet = rateioCentroResultadoDetGrouped.rateioCentroResultadoDet?.copyWith(
				id: const Value(null),
				idRateioCentroResulCab: Value(object.rateioCentroResultadoCab!.id),
			);
			await into(rateioCentroResultadoDets).insert(rateioCentroResultadoDetGrouped.rateioCentroResultadoDet!);
		}
	}
	
	Future<void> deleteChildren(RateioCentroResultadoCabGrouped object) async {
		await (delete(rateioCentroResultadoDets)..where((t) => t.idRateioCentroResulCab.equals(object.rateioCentroResultadoCab!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from rateio_centro_resultado_cab").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}