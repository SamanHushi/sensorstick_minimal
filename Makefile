project_path = sensorstick/sensorstick.kicad_pro
pcb_path = sensorstick/sensorstick.kicad_pcb
kibot_path = sensorstick/config.kibot.yaml

kicad_path := $(shell which kicad)
ifeq ($(kicad_path),)
    kicad_path = /Applications/KiCad/KiCad.app/Contents/MacOS/kicad
endif

help:
	@echo "Use the following commands:"
	@echo "  make edit - Open the project in KiCad"
	@echo "  make docs - Generate the interactive html BOM"

edit:
	$(kicad_path) $(project_path) &

build_container:
	docker build -t interactive_bom:latest .

kibot:
	./docker_kibot_linux_allow.sh "kibot -c $(kibot_path) -b $(pcb_path) -d ./generated"
