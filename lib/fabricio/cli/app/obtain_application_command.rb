require 'thor'
require 'terminal-table'

module Fabricio::CLI
  class Application < Thor

    desc 'obtain_application [APPLICATION_ID] [USERNAME] [PASSWORD]', 'Obtains a specific app.'
    def obtain_application(application_id, username, password)
      client = Fabricio::Client.new do |config|
        config.username = username
        config.password = password
      end

      application = client.app.get(application_id)

      unless application
        puts "Application with id: #{application_id} not find."
        return
      end

      print_table(application)
    end

    private

    def print_table(application)
      table = Terminal::Table.new do |t|
        headings = []
        rows = []

        unless application.name.empty?
          headings.push 'Name'
          rows.push application.name
        end

        unless application.bundle_id.empty?
          headings.push 'Bundle id'
          rows.push application.bundle_id
        end

        unless application.created_at.empty?
          headings.push 'Created at'
          rows.push application.created_at
        end

        unless application.platform.empty?
          headings.push 'Platform'
          rows.push application.platform
        end

        if application.icon_url
          headings.push 'Icon URL'
          rows.push application.icon_url
        end

        t.headings = headings
        t.rows = [rows]
      end

      puts table
    end

  end
end