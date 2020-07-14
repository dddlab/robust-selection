FROM jupyter/scipy-notebook:dc57157d6316

# start binder compatibility
# from https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

COPY . ${HOME}/work
USER root
RUN chown -R ${NB_UID} ${HOME}

# end binder compatibility code

# add modification code here

USER ${NB_USER}
RUN pip install scipy
RUN pip install networkx
RUN pip install scikit-learn
RUN pip install seaborn
RUN pip install pandas
