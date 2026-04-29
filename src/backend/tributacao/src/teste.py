from src.util.util import cifrar,decifrar  

corpo = "Qgtd+eFygILejb4Tl3HKIK3CzjA7uqmZssaewcR9YwqLBSuuzttEqgwZzuByr21jjbLnPLNEspRbcQRw7udqhhzV5nvolxhYgq6OiRn6VaQs1yCch4gaLgHskLEN8EZhYOpBJvrPazjdd1mujuAut+g931V0TLgTEE+BinrIv6xw/GhZqi4JrMxM86QVIeun09W+oRzu2cz/BpV5pkH2YiceiJ8T6mVvU38O7lI="
mensagem = decifrar(corpo)
print(mensagem)

objeto = '{"id":null,"idPessoa":null,"pessoaNome":null,"tipo":null,"email":null,"idColaborador":null,"idUsuario":null,"login":"1","senha":"1","dataCadastro":null,"administrador":null}';
retorno = cifrar(objeto)
print(retorno)