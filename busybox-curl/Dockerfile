FROM busybox:1.30.1
RUN wget http://www.magicermine.com/demos/curl/curl/curl-7.30.0.ermine.tar.bz2 && \
    tar -xjvf curl-7.30.0.ermine.tar.bz2 && \
    mv curl-7.30.0.ermine/curl.ermine /bin/curl && \
    rm -rf curl-7.30.0.ermine curl-7.30.0.ermine.tar.bz2
CMD ["/bin/sh"]
