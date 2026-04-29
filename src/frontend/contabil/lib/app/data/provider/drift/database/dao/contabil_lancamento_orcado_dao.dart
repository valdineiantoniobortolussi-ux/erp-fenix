import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_lancamento_orcado_dao.g.dart';

@DriftAccessor(tables: [
	ContabilLancamentoOrcados,
	ContabilContas,
])
class ContabilLancamentoOrcadoDao extends DatabaseAccessor<AppDatabase> with _$ContabilLancamentoOrcadoDaoMixin {
	final AppDatabase db;

	List<ContabilLancamentoOrcado> contabilLancamentoOrcadoList = []; 
	List<ContabilLancamentoOrcadoGrouped> contabilLancamentoOrcadoGroupedList = []; 

	ContabilLancamentoOrcadoDao(this.db) : super(db);

	Future<List<ContabilLancamentoOrcado>> getList() async {
		contabilLancamentoOrcadoList = await select(contabilLancamentoOrcados).get();
		return contabilLancamentoOrcadoList;
	}

	Future<List<ContabilLancamentoOrcado>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilLancamentoOrcadoList = await (select(contabilLancamentoOrcados)..where((t) => expression)).get();
		return contabilLancamentoOrcadoList;	 
	}

	Future<List<ContabilLancamentoOrcadoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilLancamentoOrcados)
			.join([ 
				leftOuterJoin(contabilContas, contabilContas.id.equalsExp(contabilLancamentoOrcados.idContabilConta)), 
			]);

		if (field != null && field != '') { 
			final column = contabilLancamentoOrcados.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilLancamentoOrcadoGroupedList = await query.map((row) {
			final contabilLancamentoOrcado = row.readTableOrNull(contabilLancamentoOrcados); 
			final contabilConta = row.readTableOrNull(contabilContas); 

			return ContabilLancamentoOrcadoGrouped(
				contabilLancamentoOrcado: contabilLancamentoOrcado, 
				contabilConta: contabilConta, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilLancamentoOrcadoGrouped in contabilLancamentoOrcadoGroupedList) {
		//}		

		return contabilLancamentoOrcadoGroupedList;	
	}

	Future<ContabilLancamentoOrcado?> getObject(dynamic pk) async {
		return await (select(contabilLancamentoOrcados)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilLancamentoOrcado?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_lancamento_orcado WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilLancamentoOrcado;		 
	} 

	Future<ContabilLancamentoOrcadoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilLancamentoOrcadoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilLancamentoOrcado = object.contabilLancamentoOrcado!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilLancamentoOrcados).insert(object.contabilLancamentoOrcado!);
			object.contabilLancamentoOrcado = object.contabilLancamentoOrcado!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilLancamentoOrcadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilLancamentoOrcados).replace(object.contabilLancamentoOrcado!);
		});	 
	} 

	Future<int> deleteObject(ContabilLancamentoOrcadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilLancamentoOrcados).delete(object.contabilLancamentoOrcado!);
		});		
	}

	Future<void> insertChildren(ContabilLancamentoOrcadoGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilLancamentoOrcadoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_lancamento_orcado").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}