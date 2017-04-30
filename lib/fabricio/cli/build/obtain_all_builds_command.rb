require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_all_builds [APPLICATION_ID] [USERNAME] [PASSWORD]', 'Obtains the list of all application builds.'
    def obtain_all_builds(application_id, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      builds = client.build.all(application_id)

      unless builds
        puts "Can not find application with id: #{application_id}."
        return
      end

      if builds.empty?
        puts "Application with id: #{application_id} has not builds."
        return
      end

      print_table(builds)
    end

    private

    def print_table(builds)
      table = Terminal::Table.new do |t|
        rows = {}

        builds.each_with_index do |build, index|
          rows[index + 1] = "id: #{build.id}\nversion: #{build.version}\nbuild_number: #{build.build_number}\nrelease_notes: #{build.release_notes}\ndistributed_at: #{build.distributed_at}"
        end

        t.rows = rows
        t.style = {:all_separators => true}
      end

      puts table
    end

  end
end