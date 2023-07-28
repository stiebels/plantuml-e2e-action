# PlantUML End-to-End Action
A GitHub Action for creating a PlantUML file from a Python module and exporting it as an image.

## Python ➡️ PlantUML ➡️ SVG </b>
This repository was forked from [this repo](https://github.com/Timmy/plantuml-action/tree/5f5f57e2ec41225b88f37aa1dc15edda188b47c8) and extends it by automating the end-to-end process, from generating the PlantUML diagram based on Python modules to exporting that diagram as SVG for ease of access and in-repo rendering.

## Usage
Use it from the GitHub Actions marketplace.

### Example workflow
The following workflow generates a PlantUML diagram from the Python module `tests`
in the `tests` directory and exports it as PUML file as well as SVG to the `diagrams` directory.
Subsequently, the changed files are committed and pushed to the repository.

```yaml
name: My workflow
on:
  push:
    branches: [ "main" ]

jobs:
  generate_diagram:
    name: Generate PlantUML diagram
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
          ref: ${{ github.event.pull_request.head.ref }}
      - name: Build & render diagram
        uses: stiebels/plantuml-e2e-action@main
        with:
          puml_version: "1.2023.7"
          pip_install_deps_cmd: "pip install -r tests/requirements.txt"
          path: "tests"
          module: "tests"
          output_dir: "diagrams"
      - name: Commit changed files
        run: |
          git config user.email gh-actions
          git config user.name gh-actions
          git add .
          git commit -m "Committed updated class diagram"
          git push
```

## Parameters
- See [here](https://sourceforge.net/projects/plantuml/files/) for a list of eligible versions to pass to `puml_version`.
- See [here](https://github.com/lucsorel/py2puml#cli) for a clear explanation on `path` and `module`, following the definition of `py2puml`.
```yaml
  puml_version:
    description: PlantUML software version. Whereas it defaults to "latest", it's recommended to pin down the PlantUML version.
    default: "latest"
    required: true
  pip_install_deps_cmd:
    description: The command that installs your project's dependencies require to have py2puml import your project. Typically, that'd be e.g. `pip install .` or `pip install .[docs]`. If the command doesn't install a version of `py2puml`, the latest version will be auto-installed.
    required: true
  path:
    description: the filepath to the domain following the py2puml definition
    required: true
  module:
    description: the module name of the domain following the py2puml definition
    required: true
  output_dir:
    description: the directory where the SVG should be saved to. File names default to the module name, but differ by file extension (.puml/.svg).
    default: diagrams
    required: true
```
