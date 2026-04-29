class CentroResultadoDomain {
	CentroResultadoDomain._();

	static getSofreRateiro(String? sofreRateiro) { 
		switch (sofreRateiro) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setSofreRateiro(String? sofreRateiro) { 
		switch (sofreRateiro) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}