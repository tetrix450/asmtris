# asmtris
Implementación básica y bastante cruda de tetris para DOS hecho completamente en ensamblador para el 8086.

![Alt text](/tetris.png?raw=true "Juego corriendo en DOSBox")

![Alt text](/pausa.png?raw=true "Juego pausado")

# Cómo compilar y correr el juego
Necesitarás DOS ó un emulador de DOS (como DOSBox) y usar turbo assembler para ensamblarlo y linkarlo:
```
tasm source.asm
tlink source.obj
```
Finalmente para ejecutar el juego:
```
source.exe
```

# Controles
Puedes usar las flechas izquierda y derecha para mover las piezas y las teclas 'Z' y 'X' para girarlas.
Para bajar las piezas un poco más rapido (soft drop), mantener pulsado hacia abajo. Para bajarlas de golpe
(hard drop), pulsar la tecla hacia arriba.
Para pausar o quitar la pausa del juego, pulsa enter.

# Problemas conocidos
Actualmente el juego sólo cuenta las líneas que has hecho y no hay un sistema de puntos. Las piezas serán siempre
de color rojo hasta que se coloquen en el tablero, que serán azules. Esto tenía pensado cambiarlo para que cada pieza
fuera de un color distinto, pero ahí esta a medio hacer.
