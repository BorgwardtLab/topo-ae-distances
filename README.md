# Challenging Euclidean Topological Autoencoders

This is a follow-up project of the ICML 2020 paper "Topological Autoencoders" (reference below).
Here, we investigate whether domain-specific distance functions in the input space (here image datasets) are necessary for TopoAE, or whether a generic euclidean distance is sufficient. 
[This work](https://openreview.net/pdf?id=P3dZuOUnyEY) has been accepted for presentation at the Neurips 2020 TDA and Beyond workshop. 

## References

Please use the following BibTeX code to cite our original [paper](https://arxiv.org/abs/1906.00722),
which was presented at [ICML 2020](https://icml.cc/Conferences/2020):

```
@InProceedings{Moor19Topological,
  author        = {Moor, Michael and Horn, Max and Rieck, Bastian and Borgwardt, Karsten},
  title         = {Topological Autoencoders},
  year          = {2020},
  eprint        = {1906.00722},
  archiveprefix = {arXiv},
  primaryclass  = {cs.LG},
  booktitle     = {Proceedings of the 37th International Conference on Machine Learning~(ICML)},
  series        = {Proceedings of Machine Learning Research},
  publisher     = {PMLR},
  pubstate      = {forthcoming},
}
```  

## Setup
In order to reproduce the results indicated in the workshop paper simply setup an
environment using the provided `Pipfile` and `pipenv` and run the experiments
using the provided makefile:

```bash
pipenv install --skip-lock  
```

Alternatively, the exact versions used in this project can be accessed in ```requirements.txt```, however
this pip freeze contains a superset of all necessary libraries. To install it, run
```bash
pipenv install -r requirements.txt --skip-lock
```
  
## Running the methods:

In case a slurm cluster is available, simply run:  
```bash  
source scripts/run_slurm.sh  
```  

Alternatively, all jobs can be sequentially/manually called using:  
```bash  
source scripts/run_manual.sh  
```  
 
