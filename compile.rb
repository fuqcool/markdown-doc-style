#!/usr/bin/env ruby

require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

unless ARGV.length > 0
  STDERR.puts 'No file specified.'
  exit 1
end

file = ARGV[0]

unless File.exist? file
  STDERR.puts 'File not found.'
  exit 1
end

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

extensions = {
  tables: true,
  fenced_code_blocks: true,
  disable_indented_code_blocks: true,
  strikethrough: true,
  no_intra_emphasis: true,
  underline: true,
  footnotes: true
}

markdown = Redcarpet::Markdown.new(HTML, extensions)

File.open file, 'r' do |f|
  puts markdown.render(f.read)
end
