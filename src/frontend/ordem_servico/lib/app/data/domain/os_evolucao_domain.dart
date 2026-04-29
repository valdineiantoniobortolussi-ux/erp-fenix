class OsEvolucaoDomain {
	OsEvolucaoDomain._();

	static getEnviarEmail(String? enviarEmail) { 
		switch (enviarEmail) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setEnviarEmail(String? enviarEmail) { 
		switch (enviarEmail) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}