class PontoClassificacaoJornadaDomain {
	PontoClassificacaoJornadaDomain._();

	static getPadrao(String? padrao) { 
		switch (padrao) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPadrao(String? padrao) { 
		switch (padrao) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getDescontarHoras(String? descontarHoras) { 
		switch (descontarHoras) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setDescontarHoras(String? descontarHoras) { 
		switch (descontarHoras) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}