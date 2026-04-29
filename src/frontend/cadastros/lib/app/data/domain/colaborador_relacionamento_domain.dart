class ColaboradorRelacionamentoDomain {
	ColaboradorRelacionamentoDomain._();

	static getSalarioFamilia(String? salarioFamilia) { 
		switch (salarioFamilia) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setSalarioFamilia(String? salarioFamilia) { 
		switch (salarioFamilia) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}