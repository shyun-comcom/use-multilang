FROM tensorflow/serving

ARG version_no=3
ENV MODEL_NAME use-multilang

RUN apt-get update && apt-get install -y curl
CMD /bin/bash

RUN mkdir -p /models/${MODEL_NAME}

# Download model
RUN cd /models/${MODEL_NAME} \
	&& curl -L https://tfhub.dev/google/universal-sentence-encoder-multilingual/3?tf-hub-format=compressed --output model.tar.gz

# Unzip model
RUN cd /models/${MODEL_NAME} \
	&& mkdir -p ${version_no} \
	&& tar -zxf model.tar.gz -C ${version_no} \
	&& rm -rf model.tar.gz

EXPOSE 8501
