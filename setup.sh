#!/usr/bin/env bash
# Prepara el entorno: crea el venv, lo activa e instala requirements.txt.
# Si hay PDF en guides_pdf/, también los convierte a texto en guides/.
# Funciona en macOS, Linux y Windows (Git Bash / WSL). Para PowerShell usa setup.ps1.
set -euo pipefail
cd "$(dirname "$0")"

case "$(uname -s)" in
  Darwin)               OS="macOS";   ACTIVATE=".venv/bin/activate" ;;
  Linux)                OS="Linux";   ACTIVATE=".venv/bin/activate" ;;
  MINGW*|MSYS*|CYGWIN*) OS="Windows"; ACTIVATE=".venv/Scripts/activate" ;;
  *) echo "Sistema operativo no reconocido: $(uname -s)" >&2; exit 1 ;;
esac
echo "Sistema detectado: $OS"

# Busca un Python 3 (en Windows suele llamarse python o py)
PY=""
for c in python3 python py; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import sys; sys.exit(sys.version_info[0] < 3)' 2>/dev/null; then
    PY="$c"; break
  fi
done
[ -n "$PY" ] || { echo "No se encontró Python 3. Instálalo desde https://www.python.org/downloads/" >&2; exit 1; }

[ -d .venv ] || "$PY" -m venv .venv
# shellcheck disable=SC1090
source "$ACTIVATE"

python -m pip install --quiet --upgrade pip
python -m pip install --quiet -r requirements.txt

if ls guides_pdf/*.pdf >/dev/null 2>&1; then
  python scripts/extract_text.py
fi

echo
echo "Listo. Para activar el entorno en otra terminal: source $ACTIVATE"
echo "Siguiente paso: python scripts/find_evidences.py <códigos de competencia>"
