FROM ubuntu:22.04

RUN apt-get -q update
RUN apt-get install -y --no-install-recommends apt-utils && apt-get -y install curl wget vim pip
 
RUN wget -O miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash miniconda.sh -bfp /usr/local/miniconda && rm -rf miniconda.sh
ENV PATH /usr/local/miniconda/bin:$PATH
RUN conda update -n base -c defaults conda

RUN useradd -ms /bin/bash gammapyuser
USER gammapyuser
WORKDIR /home/gammapyuser

RUN curl -O https://gammapy.org/download/install/gammapy-0.18.2-environment.yml
RUN conda env create -f gammapy-0.18.2-environment.yml -n gammapy
RUN conda run -n gammapy conda install -c conda-forge h5py'<3.2'
RUN conda run -n gammapy conda install psutil
RUN conda run -n gammapy pip install jupyterlab
RUN conda clean --all --yes
