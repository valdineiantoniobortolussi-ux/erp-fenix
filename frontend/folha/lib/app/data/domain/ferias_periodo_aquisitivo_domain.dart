class FeriasPeriodoAquisitivoDomain {
	FeriasPeriodoAquisitivoDomain._();

	static getSituacao(String? situacao) { 
		switch (situacao) { 
			case '': 
			case '0': 
				return '0=Em Aberto'; 
			case '1': 
				return '1=Gozado'; 
			case '2': 
				return '2=Parcialmente gozado'; 
			case '3': 
				return '3=Perda por Afastamento'; 
			case '4': 
				return '4=Perda por Falta'; 
			case '5': 
				return '5=Cancelado'; 
			default: 
				return null; 
		} 
	} 

	static setSituacao(String? situacao) { 
		switch (situacao) { 
			case '0=Em Aberto': 
				return '0'; 
			case '1=Gozado': 
				return '1'; 
			case '2=Parcialmente gozado': 
				return '2'; 
			case '3=Perda por Afastamento': 
				return '3'; 
			case '4=Perda por Falta': 
				return '4'; 
			case '5=Cancelado': 
				return '5'; 
			default: 
				return null; 
		} 
	}

	static getDescontarFaltas(String? descontarFaltas) { 
		switch (descontarFaltas) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setDescontarFaltas(String? descontarFaltas) { 
		switch (descontarFaltas) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getDesconsiderarAfastamento(String? desconsiderarAfastamento) { 
		switch (desconsiderarAfastamento) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setDesconsiderarAfastamento(String? desconsiderarAfastamento) { 
		switch (desconsiderarAfastamento) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}