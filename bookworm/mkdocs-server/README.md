docker that can be used in kubernetes that downloads/clones a git project 
on deploy and builds into the site directory to be served by nginx.
Its like Github Pages but this allows custom build to be fired 
and importantly adding basic authentication as an option to protect pages

example deploy

```yml
apiVersion: apps/v1
kind: Deployment
... snip ...
spec:
  template:
    spec: 
      containers:
      - image: yakworks/docmark-nginx
        env:
          # The basic auth user name
          - name: AUTH_USERNAME
            value: John
          # the password
          - name: AUTH_PASSWORD
            value: Galt1
          # (required) the github project to clone in form owner/repo
          - name: GITHUB_PROJECT
            value: yakworks/some-docs
          # auth token if github project is not public https://github.com/settings/tokens 
          - name: GITHUB_TOKEN
            value: 'asfd8asdf987adf987'
          # (optional) defaults to master
          - name: GITHUB_BRANCH
            value: docs-branch
          # (optional) call this make target instead of doing default `docmark build` and copy to site
          - name: MAKE_BULD_TARGET
            value: docs-build
```
