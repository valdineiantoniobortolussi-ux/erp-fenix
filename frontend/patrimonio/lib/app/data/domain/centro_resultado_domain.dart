class CentroResultadoDomain {
	CentroResultadoDomain._();

	static getSofreRateiro(String? sofreRateiro) { 
		switch (sofreRateiro) { 
			case '': 
			case '0': 
				return 'AAA'; 
			case '1': 
				return 'BBB'; 
			case '2': 
				return 'CCC'; 
			default: 
				return null; 
		} 
	} 

	static setSofreRateiro(String? sofreRateiro) { 
		switch (sofreRateiro) { 
			case 'AAA': 
				return '0'; 
			case 'BBB': 
				return '1'; 
			case 'CCC': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}