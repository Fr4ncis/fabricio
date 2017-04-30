require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_all_builds [APPLICATION_ID] [START_TIMESTAMP] [END_TIMESTAMP] [USERNAME] [PASSWORD]', 'Obtains an array of top versions for a given application.'
    def obtain_top_versions(application_id, start_timestamp, end_timestamp, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      builds = client.build.top_versions(application_id, start_timestamp, end_timestamp)

      unless builds
        puts "Can not find application with id: #{application_id}."
        return
      end

      if builds.empty?
        puts "Builds with application_id: #{application_id}, start_timestamp: #{start_timestamp}, end_timestamp: #{end_timestamp} not find."
        return
      end

      print_table(builds)
    end

    private

    def print_table(builds)
      table = Terminal::Table.new do |t|
        rows = {}

        builds.each_with_index do |build, index|
          rows[index + 1] = build
        end

        t.rows = rows
        t.style = {:all_separators => true}
      end

      puts table
    end

  end
end