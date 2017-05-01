require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_count_of_crashes [APPLICATION_ID] [START_TIMESTAMP] [END_TIMESTAMP] [BUILD] [USERNAME] [PASSWORD]', 'Obtains application crashfree.'
    def obtain_application_crashfree(application_id, start_timestamp, end_timestamp, build, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      application_crashfree = client.app.crashfree(application_id, start_timestamp, end_timestamp, build)

      unless application_crashfree
        puts "Application with id: #{application_id} not find."
        return
      end

      print_table(application_crashfree)
    end

    private

    def print_table(application_crashfree)
      table = Terminal::Table.new do |t|
        percentages = (application_crashfree * 100).round(1)

        rows = {}
        rows['Application crashfree'] = "#{percentages}%"

        t.rows = rows
      end

      puts table
    end

  end
end