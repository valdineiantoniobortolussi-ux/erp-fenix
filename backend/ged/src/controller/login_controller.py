from flask import Blueprint, request, jsonify
from src.service.login_service import LoginService
from src.model.view_pessoa_usuario_model import ViewPessoaUsuarioModel
from src.util.util import decifrar  
from sqlalchemy.orm.exc import NoResultFound
import json

login_bp = Blueprint('login', __name__)

@login_bp.route('/login', methods=['POST'])
@login_bp.route('/login/', methods=['POST'])
def login():
    data = request.data
    try:
        corpo_decifrado = decifrar(data)  # Descriptografa o corpo da requisição
        usuario = ViewPessoaUsuarioModel()
        usuario.mapping(json.loads(corpo_decifrado))  # Mapeia os dados descriptografados

        resposta = LoginService.login(usuario)

        return jsonify(resposta), 200
    except NoResultFound:
        return jsonify({'message': 'Usuário ou senha inválidos'}), 401
