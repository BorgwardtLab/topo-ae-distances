#!/bin/bash

dataset=$1
methods=(TopoAEvgg)
cifar=CIFAR
if [$dataset = $cifar]; then
    input_dim='[3,32,32]'
else
    input_dim='[1,28,28]'
fi

for method in ${methods[@]};
    do 
    output_path=exp_runs/ortho_exp/train_model/real_world/${dataset}/${method}
    mkdir -p $output_path
    output_log=${output_path}/run.log
    pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.${dataset} model.parameters.ae_kwargs.input_dims=${input_dim}
done


