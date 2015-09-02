
FROM ansible/ubuntu14.04-ansible:stable
ADD playbooks /playbooks
ADD mongodb.conf /etc/mongodb.conf
ADD entrypoint.sh /entrypoint.sh
WORKDIR /
RUN ansible-playbook /playbooks/site.yml -c local
EXPOSE 5000
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["python", "manage.py", "runserver", "--port 5000", "--host 0.0.0.0",  "--reloader", "--debug"]
