import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';

part 'orcamento_fluxo_caixa_periodo_dao.g.dart';

@DriftAccessor(tables: [
	OrcamentoFluxoCaixaPeriodos,
	BancoContaCaixas,
])
class OrcamentoFluxoCaixaPeriodoDao extends DatabaseAccessor<AppDatabase> with _$OrcamentoFluxoCaixaPeriodoDaoMixin {
	final AppDatabase db;

	List<OrcamentoFluxoCaixaPeriodo> orcamentoFluxoCaixaPeriodoList = []; 
	List<OrcamentoFluxoCaixaPeriodoGrouped> orcamentoFluxoCaixaPeriodoGroupedList = []; 

	OrcamentoFluxoCaixaPeriodoDao(this.db) : super(db);

	Future<List<OrcamentoFluxoCaixaPeriodo>> getList() async {
		orcamentoFluxoCaixaPeriodoList = await select(orcamentoFluxoCaixaPeriodos).get();
		return orcamentoFluxoCaixaPeriodoList;
	}

	Future<List<OrcamentoFluxoCaixaPeriodo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		orcamentoFluxoCaixaPeriodoList = await (select(orcamentoFluxoCaixaPeriodos)..where((t) => expression)).get();
		return orcamentoFluxoCaixaPeriodoList;	 
	}

	Future<List<OrcamentoFluxoCaixaPeriodoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(orcamentoFluxoCaixaPeriodos)
			.join([ 
				leftOuterJoin(bancoContaCaixas, bancoContaCaixas.id.equalsExp(orcamentoFluxoCaixaPeriodos.idBancoContaCaixa)), 
			]);

		if (field != null && field != '') { 
			final column = orcamentoFluxoCaixaPeriodos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		orcamentoFluxoCaixaPeriodoGroupedList = await query.map((row) {
			final orcamentoFluxoCaixaPeriodo = row.readTableOrNull(orcamentoFluxoCaixaPeriodos); 
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 

			return OrcamentoFluxoCaixaPeriodoGrouped(
				orcamentoFluxoCaixaPeriodo: orcamentoFluxoCaixaPeriodo, 
				bancoContaCaixa: bancoContaCaixa, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var orcamentoFluxoCaixaPeriodoGrouped in orcamentoFluxoCaixaPeriodoGroupedList) {
		//}		

		return orcamentoFluxoCaixaPeriodoGroupedList;	
	}

	Future<OrcamentoFluxoCaixaPeriodo?> getObject(dynamic pk) async {
		return await (select(orcamentoFluxoCaixaPeriodos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OrcamentoFluxoCaixaPeriodo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM orcamento_fluxo_caixa_periodo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OrcamentoFluxoCaixaPeriodo;		 
	} 

	Future<OrcamentoFluxoCaixaPeriodoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OrcamentoFluxoCaixaPeriodoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.orcamentoFluxoCaixaPeriodo = object.orcamentoFluxoCaixaPeriodo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(orcamentoFluxoCaixaPeriodos).insert(object.orcamentoFluxoCaixaPeriodo!);
			object.orcamentoFluxoCaixaPeriodo = object.orcamentoFluxoCaixaPeriodo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OrcamentoFluxoCaixaPeriodoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(orcamentoFluxoCaixaPeriodos).replace(object.orcamentoFluxoCaixaPeriodo!);
		});	 
	} 

	Future<int> deleteObject(OrcamentoFluxoCaixaPeriodoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(orcamentoFluxoCaixaPeriodos).delete(object.orcamentoFluxoCaixaPeriodo!);
		});		
	}

	Future<void> insertChildren(OrcamentoFluxoCaixaPeriodoGrouped object) async {
	}
	
	Future<void> deleteChildren(OrcamentoFluxoCaixaPeriodoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from orcamento_fluxo_caixa_periodo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}