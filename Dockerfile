FROM python:3.13-slim

WORKDIR /fsm

COPY . .

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources \
    && sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list.d/debian.sources

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc python3-dev supervisor \
    && rm -rf /var/lib/apt/lists/* \
    # 某些包可能存在同步不及时导致安装失败的情况，可更改为官方源：https://pypi.org/simple
    && pip install --upgrade pip -i https://mirrors.aliyun.com/pypi/simple \
    && pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple \
    && pip install gunicorn wait-for-it -i https://mirrors.aliyun.com/pypi/simple

ENV TZ="Asia/Shanghai"

RUN mkdir -p /var/log/fastapi_server \
    && mkdir -p /var/log/supervisor \
    && mkdir -p /etc/supervisor/conf.d

COPY deploy/supervisor.conf /etc/supervisor/supervisord.conf

COPY deploy/fastapi_server.conf /etc/supervisor/conf.d/

EXPOSE 8001

CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8001"]
