import 'package:drift/drift.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';
import 'package:projetos/app/data/provider/drift/database/database_imports.dart';

part 'projeto_principal_dao.g.dart';

@DriftAccessor(tables: [
	ProjetoPrincipals,
	ProjetoCronogramas,
	ProjetoRiscos,
	ProjetoCustos,
	FinNaturezaFinanceiras,
	ProjetoStakeholderss,
	ViewPessoaColaboradors,
])
class ProjetoPrincipalDao extends DatabaseAccessor<AppDatabase> with _$ProjetoPrincipalDaoMixin {
	final AppDatabase db;

	List<ProjetoPrincipal> projetoPrincipalList = []; 
	List<ProjetoPrincipalGrouped> projetoPrincipalGroupedList = []; 

	ProjetoPrincipalDao(this.db) : super(db);

	Future<List<ProjetoPrincipal>> getList() async {
		projetoPrincipalList = await select(projetoPrincipals).get();
		return projetoPrincipalList;
	}

	Future<List<ProjetoPrincipal>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		projetoPrincipalList = await (select(projetoPrincipals)..where((t) => expression)).get();
		return projetoPrincipalList;	 
	}

	Future<List<ProjetoPrincipalGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(projetoPrincipals)
			.join([]);

		if (field != null && field != '') { 
			final column = projetoPrincipals.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		projetoPrincipalGroupedList = await query.map((row) {
			final projetoPrincipal = row.readTableOrNull(projetoPrincipals); 

			return ProjetoPrincipalGrouped(
				projetoPrincipal: projetoPrincipal, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var projetoPrincipalGrouped in projetoPrincipalGroupedList) {
			projetoPrincipalGrouped.projetoCronogramaGroupedList = [];
			final queryProjetoCronograma = ' id_projeto_principal = ${projetoPrincipalGrouped.projetoPrincipal!.id}';
			expression = CustomExpression<bool>(queryProjetoCronograma);
			final projetoCronogramaList = await (select(projetoCronogramas)..where((t) => expression)).get();
			for (var projetoCronograma in projetoCronogramaList) {
				ProjetoCronogramaGrouped projetoCronogramaGrouped = ProjetoCronogramaGrouped(
					projetoCronograma: projetoCronograma,
				);
				projetoPrincipalGrouped.projetoCronogramaGroupedList!.add(projetoCronogramaGrouped);
			}

			projetoPrincipalGrouped.projetoRiscoGroupedList = [];
			final queryProjetoRisco = ' id_projeto_principal = ${projetoPrincipalGrouped.projetoPrincipal!.id}';
			expression = CustomExpression<bool>(queryProjetoRisco);
			final projetoRiscoList = await (select(projetoRiscos)..where((t) => expression)).get();
			for (var projetoRisco in projetoRiscoList) {
				ProjetoRiscoGrouped projetoRiscoGrouped = ProjetoRiscoGrouped(
					projetoRisco: projetoRisco,
				);
				projetoPrincipalGrouped.projetoRiscoGroupedList!.add(projetoRiscoGrouped);
			}

			projetoPrincipalGrouped.projetoCustoGroupedList = [];
			final queryProjetoCusto = ' id_projeto_principal = ${projetoPrincipalGrouped.projetoPrincipal!.id}';
			expression = CustomExpression<bool>(queryProjetoCusto);
			final projetoCustoList = await (select(projetoCustos)..where((t) => expression)).get();
			for (var projetoCusto in projetoCustoList) {
				ProjetoCustoGrouped projetoCustoGrouped = ProjetoCustoGrouped(
					projetoCusto: projetoCusto,
					finNaturezaFinanceira: await (select(finNaturezaFinanceiras)..where((t) => t.id.equals(projetoCusto.idFinNaturezaFinanceira!))).getSingleOrNull(),
				);
				projetoPrincipalGrouped.projetoCustoGroupedList!.add(projetoCustoGrouped);
			}

			projetoPrincipalGrouped.projetoStakeholdersGroupedList = [];
			final queryProjetoStakeholders = ' id_projeto_principal = ${projetoPrincipalGrouped.projetoPrincipal!.id}';
			expression = CustomExpression<bool>(queryProjetoStakeholders);
			final projetoStakeholdersList = await (select(projetoStakeholderss)..where((t) => expression)).get();
			for (var projetoStakeholders in projetoStakeholdersList) {
				ProjetoStakeholdersGrouped projetoStakeholdersGrouped = ProjetoStakeholdersGrouped(
					projetoStakeholders: projetoStakeholders,
					viewPessoaColaborador: await (select(viewPessoaColaboradors)..where((t) => t.id.equals(projetoStakeholders.idColaborador!))).getSingleOrNull(),
				);
				projetoPrincipalGrouped.projetoStakeholdersGroupedList!.add(projetoStakeholdersGrouped);
			}

		}		

		return projetoPrincipalGroupedList;	
	}

	Future<ProjetoPrincipal?> getObject(dynamic pk) async {
		return await (select(projetoPrincipals)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ProjetoPrincipal?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM projeto_principal WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ProjetoPrincipal;		 
	} 

	Future<ProjetoPrincipalGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ProjetoPrincipalGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.projetoPrincipal = object.projetoPrincipal!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(projetoPrincipals).insert(object.projetoPrincipal!);
			object.projetoPrincipal = object.projetoPrincipal!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ProjetoPrincipalGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(projetoPrincipals).replace(object.projetoPrincipal!);
		});	 
	} 

	Future<int> deleteObject(ProjetoPrincipalGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(projetoPrincipals).delete(object.projetoPrincipal!);
		});		
	}

	Future<void> insertChildren(ProjetoPrincipalGrouped object) async {
		for (var projetoCronogramaGrouped in object.projetoCronogramaGroupedList!) {
			projetoCronogramaGrouped.projetoCronograma = projetoCronogramaGrouped.projetoCronograma?.copyWith(
				id: const Value(null),
				idProjetoPrincipal: Value(object.projetoPrincipal!.id),
			);
			await into(projetoCronogramas).insert(projetoCronogramaGrouped.projetoCronograma!);
		}
		for (var projetoRiscoGrouped in object.projetoRiscoGroupedList!) {
			projetoRiscoGrouped.projetoRisco = projetoRiscoGrouped.projetoRisco?.copyWith(
				id: const Value(null),
				idProjetoPrincipal: Value(object.projetoPrincipal!.id),
			);
			await into(projetoRiscos).insert(projetoRiscoGrouped.projetoRisco!);
		}
		for (var projetoCustoGrouped in object.projetoCustoGroupedList!) {
			projetoCustoGrouped.projetoCusto = projetoCustoGrouped.projetoCusto?.copyWith(
				id: const Value(null),
				idProjetoPrincipal: Value(object.projetoPrincipal!.id),
			);
			await into(projetoCustos).insert(projetoCustoGrouped.projetoCusto!);
		}
		for (var projetoStakeholdersGrouped in object.projetoStakeholdersGroupedList!) {
			projetoStakeholdersGrouped.projetoStakeholders = projetoStakeholdersGrouped.projetoStakeholders?.copyWith(
				id: const Value(null),
				idProjetoPrincipal: Value(object.projetoPrincipal!.id),
			);
			await into(projetoStakeholderss).insert(projetoStakeholdersGrouped.projetoStakeholders!);
		}
	}
	
	Future<void> deleteChildren(ProjetoPrincipalGrouped object) async {
		await (delete(projetoCronogramas)..where((t) => t.idProjetoPrincipal.equals(object.projetoPrincipal!.id!))).go();
		await (delete(projetoRiscos)..where((t) => t.idProjetoPrincipal.equals(object.projetoPrincipal!.id!))).go();
		await (delete(projetoCustos)..where((t) => t.idProjetoPrincipal.equals(object.projetoPrincipal!.id!))).go();
		await (delete(projetoStakeholderss)..where((t) => t.idProjetoPrincipal.equals(object.projetoPrincipal!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from projeto_principal").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}