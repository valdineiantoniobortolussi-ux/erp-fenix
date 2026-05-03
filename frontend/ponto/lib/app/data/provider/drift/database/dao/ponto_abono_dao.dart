import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_abono_dao.g.dart';

@DriftAccessor(tables: [
	PontoAbonos,
	PontoAbonoUtilizacaos,
	ViewPessoaColaboradors,
])
class PontoAbonoDao extends DatabaseAccessor<AppDatabase> with _$PontoAbonoDaoMixin {
	final AppDatabase db;

	List<PontoAbono> pontoAbonoList = []; 
	List<PontoAbonoGrouped> pontoAbonoGroupedList = []; 

	PontoAbonoDao(this.db) : super(db);

	Future<List<PontoAbono>> getList() async {
		pontoAbonoList = await select(pontoAbonos).get();
		return pontoAbonoList;
	}

	Future<List<PontoAbono>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoAbonoList = await (select(pontoAbonos)..where((t) => expression)).get();
		return pontoAbonoList;	 
	}

	Future<List<PontoAbonoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoAbonos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(pontoAbonos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = pontoAbonos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoAbonoGroupedList = await query.map((row) {
			final pontoAbono = row.readTableOrNull(pontoAbonos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return PontoAbonoGrouped(
				pontoAbono: pontoAbono, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var pontoAbonoGrouped in pontoAbonoGroupedList) {
			pontoAbonoGrouped.pontoAbonoUtilizacaoGroupedList = [];
			final queryPontoAbonoUtilizacao = ' id_ponto_abono = ${pontoAbonoGrouped.pontoAbono!.id}';
			expression = CustomExpression<bool>(queryPontoAbonoUtilizacao);
			final pontoAbonoUtilizacaoList = await (select(pontoAbonoUtilizacaos)..where((t) => expression)).get();
			for (var pontoAbonoUtilizacao in pontoAbonoUtilizacaoList) {
				PontoAbonoUtilizacaoGrouped pontoAbonoUtilizacaoGrouped = PontoAbonoUtilizacaoGrouped(
					pontoAbonoUtilizacao: pontoAbonoUtilizacao,
				);
				pontoAbonoGrouped.pontoAbonoUtilizacaoGroupedList!.add(pontoAbonoUtilizacaoGrouped);
			}

		}		

		return pontoAbonoGroupedList;	
	}

	Future<PontoAbono?> getObject(dynamic pk) async {
		return await (select(pontoAbonos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoAbono?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_abono WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoAbono;		 
	} 

	Future<PontoAbonoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoAbonoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoAbono = object.pontoAbono!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoAbonos).insert(object.pontoAbono!);
			object.pontoAbono = object.pontoAbono!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoAbonoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoAbonos).replace(object.pontoAbono!);
		});	 
	} 

	Future<int> deleteObject(PontoAbonoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoAbonos).delete(object.pontoAbono!);
		});		
	}

	Future<void> insertChildren(PontoAbonoGrouped object) async {
		for (var pontoAbonoUtilizacaoGrouped in object.pontoAbonoUtilizacaoGroupedList!) {
			pontoAbonoUtilizacaoGrouped.pontoAbonoUtilizacao = pontoAbonoUtilizacaoGrouped.pontoAbonoUtilizacao?.copyWith(
				id: const Value(null),
				idPontoAbono: Value(object.pontoAbono!.id),
			);
			await into(pontoAbonoUtilizacaos).insert(pontoAbonoUtilizacaoGrouped.pontoAbonoUtilizacao!);
		}
	}
	
	Future<void> deleteChildren(PontoAbonoGrouped object) async {
		await (delete(pontoAbonoUtilizacaos)..where((t) => t.idPontoAbono.equals(object.pontoAbono!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_abono").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}