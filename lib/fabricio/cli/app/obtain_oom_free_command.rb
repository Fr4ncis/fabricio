require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_oomfree [APPLICATION_ID] [START_TIMESTAMP] [END_TIMESTAMP] [BUILDS] [USERNAME] [PASSWORD]', 'Obtains application out-of-memory free for a number of builds.'
    def obtain_oomfree(application_id, start_timestamp, end_timestamp, builds, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      oomfree = client.app.oomfree(application_id, start_timestamp, end_timestamp, builds.split(','))

      unless oomfree
        puts "Application with id: #{application_id} not find."
        return
      end

      print_table(oomfree)
    end

    private

    def print_table(oomfree)
      table = Terminal::Table.new do |t|
        percentages = (oomfree * 100).round(1)

        rows = {}
        rows['Application oomfree'] = "#{percentages}%"

        t.rows = rows
      end

      puts table
    end

  end
end