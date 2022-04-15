# Build a docker and push to dockerhub.
# Change NAME to match what you want it published as.
# cd to this directory before running the script.

NAME='yakworks/sftp-getter'
docker build -t $(NAME) .
docker push $(NAME)