FROM python:2.7
COPY ./example/requirements.txt requirements.txt
RUN python -m pip install pip --upgrade && \
	pip install -r requirements.txt
RUN apt-get autoremove -y; apt-get autoclean; apt-get clean && rm -rf /var/lib/apt/lists/*

CMD "python"
