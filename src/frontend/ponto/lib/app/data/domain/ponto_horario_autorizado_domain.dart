class PontoHorarioAutorizadoDomain {
	PontoHorarioAutorizadoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'F': 
				return 'Fixo'; 
			case 'D': 
				return 'Diário'; 
			case 'S': 
				return 'Semanal'; 
			case 'M': 
				return 'Mensal'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Fixo': 
				return 'F'; 
			case 'Diário': 
				return 'D'; 
			case 'Semanal': 
				return 'S'; 
			case 'Mensal': 
				return 'M'; 
			default: 
				return null; 
		} 
	}

}