# Instrucciones para el agente de IA

Este repo ayuda a un aprendiz del SENA a encontrar, dentro de las guías de aprendizaje, las evidencias que le faltan según el acta de seguimiento de su instructor. Sigue estos pasos en orden.

## Reglas

- **No tienes acceso a Zajuna** (la plataforma del SENA) y no debes intentar entrar. Buscar y revisar en Zajuna lo hace el usuario.
- Responde en español.
- Los códigos de RAP del acta (593114, 593159, ...) **no aparecen en las guías**. Relaciona cada RAP con su resultado de aprendizaje **por nombre y contenido**. Cuando una relación sea una deducción tuya, dilo.
- No inventes estados. Si el usuario no te dijo si hizo una evidencia, márcala como "sin información" y pregúntale.

## Paso 1: instalación

Ejecuta el script que corresponda al sistema operativo del usuario, sin pasos manuales:

- macOS / Linux / Windows con Git Bash o WSL: `./setup.sh`
- Windows con PowerShell: `.\setup.ps1`

Crea el entorno virtual e instala `requirements.txt`.

**Las guías ya están en texto en `guides/*.txt`. Busca siempre ahí; no hay PDF en el repo.** Solo si el usuario tiene guías nuevas en PDF, que las ponga en `guides_pdf/` y vuelva a ejecutar el script, que las convierte a texto en `guides/`.

## Paso 2: pedir el acta

Pídele al usuario que **copie y pegue tal cual** lo que escribió el instructor en el acta de seguimiento (la parte de "Temas tratados", con las competencias y los RAP faltantes). Si el texto llega cortado, avísale y pídele el resto.

## Paso 3: encontrar las evidencias

1. Relaciona cada competencia del acta con su código en las guías. Cada guía lista sus competencias con código y nombre, por ejemplo `240202501` (inglés), `230101507` (hábitos saludables), `220201501` (ciencias naturales y física).
2. Corre `python scripts/find_evidences.py <códigos de competencia>` y empareja el nombre de cada RAP con la descripción del resultado de aprendizaje.
3. Entrega **una tabla** con estas columnas: RAP, guía, **código completo de la evidencia** (ej. `GA3-220201501-AA4-EV02`), nombre de la evidencia y qué falta.
4. Avisa si algún RAP no tiene una evidencia clara (para preguntarle al instructor) o si una evidencia sirve para más de un RAP.

## Paso 4: el usuario revisa en Zajuna si hizo cada evidencia

El objetivo de este paso es que **el usuario compruebe en Zajuna si hizo o no hizo cada evidencia**. Tú no puedes saberlo, así que no lo supongas. Dile que:

1. Abra Zajuna en el navegador, en el curso correspondiente.
2. **Copie el código de la evidencia** de la tabla (ej. `GA3-220201501-AA4-EV02`).
3. Lo busque en la página con **Ctrl+F** (Windows/Linux) o **Cmd+F** (Mac). Así llega directo a la actividad.
4. Mire en qué estado está: hecha y calificada, hecha sin calificar, pendiente de entrega o pendiente de habilitación. Si no la encuentra, puede que no esté asignada o no esté habilitada.

Luego pídele que te diga, evidencia por evidencia, si la hizo o no y en qué estado está.

## Paso 5: tabla final

Con lo que te cuente el usuario, entrega la tabla actualizada por RAP: evidencia (código completo), estado y qué hacer. Resume cuántas están hechas, cuántas faltan, cuáles hay que reenviar o pedir que califiquen, y cuáles hay que pedirle al instructor que habilite. Si el usuario lo pide, ayúdale a redactar el mensaje al instructor.
