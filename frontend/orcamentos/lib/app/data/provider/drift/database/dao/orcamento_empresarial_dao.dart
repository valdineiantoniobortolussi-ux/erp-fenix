import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';

part 'orcamento_empresarial_dao.g.dart';

@DriftAccessor(tables: [
	OrcamentoEmpresarials,
	OrcamentoDetalhes,
	FinNaturezaFinanceiras,
	OrcamentoPeriodos,
])
class OrcamentoEmpresarialDao extends DatabaseAccessor<AppDatabase> with _$OrcamentoEmpresarialDaoMixin {
	final AppDatabase db;

	List<OrcamentoEmpresarial> orcamentoEmpresarialList = []; 
	List<OrcamentoEmpresarialGrouped> orcamentoEmpresarialGroupedList = []; 

	OrcamentoEmpresarialDao(this.db) : super(db);

	Future<List<OrcamentoEmpresarial>> getList() async {
		orcamentoEmpresarialList = await select(orcamentoEmpresarials).get();
		return orcamentoEmpresarialList;
	}

	Future<List<OrcamentoEmpresarial>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		orcamentoEmpresarialList = await (select(orcamentoEmpresarials)..where((t) => expression)).get();
		return orcamentoEmpresarialList;	 
	}

	Future<List<OrcamentoEmpresarialGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(orcamentoEmpresarials)
			.join([ 
				leftOuterJoin(orcamentoPeriodos, orcamentoPeriodos.id.equalsExp(orcamentoEmpresarials.idOrcamentoPeriodo)), 
			]);

		if (field != null && field != '') { 
			final column = orcamentoEmpresarials.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		orcamentoEmpresarialGroupedList = await query.map((row) {
			final orcamentoEmpresarial = row.readTableOrNull(orcamentoEmpresarials); 
			final orcamentoPeriodo = row.readTableOrNull(orcamentoPeriodos); 

			return OrcamentoEmpresarialGrouped(
				orcamentoEmpresarial: orcamentoEmpresarial, 
				orcamentoPeriodo: orcamentoPeriodo, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var orcamentoEmpresarialGrouped in orcamentoEmpresarialGroupedList) {
			orcamentoEmpresarialGrouped.orcamentoDetalheGroupedList = [];
			final queryOrcamentoDetalhe = ' id_orcamento_empresarial = ${orcamentoEmpresarialGrouped.orcamentoEmpresarial!.id}';
			expression = CustomExpression<bool>(queryOrcamentoDetalhe);
			final orcamentoDetalheList = await (select(orcamentoDetalhes)..where((t) => expression)).get();
			for (var orcamentoDetalhe in orcamentoDetalheList) {
				OrcamentoDetalheGrouped orcamentoDetalheGrouped = OrcamentoDetalheGrouped(
					orcamentoDetalhe: orcamentoDetalhe,
					finNaturezaFinanceira: await (select(finNaturezaFinanceiras)..where((t) => t.id.equals(orcamentoDetalhe.idFinNaturezaFinanceira!))).getSingleOrNull(),
				);
				orcamentoEmpresarialGrouped.orcamentoDetalheGroupedList!.add(orcamentoDetalheGrouped);
			}

		}		

		return orcamentoEmpresarialGroupedList;	
	}

	Future<OrcamentoEmpresarial?> getObject(dynamic pk) async {
		return await (select(orcamentoEmpresarials)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OrcamentoEmpresarial?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM orcamento_empresarial WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OrcamentoEmpresarial;		 
	} 

	Future<OrcamentoEmpresarialGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OrcamentoEmpresarialGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.orcamentoEmpresarial = object.orcamentoEmpresarial!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(orcamentoEmpresarials).insert(object.orcamentoEmpresarial!);
			object.orcamentoEmpresarial = object.orcamentoEmpresarial!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OrcamentoEmpresarialGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(orcamentoEmpresarials).replace(object.orcamentoEmpresarial!);
		});	 
	} 

	Future<int> deleteObject(OrcamentoEmpresarialGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(orcamentoEmpresarials).delete(object.orcamentoEmpresarial!);
		});		
	}

	Future<void> insertChildren(OrcamentoEmpresarialGrouped object) async {
		for (var orcamentoDetalheGrouped in object.orcamentoDetalheGroupedList!) {
			orcamentoDetalheGrouped.orcamentoDetalhe = orcamentoDetalheGrouped.orcamentoDetalhe?.copyWith(
				id: const Value(null),
				idOrcamentoEmpresarial: Value(object.orcamentoEmpresarial!.id),
			);
			await into(orcamentoDetalhes).insert(orcamentoDetalheGrouped.orcamentoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(OrcamentoEmpresarialGrouped object) async {
		await (delete(orcamentoDetalhes)..where((t) => t.idOrcamentoEmpresarial.equals(object.orcamentoEmpresarial!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from orcamento_empresarial").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}