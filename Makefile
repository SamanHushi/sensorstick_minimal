project_path = sensorstick/sensorstick.kicad_pro
pcb_path = sensorstick/sensorstick.kicad_pcb

kicad_path := $(shell which kicad)
ifeq ($(kicad_path),)
    kicad_path = /Applications/KiCad/KiCad.app/Contents/MacOS/kicad
endif

.PHONY: docs

help:
	@echo "Use the following commands:"
	@echo "  make edit - Open the project in KiCad"
	@echo "  make docs - Generate the interactive html BOM"

edit:
	$(kicad_path) $(project_path) &

build_container:
	docker build -t interactive_bom:latest .

ensure_docs:
	mkdir -p docs

docs: ensure_docs
	docker run -v $(PWD):/mnt --rm interactive_bom:latest
