class PapelFuncaoDomain {
	PapelFuncaoDomain._();

	static getHabilitado(String? habilitado) { 
		switch (habilitado) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setHabilitado(String? habilitado) { 
		switch (habilitado) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getPodeInserir(String? podeInserir) { 
		switch (podeInserir) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPodeInserir(String? podeInserir) { 
		switch (podeInserir) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getPodeAlterar(String? podeAlterar) { 
		switch (podeAlterar) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPodeAlterar(String? podeAlterar) { 
		switch (podeAlterar) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getPodeExcluir(String? podeExcluir) { 
		switch (podeExcluir) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPodeExcluir(String? podeExcluir) { 
		switch (podeExcluir) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}