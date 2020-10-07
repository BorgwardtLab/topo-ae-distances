#!/bin/bash

ae_models=(TopoAEOrtho TopoRegEdgeSymmetric)
datasets=(Spheres Spheres1000)
output_pattern='projection_experiments/hyperparameter_search/dimensionality_reduction/{dataset}/{model}.json'

# Autoencoder based
python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set TopoAEOrtho \
  --name dataset  \
  --set Spheres \
  --name dummy --set overrides.model__parameters__autoencoder_model=MLPAutoencoder_Spheres \
  --output-pattern ${output_pattern}

# Autoencoder based
python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${ae_models[*]} \
  --name dataset  \
  --set Spheres1000 \
  --name dummy --set overrides.model__parameters__autoencoder_model=MLPAutoencoder_Spheres \
  --name dummy --set overrides.model__parameters__ae_kwargs__input_dim=1001 \
  --output-pattern ${output_pattern}

