#!/bin/bash
jobname=highdimspheres

datasets=(MNIST FashionMNIST)
methods=(TopoAE TopoAERandomConv)
input_dim1='[1,28,28]'
input_dim2='[3,32,32]'

for method in ${methods[@]};
    do 
    for dataset in ${datasets[@]};
        do
        output_path=exp_runs/ortho_exp/train_model/real_world/${dataset}/${method}
        mkdir -p $output_path
        output_log=${output_path}/run.log
        sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 8G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.${dataset} model.parameters.ae_kwargs.input_dims=${input_dim1}"
    done
done

# CIFAR:
dataset=CIFAR
for method in ${methods[@]};
    do
     output_path=exp_runs/ortho_exp/train_model/real_world/${dataset}/${method}
    mkdir -p $output_path
    output_log=${output_path}/run.log
    sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 8G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.${dataset} model.parameters.ae_kwargs.input_dims=${input_dim2}"
done

