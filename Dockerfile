FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime


RUN apt-get update && \
    apt-get install -y && \
    apt-get install -y apt-utils wget && \
    apt-get -qq -y install curl && \
    apt-get install -y tar


RUN pip install --upgrade pip
RUN pip install transformers==2.11.0 \
    flask \
    waitress \
    sentencepiece

WORKDIR /app
COPY . .

RUN FILEID=1wLcmouRAskQiRC99mdMxj6pii7EEvb9i && \
    file=every_gpt.pt && \
    curl -c /tmp/cookies "https://drive.google.com/uc?export=download&id=$FILEID" > /tmp/intermezzo.html && \
    curl -L -b /tmp/cookies "https://drive.google.com$(cat /tmp/intermezzo.html | grep -Po 'uc-download-link" [^>]* href="\K[^"]*' | sed 's/\&amp;/\&/g')" > $file


RUN FILEID=19t6_Cn6qPM7HEq23zbeMQdeKtqGcEz73 && \
    file=kogpt2_news_wiki_ko_cased_818bfa919d.spiece && \
    URL="https://drive.google.com/uc?export=download&id=$id" && \
    wget --no-check-certificate "https://docs.google.com/uc?export=download&id=$FILEID" -O $file

RUN ls -l

EXPOSE 80

CMD ["python", "main.py"]