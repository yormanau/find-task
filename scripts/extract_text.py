"""Convierte a texto los PDF de guides_pdf/ (opcional, solo si quieres usar guías nuevas).

Genera un .txt por guía en guides/, con marcas de página. Los PDF no se suben al repo.
"""
import glob
import os

from pypdf import PdfReader

SRC, OUT = "guides_pdf", "guides"
os.makedirs(OUT, exist_ok=True)

for pdf in sorted(glob.glob(f"{SRC}/*.pdf")):
    pages = PdfReader(pdf).pages
    text = "\n".join(f"\n=== PAGE {i + 1} ===\n{p.extract_text() or ''}" for i, p in enumerate(pages))
    name = os.path.splitext(os.path.basename(pdf))[0] + ".txt"
    with open(os.path.join(OUT, name), "w") as f:
        f.write(text)
    print(f"{pdf} -> {OUT}/{name}")
