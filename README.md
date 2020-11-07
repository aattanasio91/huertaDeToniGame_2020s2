# La huerta de Toni - Game

### Intro
Toni es un [amigo youtuber](https://www.youtube.com/channel/UC8nVWi8L7fPCjOMpSSNAM0Q) que se gana la vida cultivando plantas de distintas especies.
Para ello tiene que sembrar, regar y cosechar sus cultivos. Después de la cosecha, Toni vende lo que cultivó, obteniendo ganancias en la forma de monedas de oro.
Toni es muy ahorrativo y todo el oro que obtiene por sus cosechas lo acumula.

Nuestro objetivo es construir un juego en el que podamos controlar a Toni, utilizando el teclado para moverlo alrededor del tablero. Las plantas y el comportamiento de Toni son los los que se encuentran en la **Etapa 1 - sembrar, regar, vender y consultas a Toni** de enunciado, en la segunda  le agregaremos algunas cosas para convertirlo en un juego.

## Etapa 1 
En esta primera parte vamos a concentrarnos solamente en programar las clases y objetos necesarios para modelar los siguientes comportamientos de Toni. 
 * Sembrar
 * Regar
 * Vender
 * Consultar a Toni



En este juego consideramos tres especies: **_maíz_**, **_trigo_** y **_tomaco_**.

### Sembrar
El acto de sembrar crea una nueva planta, con estas características:  

| Planta | Situación al ser sembrada |
|---|---|
| **Maíz**   | Es una planta bebé. |
| **Trigo**  | Está en etapa de evolución 0. |
| **Tomaco** | Es una planta hecha y derecha. |

Cada vez que se siembra una planta, Toni la agrega a una colección de `plantasSembradas`.

### Regar
Una vez sembrado un cultivo, para que crezca debe ser regado.

Agregar a Toni un método `regarLasPlantas()` que riegue cada una de las plantas que hay sembradas.
Cada planta reacciona diferente cuando es regada:

| Planta | Efecto al ser regada |
|---|---|
| **Maíz**   | Si es bebé, pasa a adulta. Si ya es adulta, no pasa nada. |
| **Trigo**  | Pasa a la etapa de evolución siguiente: de 0 a 1, de 1 a 2, de 2 a 3, de 3 vuelve a 0. |
| **Tomaco** | Ninguno. |

### Cosechar
Una planta, puede o no estar lista para la cosecha. El _maíz_ está listo para la cosecha si es adulto, el _trigo_ si está en nivel de evolución 2 o más, el _tomaco_ siempre.

Si la planta está lista para la cosecha, se la cosecha, para luego poder venderla. Toni debe recordar qué plantas tiene para vender. El acto de cosechar una planta implica que ya no está sembrada (y por lo tanto debe reflejarse en la colección).

Agregar a Toni los siguientes métodos:
* `plantasListasParaCosechar()`: el conjunto de las plantas sembradas que ya se pueden cosechar;
* `cosecharTodo()`: que cosecha _solamente_ las plantas que sembró y que ya están listas. Conviene acá hacer un método que resuelva la cosecha para una planta y luego utilizarlo para desarrollar `cosecharTodo()`;

### Venta
Implementar un método `venderCosecha()` que vende todas las plantas que ya fueron previamente cosechadas. Al hacerlo, obtiene el oro por cada planta que tiene, de acuerdo a esta especificación:
- **Maíz**: 150 monedas por planta.
- **Trigo**: 100 monedas si está en etapa 2, 200 si está en etapa 3.
- **Tomaco**: 80 monedas por planta.

Toni debe acumular el oro y recordar cuánto oro obtuvo en total. De nuevo, la recomendación es hacer primero un método que venda **una** planta y luego hacer el que vende todas.

**Atenti**  
Una vez que vende lo que tiene para vender, obviamente, deja de tenerlo.

### Consultas a Toni

,Queremos agregar las siguientes consultas a Toni:

* `paraCuantosDiasLeAlcanza():` asumiendo que tiene un gasto de 200 monedas por día, indica para cuántos días le alcanza el dinero. Considerar para esta cuenta el dinero acumulado **más** lo que podría sacar si vende su cosecha actual;
* `cuantoHayParaCeliacos():` indica cuántas plantas de las sembradas podrían ser consumidas por personas con celiaquía, las cuales solo pueden comer alimentos sin gluten (el trigo tiene gluten, el tomaco y el maíz no). Considerar solamente las plantas que estén listas para cosechar;
* `convieneRegar():` indica si alguna de las plantas sembradas aún no está lista para la cosecha - porque en ese caso convendría regar para acelerar el proceso.

## Etapa 2 - Game
### Caminar y sembrar

Configurar las siguientes teclas para controlar a Toni:

|Tecla|Acción esperada|
|-----|---------------|
|Flechas|Desplazan a Toni en la dirección correspondiente.|
|M|Siembra una planta de maíz en la posición actual.|
|T|Siembra una planta de trigo en la posición actual.|
|O|Siembra una planta de tomaco en la posición actual.|

Por ahora, vamos a evitar sembrar dos plantas en la misma celda, porque eso va a traer problemas a futuro. Más adelante vamos a agregar una validación para que Toni tire error. Es importante que Toni recuerde las plantas que sembró, lo vamos a necesitar para regar.

Al ser sembradas, las plantas aparecen en su estado inicial, según ya vimos en la etapa 1.

### Regar
Vamos a contemplar dos formas de regar:

|Tecla|Acción esperada|
|-----|---------------|
|A|Riega todas las plantas que hay en el tablero.|
|R|Riega la planta sobre la cual está parado Toni.|

El regar todas ya lo teníamos programado de la etapa anterior, no debería ser problemático. Regar una sola es más difícil: primero hay que averiguar qué plantas hay en la posición actual de Toni y luego regarlas.

Para esto, Wollok Game tiene un método llamado `colliders(visual)`, que devuelve **todos** los elementos que están chocando con el objeto que va por parámetro. Veamos dos ejemplos:

|Situación|Resultado de evaluar `game.colliders(toni)`
|--------|---------|
|![](./ejemplos/toni-solito.jpg)|`[]`|
|![](./ejemplos/toni-con-maiz.jpg)|`[un/a Maiz]`|

Como se ve, lo que devuelve es una lista y lo que necesitamos es una sola planta, para poder regarla. Les queda a ustedes pensar cómo resolver eso.

El efecto de las plantas al ser regadas es el mismo de antes. Obviamente, tiene que actualizarse la imagen cada vez que se riega, en la carpeta `assets` ya tienen todo lo necesario.

### Cosechar
Nuevamente, vamos a contemplar dos formas de cosechar:

|Tecla|Acción esperada|
|-----|---------------|
|X|Cosecha todas las plantas que están **listas para cosechar**.|
|C|Cosecha la planta sobre la cual está parado Toni.|

En el caso de la cosecha por planta, por ahora vamos a ignorar si está lista o no.

### Vender
Programar las siguientes teclas:

|Tecla|Acción esperada|
|-----|---------------|
|V|Vende toda la cosecha actual.|
|Espacio|Informa el estado de Toni.|

Para el informe del estado de Toni vamos a armar un String y mostrarlo con `game.say`. El mensajito debería decir cuántas monedas tiene actualmente y cuántas plantas le quedan para vender, por ejemplo: `"Tengo 80 monedas y me quedan 3 plantas para vender"`.

Recordá que se pueden concatenar Strings utilizando el `+`:

```
>>> "Me quedan " + 3 + " plantas"
"Me quedan 3 plantas"
```
**Atenti**
Hasta acá lo obligatorio para aprobar el TP. Lo que sigue debajo son bonus que pueden hacer para sumar nota (y, ponele, divertirse un rato). Los pueden hacer en cualquier orden.

## BONUS
Se incluyen 5 bonus a desarrollar para complementar el desarrollo, 
## 1-  La Pachamama

Agregar al modelo un objeto que represente a la Pachamama, el cual (obviamente) provocará distintos cambios sobre nuestros cultivos.

En una sobresimplificación, vamos a decir que la Pacha tiene un nivel de agradecimiento, que arranca en 10 y que se puede modificar según las siguientes conductas del ser humano y la naturaleza:

* `llover()`: aumenta en 5 el nivel de agradecimiento;
* `fumigar()`: lleva el nivel de agradecimiento a 0, sin importar en cuánto estaba;


Agregarle también un método `estaAgradecida()` que nos indica si su nivel de agradecimiento es de 10 o más.

Cuando está agradecida, cada planta reacciona de distinta manera:
* el _maíz_ crece más alto, y su valor en el mercado es de 180 por planta;
* el _trigo_ crece más rápido, por lo tanto su nivel aumenta en 2 cada vez que se lo riega;
* el _tomaco_ se pudre porque es un injerto artificial y por lo tanto ya no estará listo para la cosecha

Para el Game hay que agregar las teclas para las acciones de fumigar y llover:

|Tecla|Acción esperada|
|-----|---------------|
|F|Provoca el cambio correspondiente a `fumigar` en la Pachamama.|
|L|Provoca el cambio correspondiente a `llover` en la Pachamama.|

Se pide además que cambie la imagen de la Pachamama cuando no está agradecida. La imagen para hacerlo no está incluida, tienen que armarla ustedes.

Debería cambiar también la imagen de los tomacos, para reflejar si están podridos o no. Estas imágenes sí se incluyen.

## 2- Ofrenda a la Pachamama

Hacer que Toni pueda ofrendarle algo a la Pachamama para que lo ayude con su producción. La ofrenda se hace simplemente caminando hasta donde está la Pacha y "chocando" con ella (hay que usar `game.whenCollideDo` para ver si esto es así).

Cuando Toni hace una ofrenda, pasa lo siguiente:
1. Desaparece una planta cualquiera de la huerta - la ofrenda. Ojo, no vale cosecharla, tiene que simplemente desaparecer.
1. Si la Pacha no estaba agradecida, pasa a estarlo.
1. Si ya estaba agradecida, nos regala una lluvia que riega todas las plantas.

Ultra bonus: que después de la ofrenda, la Pacha cambie de lugar. Podría, por ejemplo, ubicarse en la esquina opuesta a la que está. O desplazarse un número fijo de unidades a la derecha. Elijan ustedes.

## 3 - Mercados

Incluir dos o tres mercados (imagen `mercado.png`), eligiendo dónde poner cada uno en el tablero.
Cada mercado tiene una cantidad de monedas, y una lista con la mercadería que posee.  

Hacer que Toni solamente pueda vender si está parado en un mercado, y además el mercado tiene suficiente cantidad de monedas para pagar lo que Toni tiene para vender. En tal caso, la mercadería se agrega al mercado, y se le descuentan las monedas que le da a Toni en pago. Arrojar un error si se intenta vender y Toni no está parado sobre un mercado.



## 4 - Caminar como Pacman

Hacer los cambios necesarios para que Toni aparezca "del otro lado" cuando al caminar se pasa de los límites del tablero. Por ejemplo, si está en el borde derecho y apretamos la flecha derecha, debería aparecer en el borde izquierdo de esa misma fila.

## 5 - Validaciones

Agregar las siguientes validaciones:

1. Al sembrar, arrojar error si ya había otra planta en la celda actual.
1. Al cosechar, arrojar error si la planta de la celda actual no está lista.
1. Al cosechar, arrojar error si no hay ninguna planta en la celda actual.

