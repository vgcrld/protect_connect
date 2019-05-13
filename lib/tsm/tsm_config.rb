require "logger"

module Tsm;

  PROMPT = /(?<product>Protect|tsm|TSM): (?<server>\w+)>/

  DSMADMC = %w[
    dsmadmc
    -id=admin
    -pa=admin
    -display=list
    -dataonly=yes
    -alwaysprompt
    -newlineafterprompt
  ]

  LOG = Logger.new(STDOUT)

  # ACTIVITY_SUMMARY
  # ACTLOG
  # ADMINS
  # ADMIN_SCHEDULES
  # ASSOCIATIONS
  # AUDITOCC
  # CLEANUP
  # DAMAGED_FILES
  # DEDUPSTATS
  # DEDUP_STATS
  # DEVCLASSES_DIR
  # OCCUPANCY
  # PLATFORM_APPLICATIONS
  # TSM_MON_ALERT
  # TSM_MON_ALERTTRIG
  # TSM_MON_CMDHIST
  # PLATFORM_BACKUP_COMPONENTS_VIEW
  # PLATFORM_BACKUP_STATUS_VIEW
  # PLATFORM_GROUP_SCANS
  # PLATFORM_PROTECTION_COVERAGE_VIEW
  # PLATFORM_RELATIONSHIPS

  def commands(scan)
    [
      [ "q dev f=d",                "devclass" ],
      [ "q libr f=d",               "library" ],
      [ "q libv f=d",               "libvolumes" ],
      [ "q shred f=d",              "shred" ],
      [ "q san t=a f=d",            "san" ],
      [ "q lic",                    "license" ],
      [ "q status",                 "status" ],
      [ "q opt",                    "options" ],
      [ "q vol f=d",                "volume" ],
      [ "q drive f=d",              "drive" ],
      [ "q path f=d",               "path" ],
      [ "q node f=d",               "node" ],
      [ "q admin f=d",              "admins" ],
      [ "q stg f=d",                "stgpool" ],
      [ "q do f=d",                 "domain" ],
      [ "q pol f=d",                "policy" ],
      [ "q mg f=d",                 "mgmtclass" ],
      [ "q copy f=d",               "backup_copygrp" ],
      [ "q copy t=a f=d",           "archive_copygrp" ],
      [ "q occ",                    "occupancy" ],
      [ "q file f=d",               "filespace" ],
      [ "q dbspace f=d",            "dbspace" ],
      [ "q dirspace f=d",           "dirspace" ],

      [ "select * from log",        "log" ],
      [ "select * from database",   "database" ],
      [ "select * from sessions",   "sessions" ],
      [ "select * from processes",  "process" ],

      [ "select * from volumeusage"                                                                            "volumeusage"   ],
      [ "select * from summary where end_time>=current_timestamp-(#{scan})second",                             "summary"       ],
      [ "select * from volhistory where date_time>=current_timestamp-(#{scan})second",                         "volhistory"    ],
      [ "select * from events where domain_name is not null and completed>=current_timestamp-(#{scan})second", "client_events" ],
      [ "select * from events where domain_name is null     and completed>=current_timestamp-(#{scan})second", "admin_events"  ]
    ]
  end


end

