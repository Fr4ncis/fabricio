require 'thor'
require 'terminal-table'
require 'fabricio/client/client'
require 'fabricio/models/organization'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_all_builds [USERNAME] [PASSWORD] [APPLICATION_ID]', 'Obtains the list of all application builds.'
    def obtain_all_builds(username, password, application_id)
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

      table = Terminal::Table.new do |t|
        rows = {}

        builds.each_with_index do |build, index|
          rows[index + 1] = "id: #{build.id}\nversion: #{build.version}\nbuild_number: #{build.build_number}\nrelease_notes: #{build.release_notes}\ndistributed_at: #{build.distributed_at}"
        end

        t.rows = rows
        t.title = "The list of builds for application id: #{application_id}"
        t.style = {:all_separators => true}
      end

      puts table
    end

  end
end