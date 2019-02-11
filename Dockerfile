FROM image-base

ADD ./src/oko /opt/oko
RUN pip3 install Flask flask-restplus piexif zeep pyOpenSSL

RUN mkdir /opt/openface
RUN mkdir /opt/models
RUN wget -nv https://storage.cmusatyalab.org/openface-models/nn4.small2.v1.t7 -O /opt/models/nn4.small2.v1.t7
RUN wget -nv http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2 -O /opt/models/shape_predictor_68_face_landmarks.dat.bz2
RUN cd /opt/models && bzip2 -d /opt/models/shape_predictor_68_face_landmarks.dat.bz2

RUN wget -nv https://github.com/cmusatyalab/openface/raw/master/openface/__init__.py -P /opt/openface/
RUN wget -nv https://github.com/cmusatyalab/openface/raw/master/openface/align_dlib.py -P /opt/openface/
RUN wget -nv https://github.com/cmusatyalab/openface/raw/master/openface/data.py -P /opt/openface/
RUN wget -nv https://github.com/cmusatyalab/openface/raw/master/openface/helper.py -P /opt/openface/
RUN wget -nv https://github.com/cmusatyalab/openface/raw/master/openface/openface_server.lua -P /opt/openface/
RUN wget -nv https://github.com/cmusatyalab/openface/raw/master/openface/torch_neural_net.py -P /opt/openface/
RUN wget -nv https://github.com/cmusatyalab/openface/raw/master/openface/torch_neural_net.lutorpy.py -P /opt/openface/

ENV PYTHONPATH=/opt
 

WORKDIR /opt
RUN echo "test" > /opt/test1
CMD /bin/bash -l -c 'python3 /opt/oko/app.py'
