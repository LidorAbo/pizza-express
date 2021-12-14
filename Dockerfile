# syntax=docker/dockerfile:1
ARG install_command="npm install"
FROM node:8.4.0 as base
ARG lib_folder=lib/
ARG views_folder=views/
ARG package_json=package.json
ARG package_lock_json=package-lock.json
WORKDIR /code
COPY  ${lib_folder} ${lib_folder}
COPY  ${views_folder} ${views_folder}
COPY ${package_json} ${package_json}
COPY ${package_lock_json} ${package_lock_json}
COPY ${app_name} ${app_name}
FROM base as test
ARG install_command
ARG tests_folder=test/
RUN ${install_command} 
COPY ${tests_folder} ${tests_folder}
CMD [ "npm", "run", "test" ]

FROM base as prod
ARG install_command
ARG app_name=server.js
ENV app_name ${app_name}
RUN bash -c "${install_command} --production"
CMD [ "sh", "-c", "node $app_name" ]
