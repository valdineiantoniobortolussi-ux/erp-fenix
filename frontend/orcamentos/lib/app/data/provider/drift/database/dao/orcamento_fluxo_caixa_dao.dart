import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';

part 'orcamento_fluxo_caixa_dao.g.dart';

@DriftAccessor(tables: [
	OrcamentoFluxoCaixas,
	OrcamentoFluxoCaixaDetalhes,
	FinNaturezaFinanceiras,
	OrcamentoFluxoCaixaPeriodos,
])
class OrcamentoFluxoCaixaDao extends DatabaseAccessor<AppDatabase> with _$OrcamentoFluxoCaixaDaoMixin {
	final AppDatabase db;

	List<OrcamentoFluxoCaixa> orcamentoFluxoCaixaList = []; 
	List<OrcamentoFluxoCaixaGrouped> orcamentoFluxoCaixaGroupedList = []; 

	OrcamentoFluxoCaixaDao(this.db) : super(db);

	Future<List<OrcamentoFluxoCaixa>> getList() async {
		orcamentoFluxoCaixaList = await select(orcamentoFluxoCaixas).get();
		return orcamentoFluxoCaixaList;
	}

	Future<List<OrcamentoFluxoCaixa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		orcamentoFluxoCaixaList = await (select(orcamentoFluxoCaixas)..where((t) => expression)).get();
		return orcamentoFluxoCaixaList;	 
	}

	Future<List<OrcamentoFluxoCaixaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(orcamentoFluxoCaixas)
			.join([ 
				leftOuterJoin(orcamentoFluxoCaixaPeriodos, orcamentoFluxoCaixaPeriodos.id.equalsExp(orcamentoFluxoCaixas.idOrcFluxoCaixaPeriodo)), 
			]);

		if (field != null && field != '') { 
			final column = orcamentoFluxoCaixas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		orcamentoFluxoCaixaGroupedList = await query.map((row) {
			final orcamentoFluxoCaixa = row.readTableOrNull(orcamentoFluxoCaixas); 
			final orcamentoFluxoCaixaPeriodo = row.readTableOrNull(orcamentoFluxoCaixaPeriodos); 

			return OrcamentoFluxoCaixaGrouped(
				orcamentoFluxoCaixa: orcamentoFluxoCaixa, 
				orcamentoFluxoCaixaPeriodo: orcamentoFluxoCaixaPeriodo, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var orcamentoFluxoCaixaGrouped in orcamentoFluxoCaixaGroupedList) {
			orcamentoFluxoCaixaGrouped.orcamentoFluxoCaixaDetalheGroupedList = [];
			final queryOrcamentoFluxoCaixaDetalhe = ' id_orcamento_fluxo_caixa = ${orcamentoFluxoCaixaGrouped.orcamentoFluxoCaixa!.id}';
			expression = CustomExpression<bool>(queryOrcamentoFluxoCaixaDetalhe);
			final orcamentoFluxoCaixaDetalheList = await (select(orcamentoFluxoCaixaDetalhes)..where((t) => expression)).get();
			for (var orcamentoFluxoCaixaDetalhe in orcamentoFluxoCaixaDetalheList) {
				OrcamentoFluxoCaixaDetalheGrouped orcamentoFluxoCaixaDetalheGrouped = OrcamentoFluxoCaixaDetalheGrouped(
					orcamentoFluxoCaixaDetalhe: orcamentoFluxoCaixaDetalhe,
					finNaturezaFinanceira: await (select(finNaturezaFinanceiras)..where((t) => t.id.equals(orcamentoFluxoCaixaDetalhe.idFinNaturezaFinanceira!))).getSingleOrNull(),
				);
				orcamentoFluxoCaixaGrouped.orcamentoFluxoCaixaDetalheGroupedList!.add(orcamentoFluxoCaixaDetalheGrouped);
			}

		}		

		return orcamentoFluxoCaixaGroupedList;	
	}

	Future<OrcamentoFluxoCaixa?> getObject(dynamic pk) async {
		return await (select(orcamentoFluxoCaixas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OrcamentoFluxoCaixa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM orcamento_fluxo_caixa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OrcamentoFluxoCaixa;		 
	} 

	Future<OrcamentoFluxoCaixaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OrcamentoFluxoCaixaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.orcamentoFluxoCaixa = object.orcamentoFluxoCaixa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(orcamentoFluxoCaixas).insert(object.orcamentoFluxoCaixa!);
			object.orcamentoFluxoCaixa = object.orcamentoFluxoCaixa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OrcamentoFluxoCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(orcamentoFluxoCaixas).replace(object.orcamentoFluxoCaixa!);
		});	 
	} 

	Future<int> deleteObject(OrcamentoFluxoCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(orcamentoFluxoCaixas).delete(object.orcamentoFluxoCaixa!);
		});		
	}

	Future<void> insertChildren(OrcamentoFluxoCaixaGrouped object) async {
		for (var orcamentoFluxoCaixaDetalheGrouped in object.orcamentoFluxoCaixaDetalheGroupedList!) {
			orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe = orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.copyWith(
				id: const Value(null),
				idOrcamentoFluxoCaixa: Value(object.orcamentoFluxoCaixa!.id),
			);
			await into(orcamentoFluxoCaixaDetalhes).insert(orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe!);
		}
	}
	
	Future<void> deleteChildren(OrcamentoFluxoCaixaGrouped object) async {
		await (delete(orcamentoFluxoCaixaDetalhes)..where((t) => t.idOrcamentoFluxoCaixa.equals(object.orcamentoFluxoCaixa!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from orcamento_fluxo_caixa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}