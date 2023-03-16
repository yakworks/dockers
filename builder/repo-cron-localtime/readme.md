# repo-cron-localtime

This is repo-job-1 with a hook to check the current time against a specific locale timezone which presumably follows Daylight Saving Time.

- If the current hour is listed in CRONFILTER_LOCAL_HOURS, then this pod acts exactly like repo-job-1.
- If the current hour is NOT in CRONFILTER_LOCAL_HOURS, then the job exits with zero activity and normal result code.

This project came about because we need to run cronjobs which follow Daylight Saving Time without extra junk in the way.

## Environment variables

- `CRONFILTER_LOCAL_HOURS='07|09|12|14|19'`
: A string containing 2-digit hours (00-23) separated by pipes. The hours are the local hours for which you want to run the current job.

- `CRONFILTER_LOCALE='America/New_York'`
: A string matching a Linux locale string in the `tzdata` package. This locale is not configured as the system default, which is assumed to be UTC but does not matter.

## Usage

Define your cronjob exactly as you would for repo-job-1, but add:
1. CRONFILTER_LOCALE='America/New_York'
2. CRONFILTER_LOCAL_HOURS='04|09|14|21'
3. Define the cronjob schedule with a * for hours but all other fields as usual.

This check does NOT run make to pull environment before the time check. The variables must be present when the pod runs.