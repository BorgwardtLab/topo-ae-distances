#!/bin/bash
jobname=highdimspheres
datasets=(Spheres Spheres500 Spheres1k Spheres2k Spheres3k)
methods=(TopoAEOrthoSpheres TopoAESpheres)
output_path=exp_runs/train_model/dimensionality_reduction/${dataset}/${method}
mkdir -p $output_path
output_log=${output_path}/run.log

for method in ${methods[@]};
    do 
    sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 8G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.Spheres"
    sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 8G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.Spheres500 model.parameters.ae_kwargs.input_dim=501"
    sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 8G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.Spheres1k model.parameters.ae_kwargs.input_dim=1001"
    sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 8G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.Spheres2k model.parameters.ae_kwargs.input_dim=2001"
    sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 8G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F ${output_path} with model.${method} dataset.Spheres3k model.parameters.ae_kwargs.input_dim=3001"
    done

