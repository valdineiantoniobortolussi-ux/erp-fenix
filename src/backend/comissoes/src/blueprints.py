from src.controller.login_controller import login_bp
from src.controller.comissao_perfil_controller import comissao_perfil_bp
from src.controller.comissao_objetivo_controller import comissao_objetivo_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(comissao_perfil_bp)
		app.register_blueprint(comissao_objetivo_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(login_bp)