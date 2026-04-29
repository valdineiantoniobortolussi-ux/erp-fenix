class FolhaParametroDomain {
	FolhaParametroDomain._();

	static getContribuiPis(String? contribuiPis) { 
		switch (contribuiPis) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setContribuiPis(String? contribuiPis) { 
		switch (contribuiPis) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getDiscriminarDsr(String? discriminarDsr) { 
		switch (discriminarDsr) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setDiscriminarDsr(String? discriminarDsr) { 
		switch (discriminarDsr) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getCalculoProporcionalidade(String? calculoProporcionalidade) { 
		switch (calculoProporcionalidade) { 
			case '': 
			case '0': 
				return '30 Dias'; 
			case '1': 
				return 'Conforme dias do mês'; 
			default: 
				return null; 
		} 
	} 

	static setCalculoProporcionalidade(String? calculoProporcionalidade) { 
		switch (calculoProporcionalidade) { 
			case '30 Dias': 
				return '0'; 
			case 'Conforme dias do mês': 
				return '1'; 
			default: 
				return null; 
		} 
	}

	static getDescontarFaltas13(String? descontarFaltas13) { 
		switch (descontarFaltas13) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setDescontarFaltas13(String? descontarFaltas13) { 
		switch (descontarFaltas13) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getPagarAdicionais13(String? pagarAdicionais13) { 
		switch (pagarAdicionais13) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPagarAdicionais13(String? pagarAdicionais13) { 
		switch (pagarAdicionais13) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getPagarEstagiarios13(String? pagarEstagiarios13) { 
		switch (pagarEstagiarios13) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPagarEstagiarios13(String? pagarEstagiarios13) { 
		switch (pagarEstagiarios13) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getFeriasDescontarFaltas(String? feriasDescontarFaltas) { 
		switch (feriasDescontarFaltas) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setFeriasDescontarFaltas(String? feriasDescontarFaltas) { 
		switch (feriasDescontarFaltas) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getFeriasPagarAdicionais(String? feriasPagarAdicionais) { 
		switch (feriasPagarAdicionais) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setFeriasPagarAdicionais(String? feriasPagarAdicionais) { 
		switch (feriasPagarAdicionais) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getFeriasAdiantar13(String? feriasAdiantar13) { 
		switch (feriasAdiantar13) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setFeriasAdiantar13(String? feriasAdiantar13) { 
		switch (feriasAdiantar13) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getFeriasPagarEstagiarios(String? feriasPagarEstagiarios) { 
		switch (feriasPagarEstagiarios) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setFeriasPagarEstagiarios(String? feriasPagarEstagiarios) { 
		switch (feriasPagarEstagiarios) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getFeriasCalcJustaCausa(String? feriasCalcJustaCausa) { 
		switch (feriasCalcJustaCausa) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setFeriasCalcJustaCausa(String? feriasCalcJustaCausa) { 
		switch (feriasCalcJustaCausa) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getFeriasMovimentoMensal(String? feriasMovimentoMensal) { 
		switch (feriasMovimentoMensal) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setFeriasMovimentoMensal(String? feriasMovimentoMensal) { 
		switch (feriasMovimentoMensal) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}