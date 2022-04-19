docker run -it --rm \
-v $PWD:/project \
-e GITHUB_TOKEN \
-e GPG_KEY \
yakworks/builder:repo-job /bin/bash