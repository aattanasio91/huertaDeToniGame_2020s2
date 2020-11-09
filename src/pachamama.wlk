import wollok.game.*

object pachamama {
	var property nivelAgradecimiento = 10
	var property position = game.at(0, 13)
	
	method image() {
		return if (self.estaAgradecida()) { "pachamama-agradecida.png" }
		else { "pachamama-enojada.png" }
	}
	
	method llover() { nivelAgradecimiento += 5 }
	method fumigar() { nivelAgradecimiento = 0 }
	method estaAgradecida() { return nivelAgradecimiento >= 10 }
	
	method rotarPosicion() { 
		if (self.position() == game.at(0,13)) { self.position(game.at(13,0))}
		else { self.position(game.at(0,13)) }
	}
	
}