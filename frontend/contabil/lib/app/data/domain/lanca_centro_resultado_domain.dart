class LancaCentroResultadoDomain {
	LancaCentroResultadoDomain._();

	static getOrigemDeRateio(String? origemDeRateio) { 
		switch (origemDeRateio) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setOrigemDeRateio(String? origemDeRateio) { 
		switch (origemDeRateio) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}