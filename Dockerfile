# syntax=docker/dockerfile:1
ARG install_command="npm install"
FROM node:8.4.0 as base

WORKDIR /code

COPY package.json package.json
COPY package-lock.json package-lock.json

FROM base as test
ARG install_command
RUN ${install_command} 
COPY . .
CMD [ "npm", "run", "test" ]

FROM base as prod
ARG install_command
ARG lib_folder=lib/
ARG views_folder=views/
ENV app_name=server.js
RUN bash -c "${install_command} --production"
COPY  ${lib_folder} ${lib_folder}
COPY  ${views_folder} ${views_folder}
COPY ${app_name} .
CMD [ "sh", "-c", "node $app_name" ]
