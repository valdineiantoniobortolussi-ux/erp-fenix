import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_cana_fornecimento_diario_dao.g.dart';

@DriftAccessor(tables: [
	NfeCanaFornecimentoDiarios,
	NfeCanas,
])
class NfeCanaFornecimentoDiarioDao extends DatabaseAccessor<AppDatabase> with _$NfeCanaFornecimentoDiarioDaoMixin {
	final AppDatabase db;

	List<NfeCanaFornecimentoDiario> nfeCanaFornecimentoDiarioList = []; 
	List<NfeCanaFornecimentoDiarioGrouped> nfeCanaFornecimentoDiarioGroupedList = []; 

	NfeCanaFornecimentoDiarioDao(this.db) : super(db);

	Future<List<NfeCanaFornecimentoDiario>> getList() async {
		nfeCanaFornecimentoDiarioList = await select(nfeCanaFornecimentoDiarios).get();
		return nfeCanaFornecimentoDiarioList;
	}

	Future<List<NfeCanaFornecimentoDiario>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeCanaFornecimentoDiarioList = await (select(nfeCanaFornecimentoDiarios)..where((t) => expression)).get();
		return nfeCanaFornecimentoDiarioList;	 
	}

	Future<List<NfeCanaFornecimentoDiarioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeCanaFornecimentoDiarios)
			.join([ 
				leftOuterJoin(nfeCanas, nfeCanas.id.equalsExp(nfeCanaFornecimentoDiarios.idNfeCana)), 
			]);

		if (field != null && field != '') { 
			final column = nfeCanaFornecimentoDiarios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeCanaFornecimentoDiarioGroupedList = await query.map((row) {
			final nfeCanaFornecimentoDiario = row.readTableOrNull(nfeCanaFornecimentoDiarios); 
			final nfeCana = row.readTableOrNull(nfeCanas); 

			return NfeCanaFornecimentoDiarioGrouped(
				nfeCanaFornecimentoDiario: nfeCanaFornecimentoDiario, 
				nfeCana: nfeCana, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeCanaFornecimentoDiarioGrouped in nfeCanaFornecimentoDiarioGroupedList) {
		//}		

		return nfeCanaFornecimentoDiarioGroupedList;	
	}

	Future<NfeCanaFornecimentoDiario?> getObject(dynamic pk) async {
		return await (select(nfeCanaFornecimentoDiarios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeCanaFornecimentoDiario?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_cana_fornecimento_diario WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeCanaFornecimentoDiario;		 
	} 

	Future<NfeCanaFornecimentoDiarioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeCanaFornecimentoDiarioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeCanaFornecimentoDiario = object.nfeCanaFornecimentoDiario!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeCanaFornecimentoDiarios).insert(object.nfeCanaFornecimentoDiario!);
			object.nfeCanaFornecimentoDiario = object.nfeCanaFornecimentoDiario!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeCanaFornecimentoDiarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeCanaFornecimentoDiarios).replace(object.nfeCanaFornecimentoDiario!);
		});	 
	} 

	Future<int> deleteObject(NfeCanaFornecimentoDiarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeCanaFornecimentoDiarios).delete(object.nfeCanaFornecimentoDiario!);
		});		
	}

	Future<void> insertChildren(NfeCanaFornecimentoDiarioGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeCanaFornecimentoDiarioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_cana_fornecimento_diario").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}