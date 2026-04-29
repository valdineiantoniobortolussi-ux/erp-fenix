class PontoRelogioDomain {
	PontoRelogioDomain._();

	static getUtilizacao(String? utilizacao) { 
		switch (utilizacao) { 
			case '': 
			case 'P': 
				return 'Ponto'; 
			case 'R': 
				return 'Refeitório'; 
			case 'C': 
				return 'Circulação'; 
			default: 
				return null; 
		} 
	} 

	static setUtilizacao(String? utilizacao) { 
		switch (utilizacao) { 
			case 'Ponto': 
				return 'P'; 
			case 'Refeitório': 
				return 'R'; 
			case 'Circulação': 
				return 'C'; 
			default: 
				return null; 
		} 
	}

}