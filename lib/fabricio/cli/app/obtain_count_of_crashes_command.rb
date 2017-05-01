require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_count_of_crashes [APPLICATION_ID] [START_TIMESTAMP] [END_TIMESTAMP] [BUILDS] [USERNAME] [PASSWORD]', 'Obtains the count of crashes for a number of builds.'
    def obtain_count_of_crashes(application_id, start_timestamp, end_timestamp, builds, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      count_of_crashes = client.app.crashes(application_id, start_timestamp, end_timestamp, builds.split(','))

      unless count_of_crashes
        puts "Application with id: #{application_id} not find."
        return
      end

      print_table(count_of_crashes)
    end

    private

    def print_table(count_of_crashes)
      table = Terminal::Table.new do |t|
        rows = {}
        rows['Count of crashes'] = count_of_crashes

        t.rows = rows
      end

      puts table
    end

  end
end