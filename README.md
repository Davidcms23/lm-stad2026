# STAD 2026 na disciplina de Modelos Lineares 

# Como usar o conda

Baixe o ambiente pronto [aqui](https://github.com/Davidcms23/202601stad-lm/blob/main/environment.yml)

```bash
conda install -c conda-forge mamba -y
```
conda ou mamba
```bash
conda env create -f environment.yml -n new_env_name
```

**1. Ative o ambiente virtual**

```bash
conda activate [nome_do_ambiente]
```

**2. Instale os pacotes**

```bash
conda install -c conda-forge pandas numpy scipy
```
ou
```bash
conda install -c conda-forge --file requirements.txt
```

Por que usar o [conda-forge](https://conda-forge.org/docs/user/introduction/)?

Cultura livre? use o [micromamba](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html)!

```bash
micromamba create --name stad261 python=3.12 uv -c conda-forge
```
```bash
micromamba activate stad261
```
```bash
uv pip install numpy pandas statsmodels scipy
```
```bash
uv pip install jupyterlab
```

**3. Inicie o jupyter**

```bash
jupyter lab
```

# Notebook

## Blibiotecas

Veja lista [aqui](https://github.com/Davidcms23/lm-stad2026/blob/main/requirements.txt)!

## Funções

referência:
[Linear Models with Python, Julian J. Faraway](https://www.taylorfrancis.com/books/mono/10.1201/9781351053419/linear-models-python-julian-faraway)
