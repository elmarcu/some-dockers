
##Docker Python 3.7
# with jupyterlab install on docker image

requirements.txt and files
into src directory for testing

#config
run within container:
jupyter notebook --generate-config

#without token
#just mount json config to the volume:
# - file.json:/root/.jupyter/jupyter_notebook_config.json
