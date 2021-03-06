FROM rocker/shiny-verse:4.2.1

COPY scripts/install_pandoc_latest.sh rocker_scripts

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y qpdf \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
    && rocker_scripts/install_pandoc_latest.sh \
    && apt-get install -y chromium-browser \
    && Rscript -e "install.packages('shiny')" \
    && Rscript -e "install.packages('shinytest')" \
    && Rscript -e "if (!shinytest::dependenciesInstalled()) shinytest::installDependencies()" \
    && Rscript -e "install.packages('shinytest2', dependencies = TRUE)"
