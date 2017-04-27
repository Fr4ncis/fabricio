require 'thor'
require 'terminal-table'
require 'fabricio/client/client'
require 'fabricio/models/organization'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_all_builds [APPLICATION_ID] [VERSION] [BUILD_NUMBER] [USERNAME] [PASSWORD]', 'Obtains a specific build for a specific application.'
    def obtain_build(application_id, version, build_number, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      build = client.build.get(application_id, version, build_number)

      unless build
        puts "Application with id: #{application_id}, version: #{version}, build_number: #{build_number} not find."
        return
      end

      table = Terminal::Table.new do |t|
        headings = []
        rows = []

        unless build.id.empty?
          headings.push 'ID'
          rows.push build.id
        end

        unless build.version.empty?
          headings.push 'Version'
          rows.push build.version
        end

        unless build.build_number.empty?
          headings.push 'Build Number'
          rows.push build.build_number
        end

        unless build.release_notes.empty?
          headings.push 'Release Notes'
          rows.push build.release_notes
        end

        if build.distributed_at
          headings.push 'Distributed at'
          rows.push build.distributed_at
        end

        t.headings = headings
        t.rows = [rows]
        t.title = "Information about application with id: #{application_id}"
        t.style = {:all_separators => true}
      end

      puts table
    end

  end
end