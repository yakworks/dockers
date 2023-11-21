# repo-cron-localtime

This is repo-job-1 with a hook to check the current time against a specific locale timezone which can follow Daylight Saving Time.

There are 2 critical environment variables necessary to do a cron check:
1. CRONFILTER_LOCALE='America/Chicago'
2. CRONFILTER_LOCAL_HOURS='08 09 11 21'

If either of these is not defined, then this pod acts just like repo-job-1.

- If the current hour is listed in CRONFILTER_LOCAL_HOURS, then this pod executes /opt/entry.sh (or whatever is in CRONFILTER_COMMAND)
- If the current hour is NOT in CRONFILTER_LOCAL_HOURS, then the job exits with zero activity and normal result code.

This project came about because we need to run cronjobs which follow Daylight Saving Time without extra junk in the way.

## Environment variables

### Required variables for cron time check to activate

- `CRONFILTER_LOCAL_HOURS='07 09 12 14 19'`
: A string containing 2-digit hours (00-23) separated by spaces. The hours are the local hours for which you want to run the current job.

- `CRONFILTER_LOCALE='America/New_York'`
: A string matching a Linux locale string in the `tzdata` package. This locale is not configured as the system default, which is assumed to be UTC but does not matter.

### Optional variables

`cronfilter.sh` checks the hour even if the following variables are undefined

- `CRONFILTER_COMMAND='/opt/entry.sh'`
: The command to execute if the cronfilter matches the current hour to `CRONFILTER_LOCAL_HOURS`.
This defaults to `/opt/entry.sh` which is what repo-job-1 defaults to.

- `CRONFILTER_DEBUG='false'`
: When true, this turns on extra logging in the cronfilter.sh script.

## Usage

Define your cronjob exactly as you would for repo-job-1, but add:
1. CRONFILTER_LOCALE='America/New_York'
2. CRONFILTER_LOCAL_HOURS='04 09 14 21'
3. Define the cronjob schedule with a * for hours but all other fields as usual.

```
spec:
  schedule: '7 * * * *'
...
      containers:
        ...
          env:
          - name: CRONFILTER_LOCALE
            value: 'America/New_York'
          - name: CRONFILTER_LOCAL_HOURS
            value: '04 09 14 21'
          - name: CRONFILTER_COMMAND
            value: my/optional/task.sh
          - name: CRONFILTER_DEBUG
            value: 'true' # Needs to be quoted or it will blow up deployment yaml
```

This check does __NOT__ run `make` to pull environment before the time check. It is done entirely in `bash`.
__ALL relevant `CRONFILTER_*` variables must be present as environment variables when the pod runs!__