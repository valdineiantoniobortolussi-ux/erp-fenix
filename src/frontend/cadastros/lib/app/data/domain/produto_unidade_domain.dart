class ProdutoUnidadeDomain {
	ProdutoUnidadeDomain._();

	static getPodeFracionar(String? podeFracionar) { 
		switch (podeFracionar) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPodeFracionar(String? podeFracionar) { 
		switch (podeFracionar) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}