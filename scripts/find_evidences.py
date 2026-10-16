"""Lista, por guía, los resultados de aprendizaje y las evidencias de las competencias indicadas.

Uso: python scripts/find_evidences.py 220201501 230101507 240202501
"""
import glob
import re
import sys

codes = sys.argv[1:]
if not codes:
    sys.exit(__doc__)

alt = "|".join(re.escape(c) for c in codes)
pattern = re.compile(rf"(?:(?:{alt})-0\d|GA\d+-(?:{alt})-AA\d(?:-EV\d+)?)[^\n]*")

for path in sorted(glob.glob("guides/*.txt")):
    print("#####", path)
    seen = set()
    for m in pattern.finditer(open(path).read()):
        line = re.sub(r"\s+", " ", m.group(0))[:200]
        if line not in seen:
            seen.add(line)
            print("  ", line)
