
##Usign offical dockewr hub jupyter 3.7

requirements.txt and files
into src directory for testing

#config
run within container:
jupyter notebook --generate-config

#without token
#just mount json config to the volume:
# - file.json:/root/.jupyter/jupyter_notebook_config.json
