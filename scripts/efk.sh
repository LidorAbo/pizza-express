#!/bin/bash
namespace=logging
chart_name=efk
charts_folder=charts
if ! kubectl get ns $namespace;
    then
        kubectl create ns $namespace
        helm install $chart_name ../${charts_folder}/${chart_name}
else
        helm upgrade $chart_name ../${charts_folder}/${chart_name}
fi