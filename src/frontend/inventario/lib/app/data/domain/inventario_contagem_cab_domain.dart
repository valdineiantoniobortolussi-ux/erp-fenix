class InventarioContagemCabDomain {
	InventarioContagemCabDomain._();

	static getEstoqueAtualizado(String? estoqueAtualizado) { 
		switch (estoqueAtualizado) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setEstoqueAtualizado(String? estoqueAtualizado) { 
		switch (estoqueAtualizado) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case 'G': 
				return 'Geral'; 
			case 'D': 
				return 'Dinâmico'; 
			case 'R': 
				return 'Rotativo'; 
			case 'P': 
				return 'Por Amostragem'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'Geral': 
				return 'G'; 
			case 'Dinâmico': 
				return 'D'; 
			case 'Rotativo': 
				return 'R'; 
			case 'Por Amostragem': 
				return 'P'; 
			default: 
				return null; 
		} 
	}

}