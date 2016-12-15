FROM jupyter/scipy-notebook

USER root

RUN apt-get update && \
    apt-get install -y libgeos-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# geopandas pulls in basically the whole python geo ecosystem
# temporarily downgrade geos to work around fiona compatibility issue
RUN conda install -y -c conda-forge geopandas osmnx && \
    conda install -y -c conda-forge geos=3.5.0 && \
    conda clean -tipsy && \
    find /opt -name __pycache__ | xargs rm -r && \
    rm -rf /opt/conda/pkgs/*

USER $NB_USER
