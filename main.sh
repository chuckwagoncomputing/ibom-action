#!/bin/bash

git clone https://github.com/openscopeproject/InteractiveHtmlBom.git

export INTERACTIVE_HTML_BOM_NO_DISPLAY="true"
ibom() {
  python3 InteractiveHtmlBom/generate_interactive_bom.py --no-browser --name-format "%f" --dest-dir ../ibom --include-nets $@
}

PCBS=$(find . -path "$FILES")

for P in $PCBS; do
  if ls $(dirname $P)/$(basename $P .kicad_pcb).net 2>/dev/null; then
    ibom --netlist-file $(ls $(dirname $P)/$(basename $P .kicad_pcb).net) $P
  else
    ibom $P
  fi
done