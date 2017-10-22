        Format/result           |       Command              |          Output                       
--------------------------------+----------------------------+------------------------------
YYYY-MM-DD_hh:mm:ss             | date +%F_%T                | 2017-10-16_21:47:43
YYYYMMDD_hhmmss                 | date +%Y%m%d_%H%M%S        | 20171016_214743
YYYYMMDD_hhmmss (UTC version)   | date --utc +%Y%m%d_%H%M%SZ | 20171016_124743Z
YYYYMMDD_hhmmss (with local TZ) | date +%Y%m%d_%H%M%S%Z      | 20171016_214743JST
YYYYMMSShhmmss                  | date +%Y%m%d%H%M%S         | 20171016214743
YYYYMMSShhmmssnnnnnnnnn         | date +%Y%m%d%H%M%S%N       | 20171016214743670195402
YYMMDD_hhmmss                   | date +%y%m%d_%H%M%S        | 171016_214743
Seconds since UNIX epoch:       | date +%s                   | 1508158063 
Nanoseconds only:               | date +%N                   | 675403545
Nanoseconds since UNIX epoch:   | date +%s%N                 | 1508158063676996287
ISO8601 UTC timestamp           | date --utc +%FT%TZ         | 2017-10-16T12:47:43Z
ISO8601 UTC timestamp + ms      | date --utc +%FT%T.%3NZ     | 2017-10-16T12:47:43.679Z
ISO8601 Local TZ timestamp      | date +%FT%T%Z              | 2017-10-16T21:47:43JST


        Format/result           |       Command              |          Output
--------------------------------+----------------------------+------------------------------
YYYY-MM-DD_hh:mm:ss             | date +%F_%T                | $(date +%F_%T)
YYYYMMDD_hhmmss                 | date +%Y%m%d_%H%M%S        | $(date +%Y%m%d_%H%M%S)
YYYYMMDD_hhmmss (UTC version)   | date --utc +%Y%m%d_%H%M%SZ | $(date --utc +%Y%m%d_%H%M%SZ)
YYYYMMDD_hhmmss (with local TZ) | date +%Y%m%d_%H%M%S%Z      | $(date +%Y%m%d_%H%M%S%Z)
YYYYMMSShhmmss                  | date +%Y%m%d%H%M%S         | $(date +%Y%m%d%H%M%S)
YYYYMMSShhmmssnnnnnnnnn         | date +%Y%m%d%H%M%S%N       | $(date +%Y%m%d%H%M%S%N)
YYMMDD_hhmmss                   | date +%y%m%d_%H%M%S        | $(date +%y%m%d_%H%M%S)
Seconds since UNIX epoch:       | date +%s                   | $(date +%s)
Nanoseconds only:               | date +%N                   | $(date +%N)
Nanoseconds since UNIX epoch:   | date +%s%N                 | $(date +%s%N)
ISO8601 UTC timestamp           | date --utc +%FT%TZ         | $(date --utc +%FT%TZ)
ISO8601 UTC timestamp + ms      | date --utc +%FT%T.%3NZ     | $(date --utc +%FT%T.%3NZ)
ISO8601 Local TZ timestamp      | date +%FT%T%Z              | $(date +%FT%T%Z)


*********************************************************************************************************************************************************************
date -d  @1508711128 +'%Y%m%d%H%M%S'