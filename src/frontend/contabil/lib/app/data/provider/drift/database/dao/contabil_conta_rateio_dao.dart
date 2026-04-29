import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_conta_rateio_dao.g.dart';

@DriftAccessor(tables: [
	ContabilContaRateios,
	ContabilContas,
	CentroResultados,
])
class ContabilContaRateioDao extends DatabaseAccessor<AppDatabase> with _$ContabilContaRateioDaoMixin {
	final AppDatabase db;

	List<ContabilContaRateio> contabilContaRateioList = []; 
	List<ContabilContaRateioGrouped> contabilContaRateioGroupedList = []; 

	ContabilContaRateioDao(this.db) : super(db);

	Future<List<ContabilContaRateio>> getList() async {
		contabilContaRateioList = await select(contabilContaRateios).get();
		return contabilContaRateioList;
	}

	Future<List<ContabilContaRateio>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilContaRateioList = await (select(contabilContaRateios)..where((t) => expression)).get();
		return contabilContaRateioList;	 
	}

	Future<List<ContabilContaRateioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilContaRateios)
			.join([ 
				leftOuterJoin(contabilContas, contabilContas.id.equalsExp(contabilContaRateios.idContabilConta)), 
			]).join([ 
				leftOuterJoin(centroResultados, centroResultados.id.equalsExp(contabilContaRateios.idCentroResultado)), 
			]);

		if (field != null && field != '') { 
			final column = contabilContaRateios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilContaRateioGroupedList = await query.map((row) {
			final contabilContaRateio = row.readTableOrNull(contabilContaRateios); 
			final contabilConta = row.readTableOrNull(contabilContas); 
			final centroResultado = row.readTableOrNull(centroResultados); 

			return ContabilContaRateioGrouped(
				contabilContaRateio: contabilContaRateio, 
				contabilConta: contabilConta, 
				centroResultado: centroResultado, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilContaRateioGrouped in contabilContaRateioGroupedList) {
		//}		

		return contabilContaRateioGroupedList;	
	}

	Future<ContabilContaRateio?> getObject(dynamic pk) async {
		return await (select(contabilContaRateios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilContaRateio?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_conta_rateio WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilContaRateio;		 
	} 

	Future<ContabilContaRateioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilContaRateioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilContaRateio = object.contabilContaRateio!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilContaRateios).insert(object.contabilContaRateio!);
			object.contabilContaRateio = object.contabilContaRateio!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilContaRateioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilContaRateios).replace(object.contabilContaRateio!);
		});	 
	} 

	Future<int> deleteObject(ContabilContaRateioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilContaRateios).delete(object.contabilContaRateio!);
		});		
	}

	Future<void> insertChildren(ContabilContaRateioGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilContaRateioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_conta_rateio").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}