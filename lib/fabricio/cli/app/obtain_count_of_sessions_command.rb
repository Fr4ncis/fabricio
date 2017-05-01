require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_count_of_sessions [APPLICATION_ID] [START_TIMESTAMP] [END_TIMESTAMP] [BUILD] [USERNAME] [PASSWORD]', 'Obtains the count of sessions.'
    def obtain_count_of_sessions(application_id, start_timestamp, end_timestamp, build, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      sessions_count = client.app.total_sessions(application_id, start_timestamp, end_timestamp, build)

      unless sessions_count
        puts "Application with id: #{application_id} not find."
        return
      end

      print_table(sessions_count)
    end

    private

    def print_table(sessions_count)
      table = Terminal::Table.new do |t|
        rows = {}
        rows['Count of sessions'] = sessions_count

        t.rows = rows
      end

      puts table
    end

  end
end