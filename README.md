# find-task

Cómo ubicar, dentro de las guías de aprendizaje del SENA (Análisis y desarrollo de software, programa 228118), las evidencias que corresponden a los RAP que el instructor marcó como pendientes en el acta de seguimiento.

## El problema

El acta dice cosas como "37801 · 4 pendientes", pero:

- Los **pendientes son RAP** (resultados de aprendizaje), no evidencias. Cada RAP se aprueba cuando el instructor califica sus evidencias.
- Los códigos del acta (593114, 593159, ...) **no aparecen en las guías**. Las guías usan los códigos de competencia (240202501, 220201501, ...) y de evidencia (GA3-220201501-AA4-EV02, ...).
- Las evidencias están repartidas en varias guías.

## Qué necesitas

- **Un agente de IA con acceso a tu carpeta de proyecto**, el que uses (Claude Code, Codex, Gemini CLI, Cursor, etc.). Es quien lee los PDF, cruza los datos y arma las tablas.
- **Python 3** para los scripts.
- **Un entorno virtual** (`venv`), para instalar las dependencias sin ensuciar tu sistema. Las dependencias están en `requirements.txt` (solo `pypdf`).
- **Las guías de aprendizaje en texto**, ya incluidas en `guides/` (un `.txt` por guía). Si tienes guías nuevas en PDF, ponlas en `guides_pdf/` (no se suben al repo).
- **El texto del acta de seguimiento** que te envió el instructor.

## Preparar el entorno

Un solo comando crea el entorno virtual, lo activa e instala `requirements.txt` (y convierte a texto los PDF de `guides_pdf/`, si los hay). Detecta tu sistema operativo.

| Sistema | Comando |
|---|---|
| macOS / Linux | `./setup.sh` |
| Windows (Git Bash o WSL) | `./setup.sh` |
| Windows (PowerShell) | `.\setup.ps1` |

Si PowerShell bloquea el script: `Set-ExecutionPolicy -Scope Process Bypass`.

> **Si eres un agente de IA:** ejecuta el script que corresponda al sistema operativo del usuario, sin pasos manuales. Luego, en cada terminal nueva, activa el entorno con `source .venv/bin/activate` (macOS/Linux) o `.venv\Scripts\activate` (Windows).

## Cómo funciona

1. **Copia el acta.** Copia tal cual lo que escribió el instructor en el acta de seguimiento (la parte de "Temas tratados" con las competencias y los RAP faltantes, por ejemplo `593114 — Implementar acciones de mejora...`) y pégalo en el chat con tu agente de IA. Con eso encuentra las evidencias que te hacen falta.
2. **Las guías están en `guides/*.txt`.** El agente busca ahí.
3. **Si tienes guías nuevas en PDF**, ponlas en `guides_pdf/` y vuelve a ejecutar el script de instalación (o `python scripts/extract_text.py`); las convierte a `guides/*.txt`.
4. **Relaciona cada RAP del acta con una competencia.** Cada guía lista sus competencias con el código y el nombre; busca el nombre del RAP. Ejemplo:

   | Competencia (acta) | Código en las guías |
   |---|---|
   | 37714 Inglés | 240202501 |
   | 37800 Hábitos saludables | 230101507 |
   | 37801 Ciencias naturales y física | 220201501 |

5. **Lista los resultados de aprendizaje y las evidencias** de esas competencias:
   ```bash
   python scripts/find_evidences.py 240202501 230101507 220201501
   ```
   Cada resultado de aprendizaje (`220201501-02`, ...) sale con su descripción, y cada evidencia con su código (`GA3-220201501-AA3-EV01`) y nombre.
6. **Empareja el nombre del RAP del acta con la descripción del resultado de aprendizaje.** Ej.: "Solucionar problemas asociados con el sector productivo con base en los principios y leyes de la física" corresponde a `220201501-02`.
7. **Dile a tu agente qué hiciste y qué no.** Indica el estado de cada evidencia en tu plataforma (hecha/calificada, hecha/sin calificar, pendiente de entrega, pendiente de habilitación) y pídele la tabla RAP -> evidencia -> estado.

### Prompt para tu agente

El repo trae [AGENTS.md](AGENTS.md) (y [CLAUDE.md](CLAUDE.md), que apunta a él) con las instrucciones para el agente. Si el tuyo no las lee solo, abre el agente en esta carpeta y pega:

> Lee AGENTS.md y sigue los pasos: instala el entorno, pídeme el acta de seguimiento y arma la tabla con los códigos de las evidencias que me faltan.

El agente **no entra a Zajuna**. Esa parte la haces tú, y sirve para saber si hiciste o no cada evidencia: copia el código de la evidencia de la tabla (ej. `GA3-220201501-AA4-EV02`), búscalo en Zajuna con **Ctrl+F** (o **Cmd+F** en Mac) y mira en qué estado está la actividad. Luego le cuentas al agente cuáles hiciste y cuáles no, y te devuelve la tabla final.

## Cómo leer un código de evidencia

`GA3-220201501-AA4-EV02`

- `GA3`: guía 3
- `220201501`: competencia (ciencias naturales y física)
- `AA4`: actividad de aprendizaje 4
- `EV02`: evidencia 2 de esa actividad

## Limitaciones

- La correspondencia entre RAP y evidencia es **por nombre y contenido**, no por código. Si un RAP no tiene una actividad con su nombre, confírmalo con el instructor.
- El acta puede venir cortada al copiarla; revisa que estén todos los RAP.

## Constancias

Las constancias de entrega (`Constancia_entrega_evidencias_*.docx`) son personales y están en `.gitignore`.
