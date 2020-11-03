#!/bin/bash

datasets=(MNIST FashionMNIST)
methods=(TopoAE TopoAERandomConv TopoAEvgg)
input_dim1='[1,28,28]'
input_dim2='[3,32,32]'

# MNIST FashionMNIST
for method in ${methods[@]};
    do
    for dataset in ${datasets[@]};
        output_path=exp_runs/train_model/real_world/${dataset}/${method}
        mkdir -p $output_path
        output_log=${output_path}/run.log
        pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.${dataset} model.parameters.ae_kwargs.input_dims=${input_dim1}
    done
done

# CIFAR:
dataset=CIFAR
for method in ${methods[@]};
    do
    output_path=exp_runs/train_model/real_world/${dataset}/${method}
    mkdir -p $output_path
    output_log=${output_path}/run.log
    pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.${dataset} model.parameters.ae_kwargs.input_dims=${input_dim2}
done

