require 'thor'
require 'fabricio/cli/organization/obtain_organization_info_command'
require 'fabricio/cli/build/obtain_all_builds_command'
require 'fabricio/cli/build/obtain_build_command'
require 'fabricio/cli/build/obtain_top_versions_command'
require 'fabricio/cli/app/obtain_all_applications_command'
require 'fabricio/cli/app/obtain_application_command'
require 'fabricio/cli/app/obtain_count_of_active_users_command'
require 'fabricio/cli/app/obtain_count_of_daily_new_users_command'
require 'fabricio/cli/app/obtain_count_of_daily_active_users_command'
require 'fabricio/cli/app/obtain_count_of_sessions_command'
require 'fabricio/cli/app/obtain_count_of_crashes_command'
require 'fabricio/cli/app/obtain_application_crashfree_command'
require 'fabricio/cli/app/obtain_oom_free_command'

module Fabricio::CLI
  class Application < Thor

  end
end