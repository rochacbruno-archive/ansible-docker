
FROM ansible/ubuntu14.04-ansible:stable
# Add your playbooks to the Docker image
ADD playbooks /playbooks
WORKDIR /
# Execute Ansible with your playbook's primary entry point.
# The "-c local" argument causes Ansible to use a "local connection" that won't attempt to
# ssh in to localhost.
RUN ansible-playbook /playbooks/site.yml -c local
EXPOSE 5000
ENTRYPOINT ["/app/manage.py"]
CMD ["runserver", "--port 5000", "--host 0.0.0.0",  "--reloader", "--debug"]
