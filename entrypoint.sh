#!/bin/sh -l
set -e


# Generating the PUML file from the Python module
pip install py2puml

eval "${INPUT_PIP_INSTALL_DEPS_CMD}"

mkdir -p "${INPUT_OUTPUT_DIR}"
py2puml "${INPUT_PATH}" "${INPUT_MODULE}" > "${INPUT_OUTPUT_DIR}"/"${INPUT_MODULE}".puml

# Check if a PUML file is found at the expected location
if [ ! -f "${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.puml" ]; then
	echo "File not found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.puml"
	exit 1
else
	echo "File found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.puml"
fi

# Generating the SVG file from the PUML file
if [ "$INPUT_PUML_VERSION" = "latest" ]; then
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.jar/download"
else
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.${INPUT_PUML_VERSION}.jar/download"
fi
java -jar /tmp/plantuml.jar "${INPUT_OUTPUT_DIR}"/"${INPUT_MODULE}".puml -o ../"${INPUT_OUTPUT_DIR}" -tsvg

# Check if a SVG file is found at the expected location
if [ ! -f "${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.svg" ]; then
	echo "File not found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.svg"
	exit 1
else
	echo "File found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.svg"
fi
