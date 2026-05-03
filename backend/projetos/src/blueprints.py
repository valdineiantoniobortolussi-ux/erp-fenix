from src.controller.login_controller import login_bp
from src.controller.projeto_principal_controller import projeto_principal_bp
from src.controller.fin_natureza_financeira_controller import fin_natureza_financeira_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(projeto_principal_bp)
		app.register_blueprint(fin_natureza_financeira_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)