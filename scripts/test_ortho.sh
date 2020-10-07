#!/bin/bash
jobname=orthoprojections
output_path=test_ortho
output_log=${output_path}/ortho_run.log

sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 5G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.train_model -F test_ortho with model.TopoAEOrthoSpheres dataset.Spheres"
