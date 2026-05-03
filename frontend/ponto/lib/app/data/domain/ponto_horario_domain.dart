class PontoHorarioDomain {
	PontoHorarioDomain._();

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

	static getTipoTrabalho(String? tipoTrabalho) { 
		switch (tipoTrabalho) { 
			case '': 
			case 'N': 
				return 'Normal'; 
			case 'C': 
				return 'Compensação'; 
			case 'F': 
				return 'Folga'; 
			default: 
				return null; 
		} 
	} 

	static setTipoTrabalho(String? tipoTrabalho) { 
		switch (tipoTrabalho) { 
			case 'Normal': 
				return 'N'; 
			case 'Compensação': 
				return 'C'; 
			case 'Folga': 
				return 'F'; 
			default: 
				return null; 
		} 
	}

}