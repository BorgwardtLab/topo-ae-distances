import pandas as pd
import os 
import json
from IPython import embed
import numpy as np
from collections import defaultdict

def load_json(path):
    with open(path, 'r') as f:
        return json.load(f)

def pivot_df(df, aggfunc=np.mean):
    df_out = df.pivot_table(index=['model'], columns='metric', values='value', aggfunc=aggfunc)
    return df_out

def to_tex(df):
    """ return dict of dataset-wise results in df format"""
    dfs = defaultdict()
    datasets = df['dataset'].unique()
    for dat in datasets:
        curr_df = df.query("dataset == @dat")
        #pivot df to compact format (metrics as columns)
        curr_piv = pivot_df(curr_df)
        embed()

        ##Write table to result folder
        curr_piv.to_latex(f'results/workshop/{dat}.tex', escape=False)
    return dfs

path = 'exp_runs/train_model/real_world'

datasets = ['CIFAR', 'MNIST', 'FashionMNIST']
models = ['TopoAE', 'TopoAERandomConv', 'TopoAEvgg'] #add vgg! 
model_dict = {
    'TopoAE': 'euclidean',
    'TopoAERandomConv': 'RandomConv',
    'TopoAEvgg': 'VGG'
}
used_measures = ['kl_global_', 'rmse', '_mse', 'mean_mrre', 'mean_continuity', 'mean_trustworthiness', 'reconstruction']

results = pd.DataFrame()

for dataset in datasets:
    for model in models:
        fpath = os.path.join(path, dataset, model, '1', 'run.json')
        data = load_json(fpath)
        result_keys = list(data['result'].keys())
        used_keys = [key for key in result_keys if any([measure in key for measure in used_measures])]
        used_keys = [key for key in used_keys if 'test' in key]
        for key in used_keys:
            record = {
                'dataset': dataset,
                'model': model_dict[model], 
                'metric': key,
                'value': [ data['result'][key] ]
            }
            record_df = pd.DataFrame(record)
            results = results.append(record_df)

results = results.sort_values(['dataset','metric']) 
to_tex(results)


