class PessoaFisicaDomain {
	PessoaFisicaDomain._();

	static getSexo(String? sexo) { 
		switch (sexo) { 
			case '': 
			case '0': 
				return 'Masculino'; 
			case '1': 
				return 'Feminino'; 
			case '2': 
				return 'Outro'; 
			default: 
				return null; 
		} 
	} 

	static setSexo(String? sexo) { 
		switch (sexo) { 
			case 'Masculino': 
				return '0'; 
			case 'Feminino': 
				return '1'; 
			case 'Outro': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getRaca(String? raca) { 
		switch (raca) { 
			case '': 
			case '0': 
				return 'Branco'; 
			case '1': 
				return 'Moreno'; 
			case '2': 
				return 'Negro'; 
			case '3': 
				return 'Pardo'; 
			case '4': 
				return 'Amarelo'; 
			case '5': 
				return 'Indígena'; 
			case '6': 
				return 'Outro'; 
			default: 
				return null; 
		} 
	} 

	static setRaca(String? raca) { 
		switch (raca) { 
			case 'Branco': 
				return '0'; 
			case 'Moreno': 
				return '1'; 
			case 'Negro': 
				return '2'; 
			case 'Pardo': 
				return '3'; 
			case 'Amarelo': 
				return '4'; 
			case 'Indígena': 
				return '5'; 
			case 'Outro': 
				return '6'; 
			default: 
				return null; 
		} 
	}

}