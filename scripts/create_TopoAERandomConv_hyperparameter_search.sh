#!/bin/bash

ae_models=(TopoAERandomConv, TopoAEvgg)

## REAL WORLD

output_pattern='projection_experiments/hyperparameter_search/real_world/{dataset}/{model}.json'
input_dim1='[3,32,32]'
input_dim2='[1,28,28]'

#AE methods:
python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${ae_models[*]} \
  --name dataset --set MNIST FashionMNIST \
  --name dummy --set overrides.model__parameters__autoencoder_model=DeepAE \
  --name dummy --set overrides.model__parameters__ae_kwargs__input_dims=${input_dim2} \
  --output-pattern ${output_pattern}

python scripts/configs_from_product.py exp.hyperparameter_search \
    --name model \
    --set ${ae_models[*]} \
    --name dataset --set CIFAR \
    --name dummy --set overrides.model__parameters__autoencoder_model=DeepAE \
    --name dummy --set overrides.model__parameters__ae_kwargs__input_dims=${input_dim1} \
    --output-pattern ${output_pattern}

