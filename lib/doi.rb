require 'rubygems'
require 'hpricot'
require 'open-uri'

module DOI
  # Convert a doi into a bibliographic reference.
  def biblio_for doi
    doc = Hpricot(open("http://www.crossref.org/openurl/?id=doi:#{doi}&noredirect=true&pid=ourl_sample:sample&format=unixref"))

    journal = (doc/"abbrev_title").inner_html
    year = (doc/"journal_issue/publication_date/year").inner_html
    volume = (doc/"journal_issue/journal_volume/volume").inner_html
    number = (doc/"journal_issue/issue").inner_html
    first_page = (doc/"pages/first_page").inner_html
    last_page = (doc/"pages/last_page").inner_html

    "#{journal} #{year}, #{volume}(#{number}) #{first_page}-#{last_page}"
  end

  # Convert a bibliographic reference into a DOI.
  def doi_for journal, year, volume, issue, page
    doc = Hpricot(open("http://www.crossref.org/openurl/?title=#{journal.gsub(/ /, '%20')}&volume=#{volume}&issue=#{issue}&spage=#{page}&date=#{year}&pid=ourl_sample:sample&redirect=false&format=unixref"))

   (doc/"doi").inner_html
  end
end