# Prepara el entorno en Windows (PowerShell): crea el venv, lo activa e instala requirements.txt. Si hay PDF en guides_pdf\, también los convierte a texto en guides\.
# Si PowerShell bloquea el script: Set-ExecutionPolicy -Scope Process Bypass
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
Write-Host "Sistema detectado: Windows"

$py = $null
foreach ($c in "python", "py") {
    if (Get-Command $c -ErrorAction SilentlyContinue) { $py = $c; break }
}
if (-not $py) { throw "No se encontró Python 3. Instálalo desde https://www.python.org/downloads/" }

if (-not (Test-Path .venv)) { & $py -m venv .venv }
& .\.venv\Scripts\Activate.ps1

python -m pip install --quiet --upgrade pip
python -m pip install --quiet -r requirements.txt

if (Test-Path guides_pdf\*.pdf) { python scripts\extract_text.py }

Write-Host ""
Write-Host "Listo. Para activar el entorno en otra terminal: .\.venv\Scripts\Activate.ps1"
Write-Host "Siguiente paso: python scripts\find_evidences.py <códigos de competencia>"
