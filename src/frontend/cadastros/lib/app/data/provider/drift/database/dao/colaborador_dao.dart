import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'colaborador_dao.g.dart';

@DriftAccessor(tables: [
	Colaboradors,
	Vendedors,
	ComissaoPerfils,
	Pessoas,
	ColaboradorSituacaos,
	ColaboradorTipos,
	Setors,
	Cargos,
	TipoAdmissaos,
	ColaboradorRelacionamentos,
	TipoRelacionamentos,
	Sindicatos,
])
class ColaboradorDao extends DatabaseAccessor<AppDatabase> with _$ColaboradorDaoMixin {
	final AppDatabase db;

	List<Colaborador> colaboradorList = []; 
	List<ColaboradorGrouped> colaboradorGroupedList = []; 

	ColaboradorDao(this.db) : super(db);

	Future<List<Colaborador>> getList() async {
		colaboradorList = await select(colaboradors).get();
		return colaboradorList;
	}

	Future<List<Colaborador>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		colaboradorList = await (select(colaboradors)..where((t) => expression)).get();
		return colaboradorList;	 
	}

	Future<List<ColaboradorGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(colaboradors)
			.join([ 
				leftOuterJoin(vendedors, vendedors.idColaborador.equalsExp(colaboradors.id)), 
			]).join([ 
				leftOuterJoin(comissaoPerfils, comissaoPerfils.id.equalsExp(vendedors.idComissaoPerfil)), 
			]).join([ 
				leftOuterJoin(pessoas, pessoas.id.equalsExp(colaboradors.idPessoa)), 
			]).join([ 
				leftOuterJoin(colaboradorSituacaos, colaboradorSituacaos.id.equalsExp(colaboradors.idColaboradorSituacao)), 
			]).join([ 
				leftOuterJoin(colaboradorTipos, colaboradorTipos.id.equalsExp(colaboradors.idColaboradorTipo)), 
			]).join([ 
				leftOuterJoin(setors, setors.id.equalsExp(colaboradors.idSetor)), 
			]).join([ 
				leftOuterJoin(cargos, cargos.id.equalsExp(colaboradors.idCargo)), 
			]).join([ 
				leftOuterJoin(tipoAdmissaos, tipoAdmissaos.id.equalsExp(colaboradors.idTipoAdmissao)), 
			]).join([ 
				leftOuterJoin(sindicatos, sindicatos.id.equalsExp(colaboradors.idSindicato)), 
			]);

		if (field != null && field != '') { 
			final column = colaboradors.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		colaboradorGroupedList = await query.map((row) {
			final colaborador = row.readTableOrNull(colaboradors); 
			final vendedor = row.readTableOrNull(vendedors); 
			final comissaoPerfil = row.readTableOrNull(comissaoPerfils); 
			final pessoa = row.readTableOrNull(pessoas); 
			final colaboradorSituacao = row.readTableOrNull(colaboradorSituacaos); 
			final colaboradorTipo = row.readTableOrNull(colaboradorTipos); 
			final setor = row.readTableOrNull(setors); 
			final cargo = row.readTableOrNull(cargos); 
			final tipoAdmissao = row.readTableOrNull(tipoAdmissaos); 
			final sindicato = row.readTableOrNull(sindicatos); 

			return ColaboradorGrouped(
				colaborador: colaborador, 
				vendedorGrouped: VendedorGrouped 
				(
					vendedor: vendedor, 
					comissaoPerfil: comissaoPerfil, 
				),
				pessoa: pessoa, 
				colaboradorSituacao: colaboradorSituacao, 
				colaboradorTipo: colaboradorTipo, 
				setor: setor, 
				cargo: cargo, 
				tipoAdmissao: tipoAdmissao, 
				sindicato: sindicato, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var colaboradorGrouped in colaboradorGroupedList) {
			colaboradorGrouped.colaboradorRelacionamentoGroupedList = [];
			final queryColaboradorRelacionamento = ' id_colaborador = ${colaboradorGrouped.colaborador!.id}';
			expression = CustomExpression<bool>(queryColaboradorRelacionamento);
			final colaboradorRelacionamentoList = await (select(colaboradorRelacionamentos)..where((t) => expression)).get();
			for (var colaboradorRelacionamento in colaboradorRelacionamentoList) {
				ColaboradorRelacionamentoGrouped colaboradorRelacionamentoGrouped = ColaboradorRelacionamentoGrouped(
					colaboradorRelacionamento: colaboradorRelacionamento,
					tipoRelacionamento: await (select(tipoRelacionamentos)..where((t) => t.id.equals(colaboradorRelacionamento.idTipoRelacionamento!))).getSingleOrNull(),
				);
				colaboradorGrouped.colaboradorRelacionamentoGroupedList!.add(colaboradorRelacionamentoGrouped);
			}

		}		

		return colaboradorGroupedList;	
	}

	Future<Colaborador?> getObject(dynamic pk) async {
		return await (select(colaboradors)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Colaborador?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM colaborador WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Colaborador;		 
	} 

	Future<ColaboradorGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ColaboradorGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.colaborador = object.colaborador!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(colaboradors).insert(object.colaborador!);
			object.colaborador = object.colaborador!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ColaboradorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(colaboradors).replace(object.colaborador!);
		});	 
	} 

	Future<int> deleteObject(ColaboradorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(colaboradors).delete(object.colaborador!);
		});		
	}

	Future<void> insertChildren(ColaboradorGrouped object) async {
		object.vendedorGrouped!.vendedor = object.vendedorGrouped!.vendedor!.copyWith(idColaborador: Value(object.colaborador!.id));
		// await into(pessoaFisicas).insert(object.pessoaFisicaGrouped!.pessoaFisica!);
		for (var colaboradorRelacionamentoGrouped in object.colaboradorRelacionamentoGroupedList!) {
			colaboradorRelacionamentoGrouped.colaboradorRelacionamento = colaboradorRelacionamentoGrouped.colaboradorRelacionamento?.copyWith(
				id: const Value(null),
				idColaborador: Value(object.colaborador!.id),
			);
			await into(colaboradorRelacionamentos).insert(colaboradorRelacionamentoGrouped.colaboradorRelacionamento!);
		}
	}
	
	Future<void> deleteChildren(ColaboradorGrouped object) async {
		await (delete(vendedors)..where((t) => t.idColaborador.equals(object.colaborador!.id!))).go();
		await (delete(colaboradorRelacionamentos)..where((t) => t.idColaborador.equals(object.colaborador!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from colaborador").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}