FROM python:2.7
RUN apt-get update
RUN python -m pip install --upgrade pip && python -m pip install jupyter

RUN apt-get autoremove -y; apt-get autoclean; apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./src/requirements.txt requirements.txt
RUN pip install -r requirements.txt
