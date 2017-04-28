require 'thor'
require 'fabricio/cli/organization/obtain_organization_info_command'
require 'fabricio/cli/build/obtain_all_builds'
require 'fabricio/cli/build/obtain_build'
require 'fabricio/cli/build/obtain_top_versions'
require 'fabricio/cli/app/obtain_all_applications'
require 'fabricio/cli/app/obtain_application'
require 'fabricio/cli/app/obtain_count_of_active_users'
require 'fabricio/cli/app/obtain_count_of_daily_new_users'

module Fabricio::CLI
  class Application < Thor

  end
end