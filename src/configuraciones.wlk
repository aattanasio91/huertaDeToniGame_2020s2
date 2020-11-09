import wollok.game.*
import toni.*
import plantas.*
import mercado.*
import pachamama.*

const supermercado = new Mercado(reservaOro=2000,position=game.at(13,7),image="supermarket.jpg") 
const mercadito = new Mercado(reservaOro=500,position=game.at(13,13),image="mercado1.jpg")

object juego {
	
	method configTeclado(){
		keyboard.up().onPressDo{toni.moverArriba()}
		keyboard.down().onPressDo{toni.moverAbajo()}
		keyboard.left().onPressDo{toni.moverIzq()}
		keyboard.right().onPressDo{toni.moverDer()}
		keyboard.m().onPressDo{toni.sembrar(new Maiz(position = toni.position()))}
		keyboard.t().onPressDo{toni.sembrar(new Trigo(position = toni.position()))}
		keyboard.o().onPressDo{toni.sembrar(new Tomaco(position = toni.position()))}
		keyboard.r().onPressDo{toni.regarPlanta()}
		keyboard.a().onPressDo{toni.regarLasPlantas()}
		keyboard.x().onPressDo{toni.cosecharTodo()}
		keyboard.c().onPressDo{toni.cosechar()}
		keyboard.v().onPressDo{toni.venderEnMercado()}
		keyboard.space().onPressDo{
			game.say(toni,"Tengo " + toni.oro().toString() + " monedas de oro " + 
			" y quedan " + toni.plantasCosechadas().size().toString() + " plantas por vender")
		}
		keyboard.f().onPressDo({ pachamama.fumigar() })
		keyboard.l().onPressDo({ pachamama.llover() })	
	
	}
	
	
	method configPersonajes_Y_Terreno(){
		game.title("La huerta de Toni")
		game.width(15)
		game.height(15)
		game.ground("tierra.png")
		game.addVisual(toni)
		game.addVisualIn(pachamama, game.at(0, 13));
		game.addVisual(supermercado)
		game.addVisual(mercadito)
}
}


