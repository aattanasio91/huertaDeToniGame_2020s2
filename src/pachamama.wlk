import wollok.game.*

object pachamama {
	var property nivelAgradecimiento = 10
	var property position = game.at(0, 13)
	const property tipo = "Pachamama"
	
	method image() {
		return if (self.estaAgradecida()) { "pachamama-agradecida.png" }
		else { "pachamama-enojada.png" }
	}
	
	method llover() { nivelAgradecimiento += 5 }
	method fumigar() { nivelAgradecimiento = 0 }
	method estaAgradecida() { return nivelAgradecimiento >= 10 }
	
	method recibirOfrenda() {
		if(not self.estaAgradecida()){
			self.nivelAgradecimiento(10)
		}else{
			self.llover()
		}
	}
	
}