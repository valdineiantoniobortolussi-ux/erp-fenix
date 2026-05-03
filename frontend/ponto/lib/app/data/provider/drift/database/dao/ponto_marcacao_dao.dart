import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_marcacao_dao.g.dart';

@DriftAccessor(tables: [
	PontoMarcacaos,
	ViewPessoaColaboradors,
	PontoRelogios,
])
class PontoMarcacaoDao extends DatabaseAccessor<AppDatabase> with _$PontoMarcacaoDaoMixin {
	final AppDatabase db;

	List<PontoMarcacao> pontoMarcacaoList = []; 
	List<PontoMarcacaoGrouped> pontoMarcacaoGroupedList = []; 

	PontoMarcacaoDao(this.db) : super(db);

	Future<List<PontoMarcacao>> getList() async {
		pontoMarcacaoList = await select(pontoMarcacaos).get();
		return pontoMarcacaoList;
	}

	Future<List<PontoMarcacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoMarcacaoList = await (select(pontoMarcacaos)..where((t) => expression)).get();
		return pontoMarcacaoList;	 
	}

	Future<List<PontoMarcacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoMarcacaos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(pontoMarcacaos.idColaborador)), 
			]).join([ 
				leftOuterJoin(pontoRelogios, pontoRelogios.id.equalsExp(pontoMarcacaos.idPontoRelogio)), 
			]);

		if (field != null && field != '') { 
			final column = pontoMarcacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoMarcacaoGroupedList = await query.map((row) {
			final pontoMarcacao = row.readTableOrNull(pontoMarcacaos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final pontoRelogio = row.readTableOrNull(pontoRelogios); 

			return PontoMarcacaoGrouped(
				pontoMarcacao: pontoMarcacao, 
				viewPessoaColaborador: viewPessoaColaborador, 
				pontoRelogio: pontoRelogio, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pontoMarcacaoGrouped in pontoMarcacaoGroupedList) {
		//}		

		return pontoMarcacaoGroupedList;	
	}

	Future<PontoMarcacao?> getObject(dynamic pk) async {
		return await (select(pontoMarcacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoMarcacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_marcacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoMarcacao;		 
	} 

	Future<PontoMarcacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoMarcacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoMarcacao = object.pontoMarcacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoMarcacaos).insert(object.pontoMarcacao!);
			object.pontoMarcacao = object.pontoMarcacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoMarcacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoMarcacaos).replace(object.pontoMarcacao!);
		});	 
	} 

	Future<int> deleteObject(PontoMarcacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoMarcacaos).delete(object.pontoMarcacao!);
		});		
	}

	Future<void> insertChildren(PontoMarcacaoGrouped object) async {
	}
	
	Future<void> deleteChildren(PontoMarcacaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_marcacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}