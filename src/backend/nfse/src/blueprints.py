from src.controller.login_controller import login_bp
from src.controller.os_status_controller import os_status_bp
from src.controller.nfse_cabecalho_controller import nfse_cabecalho_bp
from src.controller.nfse_lista_servico_controller import nfse_lista_servico_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_cliente_controller import view_pessoa_cliente_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(os_status_bp)
		app.register_blueprint(nfse_cabecalho_bp)
		app.register_blueprint(nfse_lista_servico_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_cliente_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)