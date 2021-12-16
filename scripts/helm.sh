#!/bin/bash
redis_release=redis
app_release=app
install_command="helm install"
upgrade_command="helm upgrade"
status_command="helm status"
helm_status='deployed'
charts_folder=charts
status=$(eval "$status_command $redis_release | grep -o $helm_status")
if [ -z "$status" ]; 
    then
         eval "$install_command $redis_release ../${charts_folder}/${redis_release}" 
else 
         eval "$upgrade_command $redis_release ../${charts_folder}/${redis_release}"     
fi
status=$(eval "$status_command $app_release | grep -o $helm_status")
if [ -z "$status" ]; 
    then
         eval "$install_command $app_release ../${charts_folder}/${app_release}" 
else 
         eval "$upgrade_command $app_release ../${charts_folder}/${app_release}"   
fi
