from src.controller.login_controller import login_bp
from src.controller.sped_contabil_controller import sped_contabil_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.sped_fiscal_controller import sped_fiscal_bp
from src.controller.sintegra_controller import sintegra_bp
from src.controller.efd_contribuicoes_controller import efd_contribuicoes_bp
from src.controller.efd_reinf_controller import efd_reinf_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(sped_contabil_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(sped_fiscal_bp)
		app.register_blueprint(sintegra_bp)
		app.register_blueprint(efd_contribuicoes_bp)
		app.register_blueprint(efd_reinf_bp)
		app.register_blueprint(login_bp)