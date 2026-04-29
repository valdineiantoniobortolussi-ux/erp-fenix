class FolhaPppExameMedicoDomain {
	FolhaPppExameMedicoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'A': 
				return 'Admissional'; 
			case 'P': 
				return 'Periódico'; 
			case 'R': 
				return 'Retorno ao Trabalho'; 
			case 'M': 
				return 'Mudança de Função'; 
			case 'D': 
				return 'Demissional'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Admissional': 
				return 'A'; 
			case 'Periódico': 
				return 'P'; 
			case 'Retorno ao Trabalho': 
				return 'R'; 
			case 'Mudança de Função': 
				return 'M'; 
			case 'Demissional': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

	static getExame(String? exame) { 
		switch (exame) { 
			case '': 
			case 'R': 
				return 'Referencial'; 
			case 'S': 
				return 'Sequencial'; 
			default: 
				return null; 
		} 
	} 

	static setExame(String? exame) { 
		switch (exame) { 
			case 'Referencial': 
				return 'R'; 
			case 'Sequencial': 
				return 'S'; 
			default: 
				return null; 
		} 
	}

}