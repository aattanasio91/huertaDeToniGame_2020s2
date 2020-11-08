import toni.*
import plantas.*
import wollok.game.*

class Mercado {
	
	var property image
	var property position
	var property reservaOro
	const property mercaderiaComprada = []
		
	method aceptarCompra(){ 
		if(reservaOro >= toni.valorCosechaActual()) {
		reservaOro -= toni.valorCosechaActual()
		game.say(self,"Compra realizada por un valor de " + toni.valorCosechaActual().toString())
		mercaderiaComprada.addAll(toni.plantasCosechadas())
		toni.venderCosecha()
	}
	else { self.error("No tengo dinero para comprar esa cosecha") }
	}
}