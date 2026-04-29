import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'pessoa_dao.g.dart';

@DriftAccessor(tables: [
	Pessoas,
	PessoaJuridicas,
	Fornecedors,
	Clientes,
	TabelaPrecos,
	PessoaFisicas,
	EstadoCivils,
	NivelFormacaos,
	Transportadoras,
	Contadors,
	PessoaContatos,
	PessoaTelefones,
	PessoaEnderecos,
])
class PessoaDao extends DatabaseAccessor<AppDatabase> with _$PessoaDaoMixin {
	final AppDatabase db;

	List<Pessoa> pessoaList = []; 
	List<PessoaGrouped> pessoaGroupedList = []; 

	PessoaDao(this.db) : super(db);

	Future<List<Pessoa>> getList() async {
		pessoaList = await select(pessoas).get();
		return pessoaList;
	}

	Future<List<Pessoa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pessoaList = await (select(pessoas)..where((t) => expression)).get();
		return pessoaList;	 
	}

	Future<List<PessoaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pessoas)
			.join([ 
				leftOuterJoin(pessoaJuridicas, pessoaJuridicas.idPessoa.equalsExp(pessoas.id)), 
			]).join([ 
				leftOuterJoin(fornecedors, fornecedors.idPessoa.equalsExp(pessoas.id)), 
			]).join([ 
				leftOuterJoin(clientes, clientes.idPessoa.equalsExp(pessoas.id)), 
			]).join([ 
				leftOuterJoin(tabelaPrecos, tabelaPrecos.id.equalsExp(clientes.idTabelaPreco)), 
			]).join([ 
				leftOuterJoin(pessoaFisicas, pessoaFisicas.idPessoa.equalsExp(pessoas.id)), 
			]).join([ 
				leftOuterJoin(estadoCivils, estadoCivils.id.equalsExp(pessoaFisicas.idEstadoCivil)), 
			]).join([ 
				leftOuterJoin(nivelFormacaos, nivelFormacaos.id.equalsExp(pessoaFisicas.idNivelFormacao)), 
			]).join([ 
				leftOuterJoin(transportadoras, transportadoras.idPessoa.equalsExp(pessoas.id)), 
			]).join([ 
				leftOuterJoin(contadors, contadors.idPessoa.equalsExp(pessoas.id)), 
			]);

		if (field != null && field != '') { 
			final column = pessoas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pessoaGroupedList = await query.map((row) {
			final pessoa = row.readTableOrNull(pessoas); 
			final pessoaJuridica = row.readTableOrNull(pessoaJuridicas); 
			final fornecedor = row.readTableOrNull(fornecedors); 
			final cliente = row.readTableOrNull(clientes); 
			final tabelaPreco = row.readTableOrNull(tabelaPrecos); 
			final pessoaFisica = row.readTableOrNull(pessoaFisicas); 
			final estadoCivil = row.readTableOrNull(estadoCivils); 
			final nivelFormacao = row.readTableOrNull(nivelFormacaos); 
			final transportadora = row.readTableOrNull(transportadoras); 
			final contador = row.readTableOrNull(contadors); 

			return PessoaGrouped(
				pessoa: pessoa, 
				pessoaJuridica: pessoaJuridica, 
				fornecedor: fornecedor, 
				clienteGrouped: ClienteGrouped 
				(
					cliente: cliente, 
					tabelaPreco: tabelaPreco, 
				),
				pessoaFisicaGrouped: PessoaFisicaGrouped 
				(
					pessoaFisica: pessoaFisica, 
					estadoCivil: estadoCivil, 
					nivelFormacao: nivelFormacao, 
				),
				transportadora: transportadora, 
				contador: contador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var pessoaGrouped in pessoaGroupedList) {
			pessoaGrouped.pessoaContatoGroupedList = [];
			final queryPessoaContato = ' id_pessoa = ${pessoaGrouped.pessoa!.id}';
			expression = CustomExpression<bool>(queryPessoaContato);
			final pessoaContatoList = await (select(pessoaContatos)..where((t) => expression)).get();
			for (var pessoaContato in pessoaContatoList) {
				PessoaContatoGrouped pessoaContatoGrouped = PessoaContatoGrouped(
					pessoaContato: pessoaContato,
				);
				pessoaGrouped.pessoaContatoGroupedList!.add(pessoaContatoGrouped);
			}

			pessoaGrouped.pessoaTelefoneGroupedList = [];
			final queryPessoaTelefone = ' id_pessoa = ${pessoaGrouped.pessoa!.id}';
			expression = CustomExpression<bool>(queryPessoaTelefone);
			final pessoaTelefoneList = await (select(pessoaTelefones)..where((t) => expression)).get();
			for (var pessoaTelefone in pessoaTelefoneList) {
				PessoaTelefoneGrouped pessoaTelefoneGrouped = PessoaTelefoneGrouped(
					pessoaTelefone: pessoaTelefone,
				);
				pessoaGrouped.pessoaTelefoneGroupedList!.add(pessoaTelefoneGrouped);
			}

			pessoaGrouped.pessoaEnderecoGroupedList = [];
			final queryPessoaEndereco = ' id_pessoa = ${pessoaGrouped.pessoa!.id}';
			expression = CustomExpression<bool>(queryPessoaEndereco);
			final pessoaEnderecoList = await (select(pessoaEnderecos)..where((t) => expression)).get();
			for (var pessoaEndereco in pessoaEnderecoList) {
				PessoaEnderecoGrouped pessoaEnderecoGrouped = PessoaEnderecoGrouped(
					pessoaEndereco: pessoaEndereco,
				);
				pessoaGrouped.pessoaEnderecoGroupedList!.add(pessoaEnderecoGrouped);
			}

		}		

		return pessoaGroupedList;	
	}

	Future<Pessoa?> getObject(dynamic pk) async {
		return await (select(pessoas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Pessoa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM pessoa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Pessoa;		 
	} 

	Future<PessoaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PessoaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pessoa = object.pessoa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pessoas).insert(object.pessoa!);
			object.pessoa = object.pessoa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PessoaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pessoas).replace(object.pessoa!);
		});	 
	} 

	Future<int> deleteObject(PessoaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pessoas).delete(object.pessoa!);
		});		
	}

	Future<void> insertChildren(PessoaGrouped object) async {
		object.pessoaJuridica = object.pessoaJuridica!.copyWith(idPessoa: Value(object.pessoa!.id));
		await into(pessoaJuridicas).insert(object.pessoaJuridica!);
		object.fornecedor = object.fornecedor!.copyWith(idPessoa: Value(object.pessoa!.id));
		await into(fornecedors).insert(object.fornecedor!);
		object.clienteGrouped!.cliente = object.clienteGrouped!.cliente!.copyWith(idPessoa: Value(object.pessoa!.id));
		await into(pessoaFisicas).insert(object.pessoaFisicaGrouped!.pessoaFisica!);
		object.pessoaFisicaGrouped!.pessoaFisica = object.pessoaFisicaGrouped!.pessoaFisica!.copyWith(idPessoa: Value(object.pessoa!.id));
		await into(pessoaFisicas).insert(object.pessoaFisicaGrouped!.pessoaFisica!);
		object.transportadora = object.transportadora!.copyWith(idPessoa: Value(object.pessoa!.id));
		await into(transportadoras).insert(object.transportadora!);
		object.contador = object.contador!.copyWith(idPessoa: Value(object.pessoa!.id));
		await into(contadors).insert(object.contador!);
		for (var pessoaContatoGrouped in object.pessoaContatoGroupedList!) {
			pessoaContatoGrouped.pessoaContato = pessoaContatoGrouped.pessoaContato?.copyWith(
				id: const Value(null),
				idPessoa: Value(object.pessoa!.id),
			);
			await into(pessoaContatos).insert(pessoaContatoGrouped.pessoaContato!);
		}
		for (var pessoaTelefoneGrouped in object.pessoaTelefoneGroupedList!) {
			pessoaTelefoneGrouped.pessoaTelefone = pessoaTelefoneGrouped.pessoaTelefone?.copyWith(
				id: const Value(null),
				idPessoa: Value(object.pessoa!.id),
			);
			await into(pessoaTelefones).insert(pessoaTelefoneGrouped.pessoaTelefone!);
		}
		for (var pessoaEnderecoGrouped in object.pessoaEnderecoGroupedList!) {
			pessoaEnderecoGrouped.pessoaEndereco = pessoaEnderecoGrouped.pessoaEndereco?.copyWith(
				id: const Value(null),
				idPessoa: Value(object.pessoa!.id),
			);
			await into(pessoaEnderecos).insert(pessoaEnderecoGrouped.pessoaEndereco!);
		}
	}
	
	Future<void> deleteChildren(PessoaGrouped object) async {
		await (delete(pessoaJuridicas)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(fornecedors)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(clientes)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(pessoaFisicas)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(transportadoras)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(contadors)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(pessoaContatos)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(pessoaTelefones)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
		await (delete(pessoaEnderecos)..where((t) => t.idPessoa.equals(object.pessoa!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from pessoa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}